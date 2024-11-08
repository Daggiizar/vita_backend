require 'rails_helper'

RSpec.describe "Prices", type: :request do
  describe "GET /price" do
    it "returns the currrent bitcoin price" do
      get '/price'
      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body)).to have_key('bitcoin_price_in_usd')
    end
  end
end