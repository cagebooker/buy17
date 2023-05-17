class CommentsController < ApplicationController
  skip_before_action :verify_authenticity_token, only: [:create]
  def index
    @comments = Comment.where(store_id: params[:store_id]).where(group_id: params[:group_id])
    render json: @comments
  end
  def create
    # 這邊好怪 要用 render json: params 才能儲存資料
    render json: params
    @comment = Comment.new
    @comment.content = params[:content]
    @comment.group_id = params[:group_id]
    @comment.store_id = params[:store_id]
    @comment.user_id = params[:user_id]
    u1 = User.find(params[:user_id])
    @comment.name = u1.name
    # render json: @comment
    if @comment.save
    else
        # render json: @comment.errors.full_messages
    end
  end
end
