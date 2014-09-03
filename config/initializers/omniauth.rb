OmniAuth.config.logger = Rails.logger

Rails.application.config.middleware.use OmniAuth::Builder do
   if Rails.env == 'production'
   #if Rails.env == 'development'
  provider :facebook, '452181538258114', '0cc9bd2cc2491649571bffbdbe3ba699', :scope => 'user_groups, publish_actions'
  else
  provider :facebook, '428057170545953', '50571ec31ec1a2306558a65b27220649', :scope => 'user_groups, publish_actions'
  end	
end
