class UserMailer < ActionMailer::Base
  def signup_notification(user)
    setup_email(user)
    @subject    += 'Please activate your account'
    @body[:url]  = activate_url(user.activation_code)

  end

  def activation(user)
    setup_email(user)
    @subject    += 'Your account has been activated!'
    @body[:url]  = root_url
  end

  def reset_notification(user)
    setup_email(user)
    @subject    += 'Reset your password'
    @body[:url]  = reset_url(user.password_reset_code)
  end

  protected
    def setup_email(user)
      @recipients  = "#{user.email}"
      @from        = Tog::Config["plugins.tog_core.mail.system_from_address"]
      @subject     = Tog::Config["plugins.tog_core.mail.default_subject"]
      @sent_on     = Time.now
      @body[:user] = user
    end
end