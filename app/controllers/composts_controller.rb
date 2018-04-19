class CompostsController < ApplicationController

  skip_before_action :authenticate_user!, only: [:index, :show]
  before_action :find_compost, only: [:edit, :update, :show, :remove, :destroy]

  def index
    if params[:query].present?
      sql_query = "address ILIKE :query OR description ILIKE :query"
      @composts = Compost.where.not(deleted: true).where(sql_query, query: "%#{params[:query]}%")
    else
      @composts = Compost.where.not(deleted: true)
    end

    map_composts = @composts.where.not(latitude: nil, longitude: nil)
    public_composts = map_composts.where(public: true)
    private_composts = map_composts.where(public: false)

    @markers = private_composts.map do |compost|
      {
        lat: compost.latitude,
        lng: compost.longitude,
        icon: "http://www.googlemapsmarkers.com/v1/0CF574/"#,
        # infoWindow: { content: render_to_string(partial: "/flats/map_box", locals: { flat: flat }) }
      }
    end
    @public_markers = public_composts.map do |compost|
       {
        lat: compost.latitude,
        lng: compost.longitude,
        icon: "http://www.googlemapsmarkers.com/v1/2F97C1/"#,
        # infoWindow: { content: render_to_string(partial: "/flats/map_box", locals: { flat: flat }) }
      }
    end
  end

  def show
    @message = Message.new
  end

  def new
    @compost = Compost.new
    authorize @compost
  end

  def create
    @compost = Compost.new(compost_params)
    authorize @compost
    @compost.user = current_user
    if @compost.save
      if current_user.admin?
        redirect_to dashboard_path
      else
        redirect_to my_composts_path
      end
    else
      render :new
    end
  end

  def edit
  end

  def update
    @compost.update(compost_params)
    if @compost.save
      if current_user.admin?
        flash[:notice] = "Compost mis à jour."
        redirect_to dashboard_path
      else
        flash[:notice] = "Compost mis à jour."
        redirect_to my_composts_path
      end
    else
      render :edit
    end
  end

  def remove
    @compost.update(deleted: true)
    flash[:notice] = "Compost supprimé!"
    redirect_to my_composts_path
  end

  def dashboard
    authorize Compost
    @composts = Compost.all.order(id: :desc)
    @compost = Compost.new
  end

  def user_composts
    @composts = policy_scope(Compost).where(deleted: false).order(id: :desc)
    @compost = Compost.new
    authorize @compost
    @compost_conversations = Conversation.where(compost: current_user.composts)
    @user_conversations = Conversation.where(user: current_user)
    @conversations = @compost_conversations + @user_conversations
  end

  def destroy
    @compost.delete
    flash[:alert] = "Compost définitivement supprimé!"
    redirect_to dashboard_path
  end

  private

  def compost_params
    params.require(:compost).permit(:address, :description, :public, :deleted, :user_id)
  end

  def find_compost
    @compost = Compost.find(params[:id])
    authorize @compost
  end
end
