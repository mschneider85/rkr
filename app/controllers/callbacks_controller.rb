class CallbacksController < Devise::OmniauthCallbacksController
  before_action :identify
  def github
    sign_in_and_redirect @user
    set_flash_message(:notice, :success, kind: 'Github') if is_navigational_format?
  end

  def bitbucket
    sign_in_and_redirect @user
    set_flash_message(:notice, :success, kind: 'Bitbucket') if is_navigational_format?
  end

  private

  def identify
    @user = Identity.from_omniauth(request.env['omniauth.auth'])
  end
end
