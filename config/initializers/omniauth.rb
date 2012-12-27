OmniAuth.config.logger = Rails.logger

Rails.application.config.middleware.use OmniAuth::Builder do
  # provider :facebook, ENV['FACEBOOK_KEY'], ENV['FACEBOOK_SECRET'], :display => "popup"
  provider :facebook, '500475053309032', '744788c4ddc57b8665c8c8e848fb24d2'
end