crumb :root do
  link "メルカリ", root_path
end

### ↓↓マイページ関係↓↓ ###

# users#show
crumb :users do
  link "マイページ", user_path(current_user.id)
  parent :root
end

# users#published
crumb :published_user do
  link "出品した商品 - 出品中", published_user_path
  parent :users
end

# users#trading
crumb :trading_user do
  link "出品した商品 - 取引中", trading_user_path
  parent :users
end

# users#sold
crumb :sold_user do
  link "出品した商品 - 売却済み", sold_user_path
  parent :users
end

# users#buy
crumb :buy_user do
  link "購入した商品 - 取引中"
  parent :users, buy_user_path
end

# users#bought
crumb :bought_user do
  link "購入した商品 - 過去の取引"
  parent :users, bought_user_path
end

  # users#edit
crumb :edit_user do
  link "プロフィール", edit_user_path
  parent :users
end

# users#signout
crumb :signout_users do
  link "ログアウト",signout_users_path
  parent :users
end

# profiles#new
crumb :new_profile do
  link "本人情報の登録", new_user_profile_path
  parent :users
end

# credit_card#index
crumb :index_credit_card do
  link "支払い方法", user_credit_card_index_path
  parent :users
end

# credit_card#new
crumb :new_credit_card do
  link "クレジットカード情報入力", new_user_credit_card_path
  parent :index_credit_card
end

    ### ↓↓ブランド関係↓↓ ###

# ページビューなし
crumb :index_brands do
  link "ブランド一覧"
  parent :root
end

# brands#show
crumb :show_brands do
  link "#{Brand.find_by(id: params[:id]).name}",brand_path
  parent :index_brands
end

    ### ↓↓カテゴリ関係↓↓ ###

# ページビューなし
crumb :index_categories do
  link "カテゴリ一覧"
  parent :root
end

# categories#show
# メンズ、レディース等の大カテゴリ
crumb :show_categories1 do
  link "#{Category.find_by(id: params[:id]).name}",category_path
  parent :index_categories
end

# トップス、パンツ等の中カテゴリ
crumb :show_categories11 do
  main_category_id = Category.find_by(id: params[:id]).main_category_id
  link "#{Category.find_by(id: main_category_id).name}",category_path(id: main_category_id)
  parent :index_categories
end
crumb :show_categories2 do
  link "#{Category.find_by(id: params[:id]).name}"
  parent :show_categories11
end

# ポロシャツ、スラックス等の小カテゴリ
crumb :show_categories22 do
  sub_category_id = Category.find_by(id: params[:id]).sub_category_id
  link "#{Category.find_by(id: sub_category_id).name}",category_path(id: sub_category_id)
  parent :show_categories11
end
crumb :show_categories3 do
  link "#{Category.find_by(id: params[:id]).name}"
  parent :show_categories22
end


    ### ↓↓商品購入↓↓ ###

# products#show
crumb :show_products do |product|
  link "#{product.name}"
  parent :root
end
