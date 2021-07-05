class PagesController < ApplicationController

  def show
    @page = Page.find_by_short_url(params[:short_url])
    render 'errors/404', status: 404 if @page.nil?
    @page.update_attribute(:counter, @page.counter + 1)
    redirect_to @page.long_url
  end
end
