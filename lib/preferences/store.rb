# Use singleton class Preferences::Store.instance to access
#
# StoreInstance has a persistence flag that is on by default,
# but we disable database persistence in testing to speed up tests
#
require 'singleton'
module Preferences

  class StoreInstance
    attr_accessor :persistence, :redis, :namespace
		
    def initialize
			@redis = Redis.new
			if defined?(Rails) && @namespace.blank?
				@namespace = "#{Rails.application.class.to_s.deconstantize}-#{Rails.env}"
			end
    end
		
		def add_ns(key)
			"#{@namespace}_"
		end
		
    def set(key, value)
			@redis.set add_ns(key), value
    end

    def exist?(key)
			get(add_ns(key)).present?
    end

    def get(key, default_key=nil)
			@redis.get(add_ns(key))
    end

    def delete(key)
			@redis.del(add_ns(key))
    end

  end

  class Store < StoreInstance
    include Singleton
  end

end
