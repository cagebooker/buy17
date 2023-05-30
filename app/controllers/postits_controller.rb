class PostitsController < ApplicationController
  skip_before_action :verify_authenticity_token, only: [:create]
  def index 
    @postits = current_user.postits.all
    # render json: @postits
    respond_to do |format|
      format.html
      format.xml { render :xml => @postits }
      format.json { render :json => @postits }
    end
  end
  def create
    # render json: params
    @postit = Postit.new
    @postit.content = params[:content]
    @postit.color = params[:color]
    @postit.pos_x = params[:pos_x]
    @postit.pos_y = params[:pos_y]
    @postit.user_id = current_user.id
    @postit.save
    render json: @postit
  end
  def update
    render json: params
    @postit = Postit.find(params[:id])
    @postit.content = params[:content]
    @postit.color = params[:color]
    @postit.pos_x = params[:pos_x]
    @postit.pos_y = params[:pos_y]
    @postit.save 
    # render json: @postit
  end
  def destroy
    @postit = Postit.find(params[:id])
    @postit.destroy
    render json: @postit
  end
end
