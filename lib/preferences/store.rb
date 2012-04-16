# Use singleton class Preferences::Store.instance to access
#
# StoreInstance has a persistence flag that is on by default,
# but we disable database persistence in testing to speed up tests
#
require 'singleton'
module Preferences

  class StoreInstance
    attr_accessor :persistence, :redis
		
    def initialize
      # @cache = Rails.cache
      # @persistence = true
      # load_preferences
			@redis = Redis.new
    end

    def set(key, value)
      # @cache.write(key, value)
      # persist(key, value)
			@redis.set key, value
			Rails.logger.info "SET PREFERENCE #{key} = #{value.to_s}"
    end

    def exist?(key)
			get(key).present?
    end

    def get(key, default_key=nil)
			@redis.get(key)
    end

    def delete(key)
			@redis.del(key)
    end

  end

  class Store < StoreInstance
    include Singleton
  end

end
