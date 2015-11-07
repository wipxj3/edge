class Track < ActiveRecord::Base
  belongs_to :user
  has_many :statuses

  def get_status!
    update_attributes!(:carrier => TrackingNumber.new(number).carrier.to_s)
    update_status!
  end

  def update_status!
    # TODO: implement
    statuses.create!(:name => "unknown")
  end
end
