class ApplicationController < ActionController::Base
    before_action :authenticate_user!
    before_action :set_locale

    def generate_text
        # render json: params[:prompt]
        client = ChatgptService.new(params[:prompt])
        @response = client.call
        # @response = ChatgptService.call(params[:message])
    end
    # 在控制器中切換語言
    

    def set_locale
        
        # 可以將 ["en", "zh-TW"] 設定為 VALID_LANG 放到 config/environment.rb 中
        if params[:locale] && I18n.available_locales.include?( params[:locale].to_sym )
            session[:locale] = params[:locale]
        end
        # render json: params[:locale] #zh-TW
        # render json: params[:locale].to_sym
        # render json: I18n.available_locales
        # render json: I18n.available_locales.include?( params[:locale].to_sym )
        I18n.locale = session[:locale] || I18n.default_locale
        
    end
  
    # 畫面亮暗模式
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
