OmniAuth.config.logger = Rails.logger

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, '407174885976917', '341e50c11002d54e6de794aaefa3d57c', {:client_options => {:ssl => {:ca_file => Rails.root.join("cacert.pem").to_s}}}
end
