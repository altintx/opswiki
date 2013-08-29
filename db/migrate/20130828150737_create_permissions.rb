class CreatePermissions < ActiveRecord::Migration
  def change
    create_table :permissions do |t|
      t.string :ldap_user
      t.string :model
      t.integer :fk
      t.string :ability

      t.timestamps
    end
  end
end
