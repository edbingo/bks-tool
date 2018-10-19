class Teacher < ApplicationRecord
  include Resetable
  require "csv"
  def self.import(file)
    $numteac = 0
    CSV.foreach(file.path, headers: true, col_sep: ";") do |row|
      unless Teacher.where(Number: row["Number"]).count >= 1
        Teacher.create! row.to_hash
        $numteac = $numteac + 1
      end
    end
    teac = Teacher.all
    teac.each do |row|
      row["Received"] = false
      row.update_attribute(:nv, "#{row.Name} #{row.Vorname}")
      row.update_attribute(:vn, "#{row.Vorname} #{row.Name}")
    end

    Teacher.all.order!(Name: :asc, Vorname: :desc)
  end
  validates :Name, presence: true
  validates :Number, uniqueness: { case_sensitive: false }
  validates :Mail, presence: true
end
