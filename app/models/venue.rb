class Venue < ApplicationRecord
  HOURS_REGEXP = /(\d{2}\:\d{2}\-\d{2}\:\d{2}\,){6}\d{2}\:\d{2}\-\d{2}\:\d{2}/
  URL_REGEXP = /(http|https):\/\/[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(:[0-9]{1,5})?(\/.*)?/ix
  DAYS_OF_WEEK = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun']
  VALID_CATEGORIES_ID_A = 1000..1200
  VALID_CATEGORIES_ID_B = 2000..2200

  validates :name, presence: true, uniqueness: true
  validates :address_line_1, presence: true
  validates :lat, presence: true
  validates :lng, presence: true
  validates :category_id_a, presence: true
  validate :category_id_a_is_valid
  validates :category_id_b, presence: true
  validate :category_id_b_is_valid
  validates :closed, exclusion: { in: [nil] }
  validates :hours, presence: true
  validates :hours, format: { with: HOURS_REGEXP,
    message: 'Format must be like: 10:00-22:00,10:00-22:00,10:00-22:00,10:00-22:00,10:00-22:00,11:00-18:00,11:00-18:00' }
  validates :website, format: { with: URL_REGEXP, message: 'You provided invalid URL' }

  def params_platform_a
    {"venue":
      {
        name: name,
        address: address_line_1,
        lat: lat,
        lng: lng,
        category_id: category_id_a,
        closed: closed,
        hours: hours_platform_a
      }
    }
  end

  def params_platform_b
    {"venue":
      {
        name: name,
        street_address: address_line_1,
        lat: lat,
        lng: lng,
        category_id: category_id_b,
        closed: closed,
        hours: hours_platform_b
      }
    }
  end

  def params_platform_c
    {"venue":
      {
        name: name,
        address_line_1: address_line_1,
        address_line_2: address_line_2,
        website: website,
        phone_number: phone_number,
        lat: lat,
        lng: lng,
        closed: closed,
        hours: hours
      }
    }
  end

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

  def hours_platform_a
    hours.split(',').map { |day| day }.join("|")
  end

  def hours_platform_b
    hours.split(',').map.with_index { |day, i| DAYS_OF_WEEK[i] + ':' + day }.join("|")
  end

end
