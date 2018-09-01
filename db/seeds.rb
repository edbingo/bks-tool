# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'csv'

csv_text = File.read(Rails.root.join('lib', 'seeds', 'PresList.csv'))
csv = CSV.parse(csv_text, :headers => true, :encoding => 'ISO-8859-1')
csv.each do |row|
  t = Presentation.new
  t.name      =  row['name']
  t.klasse    =  row['klasse']
  t.titel     =  row['titel']
  t.fach      =  row['fach']
  t.betreuer  =  row['betreuer']
  t.zimmer    =  row['zimmer']
  t.von       =  row['von']
  t.bis       =  row['bis']
  t.frei      =  5
  t.besetzt   =  0
  t.save
  puts "#{t.name} wurde zur Datenbank hinzugefügt"
end
puts csv_text
