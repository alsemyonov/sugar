module Sugar
end

require 'sugar/actionpack'
require 'sugar/activerecord'

if defined? Rails
  ActionView::Base.send :include, Sugar::Actionview if defined? ActionView
  ActionController::Base.send :include, Sugar::Actioncontroller if defined? ActionController
end
