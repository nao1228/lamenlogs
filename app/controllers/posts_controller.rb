class PostsController < ApplicationController
  
  before_action :require_user_logged_in
  before_action :correct_user, only: [:edit, :update, :destroy]
  
  def index
    @posts = Post.all.order(created_at: :desc).page(params[:page])
  end

  def new
    @post = Post.new
  end

  def create
    @post = current_user.posts.build(post_params)
    if @post.save
      flash[:success] = '投稿しました'
      redirect_to user_path(current_user)
    else
       @posts = current_user.posts.order(id: :desc).page(params[:page])
      flash.now[:danger] = '投稿に失敗しました。'
      render 'posts/new'
    end
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
      if @post.update(post_params)
        flash[:success] = '投稿 は正常に更新されました'
        redirect_to user_path(current_user)
      else
        flash.now[:danger] = '投稿は更新されませんでした'
        render :edit
      end
  end

  def destroy
    @post.destroy
    flash[:success] = '投稿を削除しました。'
    redirect_back(fallback_location: root_path)
  end
  
  private
 def post_params
  params.require(:post).permit(:shop, :content, :img)
 end
 
 def correct_user
   @post = current_user.posts.find_by(id: params[:id])
   unless @post
     redirect_to root_url
   end
 end
end
