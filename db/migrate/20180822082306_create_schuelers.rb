class CreateSchuelers < ActiveRecord::Migration[5.2]
  def change
    create_table :schuelers do |t|
      t.string :vorname
      t.string :name
      t.string :klasse
      t.string :mail
      t.string :number

      t.timestamps
    end
  end
end
