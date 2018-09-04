# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Admin.create(name:"Lancaster",vorname:"Edward",mail:"elancaster4@gmail.com",number:"s9362",
  password:"Site",password_confirmation:"Site")

Admin.create(name:"User",vorname:"Admin",mail:"admin@localhost",number:"a2",
  password:"hallo123",password_confirmation:"hallo123")

Schueler.create(Vorname:"Edward",Name:"Lancaster",Klasse:"6 Gf",Mail:"s9362@bks-campus.ch",Number:"s9362",
Code:nil,Registered:false,Selected:nil,password:"Site",password_confirmation:"Site")
