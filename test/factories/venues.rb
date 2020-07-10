FactoryBot.define do
  factory :venue do
    name            { FFaker::Name.name }
    address_line_1  { FFaker::AddressNL.street_address }
    address_line_2  { FFaker::AddressNL.secondary_address }
    website         { FFaker::InternetSE.http_url }
    phone_number    { '913697070' }
    lat             { 38.8951 }
    lng             { -77.0364 }
    category_id_a   { 1100 }
    category_id_b   { 2100 }
    closed          { true }
    hours           { '10:00-22:00,10:00-22:00,10:00-22:00,10:00-22:00,10:00-22:00,11:00-18:00,11:00-18:00' }
  end
end
