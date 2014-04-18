require "mde-4ye/version"
require "securerandom"
require "sinatra/base"
require "sinatra/assetpack"

puts File.expand_path("../../assets", __FILE__)

module MDE4ye
  MOUNT_AT   = "/mde-4ye"
  ASSET_PATH = File.expand_path("../../assets", __FILE__)

  module Helpers
    def mdeditor(name, content, height=400)
      "<input type=\"hidden\" name=\"#{name}\" value=\"#{content}\" />" +
      "<div style=\"height:#{height}px;\" id=\"4ye-markdown-editor\">#{content}</div>" +
      "<script src=\"#{MOUNT_AT}/init.js\"></script>"
    end
  end

  def self.registered(app)
    app.helpers Helpers
    app.register Sinatra::AssetPack
    app.assets {
      serve MOUNT_AT, from: ASSET_PATH
    }
  end
end
