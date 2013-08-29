class CreateRevisions < ActiveRecord::Migration
  def change
    create_table :revisions do |t|
      t.string :text
      t.belongs_to :page
      # t.integer :page_id
      t.string :ldap_editor
      t.string :changelog
      # t.integer :parent_revision_id
      t.belongs_to :parent_revision, class_name: "Revision"
      t.timestamps
    end
  end
end
