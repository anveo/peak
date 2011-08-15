$(function() {
    window.grapher = {
        data: [],
        chart: null,

        render: function() {
            this.chart = new Highcharts.StockChart({
                chart: {
                    renderTo: 'graph-cpu'
                },
                title: {
                    text: 'CPU Load Average'
                },
                yAxis: {
                    title: {
                        text: 'Load'
                    }
                },
                series: [{
                    name: 'Foo',
                    data: this.data,
                    type: 'area',
                    threshold: null
                }]
            });
        }
    };
});
