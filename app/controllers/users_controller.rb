class UsersController < ApplicationController
  before_action :authenticate_user!, except: :new
  before_action :set_user, only: [:edit, :update, :published, :trading, :sold, :buy, :bought]
  def new
  end


  def show
  end

  def edit

  end

  def update
    if @user.id == current_user.id
      @user.update(user_params)
    end
    redirect_to action: :edit
  end

  def signout
  end

  def identification
  end

  def published
    @products = @user.products.where(status: 'published').or(@user.products.where(status: 'stopped'))
  end

  def trading
    @products = @user.products.trading
  end

  def sold
    @products = @user.products.sold
  end

  def buy 
    @products = @user.products.trading
  end

  def bought
    products_number = @user.purchases[0].product_id
    @products = Product.find(products_number)
  end

  private
  def user_params
    params.require(:user).permit(:nickname, :introduction)
  end

  def set_user
    @user = User.find(params[:id])
  end

end
