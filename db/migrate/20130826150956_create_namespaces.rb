class CreateNamespaces < ActiveRecord::Migration
  def change
    create_table :namespaces do |t|
  	  t.string :name
  	  t.string :support
      t.timestamps
    end
  end
end
