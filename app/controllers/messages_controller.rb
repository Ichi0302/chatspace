class MessagesController < ApplicationController
  before_action :set_groups, :set_group, :set_messages

  def index
    @message = Message.new
    respond_to do |format|
      format.html
      format.json do
        @messages = @group.messages.where('id > ?', params[:last_message_id])
      end
    end
  end

  def create
    @message = Message.new(message_params)
    if @message.save
      respond_to do |format|
        format.html {
          redirect_to group_messages_path(@group),
          notice: "メッセージを送信しました"
        }
        format.json
      end
    else
      flash.now[:alert] = "メッセージの送信に失敗しました"
      render action: :index
    end
  end

  private

  def message_params
    params.require(:message).permit(:text, :image).merge(user_id: current_user.id, group_id: params[:group_id])
  end

  def set_groups
    @groups = current_user.groups
  end

  def set_group
    @group = Group.find(params[:group_id])
  end

  def set_messages
    @messages = @group.messages
  end
end
