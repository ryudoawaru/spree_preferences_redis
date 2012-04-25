require 'redis'
require 'preferences'
Preferences.key_prefix = ENV['PREFERENCE_KEY_PREFIX'].to_s
if defined?(Rails)
	Preferences.key_prefix = "#{Rails.application.class.to_s.deconstantize}-#{Rails.env}"
end
require 'preferences/preferable_class_methods'
require 'preferences/preferable'
require 'preferences/store'
require 'preferences/configuration'
