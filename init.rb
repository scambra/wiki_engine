require 'three_scale/wiki/page'
require 'three_scale/wiki/pages_controller'

ActiveRecord::Base.send(:include, ThreeScale::Wiki::Page)
ActionController::Base.send(:include, ThreeScale::Wiki::PagesController)
