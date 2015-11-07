class CreateTracks < ActiveRecord::Migration
  def change
    create_table :tracks do |t|
      t.string :link
    end
  end
end
