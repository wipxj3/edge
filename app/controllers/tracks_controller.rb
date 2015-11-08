class TracksController < ApplicationController
  before_filter :authenticate_user!

  def index
    @tracks = current_user.tracks.order(id: :desc).page params[:page]
  end

  def new
    @track = Track.new
  end

  def create
    @track = current_user.tracks.create!(track_params)
    create_remote_tracker(@track.number)
    @track.get_status!

    redirect_to tracks_path
  rescue => e
    @track.destroy!
    flash[:alert] = "Invalid tracking number or carrier not found!"
    redirect_to new_track_path
  end

  def edit
    @track = Track.find(params[:id])
  end

  def update
    @track = Track.find(params[:id])
    if @track.update_attributes(track_params)
      create_remote_tracker(@track.number)
      @track.get_status!
      redirect_to tracks_path
    else
      render 'edit'
    end
  end

  def refresh
    @track = Track.find(params[:track_id])
    @track.update_status!

    redirect_to tracks_path
  end

  def destroy
    @track = Track.find(params[:id])
    @track.statuses.each(&:destroy!)
    @track.destroy!

    redirect_to tracks_path
  end

  private

  def create_remote_tracker(number)
    EasyPost.api_key = 'nE8XxkwdbZg1HHu4z5ph4g'
    EasyPost::Tracker.create({tracking_code: number})
  end

  def track_params
    params.require(:track).permit!
  end
end
