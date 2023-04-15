class ApplicationController < ActionController::Base
    before_action :authenticate_user!
    def generate_text
        # render json: params[:prompt]
        client = ChatgptService.new(params[:prompt])
        @response = client.call
        # @response = ChatgptService.call(params[:message])
    end

    def set_mode
        # current_user.mode
        render json: {'mode':current_user.mode}
    end
    def change_mode
        @user = current_user
        if current_user.mode == 'light'
            @user.to_dark!
            render json: {'mode': current_user.mode+' in change mode'}
        elsif current_user.mode == 'dark'
            @user.to_light!
            render json: {'mode': current_user.mode+' in change mode'}
        end
    end
    # def 
    #     @generated_text = OpenaiService.generate_text('Hello, world!')
    # end
end
