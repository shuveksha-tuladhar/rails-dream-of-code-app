class Trimester < ApplicationRecord
  def display_name
    "#{term} #{year}"
  end
  
  has_many :courses

  validates :start_date, presence: true
  validates :end_date, presence: true
  validates :application_deadline, presence: true
end
