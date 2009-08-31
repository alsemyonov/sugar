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

    def default_page_title
      text = case action_name
             when 'index'
               controller_name.camelize
             when 'new', 'create'
               "#{t('new', :default => 'New')} #{controller_name.classify.constantize.human_name}"
             when 'edit', 'update'
               "#{t('edit', :default => 'Editing')} #{controller_name.classify.constantize.human_name}"
             else
               t("#{controller_name}.#{view_name}.title")
             end
      %(<span class="trasnlation_missing">#{text}</span>)
    end

    # Return page title for use in layout
    def page_title(title = nil)
      @page_title = if title
                 title
               else
                 @page_title || t("#{controller_name}.#{view_name}.title", :default => default_page_title)
               end
    end

    def html_page_title(default = false, separator = ' | ')
      default ||= t('application.title')
      [page_title, default].compat.join(separator)
    end

    # Put submit with proper text
    def submit(form, title = nil)
      title ||= t("#{controller.controller_name}.#{view_name}.submit",
                  :default => form.object.new_record? ? "#{t('create', :default => 'Add')} #{form.object.class.human_name}" : "#{t('update', :default => 'Save')} #{form.object.class.human_name}")
      form.submit(title)
    end

    # Build simple navigation list
    def navigation_list(menu)
      returning '' do |result|
        menu.each do |item|
          path = "/#{item}"
          uri = request.request_uri
          title = t("#{item}.index.title", :default => item.to_s.camelize)
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

      "<form method=\"#{form_method}\" action=\"#{escape_once url}\" class=\"button-to action\"><div class=\"b_input b_input-imagebutton\">" +
        method_tag + tag("input", html_options) + request_token_tag + "</div></form>"
    end

    def link_to_edit(something)
      link_to(image_tag('icons/edit.png',
                        :alt => t('.edit'),
                        :title => t('.edit')),
              edit_polymorphic_path(something),
              :class => 'ajax edit action')
    end

    def button_to_delete(something, title = nil)
      title ||= t('.delete',
                  :default => %(Delete #{(something.is_a?(Array) ? something.last : something).class.human_name}))
      button_to(title,
                polymorphic_path(something),
                :class => 'delete action',
                :method => :delete,
                :confirm => t('sure', :default => 'Are you sure?'))
    end

    def image_button_to_delete(something)
      image_to('icons/delete.png',
               t('.delete', :default => 'Delete'),
               polymorphic_path(something),
               :class => 'delete action',
               :method => :delete,
               :confirm => t('sure'))
    end

    def link_to_delete(something)
      link_to(image_tag('icons/delete.png',
                        :alt => t('.delete', :default => 'Delete'),
                        :title => t('.delete', :default => 'Delete')),
              polymorphic_path(something),
              :class => 'ajax action delete')
    end

    def default_new_link_options
      @default_new_link_options ||= {
        :image => 'icons/add.png',
        :alt => t('.add', :default => 'Add'),
        :title => t('.add', :default => 'Add')
      }
    end

    def link_to_new(options = {})
      options = default_new_link_options.merge(options || {})
      url = options.has_key?(:url) ? options.delete(:url) : {:action => 'new'}
      link_to(image_tag(options.delete(:image),
                        options),
              url, :class => 'action')
    end

    def period_field(form, field)
      content_tag :div, :class => 'b_input b_input-period' do
        returning '' do |content|
          content << form.label(:"#{field}_min")
          content << form.text_field(:"#{field}_min")
          content << form.label(:"#{field}_max", '—', :class => 'period')
          content << form.text_field(:"#{field}_max")
        end
      end
    end

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
  end
end

