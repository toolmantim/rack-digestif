Rack::Digestif [![Build Status](https://secure.travis-ci.org/toolmantim/rack-digestif.png?branch=master)](http://travis-ci.org/toolmantim/rack-digestif)
==============

A rack middleware that ensures Sprockets assets are served regardless of whether the asset digest matches.

All asset URLs such as:

    /assets/application-a1d0c6e83f027327d8461063f4ac58a6.css

are rewritten to remove the digest:

    /assets/application.css

This works thanks to Sprockets compiling both digest and non-digest filenames in the assets directory.

Why?
----

Sprockets (and the Rails asset pipeline) use MD5 hashes of files to create cache-busting URLs. These new URLs have one big disadvantage over the old query-string method: requests to assets with an out-of-date digest cause a 404, unlike the old method which would serve the asset file regardless of the correctness of the timestamp. This problem becomes particularly noticable during a deployment when a browser requests an asset but the digest has been updated on the server and so they receive a 404, resulting in an unstyled or javascript-less page.

Luckily the fix is easy; Sprockets generates every compiled file with and without a digest, so all that's needed is to rewrite incoming requests to remove the digest from the path. You can do this in nginx or HTTP proxy, rack-rewrite, or using `Rack::Digestif`.

Installation
------------

    $ gem install rack-digestif
    
Usage
-----

Add it to your Rackup `config.ru` file like so:

    require 'rack/digestif'
    use Rack::Digestif

By default `Rack::Digestif` will rewrite all incoming URLs that have a digest. If you want to limit it to a given path, such as `/assets`, you simply pass the path as the first argument:

    use Rack::Digestif, "/assets/"


Rails Usage
-----------

Firstly add it to your `Gemfile`, and then add the middleware in `application.rb` like so:

    config.middleware.insert_before ActionDispatch::Static, Rack::Digestif


License
-------

See MIT-LICENSE for details.