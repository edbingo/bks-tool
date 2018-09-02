class CreateSchuelers < ActiveRecord::Migration[5.2]
  def change
    create_table :schuelers do |t|
      t.string :Vorname
      t.string :Name
      t.string :Klasse
      t.string :Mail
      t.string :Number
      t.string :Code
      t.timestamps
    end
  end
end
