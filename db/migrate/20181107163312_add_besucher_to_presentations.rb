class AddBesucherToPresentations < ActiveRecord::Migration[5.2]
  def change
    add_column :presentations, :besucher, :text
  end
end
