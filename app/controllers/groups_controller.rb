class GroupsController < ApplicationController
    before_action :set_group, only: [:edit, :update,:destroy, :showmember]
    def index 
        @user = current_user
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
        redirect_to group_stores_path(@group)
    end
    def destroy
        # @group.stores.destroy(@group)
        @group.destroy 
        redirect_to groups_path
    end
    def invite 
        
    end
    def showmember 

    end
    private
    def set_group
        @group = Group.find params[:id]
    end
    def group_params
        params.require(:group).permit(:name)
    end
end
