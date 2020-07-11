# frozen_string_literal: true

require 'httparty'

class PlatformBApi
  PLATFORM_B_URL = 'https://rails-code-challenge.herokuapp.com/platform_b/venue?api_key=f4ac0bb0f8bdad55977df17d72835d82'

  def platform_b_info
    response = HTTParty.get(PLATFORM_B_URL)
    JSON.parse(response.body)
  end
end