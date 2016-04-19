class ContactUsController < ApplicationController

  def new

  end

  def create
    @full_name = params[:full_name]
  end
end
