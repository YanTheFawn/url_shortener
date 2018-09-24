class UrlShortener
  def self.call(id)
    IntegerToBase62.call(id)
  end
end
