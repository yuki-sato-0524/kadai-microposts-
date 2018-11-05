class SessionsController < ApplicationController
#ログインフォーム用。Modelがいらないので何も書かない
  def new
  end
  
#実質的にはログイン処理を行う
  def create
    email = params[:session][:email]
    password = params[:session][:password]
    if login(email, password)
      flash[:success] = "ログインに成功しました"
      redirect_to @user #user_path(@user)の省略版。受け取った情報をもとにユーザーのインスタンスを生成？
    else
      flash.now[:danger] = "ログインに失敗しました"
      render :new
    end
  end
  
#ログアウト処理を行う
#log outボタン押す→destroyアクションくる→session[:user_id]を空にする！
#特定する必要もない！！
  def destroy
    session[:user_id] = nil
    flash[:success] = "ログアウトしました"
    redirect_to root_url
  end
  
  
  private
  
  def login(email, password)
    @user = User.find_by(email: email)
    if @user && @user.authenticate(password)
      session[:user_id] = @user.id
      return true
    else
      return false
    end
  end
    
end
