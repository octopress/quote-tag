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

          @author = nil
          @source = nil
          @title = nil
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
<<-QUOTE
<figure class='quote'>
<blockquote>#{super.strip}</blockquote>#{figcaption}
</figure>
QUOTE
        end

        def figcaption
          "<figcaption class='quote-caption'>#{author}#{source}</figcaption>"

        end

        def author
          if @author
            "<span class='quote-author'>#{@author}</span>"
          else
            ''
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
          else
            ''
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
