class FavoritesController < ApplicationController
  
#受け取った:micropost_idでユーザを特定する
#モデルファイルで定義したlike()メソッドを実行する
  def create
    micropost = Micropost.find_by(id: params[:micropost_id])
    #user = micropost.favorites.find_by(micropost_id: params[:micropost_id])
    current_user.like(micropost)
    #if current_page?(user_path(user))
     # redirect_to user_path(user) 
    #else
      redirect_back(fallback_location: root_path)
    #end
  end

#受け取った:micropost_idでユーザを特定する
#モデルファイルで定義したunlike()メソッドを実行する
  def destroy
    micropost = Micropost.find(params[:micropost_id])
    #user = micropost.be_likeds.find_by(user_id: params[:id])
    current_user.unlike(micropost)
    #if current_page?(user_path(user))
     # redirect_to user_path(user) 
    #else
     redirect_back(fallback_location: root_path)
    #end
  end
  
 
end
