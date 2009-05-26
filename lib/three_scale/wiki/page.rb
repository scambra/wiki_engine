module ThreeScale
  module Wiki
    module Page
      def self.included(base)
        base.extend(ActsMethods)
      end

      module ActsMethods
        # Tell model to act as wiki page.
        def acts_as_wiki_page(options = {})
          # TODO: test presence of required fields.
          
          has_friendly_id :title, options.slice(:scope).merge(:use_slug => true)
          validates_presence_of :title

          include InstanceMethods
        end
      end

      module InstanceMethods
        def title_from_id=(id)
          self.title = id.to_s.underscore.humanize if id
        end
      end
    end
  end
end
