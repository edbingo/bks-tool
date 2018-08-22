class Schueler < ApplicationRecord
  before_save { mail.downcase! }
  validates :name,     presence: true
  validates :vorname,  presence: true
  validates :klasse,   presence: true
  validates :mail,     presence: true
  validates :number,   presence: true, uniqueness: { case_sensitive: false }
  has_secure_password
  validates :password, presence: true
end
