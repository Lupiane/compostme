class CompostsController < ApplicationController

  skip_before_action :authenticate_user!, only: [:index, :show]
  before_action :find_compost, only: [:edit, :update, :show, :remove, :destroy]

  def index
    if params[:query].present?
      @composts = Compost.where.not(deleted: true).near(params[:query], 5)
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
        icon: "http://www.googlemapsmarkers.com/v1/44B59E/",
        infoWindow: { content: render_to_string(partial: "/composts/map_box", locals: { compost: compost }) }
      }
    end
    @public_markers = public_composts.map do |compost|
       {
        lat: compost.latitude,
        lng: compost.longitude,
        icon: "http://www.googlemapsmarkers.com/v1/E67E22/",
        infoWindow: { content: render_to_string(partial: "/composts/map_box", locals: { compost: compost }) }
      }
    end
  end

  def show
    @message = Message.new
    marker_color_code = @compost.public ? "E67E22" : "44B59E"
    @markers = [{
      lat: @compost.latitude,
      lng: @compost.longitude,
      icon: "http://www.googlemapsmarkers.com/v1/#{marker_color_code}/"
    }]
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
    @users = User.all.where(admin: false).order(id: :desc)
    if params[:user_search].present?
      sql_query = "username ILIKE :query OR first_name ILIKE :query OR last_name ILIKE :query"
      user = User.where(sql_query, query: "%#{params[:user_search]}%")
      @composts= Compost.where(user: user).order(id: :desc)
    else
      @composts = Compost.all.order(id: :desc)
    end
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
