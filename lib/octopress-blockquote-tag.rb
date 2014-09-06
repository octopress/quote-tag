require "octopress-blockquote-tag/version"
require "jekyll"

module Octopress
  module Tags
    module BlockquoteTag
      class Tag < Liquid::Block
        FullCiteWithTitle = /(\S.*)\s+(https?:\/\/)(\S+)\s+(.+)/i
        FullCite = /(\S.*)\s+(https?:\/\/)(\S+)/i
        AuthorTitle = /([^,]+),([^,]+)/
        Author =  /(.+)/

        def initialize(tag_name, markup, tokens)
          super

          if markup =~ FullCiteWithTitle
            @author = $1
            @source = $2 + $3
            @title = $4.strip
          elsif markup =~ FullCite
            @author = $1
            @source = $2 + $3
          elsif markup =~ AuthorTitle
            @author = $1
            @title = $2.strip
          elsif markup =~ Author
            @author = $1
          end
        end

        def render(context)
          quote = "<blockquote>#{parse_content(super, context).strip}</blockquote>"
          if cap = figcaption
            quote = "<figure class='quote'>#{quote}#{cap}</figure>"
          end
          quote
        end

        def parse_content(content, context)
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

        def figcaption
          if @author || @source || @title
            "<figcaption class='quote-caption'>#{author || ''}#{source || ''}</figcaption>"
          end
        end

        def author
          if @author
            "<span class='quote-author'>#{@author}</span>"
          end
        end

        def source
          if @source && @title
            s = "<a href='#{@source}'>#{@title}</a>"
          elsif @source
            s = "<a href='#{@source}'>#{trim_url(@source)}</a>"
          elsif @title
            s = "#{@title}"
          end

          if s
            "<cite class='quote-source'>#{s}</cite>"
          end
        end

        def trim_url(full_url)
          parts = []
          short_url = full_url.match(/https?:\/\/(.+)/)[1][0..30]
          short_url << '…' unless short_url == full_url
          short_url
        end
      end
    end
  end
end

Liquid::Template.register_tag('blockquote', Octopress::Tags::BlockquoteTag::Tag)
