class Link < ApplicationRecord
  validates_presence_of :url
  after_save :set_shortened_url, :if => Proc.new {|link| link.id_previously_changed? }

  PROTOCOL = "https://".freeze
  DOMAIN_NAME = "mysite.com"

  def self.most_popular
    Link.order(access_count: :desc).limit(100).pluck(:url)
  end

  def self.url_prefix
    "#{PROTOCOL}#{DOMAIN_NAME}/"
  end

  def shortened_url
    "#{self.class.url_prefix}#{super}"
  end

  private

  def set_shortened_url
    self.update_attributes(shortened_url: UrlShortener.call(self.id))
  end
end
