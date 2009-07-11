module WikiPagesHelper
  # Format wiki text to html.
  def wiki_text(string)
    return '' unless string

    string = string.dup

    # Convert wiki links of type "Some stuff":[[hello-world]]
    string.gsub!(/"([^"]+)":\[\[\s*([^\]]+)\s*\]\]/) do
      "\"#{$1}\":#{wiki_page_path(:id => wiki_title_to_id($2))}"
    end

    # Convert wiki links of type [[hello-world]]
    string.gsub!(/\[\[\s*([a-z0-9_\-]+)\s*\]\]/) do
      "\"#{wiki_id_to_title($1)}\":#{wiki_page_path(:id => $1)}"
    end

    # Convert wiki links of type [[Hello world]]
    string.gsub!(/\[\[\s*([^\]]+)\s*\]\]/) do
      "\"#{$1}\":#{wiki_page_path(:id => wiki_title_to_id($1))}"
    end

    string = textilize(string)
    string
  end

  # Render widget with list of wiki pages.
  def wiki_pages_widget(wiki_pages)
    render :partial => 'widget', :locals => {:wiki_pages => wiki_pages}
  end

  def preview_button
    button_to_remote 'Preview', :url => preview_wiki_pages_path, :method => :put, :update => 'preview', :with => 'Form.serialize(this.form)', :complete => 'Element.scrollTo("preview")'
  end

  private

  def wiki_id_to_title(id)
    id.underscore.humanize
  end

  def wiki_title_to_id(title)
    Slug.normalize(title)
  end
end
