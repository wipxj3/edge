class AddMessageToStatuses < ActiveRecord::Migration
  def change
    add_column :statuses, :message, :string, :default => "No message."
    Status.all.each do |status|
      status.update_attributes(:message => "No message.")
    end
  end
end
