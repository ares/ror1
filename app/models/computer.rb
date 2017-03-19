class Computer < ApplicationRecord
  CITIES = [ 'Brno', 'Praha' ]
  validates :vendor, :presence => true
  validates :city, :inclusion => CITIES
  validates :serial_number, :numericality => true
  validates :serial_number, :uniqueness => true
  validates :serial_number, :presence => true

  belongs_to :user
end
