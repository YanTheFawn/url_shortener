class Link < ApplicationRecord
  validates_presence_of :url
  after_save :set_shortened_url, :if => Proc.new {|link| link.id_previously_changed? }

  PROTOCOL = "https://".freeze
  DOMAIN_NAME = "mysite.com"

  private

  def shortened_url
    "#{PROTOCOL}#{DOMAIN_NAME}/#{super}"
  end

  def set_shortened_url
    self.update_attributes(shortened_url: UrlShortener.call(self.id))
  end
end
