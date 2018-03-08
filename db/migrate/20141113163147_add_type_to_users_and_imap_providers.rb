class AddTypeToUsersAndImapProviders < ActiveRecord::Migration
  def change
    add_column :imap_providers, :type, :string
    add_column :super_imap_users, :type, :string
  end
end
