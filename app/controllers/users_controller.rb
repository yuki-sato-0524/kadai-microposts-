class UsersController < ApplicationController
  before_action :require_user_logged_in, only:[:index,:show]
  def index
    @users = User.all.order("created_at DESC").page(params[:page]).per(10)
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
#showページ
  def show
    @user = User.find_by(id: params[:id])
    @microposts = @user.microposts.order("created_at DESC").page(params[:page])
    count(@user)
  end

  def followings
    @user = User.find_by(id: params[:id])
    #@userのフォローしてる人をfollowingsメソで取得する
    @followings = @user.followings.page(params[:page]) 
    count(@user)
  end
  
  def followers
    @user = User.find_by(id: params[:id])
    #@userのフォロワーをfollowersメソで取得する
    @followers = @user.followers.page(params[:page])
    count(@user) 
  #countメソッドは@userが同じ限り #show, #followings, #followers どれも同じ結果が出る。
  end
    
  def likes
    @user = User.find_by(id: params[:id])
    @microposts = @user.likes.order("created_at DESC").page(params[:page])
    count(@user) 
  end


private

  def set_user
    params.require(:user).permit(:name,:email,:password, :password_confirmation)
  end 
  
end