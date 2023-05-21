class GroupsController < ApplicationController
    before_action :set_group, only: [:edit, :update,:destroy, :showmember]
    def index 
        @user = current_user
        @groups = current_user.groups.with_attached_cover
        # @message = 
    end
    def new
        @group = Group.new
    end
    def create 
        @group = Group.new group_params
        if @group.save
            @group.users = [current_user]
            redirect_to groups_path
        else
            render 'new'
        end
    end
    def edit

    end
    def update
        @group.update group_params
        redirect_to groups_path
    end
    def destroy
        # @group.stores.destroy(@group)
        @group.destroy 
        redirect_to groups_path
    end
    def invite 
        @group = Group.find params[:id]
    end
    def showmember 
        
    end
    def pending_purchases
        
    end

    def generate_text
        # render json: params[:prompt]
        client = ChatgptService.new(params[:prompt])
        @response = client.call
        # @response
        # render json: @response
        # @response = ChatgptService.call(params[:message])
    end
    private
    def set_group
        @group = Group.find params[:id]
    end
    def group_params
        params.require(:group).permit(:name, :cover)
    end
end
