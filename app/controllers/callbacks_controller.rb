class CallbacksController < Devise::OmniauthCallbacksController
  before_action :load_user_from_omniauth
  def github
    sign_in_and_redirect @user
    set_flash_message(:notice, :success, kind: 'Github') if is_navigational_format?
  end

  def bitbucket
    sign_in_and_redirect @user
    set_flash_message(:notice, :success, kind: 'Bitbucket') if is_navigational_format?
  end

  private

  def load_user_from_omniauth
    @user = User.from_omniauth(request.env['omniauth.auth'])
  end
end
