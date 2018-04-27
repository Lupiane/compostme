class MessagesController < ApplicationController

  def index
    @conversation = Conversation.find(params[:conversation_id])
    @messages = @conversation.messages.order(created_at: :desc)
    @message = Message.new
    @compost = @conversation.compost
  end

  def create
    @compost = Compost.find(params[:compost_id])
    @conversation = set_conversation
    @message = Message.new(message_params)
    authorize @message

    @message.conversation = @conversation
    @message.user = current_user

    if @message.save
      redirect_to conversation_messages_path(@message.conversation)
    else
      if params[:message][:from_show]
        create_markers
        render 'composts/show'
      else
        @messages = @conversation.messages.order(created_at: :desc)
        render :index
      end
    end
  end

  private

  def message_params
    params.require(:message).permit(:content)
  end

  def create_markers
    @markers = [{
      lat: @compost.latitude,
      lng: @compost.longitude,
      icon: "http://www.googlemapsmarkers.com/v1/44B59E/"
    }]
  end

  def set_conversation
    if current_user == @compost.user
      # WHEN CURRENT USER IS COMPOST OWNER --> ALWAYS FROM THE CONVERSATION PAGE NEVER FROM THE
      # COMPOST SHOW PAGE SO CONVERSATION IS ALWAYS IN THE PARAMS
      conversation = Conversation.find(params[:message][:conversation_id].to_i)
    else
      conversation = Conversation.where(user: current_user).where(compost: @compost).first
      if conversation.nil?
        conversation = Conversation.create(user: current_user, compost: @compost)
      end
      conversation
    end
  end
end
