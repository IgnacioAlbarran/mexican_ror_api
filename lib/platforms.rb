require 'httparty'

class Platforms
  URL_A = 'https://rails-code-challenge.herokuapp.com/platform_a/venue?api_key=f4ac0bb0f8bdad55977df17d72835d82'
  URL_B = 'https://rails-code-challenge.herokuapp.com/platform_b/venue?api_key=f4ac0bb0f8bdad55977df17d72835d82'
  URL_C = 'https://rails-code-challenge.herokuapp.com/platform_c/venue?api_key=f4ac0bb0f8bdad55977df17d72835d82'

  def params_platform_a(venue)
    {
      name: venue.name,
      address_line_1: venue.address_line_1,
      lat: venue.lat,
      lng: venue.lng,
      category_id: venue.category_id_a,
      closed: venue.closed,
      hours: venue.hours_platform_a
    }.to_json
  end

  def params_platform_b(venue)
    {
      name: venue.name,
      address_line_1: venue.address_line_1,
      lat: venue.lat,
      lng: venue.lng,
      category_id: venue.category_id_b,
      closed: venue.closed,
      hours: venue.hours_platform_b
    }.to_json
  end

  def params_platform_c(venue)
    {
      name: venue.name,
      address_line_1: venue.address_line_1,
      address_line_2: venue.address_line_2,
      website: venue.website,
      phone_number: venue.phone_number,
      lat: venue.lat,
      lng: venue.lng,
      closed: venue.closed,
      hours: venue.hours
    }.to_json
  end


  def platform_info_from(platform_url)
    response = HTTParty.get(platform_url)
    JSON.parse(response.body)
  end

  def change_platforms(venue)
    HTTParty.patch(URL_A, body: params_platform_a(venue).to_json)
    HTTParty.patch(URL_B, body: params_platform_b(venue).to_json)
    HTTParty.patch(URL_C, body: params_platform_c(venue).to_json)
  end
end