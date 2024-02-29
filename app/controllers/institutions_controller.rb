class InstitutionsController < ApplicationController
  before_action :set_institution, only: [:show]

  def show
    # Your show action logic goes here
  end

  private

  def set_institution
    @institution = Institution.find(params[:id])
  end
end
