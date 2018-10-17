class Presentation < ApplicationRecord
  include Resetable
  require "csv"
  require 'active_support'

  def self.import(file) # Import function
    CSV.foreach(file.path, headers: true, col_sep: ";") do |row|
      if Teacher.where(Number: row["Betreuer"]).count == 0 && Teacher.where(
        nv: row["Betreuer"]).count == 0 && Teacher.where(vn: row["Betreuer"]).count != 0
        row["Betreuer"] = Teacher.find_by(vn: row["Betreuer"]).Number
      elsif Teacher.where(Number: row["Betreuer"]).count == 0 && Teacher.where(
        nv: row["Betreuer"]).count != 0 && Teacher.where(vn: row["Betreuer"]).count == 0
        row["Betreuer"] = Teacher.find_by(nv: row["Betreuer"]).Number
      elsif Teacher.where(Number: row["Betreuer"]).count != 0 && Teacher.where(
        nv: row["Betreuer"]).count == 0 && Teacher.where(vn: row["Betreuer"]).count == 0
      end
      unless Presentation.where(Name: row["Name"]).count == 1 &&
        Presentation.where(Titel: row["Titel"]).count == 1
        Presentation.create! row.to_hash
      end
    end
    presentations = Presentation.all
    presentations.each do |row| # Sets occupied seats to 0, visitors to nil
        row["Besetzt"] = 0
        row["Besucher"] = nil
        row.update_attribute(:Von, "#{Time.parse(row.Von).seconds_since_midnight}")
        row.update_attribute(:Bis, "#{Time.parse(row.Bis).seconds_since_midnight}")
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
