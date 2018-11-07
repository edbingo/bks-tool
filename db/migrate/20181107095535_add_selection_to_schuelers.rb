class AddSelectionToSchuelers < ActiveRecord::Migration[5.2]
  def change
    add_column :schuelers, :selected, :text
  end
end
