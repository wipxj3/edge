class CreateStatuses < ActiveRecord::Migration
  def change
    create_table :statuses do |t|
      t.string :name, :default => "unknown"
      t.references :track, index: true, foreign_key: true

      t.timestamps null: false
    end
    Track.all.each do |track|
      track.statuses.create(:name => "unknown")
    end
  end
end
