OmniAuth.config.logger = Rails.logger

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, '556001534505863', '789a182cd396b99af2a8a7aeb559013a', {:client_options => {:ssl => {:ca_file => Rails.root.join("cacert.pem").to_s}}}
end
