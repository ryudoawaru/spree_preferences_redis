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
			@redis = Redis.new
    end
		
    def set(key, value)
			@redis.set(key, Marshal.dump(value))
			get(key)
    end

    def exist?(key)
			@redis.get(key).present?
    end

    def get(key, default_key=nil)
			if vv = @redis.get(key)
				Marshal.load(vv)
			else
				nil
			end
    end

    def delete(key)
			@redis.del(key)
    end

  end

  class Store < StoreInstance
    include Singleton
  end

end
