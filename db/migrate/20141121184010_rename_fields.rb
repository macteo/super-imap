class RenameFields < ActiveRecord::Migration
  def change
    remove_column :super_imap_users, :last_connected_at, :datetime
    add_column :super_imap_users, :connected_at, :datetime
    add_column :super_imap_users, :last_login_at, :datetime
    remove_column :mail_logs, :md5, :string
    add_column :mail_logs, :sha1, :string, :limit => 40, :index => true
  end
end
