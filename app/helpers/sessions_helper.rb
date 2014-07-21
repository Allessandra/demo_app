module SessionsHelper

def sign_in(user)
  #cookies[:remember_token]={value: user.remember_token,
                          #expires: 20.years.from_now }
  cookies.permanent[:remember_token]=user.remember_token 
  self.current_user=user #call setter
end

def current_user=(user) #setter
  @current_user=user
end

def current_user #getter
  #@current_user=@current_user||User.find_by_remember_token(cookies[:remember_token])
  #if it exists or find by token
  @current_user||=User.find_by_remember_token(cookies[:remember_token])
end

def current_user?(user)
  user==current_user
end
def signed_in?
  !current_user.nil? #call getter
  #signed in is true when current user isn't 
  # nil
end

def sign_out
  self.current_user=nil
  cookies.delete(:remember_token)  
end

def store_location
  session[:return_to]= request.fullpath
end

def redirect_back_or(default)
  redirect_to(session[:return_to]|| default)
  session.delete(:return_to)
end
end
