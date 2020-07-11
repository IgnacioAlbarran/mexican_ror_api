# frozen_string_literal: true

require 'httparty'

class Platforms
  URL_A = 'https://rails-code-challenge.herokuapp.com/platform_a/venue?api_key=f4ac0bb0f8bdad55977df17d72835d82'
  URL_B = 'https://rails-code-challenge.herokuapp.com/platform_b/venue?api_key=f4ac0bb0f8bdad55977df17d72835d82'
  URL_C = 'https://rails-code-challenge.herokuapp.com/platform_c/venue?api_key=f4ac0bb0f8bdad55977df17d72835d82'

  def platform_info_from(platform_url)
    response = HTTParty.get(platform_url)
    JSON.parse(response.body)
  end
end
