class OpenaiController < ApplicationController
  skip_before_action :verify_authenticity_token

  def api
    prompt = params[:prompt]

    response = OpenaiService.new(prompt).call

    render json: response
  end
end
