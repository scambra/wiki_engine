require 'test_helper'

class WikiPageTest < ActiveSupport::TestCase
  test 'has friendly id' do
    wiki_page = WikiPage.create!(:title => 'Hello world')

    assert_equal 'hello-world', wiki_page.to_param
    assert_equal wiki_page, WikiPage.find('hello-world')
  end
end
