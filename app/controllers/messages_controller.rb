class MessagesController < ApplicationController
  before_action :authenticate_user!, :only => [:create]

  def create
      @message = Message.create(params.require(:message).permit(:user_id, :content, :room_id).merge(:user_id => current_user.id))
      redirect_to "/rooms/#{@message.room_id}"
  end
end
