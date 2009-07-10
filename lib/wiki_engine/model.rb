module WikiEngine::Model
  def self.included(base)
    base.class_eval do
      has_friendly_id :title, :use_slug => true, :strip_diacritics => true
      acts_as_versioned :non_versioned_columns => :title
      validates_presence_of :title
    end
  end

  def title_from_id=(id)
    self.title = id.to_s.underscore.humanize if id
  end
end
