class RenameFavaritesToFavorites < ActiveRecord::Migration[5.2]
  def change
    rename_table :favarites, :favorites
  end
end
