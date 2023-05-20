class LabelsController < ApplicationController
  skip_before_action :verify_authenticity_token, only: [:create]
  def show
    @label = Grouplabel.find_by(groups_id: params[:group_id], users_id: current_user.id)
    if @label
      render json: { name: @label.name }
    else
      render json: { name: '取消' }
    end
  end
  def create
    # render json: params
    # @label = Grouplabel.find_by(groups_id: params[:group_id], users_id: params[:user_id])
    # render json: label_params 
    if @label = Grouplabel.find_by(groups_id: params[:group_id], users_id: params[:user_id]) 
      @label.update label_params
      # redirect_to root_path
      # 能不要用 redirect_to 嗎？
      render json: @label
    else
      @label = Grouplabel.new
      @label.users_id = params[:user_id]
      @label.groups_id = params[:group_id]
      @label.name = label_params[:name]
      @label.save
      # redirect_to root_path
      render json: @label
    end
  end
  private
  def label_params
    params.require(:label).permit(:name)
  end
end
