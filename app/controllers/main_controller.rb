class MainController < ApplicationController
  def index
  end

  def send_feedback
    NotifyMailer.new_message(params[:email], params[:message]).deliver_now
    render status: 200, json: @controller.to_json
  end
end
