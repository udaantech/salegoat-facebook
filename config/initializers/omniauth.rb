OmniAuth.config.logger = Rails.logger

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, '428057170545953', '50571ec31ec1a2306558a65b27220649', {:client_options => {:ssl => {:ca_file => Rails.root.join("cacert.pem").to_s}}}

end
