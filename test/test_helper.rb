require 'rubygems'
require 'test/unit'
require 'active_support'
require 'active_support/test_case'
require 'active_record'
require 'action_controller'
require 'action_controller/test_process'

require File.dirname(__FILE__) + '/../init'

# Load inherit_views plugin
# TODO: is there a better way to load a plugin?
$LOAD_PATH << File.dirname(__FILE__) + '/../../inherit_views/lib'
require File.dirname(__FILE__) + '/../../inherit_views/init'

# Establish a temporary sqlite3 db for testing.
ActiveRecord::Base.establish_connection(:adapter => 'sqlite3', :database => ':memory:')
ActiveRecord::Base.logger # instantiate logger
ActiveRecord::Schema.define(:version => 1) do
  create_table :wiki_pages do |t|
    t.string :title
    t.text :content
    t.timestamps
  end
end

# Testing classes
class WikiPage < ActiveRecord::Base
  include ThreeScale::Wiki::Page
end

class WikiPagesController < ActionController::Base
  include ThreeScale::Wiki::PagesController
  
  private

  def wiki_page_model
    WikiPage
  end
end

# Routes
ActionController::Routing::Routes.draw do |map|
  map.resources :wiki_pages
end
