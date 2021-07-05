class Page < ApplicationRecord
  validates_presence_of :long_url
  validates :long_url, format: URI::regexp(%w[http https])
  validates_uniqueness_of :short_url

  belongs_to :user

  def short
    Rails.application.routes.url_helpers.short_url(short_url: self.short_url)
  end
end
