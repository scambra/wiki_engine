module ThreeScale
  module Wiki
    module PagesHelper
      # Format wiki text to html.
      def wiki_text(string)
        string = string.dup

        # Convert wiki links of type "Some stuff":[[hello-world]]
        string.gsub!(/"([^"]+)":\[\[\s*([^\]]+)\s*\]\]/) do
          link_to $1, wiki_page_path(:id => wiki_title_to_id($2))
        end

        # Convert wiki links of type [[hello-world]]
        string.gsub!(/\[\[\s*([a-z0-9_\-]+)\s*\]\]/) do
          link_to wiki_id_to_title($1), wiki_page_path(:id => $1)
        end

        # Convert wiki links of type [[Hello world]]
        string.gsub!(/\[\[\s*([^\]]+)\s*\]\]/) do
          link_to $1, wiki_page_path(:id => wiki_title_to_id($1))
        end

        string = textilize(string)
        string
      end

      private 

      def wiki_id_to_title(id)
        id.underscore.humanize
      end

      def wiki_title_to_id(title)
        Slug.normalize(title)
      end
    end
  end
end
