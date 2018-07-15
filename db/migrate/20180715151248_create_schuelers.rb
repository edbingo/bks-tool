class CreateSchuelers < ActiveRecord::Migration[5.2]
  def change
    create_table :schuelers do |t|
      t.string :name
      t.string :vorname
      t.string :klasse
      t.string :mail

      t.timestamps
    end
  end
end
