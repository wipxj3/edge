require 'easypost'
require 'pp'

class Track < ActiveRecord::Base
  belongs_to :user
  paginates_per 4
  has_many :statuses

  attr_reader :info

  def get_status!
    EasyPost.api_key = 'nE8XxkwdbZg1HHu4z5ph4g'
    @info = EasyPost::Tracker.create({tracking_code: number})

    update_attributes!(:carrier => @info.carrier)
    update_status!
  end

  def update_status!
    if number == "EZ1000000001"
      info = [
        { status: "pre_transit", message: "Packing at seller." },
        { status: "in_transit", message: "At shipping facility." },
        { status: "delivered", message: "Delivered successfully,"}
      ].sample

      statuses.create!(
        :name => info[:status],
        :message => info[:message]
      )
    else
      statuses.create!(
        :name => @info.status,
        :message => @info.tracking_details.empty? ? "No message." : @info.tracking_details.last.message
      )
    end
  end
end
