class AddPasswordDigestToSchuelers < ActiveRecord::Migration[5.2]
  def change
    add_column :schuelers, :password_digest, :string
  end
end
