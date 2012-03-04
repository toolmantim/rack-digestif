require 'minitest/autorun'

require 'rack/digestif'
require 'rack/mock'

describe Rack::Digestif do

  let(:base_app) { Proc.new {|env| [200, {}, Rack::Request.new(env).path]} }

  def path_after_digestif request_path
    Rack::MockRequest.new(app).get(request_path).body
  end

  describe "initialized no arguments" do
    let(:app) { Rack::Digestif.new(base_app) }
    it "must rewrite assets with digests" do
      path_after_digestif("/path/f-c20ad4d76fe97759aa27a0c99bff6710.css").must_equal "/path/f.css"
    end
    it "mustn't rewrite assets without digests" do
      path_after_digestif("/path/f.css").must_equal "/path/f.css"
    end
  end
  
  describe "initialized with a path argument" do
    let(:app) { Rack::Digestif.new(base_app, "/custom-path/") }
    it "must rewrite assets with digests in the custom path" do
      path_after_digestif("/custom-path/f-c20ad4d76fe97759aa27a0c99bff6710.css").must_equal "/custom-path/f.css"
    end
    it "mustn't rewrite assets with digests outside the custom path" do
      path_after_digestif("/other-path/f-c20ad4d76fe97759aa27a0c99bff6710.css").must_equal "/other-path/f-c20ad4d76fe97759aa27a0c99bff6710.css"
    end
  end

end
