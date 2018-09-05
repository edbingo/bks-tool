class Teacher < ApplicationRecord
  include Resetable
  require "csv"
  def self.import(file)
    CSV.foreach(file.path, headers:true) do |row|
      Teacher.create! row.to_hash
    end
    teacher = Teacher.all
    teacher.each do |entry|
      entry.update_attribute(:Received, false)
    end
  end
  validates :Name, presence: true
  validates :Mail, presence: true
end
