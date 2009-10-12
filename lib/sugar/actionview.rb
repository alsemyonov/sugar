require 'sugar/actionview/forms'
require 'sugar/actionview/structure'

module Sugar
  module Actionview
    include Sugar::Actionview::Structure
    include Sugar::Actionview::Forms

    def human(*args)
      if args.size == 2
        args.first.human_attribute_name(args.second.to_s)
      else
        args.first.human_name
      end
    end

    def zebra
      {:class => cycle('even', 'odd')}
    end

    def translatable(text, key = nil)
      key ||= ".#{text.gsub(/[\s\.,-]+/, '_').downcase}"
      translate(key, :default => text)
    end

    def body_class
      controller_name = controller.controller_name
      {:class => "m_#{controller_name} m_#{controller_name}-#{controller.action_name}"}
    end
  end
end

