class AddIndexToSchuelersMail < ActiveRecord::Migration[5.2]
  def change
    add_index :schuelers, :mail, unique: true
  end
end
