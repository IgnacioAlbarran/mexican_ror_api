require 'httparty'

class Platforms
  URL_A = 'https://rails-code-challenge.herokuapp.com/platform_a/venue?api_key=f4ac0bb0f8bdad55977df17d72835d82'
  URL_B = 'https://rails-code-challenge.herokuapp.com/platform_b/venue?api_key=f4ac0bb0f8bdad55977df17d72835d82'
  URL_C = 'https://rails-code-challenge.herokuapp.com/platform_c/venue?api_key=f4ac0bb0f8bdad55977df17d72835d82'

  def params_platform_a(venue)
    {"venue":
      {
        name: venue.name,
        address_line_1: venue.address_line_1,
        lat: venue.lat,
        lng: venue.lng,
        category_id: venue.category_id_a,
        closed: venue.closed,
        hours: venue.hours_platform_a
      }
    }
  end

  def params_platform_b(venue)
    {"venue":
      {
        name: venue.name,
        address_line_1: venue.address_line_1,
        lat: venue.lat,
        lng: venue.lng,
        category_id: venue.category_id_b,
        closed: venue.closed,
        hours: venue.hours_platform_b
      }
    }
  end

  def params_platform_c(venue)
    {"venue":
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
      }
    }
  end

  def platform_info_from(platform_url)
    response = HTTParty.get(platform_url)
    JSON.parse(response.body)
  end

  def update_platform(url, params)
    Thread.new{
      begin
        HTTParty.patch(url, body: params)
      rescue StandardError => e
        send_error_to_logger(url, params, e)
        render json: { venue: { "status": 'error', "message": e.message } }
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

    threads << update_platform(URL_A, params_platform_a(venue))
    threads << update_platform(URL_B, params_platform_b(venue))
    threads << update_platform(URL_C, params_platform_c(venue))
    threads.each(&:join)
  end
end
