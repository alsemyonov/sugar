module Sugar
  module Actionview
    VIEW_PLACEHOLDERS = {
      'create' => 'new',
      'update' => 'edit'
    }

    def view_name
      action_name = controller.action_name
      VIEW_PLACEHOLDERS[action_name] || action_name
    end

    # Return page title for use in layout
    def page_title(title = nil)
      @title ||= title || t("#{controller_name}.#{view_name}.title")
      @title
    end

    # Put submit with proper text
    def submit(form, title = nil)
      title ||= t("#{controller.controller_name}.#{view_name}.submit")
      form.submit(title)
    end

    # Build simple navigation list
    def navigation_list(menu)
      returning '' do |result|
        menu.each do |item|
          path = "/#{item}"
          uri = request.request_uri
          title = t("#{item}.index.title")
          result << content_tag(:li, :class => uri.starts_with?(path) ? 'selected' : nil) do
            link_to_unless_current(title, path) {
              content_tag(:strong, title)
            }
          end
        end
      end
    end

    # Build image submit
    def image_to(src, name, options = {}, html_options = {})
      html_options = html_options.stringify_keys
      convert_boolean_attributes!(html_options, %w( disabled ))

      method_tag = ''
      if (method = html_options.delete('method')) && %w{put delete}.include?(method.to_s)
        method_tag = tag('input', :type => 'hidden', :name => '_method', :value => method.to_s)
      end

      form_method = method.to_s == 'get' ? 'get' : 'post'

      request_token_tag = ''
      if form_method == 'post' && protect_against_forgery?
        request_token_tag = tag(:input, :type => "hidden", :name => request_forgery_protection_token.to_s, :value => form_authenticity_token)
      end

      if confirm = html_options.delete("confirm")
        html_options["onclick"] = "return #{confirm_javascript_function(confirm)};"
      end

      url = options.is_a?(String) ? options : self.url_for(options)

      html_options.merge!("type" => "image", "src" => image_path(src), :alt => name, :title => name)

      "<form method=\"#{form_method}\" action=\"#{escape_once url}\" class=\"button-to\"><div class=\"b_input b_input-imagebutton\">" +
        method_tag + tag("input", html_options) + request_token_tag + "</div></form>"
    end

    def link_to_edit(something)
      link_to(image_tag('icons/edit.png',
                        :alt => t('.edit'),
                        :title => t('.edit')),
              edit_polymorphic_path(something),
              :class => 'ajax edit')
    end

    def button_to_delete(something)
      image_to('icons/delete.png',
               t('.delete'),
               polymorphic_path(something),
               :class => 'ajax delete',
               :method => :delete,
               :confirm => t('sure'))
    end

    def link_to_delete(something)
      link_to(image_tag('icons/delete.png',
                        :alt => t('.delete'),
                        :title => t('.delete')),
              polymorphic_path(something),
              :class => 'ajax delete')
    end
  end
end

