class ShortUrl < ActiveRecord::Base
  before_validation :clean_original_url

  URL_REGEX = %r{
    \A(http|https):\/\/[[:alnum:]]+([\-\.]{1}[[:alnum:]]+)*\.[a-z]{2,}(:[0-9]{1,5})?(\/.*)?$\z
  }ix.freeze

  validates :original_url, presence: true,
                           format: { with: URL_REGEX, message: 'does not look like a URL' }

  def self.find_by_base62_id!(base62_id)
    base62_id = base62_id.to_s
    if /\A[a-zA-Z0-9]+\z/.match(base62_id)
      find(Base62.decode(base62_id))
    else
      fail ActiveRecord::RecordNotFound, "#{base62_id} is not a valid base62 string"
    end
  end

  def base62_id
    if persisted?
      Base62.encode(id)
    else
      fail 'base62_id can only be called on persisted ShortUrls.'
    end
  end

  def url_for_host(host)
    "#{host}#{base62_id}"
  end

  private

  # Match if the string starts with http or https.
  PROTOCOL_REGEX = /\Ahttp(s)?/i.freeze
  private_constant :PROTOCOL_REGEX

  # # Allow users to enter URLs without protocol and extra whitespace.
  def clean_original_url
    if original_url
      url = original_url.strip
      url = 'http://' + url unless PROTOCOL_REGEX.match(url)
      url = URI.parse(url).normalize.to_s
      self.original_url = url
    end
  rescue URI::InvalidURIError # rubocop:disable HandleExceptions
  end
end

# == Schema Information
#
# Table name: short_urls
#
#  id           :integer          not null, primary key
#  original_url :string(2100)     not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#
