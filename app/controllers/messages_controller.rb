class MessagesController < ApplicationController
  before_action :set_group,only: [:send_message]
  skip_before_action :verify_authenticity_token, only: [:send_message]
  def index

  end
  def read_message
    @message = Message.find(params[:message_id])
    @message.read_message!
    
  end
  def send_message
    #還需要判別是不是已經在群組裡面
    @message = Message.new
    @user = User.find_by(email: params[:message][:user_id])
    @message.user_id = @user.id
    @message.content = @group.name+"邀請你進入群組"
   
    # render json: @message
    if @message.save
      @user.groups << @group #邀請就直接加入了，先這樣
      redirect_to group_stores_path(@group), :notice => '邀請已經寄出'
    else
      render json: {'wrong':@message.errors.full_messages}
    end
  end
  private
  def set_group
    @group = Group.find(params[:id])
  end
  def message_params
    params.require(:message).permit(:user_id)
  end
end
