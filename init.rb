require File.dirname(__FILE__) + '/lib/3scale/wiki/page'
require File.dirname(__FILE__) + '/lib/3scale/wiki/pages_controller'

# TODO: this line won't be needed after we switch to rails 2.3
require File.dirname(__FILE__) + '/lib/app/helpers/3scale/wiki/pages_helper'

ActionView::Base.send(:include, ThreeScale::Wiki::PagesHelper)
