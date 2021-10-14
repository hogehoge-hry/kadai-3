class ApplicationController < ActionController::Base
  #ログインしていない限り、TopとAbout以外の閲覧を不許可
  before_action :authenticate_user!,except: [:top, :about]
  before_action :configure_permitted_parameters, if: :devise_controller?


  def after_sign_in_path_for(resource)
    #log in後にユーザーのマイページへ遷移
    user_path(current_user.id)
  end

  protected

  def configure_permitted_parameters
    #ユーザ登録の際に、ユーザ名のデータ操作を許可
    devise_parameter_sanitizer.permit(:sign_up, keys: [:email])
  end
end
