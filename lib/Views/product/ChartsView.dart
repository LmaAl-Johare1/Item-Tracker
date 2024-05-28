import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart'; // استيراد الترجمة
import '../../ViewModels/products/ChartsViewModel.dart';

class ChartView extends StatefulWidget {
  @override
  _ChartViewState createState() => _ChartViewState();
}

class _ChartViewState extends State<ChartView> {
  final ChartViewModel _viewModel = ChartViewModel();
  String _selectedFilter = 'Near Sold Out'; // القيمة الافتراضية للتصفية
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
    final localizations = AppLocalizations.of(context)!; // الحصول على الترجمة

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: Text(
          localizations.charts,
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
            _buildFilterDropdown(localizations), // تمرير الترجمة
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

  Widget _buildFilterDropdown(AppLocalizations localizations) {
    List<Map<String, String>> filterItems = [
      {'value': 'Near Sold Out', 'text': localizations.nearSoldOut},
      {'value': 'Expiration Date Proximity', 'text': localizations.expirationDateProximity},
    ];




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
            localizations.filter,
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
            items: filterItems.map<DropdownMenuItem<String>>((item) {
              return DropdownMenuItem<String>(
                value: item['value']!,
                child: Text(item['text']!),
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

  Widget _buildChart(
      List<SalesData> data, String xAxisTitle, String yAxisTitle) {
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
