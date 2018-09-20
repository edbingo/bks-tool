class Teacher < ApplicationRecord
  include Resetable
  require "csv"
  def self.import(file)
    CSV.foreach(file.path, headers: true, col_sep: ";") do |row|
      Teacher.create! row.to_hash
    end
    teac = Teacher.all
    teac.each do |row|
      row["Received"] = false
    end

    Teacher.all.order!(Name: :asc, Vorname: :desc)
  end
  validates :Name, presence: true
  validates :Number, uniqueness: { case_sensitive: false }
  validates :Mail, presence: true
end
