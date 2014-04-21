require "mde-4ye/version"
require "securerandom"
require "sinatra/base"
require "sinatra/assetpack"

puts File.expand_path("../../assets", __FILE__)

module MDE4ye
  MOUNT_AT   = "/mde-4ye"
  ASSET_PATH = File.expand_path("../../assets", __FILE__)

  module Helpers
    def mdeditor(name, content, height=400, theme="github")
      "<textarea id=\"4ye-markdown-content\" name=\"#{name}\" style=\"display:none;\">#{content}</textarea>" +
      "<div style=\"height:#{height}px;\" id=\"4ye-markdown-editor\" data-theme=\"#{theme}\">#{content}</div>" +
      "<script src=\"#{MOUNT_AT}/init.js\"></script>"
    end
  end

  class Assets < Sinatra::Base
    set :public_folder, ASSET_PATH
  end

  def self.registered(app)
    app.helpers Helpers
  end

  def self.mount!(context)
    context.map(MOUNT_AT) {run Assets.new}
  end
end
