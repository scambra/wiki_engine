require 'test_helper'

class WikiPagesHelperTest < ActionView::TestCase
  tests ThreeScale::Wiki::PagesHelper

  test 'helper is available' do
    assert respond_to?(:wiki_text)
  end

  test 'converts wiki links' do
    assert_match '<a href="/wiki_pages/hello-world">Hello world</a>',
                 wiki_text('[[hello-world]]')

    assert_match '<a href="/wiki_pages/hello-world">Hello world</a>',
                 wiki_text('[[Hello world]]')

    assert_match '<a href="/wiki_pages/hello-world">Look here</a>',
                 wiki_text('"Look here":[[hello-world]]')

    # TODO: more edge cases...
  end

  test 'wraps in paragraphs' do
    assert_equal '<p>hello world</p>', wiki_text('hello world')
  end

  test 'textilizes' do
    assert_match '<strong>bar</strong>', wiki_text('foo *bar*')
  end

  private

  # Stub named routes, because they don't work in helper tests for some reason.
  def wiki_page_path(*args)
    "/wiki_pages/#{args.first[:id] || args.first.to_param}"
  end
end
