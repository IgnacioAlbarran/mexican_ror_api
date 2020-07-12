require 'rails_helper'

RSpec.describe Venue do
  subject { build :venue}

  it { is_expected.to be_valid }
  it { is_expected.to validate_presence_of(:name) }
  it { is_expected.to validate_uniqueness_of(:name) }
  it { is_expected.to validate_presence_of(:address_line_1) }
  it { is_expected.to validate_presence_of(:lat) }
  it { is_expected.to validate_presence_of(:lng) }
  it { is_expected.to validate_presence_of(:category_id_a) }
  it { is_expected.to validate_presence_of(:category_id_b) }

  it 'should validate correct category_id numbers' do
    Venue.new(category_id_a: 200).should_not be_valid
    Venue.new(category_id_b: 3000).should_not be_valid
  end

  it 'closed should not be nil' do
    Venue.new(closed: nil).should_not be_valid
  end

  it { is_expected.to validate_presence_of(:hours) }
end
