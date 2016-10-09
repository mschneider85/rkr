class CallbacksController < Devise::OmniauthCallbacksController
  before_action do
    @user = IdentifyFromOmniauth.call(request.env['omniauth.auth'])
  end

  def github
    sign_in_and_redirect @user
    set_flash_message(:notice, :success, kind: 'Github') if is_navigational_format?
  end

  def bitbucket
    sign_in_and_redirect @user
    set_flash_message(:notice, :success, kind: 'Bitbucket') if is_navigational_format?
  end
end
