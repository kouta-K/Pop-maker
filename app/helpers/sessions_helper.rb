module SessionsHelper
  def current_user 
    if id = session[:user_id]
      @current_user ||= User.find_by(id: id)
    else 
      return nil 
    end
  end
  
  def login? 
    if current_user.nil?
      return false 
    else 
      return true
    end 
  end
end
