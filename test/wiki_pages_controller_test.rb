require 'test_helper'

class WikiPagesControllerTest < ActionController::TestCase
  def setup
    WikiPage.delete_all
  end

  test 'on GET to :index without pages' do
    get :index

    assert_response :success
    assert_template '3scale/wiki/pages/index'

    assert_select 'a[href=?]', new_wiki_page_path, 'New page'
    assert_select 'table.wiki_pages', false
  end

  test 'on GET to :index with pages' do
    setup_page
    get :index

    assert_response :success
    assert_equal [@page], assigns(:wiki_pages)

    assert_select 'table.wiki_pages tr' do
      assert_select 'td', 'Cool page'
      # assert_select 'td a[href=?]'
    end
  end

  test 'on GET to :new' do
    get :new

    assert_response :success
    assert_template '3scale/wiki/pages/new'

    assert_not_nil assigns(:wiki_page)
    assert assigns(:wiki_page).new_record?
  end


  private

  def setup_page
    @page = WikiPage.create!(:title => 'Cool page', :content => 'Some cool content...')
  end

end
