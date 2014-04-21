require "mde-4ye/version"
require "securerandom"
require "sinatra/base"
require "sinatra/assetpack"

module MDE4ye
  MOUNT_AT   = "/mde-4ye"
  ASSET_PATH = File.expand_path("../../assets", __FILE__)

  module Helpers
    def mdeditor(name, content, height=400, theme="github")
      haml "%input#4ye-markdown-content{type: \"hidden\", name: \"#{name}\", value: content}\n" +
           "#4ye-markdown-editor{:\"data-theme\" => \"#{theme}\", style: \"height:#{height}px;\"}\n" +
           "%script{src: \"#{MOUNT_AT}/init.js\"}", 
           locals: {name: name, content: content, height: height, theme: theme}
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
