class MicropostsController < ApplicationController
  before_action :require_user_logged_in
  before_action :correct_user, only:[:destroy]
  
  def create
    @micropost = current_user.microposts.build(post_params)
    
    if @micropost.save
      flash[:success] = "投稿しました"
      redirect_to root_path
    else
    #actionを経由せずにトップページに飛ばされるので表示する投稿の情報を持っておかないといけない
      @microposts = current_user.microposts.order("created_at DESC").page(params[:page])
      flash[:danger] = "投稿できませんでした"
      render "toppages/index"
    end
  end
  
  def destroy
    @micropost.destroy
    flash[:success] = "削除しました"
    redirect_back(fallback_location: root_url) 
  end



  private
  
  def post_params
    params.require(:micropost).permit(:content)
 
  end
  
  def correct_user
    @micropost = current_user.microposts.find_by(id: params[:id])
    unless @micropost
    redirect_to root_path
    end
  end
end
