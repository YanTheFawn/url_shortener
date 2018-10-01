class LinkSerializer < ActiveModel::Serializer
  attributes :shortened_url

  def shortened_url
    object.display_shortened_url
  end
end
