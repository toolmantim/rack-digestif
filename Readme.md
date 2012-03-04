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

Sprockets (and the Rails asset pipeline) uses MD5 hashes on the asset filenames to create cache-busting URLs. Although these new URLs are awesome they introduce a problem that the old query-string method did not have: requests to assets with an out-of-date digest will receive a 404. Why is this a problem? During a deployment there's a gap in between when the browser receives the HTML and when it requests an asset, and during that time the server may and probably will be updated and that poor customer will end up with an unstyled or javascript-less page.

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


Doesn't fresh assets + stale markup = trouble?
-----------------------------------------

As James A Rosen [pointed out](https://twitter.com/#!/jamesarosen/status/176386910237892608) this isn't the ideal solution because you're serving up a new assets to old pages that aren't designed for the new scripts.

To be clear: this solution just brings things back on par with the way things have always been with timestamped assets.

If this isn't robust enough for you then ditch it, and consider pushing compiled assets up to S3 (probably fronted by a CDN such as CloudFront), and making sure old versions of assets are still around.

License
-------

See MIT-LICENSE for details.