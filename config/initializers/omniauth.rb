OmniAuth.config.logger = Rails.logger

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, '452181538258114', 'bf105dbd1547dd4414c3b7ceda011cdb', {:client_options => {:ssl => {:ca_file => Rails.root.join("cacert.pem").to_s}}}

end
