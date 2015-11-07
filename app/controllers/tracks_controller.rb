class TracksController < ApplicationController
  before_filter :authenticate_user!

  def index
  end

  def new
    @track = Track.new
  end

  def create
    @track=Track.create(track_params)
    @track.user = current_user
    @track.save

    redirect_to tracks_path
  end

  def edit
    @track = Track.find(params[:id])
  end

  def update
    @track = Track.find(params[:id])
    if @track.update_attributes(track_params)
      redirect_to track_path
    else
      render 'edit'
    end
  end

  def destroy
    @track = Track.find(params[:id])
    @track.destroy

    redirect_to tracks_path
  end

  private

  def track_params
    params.require(:track).permit!
  end
end