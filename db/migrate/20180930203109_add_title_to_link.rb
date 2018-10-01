class AddTitleToLink < ActiveRecord::Migration[5.2]
  def change
    add_column :links, :title, :text
  end
end
