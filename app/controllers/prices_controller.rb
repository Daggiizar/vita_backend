class PricesController < ApplicationController

  def show
    btc_price = BitcoinPriceService.get_btc_price_in_usd

    if btc_price
      render json: { bitcoin_price_in_usd: btc_price }, status: :ok
    else
      render json: { error: 'Error fetching BTC price' }, status: :service_unavailable
    end
  end
end
