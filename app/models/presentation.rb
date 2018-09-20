class Presentation < ApplicationRecord
  include Resetable
  require "csv"
  def self.import(file) # Import function
    CSV.foreach(file.path, headers: true, col_sep: ";") do |row|
      Presentation.create! row.to_hash
    end
    presentations = Presentation.all
    presentations.each do |row| # Sets occupied seats to 0, visitors to nil
        row["Besetzt"] = 0
        row["Besucher"] = nil
    end
  end
  validates :Name, presence: true, uniqueness: { case_sensitive: false }
  validates :Klasse, presence: true
  validates :Titel, presence: true
  validates :Fach, presence: true
  validates :Betreuer, presence: true
  validates :Zimmer, presence: true
  validates :Von, presence: true
  validates :Bis, presence: true
end
