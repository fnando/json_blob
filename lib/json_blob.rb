module JSONBlob
  require "json"
  require "json_blob/version"

  class << self
    attr_accessor :json_engine
  end

  self.json_engine = JSON

  def self.dump(data)
    Base64.strict_encode64(json_engine.dump(data))
  end

  def self.parse(data)
    json_engine.parse(Base64.strict_decode64(data))
  end
end

require "json_blob/action_view" if defined?(ActionView)
