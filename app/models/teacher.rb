class Teacher < ApplicationRecord
  include Resetable
  require "csv"
  def self.import(file)
    table = CSV.read(file.path, { headers: true, col_sep: ";" })

    CSV.open(file.path, "w") do |f|
      f << table.headers
      table.each{ |row| f << row }
    end

    CSV.foreach(file.path, headers: true) do |row|
      Teacher.create! row.to_hash
    end
    teachers = Teacher.all
  end
  validates :Name, presence: true
  validates :Number, uniqueness: { case_sensitive: false }
  validates :Mail, presence: true
end
