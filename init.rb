require 'rubygems'
require 'action_view'

require 'sugar'

ActionView::Base.send :include, Sugar::Actionpack
