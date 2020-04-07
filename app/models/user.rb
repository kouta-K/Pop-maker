class User < ApplicationRecord
  before_save :downcase_email
  has_secure_password
  validates :name, presence: true, length: {maximum: 30}
  validates :email, format: {with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i},
                    presence: true, uniqueness: {case_sensitive: false}
  validates :password, presence: true, length: {minimum: 6}, allow_nil: true
  
  def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end
  private 
    def downcase_email 
      self.email = email.downcase 
    end
end
