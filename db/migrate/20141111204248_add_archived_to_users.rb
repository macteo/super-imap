class AddArchivedToUsers < ActiveRecord::Migration
  def change
    add_column :super_imap_users, :archived, :boolean, :default => false
  end
end
