require 'rails_helper'

RSpec.describe ShortUrl, type: :model do
  subject { create(:short_url) }

  describe '::find_by_base62_id!' do
    context 'when given the base62 version of an existing id' do
      it 'returns the ShortUrl' do
        base62_id = Base62.encode(subject.id)
        expect(ShortUrl.find_by_base62_id!(base62_id)).to eq subject
      end
    end

    context 'when given the base62 version of an id that does not exist' do
      it 'raises ActiveRecord::RecordNotFound error for id not found' do
        expect do
          ShortUrl.find_by_base62_id!('GG')
        end.to raise_error(/Couldn't find ShortUrl with 'id'=/)
      end
    end

    context 'when given a string with an invalid base62 character' do
      it 'raises ActiveRecord::RecordNotFound error for invalid string' do
        expect do
          ShortUrl.find_by_base62_id!('')
        end.to raise_error(/is not a valid base62 string/)

        %w(GG_ GG\ c GG- GGÔ).each do |base62_id|
          expect do
            ShortUrl.find_by_base62_id!(base62_id)
          end.to raise_error(/is not a valid base62 string/)
        end
      end
    end
  end

  describe '#original_url' do
    it 'is required' do
      expect(build(:short_url, original_url: nil)).not_to be_valid
    end

    it 'allows valid urls' do
      expect(build(:short_url, original_url: 'https://example.com')).to be_valid
      expect(build(:short_url, original_url: 'https://example.com/ß∂')).to be_valid
      expect(build(:short_url, original_url: 'https://exampleå.com')).to be_valid
      expect(build(:short_url, original_url: 'http://example.com')).to be_valid
      expect(build(:short_url, original_url: 'http://example.com ')).to be_valid
      expect(build(:short_url, original_url: 'http://example.com?q=cat')).to be_valid
      expect(build(:short_url, original_url: 'example.com?q=cat')).to be_valid
      expect(build(:short_url, original_url: 'http://www.test.example.com')).to be_valid
      expect(build(:short_url, original_url: 'example.anything')).to be_valid
    end

    it 'does not allow invalid urls' do
      expect(build(:short_url, original_url: 'example')).not_to be_valid
      expect(build(:short_url, original_url: 'example..com')).not_to be_valid
      expect(build(:short_url, original_url: 'http://')).not_to be_valid
      expect(build(:short_url, original_url: 'http:')).not_to be_valid
      expect(build(:short_url, original_url: 'http:example.com')).not_to be_valid
      expect(build(:short_url, original_url: 'ht://example.com')).not_to be_valid
      expect(build(:short_url, original_url: 'ftp://example.com')).not_to be_valid
      expect(build(:short_url, original_url: 'urn:isbn:0451450523')).not_to be_valid
      expect(build(:short_url, original_url: 'http://example.com more')).not_to be_valid
      expect(build(:short_url, original_url: "http://example.com\nmore")).not_to be_valid
      expect(build(:short_url, original_url: 'http://example')).not_to be_valid
      expect(build(:short_url, original_url: ':::example')).not_to be_valid
    end
  end

  describe '#base62_id' do
    context 'when persisted' do
      it 'returns base62 of id' do
        subject.id = 42
        expect(subject.base62_id).to eq 'G'
      end
    end

    context 'when not persisted' do
      subject { build(:short_url) }

      it 'should raise an error' do
        expect do
          subject.base62_id
        end.to raise_error(/can only be called on persisted/)
      end
    end
  end

  describe '#url_for_host' do
    it 'returns url with base62 of id added to given host' do
      subject.id = 42
      expect(subject.url_for_host('http://example.com/')).to eq 'http://example.com/G'
    end
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
