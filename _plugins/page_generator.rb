require 'active_support/core_ext/string'

module Jekyll
  class CategoryPageGenerator < Generator
    safe true

    def generate(site)
      site.static_files.each do |file|
        if file.relative_path.start_with?("/photos/original")
          site.pages << CategoryPage.new(site, site.source, file)
        end
      end
    end
  end

  # A Page subclass used in the `CategoryPageGenerator`
  class CategoryPage < Page
    def initialize(site, base, file)
      basename = File.basename(file.path)
      name = File.basename(basename).split(".").first

      puts '-----------'
      puts name
      puts '-----------'

      @site = site
      @base = base
      @dir  = name
      @name = 'index.html'

      self.process(@name)
      self.read_yaml(File.join(base), 'index.html')

      self.data['title'] = ::ActiveSupport::Inflector.titleize(name)
      self.data['image'] = basename
    end
  end
end
