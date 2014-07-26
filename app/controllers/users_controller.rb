class UsersController < ApplicationController

before_filter :signed_in_user ,only: [:index, :edit ,:update ,:destroy,
  :following, :followers]
before_filter :correct_user, only: [:edit , :update]
before_filter :admin_user, only: :destroy
def index
  #@users=User.all
  @users=User.paginate(page: params[:page])
end

def new #to new view
  @user=User.new
end

def show
  @user=User.find(params[:id])
  @posts=@user.posts.paginate(page: params[:page])
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
  #@user=User.find(params[:id])
end

def update #handle edit form
  #@user=User.find(params[:id]) as hya fe current
  # user
  if @user.update_attributes(user_params)
    #handle successful update
    sign_in @user
    flash[:notice]="Profile updated"
    redirect_to @user
  else
    render 'edit'
  end
end

def destroy
  User.find(params[:id]).destroy
  flash[:notice]="User destroyed"
  redirect_to users_path
end

def following
  @title="Following"
  @user=User.find(params[:id])
  @users=@user.followed_users.paginate(page: params[:page])
  render 'show_follow'
end

def followers
  @title="Followers"
  @user=User.find(params[:id])
  @users=@user.followers.paginate(page: params[:page])
  render 'show_follow'
end

private
def user_params
  params.require(:user).permit(:name, :email, :password, :password_confirmation)
end


def correct_user
  @user=User.find(params[:id])
  #as kant fe edit bas before filter msh hat5aly el
  # @user mt3araf
  redirect_to root_path unless current_user?(@user)
end

def admin_user
  redirect_to root_path unless current_user.admin?
end
end

