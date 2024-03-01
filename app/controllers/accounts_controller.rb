class AccountsController < ApplicationController
  before_action :set_account, only: [:show, :edit, :update, :destroy]

  def index
    #@accounts = Account.page(params[:page]).per(10)
    #@all_accounts = Account.all
    def index
      @accounts = if params[:search]
                    Account.search(params[:search]).paginate(page: params[:page], per_page: 10)
                  elsif params[:household_member_id]
                    Account.where(household_member_id: params[:household_member_id]).paginate(page: params[:page], per_page: 10)
                  else
                    Account.paginate(page: params[:page], per_page: 10)
                  end

      @household_members = HouseholdMember.all
    end
  end

  def show
    # No need to find the account again since it's already done in the before_action
  end

  def new
    @account = Account.new
  end

  def create
    @account = Account.new(account_params)

    if @account.save
      redirect_to @account, notice: 'Account was successfully created.'
    else
      render :new
    end
  end

  def edit
    # No need to find the account again since it's already done in the before_action
  end

  def update
    if @account.update(account_params)
      redirect_to @account, notice: 'Account was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @account = Account.find(params[:id])
    @account.destroy
    redirect_to accounts_url, notice: 'Account was successfully destroyed.'
  end

  private

  def set_account
    @account = Account.find(params[:id])
  end

  def account_params
    params.require(:account).permit(:household_member_id, :account_name, :balance)
  end
end
