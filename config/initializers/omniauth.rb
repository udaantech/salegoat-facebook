OmniAuth.config.logger = Rails.logger

Rails.application.config.middleware.use OmniAuth::Builder do
  if Rails.env == 'production'
  provider :facebook, '452181538258114', 'bf105dbd1547dd4414c3b7ceda011cdb', :scope => 'user_groups, publish_actions'
  else
  provider :facebook, '428057170545953', '50571ec31ec1a2306558a65b27220649', :scope => 'user_groups, publish_actions'
  end	
end
