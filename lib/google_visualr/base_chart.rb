module GoogleVisualr

  class BaseChart
    include GoogleVisualr::Packages
    include GoogleVisualr::ParamHelpers
    
    JS_VAR = 'chart'

    attr_accessor :data_table, :listeners

    def initialize(data_table, options={})
      @data_table = data_table
      send(:options=, options)
      @listeners  = []
    end

    def chart_name
      class_name
    end

    def options
      @options
    end

    def options=(options)
      @options = stringify_keys!(options)
    end

    def add_listener(event, callback)
      @listeners << { :event => event.to_s, :callback => callback }
    end

    # Generates JavaScript and renders the Google Chart in the final HTML output.
    #
    # Parameters:
    #  *div_id            [Required] The ID of the DIV element that the Google Chart should be rendered in.
    #  options            [Optional] Listeners will use JQuery proxying to provide access to chart and data_table
    def to_js(element_id, options = {})
      listeners = @listeners.map do |l|
        callback = options[:use_jquery_proxy] ? "jQuery.proxy(#{l[:callback]}, { chart: #{JS_VAR}, data_table: #{DataTable::JS_VAR} })" : l[:callback]
        "google.visualization.events.addListener(chart, '#{l[:event]}', #{callback});"
      end.join('\n')
<<JS
<script type='text/javascript'>
  google.load('visualization','1', {packages: ['#{package_name}'], callback: function() {
    #{@data_table.to_js}
    var #{JS_VAR} = new google.visualization.#{chart_name}(document.getElementById('#{element_id}'));
    #{listeners}
    #{JS_VAR}.draw(data_table, #{js_parameters(@options)});
  }});
</script>
JS
    end

  end

end
