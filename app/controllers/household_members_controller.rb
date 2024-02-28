class HouseholdMembersController < ApplicationController
  before_action :set_household_member, only: [:show, :edit, :update, :destroy]

  def index
    @household_members = HouseholdMember.all
  end

  def show
    @household_member = HouseholdMember.find(params[:id])
  end

  def new
    @household_member = HouseholdMember.new
  end

  def create
    @household_member = HouseholdMember.new(household_member_params)

    if @household_member.save
      redirect_to @household_member, notice: 'Household member was successfully created.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @household_member = HouseholdMember.find(params[:id])
  end

  def update
    if @household_member.update(household_member_params)
      redirect_to @household_member, notice: 'Household member was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @household_member = HouseholdMember.find(params[:id])
    @household_member.destroy
    redirect_to household_members_url, notice: 'Household member was successfully destroyed.'
  end

  private

  def set_household_member
    @household_member = HouseholdMember.find(params[:id])
  end

  def household_member_params
    params.require(:household_member).permit(:name)
  end
end
