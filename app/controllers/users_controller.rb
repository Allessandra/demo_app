class UsersController < ApplicationController

before_filter :signed_in_user ,only:[:edit]

def new #to new view
  @user=User.new
end

def show
  @user=User.find(params[:id])
end

def create #handle
  @user=User.new(user_params)
  if @user.save
    sign_in @user
    flash[:notice]="Welcome to the Demo App"
    #redirect_to user_path(@user)
    redirect_to @user
  else
    render 'new'
  end
end

def edit #edit view
  @user=User.find(params[:id])
end

def update #handle edit form
  @user=User.find(params[:id])
  if @user.update_attributes(user_params)
    #handle successful update
    sign_in @user
    flash[:notice]="Profile updated"
    redirect_to @user
  else
    render 'edit'
  end
end

private
def user_params
  params.require(:user).permit(:name, :email, :password, :password_confirmation)
end

def signed_in_user
  #flash[:notice]="please sign in"
  #redirect_to root_path unless signed_in?
  redirect_to(root_path, :notice => "please sign in") unless signed_in?
end

end
