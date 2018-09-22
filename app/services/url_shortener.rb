class UrlShortener
  def self.call(url)
    url_id = Link.create(url: url).id

    IntegerToBase62.call(url_id)
  end
end
