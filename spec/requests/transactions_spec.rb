require 'rails_helper'

RSpec.describe "Transactions", type: :request do
  let!(:user) { create(:user) }

  describe "POST /transactions" do
    it "creates a new transaction" do
      post '/transactions', params: { 
        user_id: user.id, 
        currency_sent: 'USD', 
        currency_received: 'BTC', 
        amount_sent: 100.0 
      }
      expect(response).to have_http_status(:created)
      expect(JSON.parse(response.body)).to have_key('transaction')
    end

    it "returns an error if the user is not found" do
      post '/transactions', params: { 
        user_id: 999, 
        currency_sent: 'USD', 
        currency_received: 'BTC', 
        amount_sent: 100 
      }
      expect(response).to have_http_status(:not_found)
    end
  end

  describe "GET /transactions" do
    it "returns all transactions for a user" do
      create(:transaction, user: user)
      get "/transactions", params: { user_id: user.id }
      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body)).to be_an(Array)
    end
  end

  describe "GET /transactions/:id" do
    let!(:transaction) { create(:transaction, user: user) }

    it "returns the details of a specific transaction" do
      get "/transactions/#{transaction.id}", params: { user_id: user.id }
      expect(response).to have_http_status(:ok)

      response_body = JSON.parse(response.body)
      expect(response_body["id"]).to eq(transaction.id)
      expect(response_body["currency_sent"]).to eq(transaction.currency_sent)
      expect(response_body["amount_sent"].to_f).to eq(transaction.amount_sent)
    end

    it "returns an error if transaction not found" do
      get "/transactions/999", params: { user_id: user.id }
      expect(response).to have_http_status(:not_found)
    end
  end
end