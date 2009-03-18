module ThreeScale
  module Wiki
    module Page
      def self.included(base)
        base.has_friendly_id :title, :use_slug => true
      end

      def title_from_id=(id)
        self.title = id.to_s.underscore.humanize if id
      end
    end
  end
end
