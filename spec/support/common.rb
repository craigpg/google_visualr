def data_table
  @cols = [
    { :type => "string", :label => "Year" },
    { :type => "number", :label => "Sales" },
    { :type => "number", :label => "Expenses" }
  ]
  @rows = [
    { :c => [{ :v => "2004" }, { :v => 1000 }, { :v => 400 }] },
    { :c => [{ :v => "2005" }, { :v => 1200 }, { :v => 450 }] },
    { :c => [{ :v => "2006" }, { :v => 1500 }, { :v => 600 }] },
    { :c => [{ :v => "2007" }, { :v => 800  }, { :v => 500 }] }
  ]
  GoogleVisualr::DataTable.new(:cols => @cols, :rows => @rows)
end

def base_chart(data_table=data_table)
  GoogleVisualr::BaseChart.new(data_table, { :legend => "Test Chart", :width => 800, :is3D => true })
end

def base_chart_js(div_class="div_class")
  js  = <<JS
<script type='text/javascript'>
  google.load('visualization','1', {packages: ['basechart'], callback: function() {
    var data_table = new google.visualization.DataTable();data_table.addColumn({\"type\":\"string\",\"label\":\"Year\"});data_table.addColumn({\"type\":\"number\",\"label\":\"Sales\"});data_table.addColumn({\"type\":\"number\",\"label\":\"Expenses\"});data_table.addRow([{v: \"2004\"}, {v: 1000}, {v: 400}]);data_table.addRow([{v: \"2005\"}, {v: 1200}, {v: 450}]);data_table.addRow([{v: \"2006\"}, {v: 1500}, {v: 600}]);data_table.addRow([{v: \"2007\"}, {v: 800}, {v: 500}]);\n    var chart = new google.visualization.BaseChart(document.getElementById('#{div_class}'));
    
    chart.draw(data_table, {legend: \"Test Chart\", width: 800, is3D: true});
  }});
</script>
JS
end

def base_chart_with_listener_js(div_class="div_class")
  js  = <<JS
<script type='text/javascript'>
  google.load('visualization','1', {packages: ['basechart'], callback: function() {
    var data_table = new google.visualization.DataTable();data_table.addColumn({\"type\":\"string\",\"label\":\"Year\"});data_table.addColumn({\"type\":\"number\",\"label\":\"Sales\"});data_table.addColumn({\"type\":\"number\",\"label\":\"Expenses\"});data_table.addRow([{v: \"2004\"}, {v: 1000}, {v: 400}]);data_table.addRow([{v: \"2005\"}, {v: 1200}, {v: 450}]);data_table.addRow([{v: \"2006\"}, {v: 1500}, {v: 600}]);data_table.addRow([{v: \"2007\"}, {v: 800}, {v: 500}]);\n    var chart = new google.visualization.BaseChart(document.getElementById('#{div_class}'));
    google.visualization.events.addListener(chart, 'select', function() {test_event(chart);});
    chart.draw(data_table, {legend: \"Test Chart\", width: 800, is3D: true});
  }});
</script>
JS
end

def base_chart_with_listener_js_with_jquery_proxy(div_class="div_class")
  js  = <<JS
<script type='text/javascript'>
  google.load('visualization','1', {packages: ['basechart'], callback: function() {
    var data_table = new google.visualization.DataTable();data_table.addColumn({\"type\":\"string\",\"label\":\"Year\"});data_table.addColumn({\"type\":\"number\",\"label\":\"Sales\"});data_table.addColumn({\"type\":\"number\",\"label\":\"Expenses\"});data_table.addRow([{v: \"2004\"}, {v: 1000}, {v: 400}]);data_table.addRow([{v: \"2005\"}, {v: 1200}, {v: 450}]);data_table.addRow([{v: \"2006\"}, {v: 1500}, {v: 600}]);data_table.addRow([{v: \"2007\"}, {v: 800}, {v: 500}]);\n    var chart = new google.visualization.BaseChart(document.getElementById('#{div_class}'));
    google.visualization.events.addListener(chart, 'select', jQuery.proxy(function() {test_event(chart);}, { chart: chart, data_table: data_table }));
    chart.draw(data_table, {legend: \"Test Chart\", width: 800, is3D: true});
  }});
</script>
JS
end
