class CreateHasCategories < ActiveRecord::Migration
  def change
    create_table :has_categories do |t|
      t.references :article, index: true
      t.references :category, index: true

      t.timestamps null: false
    end
    add_foreign_key :has_categories, :articles
    add_foreign_key :has_categories, :categories
  end
end
