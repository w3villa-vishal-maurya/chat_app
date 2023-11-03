class MessagesController < ApplicationController
    before_action :require_user,only:[:create,:index]
    def index
        @messages = Message.all
    end
    def create
         @message = current_user.message.build(params.require(:message).permit(:body))
         if @message.save
            # ActionCable.server.broadcast 'chatroom_channel',message: message_render(@message)
         else
            flash[:alert]= "message did not saved"
            redirect_to root_path
         end
    end

    private

    def message_render(message)

      render(partial: "message",locals:{message: message} )
    end

end