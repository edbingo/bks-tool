class Admin < ApplicationRecord
  include Resetable
  before_save { number.downcase! }
  validates :name, presence: true
  validates :vorname, presence: true
  validates :mail, presence: true
  validates :number, presence: true, uniqueness: {case_sensitive: false }
  has_secure_password
  validates :password, presence: true

end
