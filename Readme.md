Rack::Digestif
==============

A rack middleware for removing the digest in Sprockets asset requests, saving your users from unstyled and javascript-less pages.

For example:

    /assets/application-a1d0c6e83f027327d8461063f4ac58a6.css

gets rewritten to:

    /assets/application.css

Why?
----

Sprockets (and the Rails asset pipeline) use MD5 hashes of files to create cache-busting URLs. These URLs play nicer with caching proxies, but they have the disadvantage that requests to old assets cause a 404, rather than rendering the latest asset as the query-string method would. This can cause big problems during a deployment when a browser requests an asset during a deployment and gets 404 resulting in an unstyled or javascript-less page.

Luckily the fix is easy; Sprockets puts two copies of each compiled asset into the /public/assets directory, one with the digest and one without. All that's needed from us is to rewrite incoming requests and remove the digest. You can do this in nginx or your HTTP proxy, or you can do it with `Rack::Digestif`.

Installation
------------

    $ gem install rack-digestif
    
Usage
-----

Add it to your `config.ru` rackup file:

    require 'rack/digestif'
    use Rack::Digestif

You can also limit it to affect only a certain path:

    use Rack::Digestif, "/some-path"


Rails Usage
-----------

Firstly add the gem to the `assets` group in your Gemfile:

    group :assets do
      gem 'rack-digestif'
      # ...

and then add the following to your application.rb:

    ?


License
-------

Insert license here