class PostsController <ApplicationController
  
  before_filter :signed_in_user ,only:[:create, :destroy]
  before_filter :correct_user ,only: [:destroy ,:edit,:update]
  def create
    @post=current_user.posts.build(post_params)
    if @post.save
      flash[:notice]="Post created"
      redirect_to root_path
    else
      @feed_items=current_user.feed.paginate(page: params[:page])
      render 'blogs/home'
    end
  end
  
  def destroy
     @post.destroy
     redirect_to root_path
  end
  
  def edit #edit view
  end

  def update #handle edit form
    if @post.update_attributes(post_params)
      flash[:notice]="Post updated"
      redirect_to @post
    else
      render 'edit'
    end
  end
  def show
    @post=Post.find(params[:id])
    
  end
private
  def post_params
    params.require(:post).permit(:title, :content)
  end
  def correct_user
    @post=current_user.posts.find_by_id(params[:id])
    redirect_to root_path if @post.nil?
  end
end