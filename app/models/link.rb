class Link < ApplicationRecord
  validates_presence_of :url
  after_save :set_shortened_url, :if => Proc.new {|link| link.id_previously_changed? }
  validate :url_is_https


  PROTOCOL = "https://".freeze
  DOMAIN_NAME = "mysite.com"

  def self.most_popular
    order(access_count: :desc).limit(100).map {|link| { url: link.url, access_count: link.access_count}}
  end

  def self.url_prefix
    "#{PROTOCOL}#{DOMAIN_NAME}/"
  end

  def display_shortened_url
    "#{self.class.url_prefix}#{shortened_url}"
  end

  private
  def url_is_https
    https_pattern = /^https:\/\//
    if !https_pattern.match?(self.url)
      errors.add(:url, "url must start with 'https://'")
    end
  end

  def set_shortened_url
    self.update_attributes(shortened_url: UrlShortener.call(self.id))
  end
end
