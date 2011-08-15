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
                    },
                    min: 0,
                    max: 2.1
                },
                navigator: {
                    enabled: false
                },
                scrollbar: {
                    enabled: false
                },
                rangeselector: {
                    enabled: false
                },
                credits: {
                    enabled: false
                },
                series: [{
                    name: 'Load Avg',
                    data: this.data,
                    type: 'area',
                    threshold: null,
                    id: 'loadavg'
                },
                {
                    type: 'flags',
                    name: 'Deploys',
                    data: this.deploy_data,
                    shape: 'squarepin'
                },
                {
                    type: 'flags',
                    name: 'Analytics',
                    data: this.analytics_data,
                    shape: 'squarepin',
                    onSeries: 'loadavg'
                }]
            });
        }
    };
});
