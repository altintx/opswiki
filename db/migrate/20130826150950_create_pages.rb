class CreatePages < ActiveRecord::Migration
  def change
    create_table :pages do |t|
      t.string :alias
      t.string :title
      t.belongs_to :revision
      t.belongs_to :namespace
      # t.integer :revision_id
      # t.integer :namespace_id
      t.timestamps
    end

    create_table :pages_tags do |t|
      t.belongs_to :page
      t.belongs_to :tag
  	end
  end
end
