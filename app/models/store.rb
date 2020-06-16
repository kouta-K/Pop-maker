class Store < ApplicationRecord
  validates :name, presence: true
  validates :price, presence: true, numericality: true
  validates :maker, presence: true
  validates :category, presence: true
  validates :jan, presence: true
  has_many :weeks, dependent: :destroy
  belongs_to :user
  
  def self.import(file, id)
    errors = []
    CSV.foreach(file.path, headers: true) do |r|
      store = find_by(jan: r["jan"], user_id: id) || User.find(id).stores.build
      if store.id
        next 
      end
      store.attributes = r.to_hash.slice("name", "price", "maker", "category", "jan")
      unless store.jan_correct?
        errors << {name: store.name, jan: store.jan, error: ["無効なjanです"]}
        next
      end 
      unless store.save
        errors << {name: store.name, jan: store.jan, error: store.errors.full_messages}
      end 
    end
    errors 
  end 
  
  def jan_correct?
    if jan.nil?
      false
    else 
      jan_code = Jan::Code.new(jan)
      jan_code.valid?
    end 
  end 
end
