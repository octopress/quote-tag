module Octopress
  module Tags
    module Quote
      module Utils
        def self.parse_content(content, context)
          path  = context.environments.first['page']['path']
          ext   = File.extname(path[1..-1])[1..-1]
          site  = context.registers[:site]
          mdext = site.config['markdown_ext']
          txext = site.config['textile_ext']

          if mdext.include? ext
            site.getConverterImpl(Jekyll::Converters::Markdown).convert(content)
          elsif txext.include? ext
            site.getConverterImpl(Jekyll::Converters::Textile).convert(content)
          else
            "<p>" + content.strip.gsub(/\n\n/, "<p>\n\n</p>") + "</p>"
          end
        end
      end
    end
  end
end

