class CreateSchuelers < ActiveRecord::Migration[5.2]
  def change
    create_table :schuelers do |t|
      t.string :Vorname
      t.string :Name
      t.string :Klasse
      t.string :Mail
      t.string :Number
      t.string :Code
      t.boolean :Registered
      t.string :Selected
      t.string :Selected1
      t.string :Selected2
      t.boolean :Received
      t.boolean :loginpermit
      t.timestamps
    end
  end
end
