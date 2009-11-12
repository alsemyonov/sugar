module Sugar
  module Actionview
    module Stats
      def online_stats(options = {})
        static_includes = []
        dynamic_includes = ''
        noscript_includes = []
        initializers = []

        if options[:piwik]
          static_includes << "//#{options[:piwik][:site]}/piwik.js"
          initializers <<-END_PIWIK
            var piwikTracker = Piwik.getTracker("#{options[:piwik][:site]}/piwik.php", #{options[:piwik][:id]});
            piwikTracker.trackPageView();
            piwikTracker.enableLinkTracking();
          END_PIWIK
          noscript_includes << %(<img src="//#{options[:piwik][:site]}/piwik.php?idsite=#{options[:piwik][:id]}" alt="" style="border:0"  />)
        end

        if options[:metrika]
          static_includes << '//mc.yandex.ru/resource/watch.js'
          initializers << "var yaCounter#{options[:metrika]} = new Ya.Metrika(#{options[:metrika]});"
          noscript_includes << %(<img src="//mc.yandex.ru/watch/#{options[:metrika]}" alt="" />)
        end

        if options[:analytics]
          dynamic_includes << 'var gaJsHost=("https:"==document.location.protocol)?"https://ssl.":"http://www.";'
          dynamic_includes << 'document.write(unescape("%3Cscript src=\'"+gaJsHost+"google-analytics.com/ga.js"\' type=\'text/javascript\'%3E%3C/script%3E));'
          initializers << "var pageTracker = _gat._getTracker('#{options}'); pageTracker._trackPageview();"
        end

        returning '' do |result|
          unless dynamic_includes.empty?
            result << javascript_tag(dynamic_includes)
          end
          result << javascript_include_tag(static_includes) unless static_includes.empty?
          unless initializers.empty?
            result << javascript_tag do
              initializers.collect do |initializer|
            "try {#{initializer}} catch(e) {}\n"
              end
            end
          end
          unless noscript_includes.empty?
            result << content_tag(:noscript,
                                  content_tag(:div,
                                              noscript_includes.join,
                                              :style => 'position: absolute'))
          end
        end
      end

    end
  end
end
