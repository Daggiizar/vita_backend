require 'httparty'

class BitcoinPriceService
  COINDESK_API_URL = ENV['COINDESK_API_URL']

  def self.get_btc_price_in_usd
    response = HTTParty.get(COINDESK_API_URL)

    if response.success?
      price = response['bpi']['USD']['rate_float']
      format('%.2f', price)
    else
      nil
    end
  end
end