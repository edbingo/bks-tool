class CreateTeachers < ActiveRecord::Migration[5.2]
  def change
    create_table :teachers do |t|
      t.string :Vorname
      t.string :Name
      t.string :Number
      t.string :Mail
      t.boolean :Received

      t.timestamps
    end
  end
end
