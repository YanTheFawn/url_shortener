class AddAccessCountToLinks < ActiveRecord::Migration[5.2]
  def change
    add_column :links, :access_count, :integer, default: 0
  end
end
