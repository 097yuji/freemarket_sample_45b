class CreateProductSizes < ActiveRecord::Migration[5.0]
  def change
    create_table :product_sizes do |t|

      t.timestamps
    end
  end
end
