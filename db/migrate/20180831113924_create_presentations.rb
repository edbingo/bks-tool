class CreatePresentations < ActiveRecord::Migration[5.2]
  def change
    create_table :presentations do |t|
      t.string :Name
      t.string :Klasse
      t.string :Titel
      t.string :Fach
      t.string :Betreuer
      t.string :Zimmer
      t.string :Von
      t.string :Bis
      t.string :Datum
      t.integer :Frei
      t.integer :Besetzt
      t.string :Besucher
      t.integer :time

      t.timestamps
    end
  end
end
