class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy] 
  
  def index
    @posts = Post.all
  end

  def new
    @post = Post.new
  end
  
  def create
    @post = Post.new(post_params)
    @post.author_id = current_author.id 
    if @post.save
      redirect_to '/'
    else 
      redirect_to '/posts/new'
    end
  end

  def show
  end

  def edit
  end

  def update
    if @post.update(post_params)
      redirect_to '/'
    else 
      redirect_to @post
    end
  end

  def destroy
    @post.destroy
    redirect_to '/'
  end

  def author
    posts = Post.all
    @author = params[:author]
		@author_id = current_author.id
		@posts_by_author = Post.where(["author_id = '%s'", @author_id]).paginate(page: params[:page], per_page: 5)
		@authorvalid = []
		posts.each do |post|
			 @authorvalid << post.author.name
		end
		if (@authorvalid).include?(@author)
			render :author
		else
			render file: "#{Rails.root}/public/404.html" , status: 404
		end
  end
  
  
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.friendly.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def post_params
      params.require(:post).permit(:title, :body, :author_id)
    end


end
