class ApplicationController < ActionController::Base
    before_action :authenticate_user!
    def generate_text
        # render json: params[:prompt]
        client = ChatgptService.new(params[:prompt])
        @response = client.call
        # @response = ChatgptService.call(params[:message])
    end
    # def 
    #     @generated_text = OpenaiService.generate_text('Hello, world!')
    # end
end
