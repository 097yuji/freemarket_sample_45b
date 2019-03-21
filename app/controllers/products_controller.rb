class ProductsController < ApplicationController
before_action :authenticate_user!, except: [:index, :show, :search]
before_action :set_product, only: [:edit, :update, :destroy, :stop, :start]
#トップページ
  def index
    @ladies = Category.find(1)
    @mens = Category.find(2)
    @baby = Category.find(3)
    @cosme = Category.find(7)
    @ladies_item = Product.joins(:category).merge(Category.where(main_category_id: 1)).limit(4).order(id: "DESC")
    @mens_item = Product.joins(:category).merge(Category.where(main_category_id: 2)).limit(4).order(id: "DESC")
    @baby_item = Product.joins(:category).merge(Category.where(main_category_id: 3)).limit(4).order(id: "DESC")
    @cosme_item = Product.joins(:category).merge(Category.where(main_category_id: 7)).limit(4).order(id: "DESC")
    @chanel = Brand.find(1)
    @vuitton = Brand.find(2)
    @supreme = Brand.find(3)
    @nike = Brand.find(4)
    @chanel_item = Product.where(brand_id: 1).limit(4).order(id: "DESC")
    @vuitton_item = Product.where(brand_id: 2).limit(4).order(id: "DESC")
    @supreme_item = Product.where(brand_id: 3).limit(4).order(id: "DESC")
    @nike_item = Product.where(brand_id: 4).limit(4).order(id: "DESC")
  end

#商品詳細ページ
  def show
    @product = Product.find(params[:id])
    @other_product_previous = Product.order(id: "DESC").where("id < ?", params[:id]).first
    @other_product_next = Product.order(id: "DESC").where("id > ?", params[:id]).reverse.first
    @user_other_products = Product.where("(user_id = ?) AND (status = ?)", @product.user_id, 0).where.not(id: params[:id]).limit(6)
    @other_products = Product.where("brand_id = ?", @product.brand_id).joins(:category).merge(Category.where("sub_category_id = ?" , @product.category.sub_category_id)).where.not(id: params[:id]).limit(6)
    @other_products_no_brand = Product.joins(:category).merge(Category.where("sub_category_id = ?" , @product.category.sub_category_id)).where.not(id: params[:id]).limit(6)
  end

#商品検索機能
  def search
    if params[:keyword] != ""
      @products = Product.where('name LIKE(?)', "%#{params[:keyword]}%").limit(20)
    end
    @search = Product.ransack(params[:q])
    @products = @search.result
    @search.build_sort if @search.sorts.empty?
  end

#商品出品ページ
  def new
    @product = Product.new
    @product.product_images.build
    @product.build_brand
  end

#トップページへリダイレクト
  def create
    @product = Product.new(product_params)
    if @product.save
      @product.new_brand(params[:product][:brand_attributes][:name]) if params[:product][:brand_attributes][:name].present?
      redirect_to root_path
    else
      render :new
    end
  end

  def edit
    @product_images = @product.product_images
    @product_sales_fee = ( @product.price * 0.1 ).floor
    @product_sales_profit = @product.price - @product_sales_fee
    @product_images.each do |product_image|
      product_image.image.cache!
    end
    @product.build_brand if @product.brand_id.nil?
  end

  def update
    if @product.user_id == current_user.id
      if @product.brand_id.present?
        @product.new_brand(params[:product][:brand_attributes][:name]) if @product.brand.name != params[:product][:brand_attributes][:name]
      else
        @product.new_brand(params[:product][:brand_attributes][:name]) if params[:product][:brand_attributes][:name].present?
      end
      if @product.update_attributes(product_params)
        brand_null_update
        redirect_to root_path
      else
        @product_images = @product.product_images
        @product.build_brand if @product.brand_id.nil?
        render :edit
      end
    end
  end

  def destroy
    if @product.user == current_user
      @product.destroy
    end
    redirect_to root_path
  end

  def stop
    @product.status = 'stopped'
    @product.save
    render :show
  end

  def start
    @product.status = 'published'
    @product.save
    render :show
  end

private
  def product_params
    params.require(:product).permit(:name, :description, :category_id, :product_size_id, :brand_id, :condition, :shipping_method, :shipping_burden, :area_id, :estimated_date, :price, product_images_attributes:[:id, :image, :image_cache], brand_attributes:[:id, :name]).merge(user_id: current_user.id)
  end

  def brand_null_update
    @product.brand_id = nil if params[:product][:brand_attributes][:id].present? && params[:product][:brand_attributes][:name].blank?
    @product.save
  end

  def set_product
    @product = Product.find(params[:id])
  end
end
