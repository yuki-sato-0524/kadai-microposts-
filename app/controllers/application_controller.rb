class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  
  private
  
  include SessionsHelper
  
  def require_user_logged_in
    redirect_to login_url unless logged_in?
  end
  
  def count(user)
    @count_microposts = user.microposts.count
    @count_followings = user.followings.count
    @count_followers = user.followers.count
    @count_favorites = user.likes.count
    
    #@count_~ = user.情報取得メソッド.count
    #Applicationコントローラでcountメソッドを定義。
    #使う場合はそれぞれのアクションで定義するuserのインスタンスを入れて
    #@~をViewに埋め込むだけ。
  end
  
  #def count(micropost)
   # @count_star = micropost.be_likeds.count
  #end
  
  
end
