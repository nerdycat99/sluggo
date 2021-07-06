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

  def new
    @page = Page.new
  end

  def create
    @page = current_user.pages.create(page_params)
    if @page.persisted?
      redirect_to user_pages_path(current_user)
    else
      flash.now[:alert] = "Invalid url, please try again"
      render :new
    end
  end

  private

  def not_found
    raise ActionController::RoutingError.new('Not Found')
  end

  def page_params
    params.require(:page).permit(:long_url)
  end
end
