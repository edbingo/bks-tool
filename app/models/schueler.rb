class Schueler < ApplicationRecord
  include Resetable
  require "csv"
  def self.import(file)
    CSV.foreach(file.path, headers: true, col_sep: ";") do |row|
      Schueler.create! row.to_hash
    end
    stud = Schueler.all
    stud.each do |row|
      pass = 1.times.map{ 9999 + Random.rand(100000) }
      row["password"] = pass.join
      row["password_confirmation"] = pass.join
      row["Code"] = pass.join
      row["Registered"] = false
      row["Selected"] = nil
      row["Selected1"] = nil
      row["Selected2"] = nil
      row["Received"] = false
    end

    Schueler.all.order!(Name: :asc, Vorname: :desc)
  end
  validates :Name,     presence: true
  validates :Vorname,  presence: true
  validates :Klasse,   presence: true
  validates :Mail,     presence: true
  validates :Number,   presence: true, uniqueness: { case_sensitive: false }
  has_secure_password
  validates :password, presence: true
end
