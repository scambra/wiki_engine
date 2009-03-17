module ThreeScale
  module Wiki
    module Page
      def self.included(base)
        base.has_friendly_id :title, :use_slug => true
      end
    end
  end
end
