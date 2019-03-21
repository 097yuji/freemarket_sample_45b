class Product < ApplicationRecord
  belongs_to :user
  belongs_to :area
  belongs_to :product_size
  belongs_to :brand, optional: true
  accepts_nested_attributes_for :brand, reject_if: :reject_brand_blank, allow_destroy: true
  has_many :product_images, dependent: :delete_all
  accepts_nested_attributes_for :product_images, reject_if: :reject_image_no_change, allow_destroy: true, limit: 10
  belongs_to :category
  has_many :purchases
  has_many :users, through: :purchases

  enum condition:       {"新品、未使用": 0, "未使用に近い": 1, "目立った傷や汚れなし": 2, "やや傷や汚れあり": 3, "傷や汚れあり": 4, "全体的に状態が悪い": 5}

  enum shipping_method: {"未定": 0, "らくらくメルカリ便": 1, "ゆうメール": 2, "レターパック": 3, "普通郵便(定形、定形外)": 4, "クロネコヤマト": 5, "ゆうパック": 6, "クリックポスト": 7, "ゆうパケット": 8}

  enum shipping_burden: {"送料込み(出品者負担)": 0, "着払い(購入者負担)": 1}

  enum estimated_date: {"1~2日で発送": 0, "2~3日で発送": 1, "4~7日で発送": 2}

  enum status: {published: 0, stopped: 1, trading: 2, sold: 3}

  validates :name, length: { maximum: 40 }, presence: true
  validates :description, length: { maximum: 1000 }, presence: true
  validates :price, numericality: { only_integer: true, greater_than_or_equal_to: 300, less_than_or_equal_to: 9999999 }, presence: true
  validates :area_id, presence: true
  validates :condition, presence: true
  validates :product_size_id, presence: true
  validates :shipping_method, presence: true
  validates :shipping_burden, presence: true
  validates :estimated_date, presence: true
  validates :user_id, presence: true
  validates :product_images, length: { minimum: 1, maximum: 10 }

  def reject_brand_blank(attributes)
    exists = Brand.find_by(name: attributes[:name]).present?
    empty = attributes[:name].blank?
    exists || empty
  end

  def reject_image_no_change(attributes)
    exists = ProductImage.find_by(id: attributes[:id]).present?
    destory = attributes[:image_cache].nil?
    empty = attributes[:image].blank?
    if exists
      attributes.merge!(_destroy: 1) if destory
      return !destory
    else
      return empty
    end
  end

  def new_brand(brand_name)
    self.brand = Brand.find_by(name: brand_name) if Brand.find_by(name: brand_name)
    self.save
  end

  def self.find_products_match_category(category)
    if category.main_category_id.nil? && category.sub_category_id.nil?
      self.joins(:category).merge(Category.where(main_category_id: category.id)).order("created_at DESC")
    elsif category.main_category_id.present? && category.sub_category_id.nil?
      self.joins(:category).merge(Category.where(sub_category_id: category.id)).order("created_at DESC")
    end
  end

end
