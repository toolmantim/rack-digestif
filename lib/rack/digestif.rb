module Rack
  # Rack middleware which rewrites the REQUEST_PATH to remove the asset digest
  class Digestif
    PATTERN = /-[0-9a-z]{32}(\.[^.]+)\Z/.freeze
    def initialize app, path=nil
      @app = app
      @path = path.freeze
    end
    def call env
      if (not @path) || (@path && env["PATH_INFO"].index(@path) == 0)
        env["PATH_INFO"].gsub! PATTERN, '\1'
      end
      @app.call env
    end
  end
end
