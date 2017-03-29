class CreateSearchResults < ActiveRecord::Migration[5.0]
  def change
    create_table :search_results do |t|
      t.string :json
      t.string :term

      t.timestamps
    end
    add_index :search_results, :term
  end
end
