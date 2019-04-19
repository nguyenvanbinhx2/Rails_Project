class UsersController < ApplicationController
  before_action :find_user, only: [:show, :create, :edit, :update, :destroy]
  before_action :logged_in, user, only: [:index, :edit, :update, :destroy]
  before_action :admin_user, only: :destroy
  before_action :correct_user, only: [:edit, :update]
  def show
    @user = User.find(params[:id])
    @microposts = @user.microposts.paginate(page: params[:page])
  end

  def index
    @user = User.paginate(page: params[:page], per_page: Settings.per_page_count)
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new user_params
    if @user.save
      log_in @user
      flash[:sucess] = t ".new.sucess"
      redirect_to @user
    else
      render :new
    end
  end

  def update
    if @user.update user_params
      flash.now[:sucess] = t "controller.user.update.message.sucess"
      redirect_to @user
    else
      render :edit
    end
  end

  def edit
    @user = User.find params[:id]
  end

  def destroy
    User.find_by(id: params[:id]).destroy
    flash.now[:success] = t "controller.user.user_deleted"
    redirect_to users_url
  end

  private

  def user_params
    params.require(:user).permit :name, :email, :password, :password_confirmation
  end

  def logged_in_user
    return if logged_in?
    store_location
    flash[:danger] = t "controller.user.not_login"
    redirect_to login_url
  end

  def correct_user
    redirect_to(root_url) unless current_user.current_user? @user
  end

  def admin_user
    redirect_to(root_url) unless current_user.admin?
  end

  def find_user
    @user = User.find_by id: params[:id]
    return if @user
    flash.now[:danger] = t "controller.user.show.not_found"
    redirect_to root_url
  end
end
