class MessagesController < ApplicationController
  before_action :require_user, only: [:create, :index]

  def index
    @messages = Message.all
  end

  def create
    @message = current_user.messages.new(message_params)
    if @message.save 
      ActionCable.server.broadcast 'chatroom_channel', message: @message.body
    else
      flash[:alert] = "message did not saved"
      redirect_to root_path
    end
  end

  private

  def message_params
    params.require(:message).permit(:body)
  end

  def message_render(message)
    render(partial: "message", locals: { message: message })
  end
end
