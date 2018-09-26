class Schueler < ApplicationRecord
  include Resetable
  require "csv"
  def self.import(file)
    table = CSV.read(file.path, { headers: true, col_sep: ";" })

    table.each do |row| # Generates password for each user and marks selection as nil
      pass = 1.times.map{ 9999 + Random.rand(99999) }
      row["password"] = pass.join
      row["password_confirmation"] = pass.join
      row["Code"] = pass.join
      row["Registered"] = false
      row["Selected"] = nil
      row["Selected1"] = nil
      row["Selected2"] = nil
      row["Received"] = false
      row["loginpermit"] = true
    end

    CSV.open(file.path, "w") do |f|
      f << table.headers
      table.each{ |row| f << row }
    end

    CSV.foreach(file.path, headers: true) do |row|
      unless Schueler.where(Number: row["Number"]).count >= 1
        Schueler.create! row.to_hash
      end
    end
    students = Schueler.all
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
