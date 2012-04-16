#SUMMARY
This gem is extracted from part of [spree](http://github.com/spree/spree), I remove cache, Rails dependency and use Redis for persistance, so you can use it in Rails or Sinatra.etc.

Install:

* add 「** gem spree_preferences, :git => 'git://github.com/ryudoawaru/spree_preferences.git' **」 to your project's Gemfile.
* no DB migration needed!
* done!


In model :


    $ class Article
    $   include Preferences::Preferable
    $   preference :p1, :string
    $ end

Use :


    $ a = Article.find(1)
    $ a.preferred_p1 = 'abc'
    
For detial usage, please referer to [spree documentation](http://guides.spreecommerce.com/preferences.html)

Redis connection is default to localhost and default port; to change connection, use:


    $ Preferences::Store.instance.redis = Redis.new(:host => "10.0.1.1", :port => 6380)