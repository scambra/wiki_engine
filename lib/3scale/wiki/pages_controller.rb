module ThreeScale
  module Wiki
    module PagesController
      def self.included(base)
        base.class_eval do
          # TODO: This line can be deleted when we switch to rails 2.3
          append_view_path File.dirname(__FILE__) + '/../../app/views'
          inherit_views '3scale/wiki/pages'

          before_filter :find_wiki_page, :only => [:show, :edit, :update, :destroy]

          rescue_from ActiveRecord::RecordNotFound, :with => :not_found
        end
      end

      def index
        @wiki_pages = wiki_pages.all(:order => 'title')
      end

      def new
        @wiki_page = wiki_pages.new
      end

      def show
      end

      def create
        @wiki_page = wiki_pages.new(params[:wiki_page])

        if @wiki_page.save
          flash[:notice] = 'New wiki page has been created.'
          redirect_to(wiki_pages_url)
        else
          render :action => 'new'
        end
      end

      def edit
      end

      def update
        if @wiki_page.update_attributes(params[:wiki_page])
          flash[:notice] = 'The wiki page has been updated.'
          redirect_to(wiki_pages_url)
        else
          render :action => 'edit'
        end
      end

      def destroy
        @wiki_page.destroy

        flash[:notice] = 'The wiki page has been deleted.'
        redirect_to(wiki_pages_url)
      end

      private

      # Override this to supply your own wiki page class. Default is WikiPage.
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

      # Ovverride this if you need custom find logic for single wiki page.
      #
      # == Example
      #
      #   # Restrict wiki pages to some named scope
      #   # (+visible+ is hypotetical named_scope defined on WikiPage model).
      #   def find_wiki_page     
      #     @wiki_page = wiki_pages.visible.find(params[:id])
      #   end
      #
      # or
      #   
      #   # Use different param name. 
      #   def find_wiki_page
      #     @wiki_page = wiki_pages.find(params[:wiki_page_id])
      #   end
      #
      def find_wiki_page
        @wiki_page = wiki_pages.find(params[:id])
      end

      # This is called when wiki page is not found. By default it display a page explaining
      # that the wiki page does not exist yet and link to create it.
      def not_found
        render :action => 'not_found', :status => :not_found
      end
    end
  end
end
