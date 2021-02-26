class PostsController < ApplicationController
  helper_method :params

  def index
    @authors = Author.all
    @posts = if !params[:author].blank?
               @posts = Post.by_author(params[:author])
             elsif !params[:date].blank?
               @posts = if params[:date] == 'Today'
                          Post.from_today
                        else
                          Post.old_news
                        end
             else
               Post.all
             end
  end

  def show
    @post = Post.find(params[:id])
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(params)
    @post.save
    redirect_to post_path(@post)
  end

  def update
    @post = Post.find(params[:id])
    @post.update(params.require(:post))
    redirect_to post_path(@post)
  end

  def edit
    @post = Post.find(params[:id])
  end
end
