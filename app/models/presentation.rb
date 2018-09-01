class Presentation < ApplicationRecord
  validates :name, presence: true
  validates :klasse, presence: true
  validates :titel, presence: true
  validates :fach, presence: true
  validates :betreuer, presence: true
  validates :zimmer, presence: true
  validates :von, presence: true
  validates :bis, presence: true
end
