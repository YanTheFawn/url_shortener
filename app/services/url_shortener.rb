class UrlShortener
  def self.call(url)
    id = Link.find_by_url(url).id

    IntegerToBase62.call(id)
  end
end
