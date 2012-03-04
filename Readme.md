Rack::Digestif
==============

A rack middleware for preventing 404s on digest changes of Sprockets assets, saving your users from unstyled and javascript-less pages during a redeploy.

For example:

    /assets/application-a1d0c6e83f027327d8461063f4ac58a6.css

gets rewritten to:

    /assets/application.css

Why?
----

Sprockets (and the Rails asset pipeline) use MD5 hashes of files to create cache-busting URLs. These new URLs have one big disadvantage over the old query-string method: requests to old assets cause a 404, unlike the old method which would serve the asset file regardless of the correctness of the timestamp. This problem becomes particularly noticable during a deployment when a browser requests an asset but its digest has been updated and they receive a 404, resulting in an unstyled or javascript-less page.

Luckily the fix is easy; Sprockets puts two copies of each compiled asset into the /public/assets directory, one with the digest and one without. All that's needed is to rewrite incoming requests and remove the digest from the path. You can do this in nginx, your HTTP proxy, or something like rack-rewrite, or you can simply throw in `Rack::Digestif`.

Installation
------------

    $ gem install rack-digestif
    
Usage
-----

Add it to your Rackup `config.ru` file:

    require 'rack/digestif'
    use Rack::Digestif

You can also limit it to affect only a certain path:

    use Rack::Digestif, "/some-path"


Rails Usage
-----------

Add it your `application.rb` file like so:

    config.middleware.insert_before Rack::Lock, Rack::Digestif


License
-------

See MIT-LICENSE for details.