class AddCarrierToTrack < ActiveRecord::Migration
  def change
    add_column :tracks, :carrier, :string, :default => "unknown"
    rename_column :tracks, :link, :number
  end
end
