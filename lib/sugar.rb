module Sugar
  autoload :ActiveRecord, 'sugar/active_record'
  autoload :ActionView, 'sugar/action_view'
  autoload :ActionController, 'sugar/action_controller'

  def self.locale_files
    Dir[File.join(File.dirname(__FILE__), 'sugar', 'locales', '*')]
  end
end

if defined? Rails
  ActionView::Base.send :include, Sugar::Actionview if defined? ActionView
  ActionController::Base.send :include, Sugar::Actioncontroller if defined? ActionController
  I18n.load_path.unshift(*Sugar.locale_files)
end
