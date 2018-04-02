class MessagesController < ApplicationController

  def index
    @conversation = Conversation.find(params[:conversation_id])
    @messages = @conversation.messages.order(created_at: :desc)
    @message = Message.new
    @compost = @conversation.compost
  end

  def create
    @compost = Compost.find(params[:compost_id])
    conversation = Conversation.where(user: current_user).where(compost: @compost).first
    if conversation.nil?
      conversation = Conversation.create(user: current_user, compost: @compost)
    end
    @message = Message.new(message_params)
    authorize @message
    unless @message.conversation.nil?
      @message.conversation = Conversation.find(params[:message][:conversation_id].to_i)
    else
      @message.conversation = conversation
    end
    @message.user = current_user
    if @message.save
      redirect_to conversation_messages_path(@message.conversation)
    end
  end

  private

  def message_params
    params.require(:message).permit(:content, :conversation_id)
  end
end
