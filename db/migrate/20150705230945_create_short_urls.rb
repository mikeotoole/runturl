class CreateShortUrls < ActiveRecord::Migration
  def change
    create_table :short_urls do |t|
      t.string :original_url, limit: 2100, null: false

      t.timestamps null: false
    end
  end
end
