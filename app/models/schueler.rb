class Schueler < ApplicationRecord
  before_save { self.mail = mail.downcase }
  validates :name,    presence: true
  validates :vorname, presence: true
  validates :klasse,  presence: true
  validates :mail,    presence: true, uniqueness: { case_sensitive: false }
  has_secure_password
end
