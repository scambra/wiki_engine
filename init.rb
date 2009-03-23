$LOAD_PATH.unshift(File.dirname(__FILE__) + '/lib/app')

require '3scale/wiki/page'
require '3scale/wiki/pages_controller'

ActiveRecord::Base.send(:include, ThreeScale::Wiki::Page)
ActionController::Base.send(:include, ThreeScale::Wiki::PagesController)
