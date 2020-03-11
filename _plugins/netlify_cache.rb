module Jekyll
  module NetlifyCache
    def self.init(site)
      @JEKYLL_CONFIG = site.config
    end

    def self.jekyll_config
      @JEKYLL_CONFIG || Jekyll.configuration({})
    end

    def self.extract_cache
      if cache? && File.directory?(cache_directory)
        FileUtils.copy_entry cache_directory, build_directory
      end
    end

    def self.cache_files
      if cache?
        FileUtils.rm_rf(cache_base)
        Dir.mkdir(cache_base)
        FileUtils.copy_entry build_directory, cache_directory
      end
    end

    def self.cache?
      !build_base.nil?
    end

    def self.build_directory
      File.join(build_base, "repo", "_site")
    end

    def self.cache_directory
      File.join(cache_base, "_site")
    end

    def self.cache_base
      File.join(build_base, "cache", "jekyll")
    end

    def self.build_base
      ENV["NETLIFY_BUILD_BASE"]
    end
  end
end

Jekyll::Hooks.register :site, :after_reset do |jekyll|
  Jekyll::NetlifyCache.init(jekyll)
  Jekyll::NetlifyCache.extract_cache
end

Jekyll::Hooks.register :site, :post_write do |page|
  Jekyll::NetlifyCache.cache_files
end
