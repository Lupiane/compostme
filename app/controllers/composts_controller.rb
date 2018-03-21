class CompostsController < ApplicationController

  skip_before_action :authenticate_user!, only: [:index, :show]
  before_action :find_compost, only: [:edit, :update, :show, :remove]

  def index
    @composts = policy_scope(Compost).where.not(deleted: true)
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
      redirect_to compost_path(@compost)
    else
      render :new
    end
  end

  def edit
  end

  def update
    @compost.update(compost_params)
    if @compost.save
      redirect_to compost_path(@compost)
    else
      render :edit
    end
  end

  def remove
    @compost.update(deleted: true)
    redirect_to composts_path
  end

  private

  def compost_params
    params.require(:compost).permit(:address, :description)
  end

  def find_compost
    @compost = Compost.find(params[:id])
    authorize @compost
  end
end
