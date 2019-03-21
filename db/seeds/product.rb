4.times do
Product.create(name: "レディースアイテム",description: "test", price: 2000, area_id: 1,condition: "新品、未使用", product_size_id: 1, shipping_method: "未定", shipping_burden: "送料込み(出品者負担)", estimated_date: "1~2日で発送", user_id: 1, category_id: 146, brand_id: 1, product_images_attributes:[image: File.open("#{Rails.root}/db/fixtures/テスト.png")])
end


4.times do
Product.create(name: "メンズアイテム",description: "test", price: 5000, area_id: 1,condition: "新品、未使用", product_size_id: 1, shipping_method: "未定", shipping_burden: "送料込み(出品者負担)", estimated_date: "1~2日で発送", user_id: 1, category_id: 303, brand_id: 2, product_images_attributes:[image: File.open("#{Rails.root}/db/fixtures/テスト.png")])
end


4.times do
Product.create(name: "ベビーアイテム",description: "test", price: 5000, area_id: 1,condition: "新品、未使用", product_size_id: 1, shipping_method: "未定", shipping_burden: "送料込み(出品者負担)", estimated_date: "1~2日で発送", user_id: 5, category_id: 456, brand_id: 3, product_images_attributes:[image: File.open("#{Rails.root}/db/fixtures/テスト.png")])
end


4.times do
Product.create(name: "コスメアイテム",description: "test", price: 5000, area_id: 1,condition: "新品、未使用", product_size_id: 1, shipping_method: "未定", shipping_burden: "送料込み(出品者負担)", estimated_date: "1~2日で発送", user_id: 5, category_id: 771, brand_id: 4, product_images_attributes:[image: File.open("#{Rails.root}/db/fixtures/テスト.png")])
end
