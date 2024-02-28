class TransactionsController < ApplicationController
  before_action :set_transaction, only: [:show, :edit, :update, :destroy]

  def index
    @transactions = Transaction.page(params[:page]).per(10)
  end

  def show
    # set_transaction before_action will set the @transaction instance variable
  end

  def new
    @transaction = Transaction.new
  end

  def create
    @transaction = Transaction.new(transaction_params)

    if @transaction.save
      redirect_to @transaction, notice: 'Transaction was successfully created.'
    else
      render :new
    end
  end

  def edit
    # set_transaction before_action will set the @transaction instance variable
  end

  def update
    if @transaction.update(transaction_params)
      redirect_to @transaction, notice: 'Transaction was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @transaction.destroy
    redirect_to transactions_url, notice: 'Transaction was successfully destroyed.'
  end

  private

  def set_transaction
    @transaction = Transaction.find(params[:id])
  end

def transaction_params
  params.require(:transaction).permit(
    :household_member_id,
    :account_id,
    :transaction_type,
    :amount,
    :date,
    :description,
    transaction_categories_attributes: [:id, :category_id],
    transaction_tags_attributes: [:id, :tag_id]
  )
end

end