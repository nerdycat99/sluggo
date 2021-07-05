class PagesController < ApplicationController

  def index
    @pages = current_user.pages
  end

  def show
    @page = Page.find_by_short_url(params[:short_url])
    render 'errors/404', status: 404 if @page.nil?
    @page.update_attribute(:counter, @page.counter + 1)
    redirect_to @page.long_url
  end

  private

  def current_user_in
    @current_user_in = current_user
  end
end
