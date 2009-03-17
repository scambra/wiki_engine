module ThreeScale
  module Wiki
    module PagesController
      def self.included(base)
        base.class_eval do
          # TODO: This line can be deleted when we switch to rails 2.3
          append_view_path File.dirname(__FILE__) + '/../../app/views'
          inherit_views '3scale/wiki/pages'
        end
      end

      def index
        @wiki_pages = wiki_pages.all(:order => 'title')
      end

      def new
        @wiki_page = wiki_pages.new
      end

      private

      # Override this to supply your own wiki page class.
      #
      # == Example
      #
      #   def wiki_page_class
      #     MyCoolWikiPage
      #   end
      def wiki_page_class
        ::WikiPage
      end

      # Override this to provide own collection of wiki pages. This by default equals to
      # +wiki_page_class+ (therefore - all wiki pages).
      #
      # == Example
      #
      #   def wiki_pages
      #     current_user.wiki_pages
      #   end
      def wiki_pages
        wiki_page_class
      end
    end
  end
end
