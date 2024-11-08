class TransactionService

  def self.create_transaction(user, currency_sent, currency_received, amount_sent)

    btc_price_in_usd = BitcoinPriceService.get_btc_price_in_usd.to_f

    amount_received = (currency_received == 'BTC' ? amount_sent / btc_price_in_usd : amount_sent * btc_price_in_usd)

    if currency_sent == 'USD' && user.balance < amount_sent
      return { sucess: false, error: 'Insufficient balance for purchase' }
    end

    transaction = user.transactions.create(
      currency_sent: currency_sent,
      currency_received: currency_received,
      amount_sent: amount_sent,
      amount_received: amount_received
    )

    if currency_sent == 'USD'
      user.update(balance: user.balance - amount_sent)
    end

    { success: true, transaction: transaction }
    end
end
