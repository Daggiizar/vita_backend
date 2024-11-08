class TransactionsController < ApplicationController
  skip_before_action :verify_authenticity_token

  def create

    user = User.find_by(id: params[:user_id])
    if user.nil?
      return render json: { error: 'User not found' }, status: :not_found
    end

    currency_sent = params[:currency_sent]
    currency_received = params[:currency_received]
    amount_sent = params[:amount_sent].to_f

    result = TransactionService.create_transaction(user, currency_sent, currency_received, amount_sent)

    if result[:success]
      render json: { transaction: result[:transaction] }, status: :created
    else
      render json: { error: result[:error] }, status: :unprocessable_entity
    end
  end

  def index

    user = User.find_by(id: params[:user_id])
    if user.nil?
      return render json: { error: 'User not found' }, status: :not_found
    end

    transactions = user.transactions
    render json: transactions, status: :ok
  end

  def show
    
    transaction = Transaction.find_by(id: params[:id], user_id: params[:user_id])

    if transaction
      render json: transaction, status: :ok
    else
      render json: { error: 'Transaction not found' }, status: :not_found
    end
  end
end
