class CompostsController < ApplicationController

  skip_before_action :authenticate_user!, only: [:index, :show]
  before_action :find_compost, only: [:edit, :update, :show, :remove, :destroy]

  def index
    @composts = Compost.where.not(deleted: true)
    @map_composts = @composts.where.not(latitude: nil, longitude: nil)

    @markers = @map_composts.map do |compost|
      {
        lat: compost.latitude,
        lng: compost.longitude#,
        # infoWindow: { content: render_to_string(partial: "/flats/map_box", locals: { flat: flat }) }
      }
    end
  end

  def show
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
        redirect_to dashboard_path
      else
        redirect_to my_composts_path
      end
    else
      render :edit
    end
  end

  def remove
    @compost.update(deleted: true)
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
  end

  def destroy
    @compost.delete
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
