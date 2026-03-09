class ApplicationController < ActionController::Base
 before_action :configure_authentication #どのページを開く時も、最初にこのチェックを行う
 before_action :configure_permitted_parameters, if: :devise_controller? #deviseのコントローラーを開くときだけ、configure_permitted_parametersを呼び出す
 
 def after_sign_in_path_for(resource)
    if resource.is_a?(Admin)
      admin_dashboard_path
    else
      # 以前のコントローラで設定していた mypage_path を使用
      mypage_path 
    end
  end

  # ログアウト後の遷移先
  def after_sign_out_path_for(resource_or_scope)
    if resource_or_scope == :admin
      new_admin_session_path
    else
      root_path
    end
  end
  private
 
  def configure_authentication
    if admin_controller? #開こうとしているのは,管理者用のページ？
      authenticate_admin!  #管理者用ページなら、管理者としてログインしてるかを確認
    else
      authenticate_user! unless action_is_public? #管理者用ページ以外なら、ユーザーとしてログインしてるかを確認
    end
  end
 
  def admin_controller? #開こうとしているのは,管理者用のページ？
    self.class.module_parent_name == 'Admin' #コントローラーのモジュール名がAdminなら、管理者用ページと判断　モジュール名は、Admin::から始まるcontroller
  end
 
  def action_is_public? #開こうとしているのは,公開用のページ？
    controller_name == 'homes' && action_name == 'top' #コントローラー名がhomesで、アクション名がtopなら、公開用ページと判断
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:last_name, :first_name, :nickname])
    devise_parameter_sanitizer.permit(:account_update, keys: [:last_name, :first_name, :nickname])
  end

end
