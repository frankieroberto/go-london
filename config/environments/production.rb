GoLondon::Application.configure do

  config.cache_classes = true
  config.consider_all_requests_local = false

  config.action_controller.perform_caching = true

  config.eager_load = true

  config.log_level = :warn

end
