# frozen_string_literal: true

require 'httparty'

class PlatformAApi
  PLATFORM_A_URL = 'https://rails-code-challenge.herokuapp.com/platform_a/venue?api_key=f4ac0bb0f8bdad55977df17d72835d82'

  def platform_a_info
    response = HTTParty.get(PLATFORM_A_URL)
    JSON.parse(response.body)
  end
end
