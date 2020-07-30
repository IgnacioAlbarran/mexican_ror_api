require 'httparty'

class Platforms
  API_KEY = File.read('external_apis_key')
  URL_A = "https://rails-code-challenge.herokuapp.com/platform_a/venue?api_key=#{API_KEY}"
  URL_B = "https://rails-code-challenge.herokuapp.com/platform_b/venue?api_key=#{API_KEY}"
  URL_C = "https://rails-code-challenge.herokuapp.com/platform_c/venue?api_key=#{API_KEY}"

  def platform_info_from(platform_url)
    response = HTTParty.get(platform_url)
    JSON.parse(response.body)
  end

  def update_platform(url, params)
    Thread.new{
      begin
        (HTTParty.patch(url, body: params))
      rescue StandardError => e
        send_error_to_logger(url, params, e)
        @error_json = { venue: { "status": 'error', "message": e.message } }
      end
    }
  end

  def send_error_to_logger(url, params, e)
    error =  %(\n* * * * * ERROR * * * *
               \n #{Time.now}
               \n PLATFORM NOT UPDATED
               \n URL: #{url}
               \n MESSAGE: #{e.message}
               \n PARAMS: #{params}
               \n* * * * *  END  * * * *)
    logger = Rails.logger
    logger.error error
  end

  def change_platforms(venue)
    threads = []

    threads << update_platform(URL_A, venue.params_platform_a)

    threads << update_platform(URL_B, venue.params_platform_b)
    threads << update_platform(URL_C, venue.params_platform_c)
    threads.each(&:join)
  end
end
