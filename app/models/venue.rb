class Venue < ApplicationRecord
  validates :name, presence: true, uniqueness: true
  validates :address_line_1, presence: true
  validates :lat, presence: true
  validates :lng, presence: true
  validates :category_id_a, presence: true
  validate :category_id_a_is_valid
  validates :category_id_b, presence: true
  validate :category_id_b_is_valid
  validates :closed, presence: true
  validates :hours, format: { with: /(\d{2}\:\d{2}\-\d{2}\:\d{2}\,){6}\d{2}\:\d{2}\-\d{2}\:\d{2}/,
    message: 'Format must be like: 10:00-22:00,10:00-22:00,10:00-22:00,10:00-22:00,10:00-22:00,11:00-18:00,11:00-18:00' }

  VALID_CATEGORIES_ID_A = 1000..1200
  VALID_CATEGORIES_ID_B = 2000..2200

  private

  def category_id_a_is_valid
    unless category_id_a.in?(VALID_CATEGORIES_ID_A)
      errors.add(:category_id_a, 'Has to be between 1000 and 1200')
    end
  end

  def category_id_b_is_valid
    unless category_id_b.in?(VALID_CATEGORIES_ID_B)
      errors.add(:category_id_b, 'Has to be between 2000 and 2200')
    end
  end
end
