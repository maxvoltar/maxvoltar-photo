module Jekyll
  class NetlifyContext < Generator
    def generate(site)
      if ENV["CONTEXT"] != "production" && ENV["DEPLOY_PRIME_URL"]
        site.config['url'] = ENV["DEPLOY_PRIME_URL"]
      end
    end
  end
end