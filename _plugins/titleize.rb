require 'active_support/core_ext/string'

module Jekyll
  module Titleize
    def titleize(text)
      ActiveSupport::Inflector.titleize(text.split(".").first)
    end
  end
end

Liquid::Template.register_filter(Jekyll::Titleize)