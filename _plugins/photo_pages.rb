module Jekyll
  class PhotoPages < Generator
    safe true

    def generate(site)
      site.static_files.each do |file|
        if file.relative_path.include?("original")
          site.pages << PhotoPage.new(site, site.source, file)
        end
      end
    end
  end

  class PhotoPage < Page
    def initialize(site, base, file)
      basename = File.basename(file.path)
      name = File.basename(file.path, ".*")
      slug = Jekyll::Utils.slugify(name)

      @site = site
      @base = base
      @dir  = slug
      @name = "index.html"

      self.process(@name)
      self.read_yaml(File.join(base), "index.html")

      self.data["title"] = name
      self.data["images"] = [file]
      self.data["image_slug"] = slug
    end
  end
end
