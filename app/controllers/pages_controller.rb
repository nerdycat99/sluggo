class PagesController < ApplicationController
  before_action :authenticate_user!, only: [:index]

  def index
    @pages = current_user.pages
  end

  def show
    @page = Page.find_by_short_url(params[:short_url])
    not_found if @page.nil?
    @page.update_attribute(:counter, @page.counter + 1)
    redirect_to @page.long_url
  end

  private

  def not_found
    raise ActionController::RoutingError.new('Not Found')
  end
end
