class AddTracerToUsers < ActiveRecord::Migration
  def change
    add_column :super_imap_users, :enable_tracer, :boolean, :default => false
    # add_index :users, :enable_tracer
  end
end
