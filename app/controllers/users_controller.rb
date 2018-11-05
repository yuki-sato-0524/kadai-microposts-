class UsersController < ApplicationController
  before_action :require_user_logged_in, only:[:index,:show]
  def index
    @users = User.all.page(params[:page]).per(15)
  end

  def show
    @user = User.find_by(id: params[:id])
    @microposts = @user.microposts.order("created_at DESC").page(params[:page])
    count(@user)
  end

  def create
    @user = User.new(set_user)
    
    if @user.save
      flash[:success] = "ユーザを登録しました。"
      redirect_to user_path(@user)
    else
      flash.now[:danger] = "ユーザ登録に失敗しました"
      render :new
    end
  end

  def new
    @user = User.new
  end



private

  def set_user
    params.require(:user).permit(:name,:email,:password, :password_confirmation)
  end 
  
end