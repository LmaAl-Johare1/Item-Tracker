import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../ViewModels/ChartsViewModel.dart';

class ChartView extends StatefulWidget {
  @override
  _ChartViewState createState() => _ChartViewState();
}

class _ChartViewState extends State<ChartView> {
  final ChartViewModel _viewModel = ChartViewModel();
  String _selectedFilter = 'Near Sold Out'; // Default filter option
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadChartData();
  }

  Future<void> _loadChartData() async {
    setState(() {
      _isLoading = true;
    });
    await _viewModel.loadData(_selectedFilter);
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: Text(
          'Charts',
          style: TextStyle(color: Colors.black),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushReplacementNamed(context, '/dashboard');
          },
          color: Colors.black,
        ),
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            _buildFilterDropdown(),
            SizedBox(height: 20),
            Expanded(
              child: _isLoading
                  ? Center(child: CircularProgressIndicator())
                  : Center(
                child: AnimatedSwitcher(
                  duration: Duration(milliseconds: 300),
                  child: _selectedFilter == 'Near Sold Out'
                      ? _buildNearSoldOutChart()
                      : _buildExpirationDateProximityChart(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFilterDropdown() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 4,
            offset: Offset(2, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Filter: ',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          ),
          SizedBox(width: 8),
          DropdownButton<String>(
            value: _selectedFilter,
            dropdownColor: Colors.white,
            onChanged: (String? newValue) {
              if (newValue != null) {
                setState(() {
                  _selectedFilter = newValue;
                  _loadChartData();
                });
              }
            },
            items: <String>[
              'Near Sold Out',
              'Expiration Date Proximity',
            ].map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildNearSoldOutChart() {
    return _buildChart(_viewModel.data, 'Product', 'Quantity');
  }

  Widget _buildExpirationDateProximityChart() {
    return _buildChart(
        _viewModel.data, 'Product', 'Remaining Days Until Expiry');
  }

  Widget _buildChart(List<SalesData> data, String xAxisTitle, String yAxisTitle) {
    data = data.where((dataPoint) => dataPoint.product.isNotEmpty).toList();

    return SfCartesianChart(
      legend: Legend(isVisible: false),
      tooltipBehavior: TooltipBehavior(enable: true),
      series: <CartesianSeries>[
        ColumnSeries<SalesData, String>(
          dataSource: data,
          xValueMapper: (SalesData sales, _) => sales.product,
          yValueMapper: (SalesData sales, _) => sales.value.toDouble(),
          dataLabelSettings: DataLabelSettings(isVisible: true),
          name: 'Product',
        ),
      ],
      primaryXAxis: CategoryAxis(
        title: AxisTitle(
            text: xAxisTitle,
            textStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
      ),
      primaryYAxis: NumericAxis(
        title: AxisTitle(
            text: yAxisTitle,
            textStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
      ),
    );
  }
}
