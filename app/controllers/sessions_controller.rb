class SessionsController < ApplicationController

def create
  user=User.find_by_email(params[:session][:email])
  if user && user.authenticate(params[:session][:password])
    sign_in user
    redirect_to user
   else
     
    redirect_to :back
    flash[:error]="Invalid email/password combination"
  end
end

def destroy
  sign_out
  redirect_to root_path
end

end
