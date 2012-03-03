require 'test/unit'
require 'rack/digestif'
require 'rack/mock'

class TestRackDigestif < Test::Unit::TestCase
  def app
    # Rack app that returns the request path as the response body
    app = Proc.new {|env| [200, {}, Rack::Request.new(env).path]}
  end
  def app_with_digestif path=nil
    Rack::Digestif.new(app, path)
  end
  def assert_rewrites source_path, rewritten_path
    req = Rack::MockRequest.new(@app)
    assert_equal rewritten_path, req.get(source_path).body
  end
  def assert_not_rewrites path
    req = Rack::MockRequest.new(@app)
    assert_equal path, req.get(path).body
  end

  def test_rewrites_path
    @app = app_with_digestif
    assert_rewrites "/path/f-c20ad4d76fe97759aa27a0c99bff6710.css", "/path/f.css"
    assert_rewrites "/sub/dir/f-c20ad4d76fe97759aa27a0c99bff6710.css", "/sub/dir/f.css"
    assert_not_rewrites "/assets/f.css"
  end
  def test_rewrites_only_matching_paths
    @app = app_with_digestif "/path"
    assert_rewrites "/path/f-c20ad4d76fe97759aa27a0c99bff6710.css", "/path/f.css"
    assert_not_rewrites "/not-path/f-c20ad4d76fe97759aa27a0c99bff6710.css"
  end
end
