FactoryGirl.define do
  factory :short_url do
    original_url 'http://example.com'
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
