class CreateLinks < ActiveRecord::Migration[5.2]
  def change
    create_table :links do |t|
      t.text :url
      t.text :shortened_url

      t.timestamps
    end
  end
end
