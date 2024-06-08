import 'dart:math';

import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../ViewModels/Products/ChartsViewModel.dart';
import '../../res/AppColor.dart';
import '../../res/AppText.dart';
import '../../ViewModels/Products/ProductData.dart';

/// This widget represents a view for displaying charts. It allows users to select
/// different filters to visualize data in different chart types such as column
/// and line charts. The data for the charts is fetched from a remote server
/// using the [ChartViewModel] class.
class ChartView extends StatefulWidget {
  @override
  _ChartViewState createState() => _ChartViewState();
}

class _ChartViewState extends State<ChartView> {
  final ChartViewModel _viewModel = ChartViewModel();
  String _selectedFilter = 'Near Sold Out'; // Default filter value
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
    final localizations = AppLocalizations.of(context)!; // Get translation

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          localizations.charts,
          style: TextStyle(
            color: AppColor.primary,
            fontSize: AppText.HeadingOne.fontSize,
            fontWeight: AppText.HeadingOne.fontWeight,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: AppColor.primary),
          onPressed: () {
            Navigator.pushReplacementNamed(context, '/dashboard');
          },
        ),
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            _buildFilterDropdown(localizations),
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

  /// Builds the dropdown widget for selecting filters.
  Widget _buildFilterDropdown(AppLocalizations localizations) {
    List<Map<String, String>> filterItems = [
      {'value': 'Near Sold Out', 'text': localizations.nearSoldOut},
      {
        'value': 'Expiration Date Proximity',
        'text': localizations.expirationDateProximity
      },
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
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: AppColor.primary,
            ),
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
                child: Text(
                  item['text']!,
                  style: TextStyle(color: AppColor.primary),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  /// Builds the chart for products near sold out.
  Widget _buildNearSoldOutChart() {
    return _buildColumnChart(
        _viewModel.data.cast<ProductData>(), 'Product', 'Quantity');
  }

  /// Builds the column chart.
  Widget _buildColumnChart(List<ProductData> data, String xAxisTitle,
      String yAxisTitle) {
    data = data.where((dataPoint) => dataPoint.productName.isNotEmpty).toList();

    return SfCartesianChart(
      legend: Legend(isVisible: true, position: LegendPosition.bottom),
      tooltipBehavior: TooltipBehavior(enable: true),
      series: <CartesianSeries>[
        ColumnSeries<ProductData, String>(
          dataSource: data,
          xValueMapper: (ProductData product, _) => product.productName,
          yValueMapper: (ProductData product, _) => product.quantity.toDouble(),
          dataLabelSettings: DataLabelSettings(isVisible: true),
          name: 'Product',
          color: AppColor.primary,
        ),
      ],
      primaryXAxis: CategoryAxis(
        title: AxisTitle(
          text: xAxisTitle,
          textStyle: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: AppColor.grey,
          ),
        ),
      ),
      primaryYAxis: NumericAxis(
        title: AxisTitle(
          text: yAxisTitle,
          textStyle: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: AppColor.grey,
          ),
        ),
      ),
    );
  }

  /// Builds the chart for expiration date proximity.
  Widget _buildExpirationDateProximityChart() {
    return _buildLineChart(
        _viewModel.data.cast<ProductData>(), 'Product', 'Remaining Days');
  }

  /// Builds the line chart.
  Widget _buildLineChart(List<ProductData> data, String xAxisTitle,
      String yAxisTitle) {
    data = data.where((dataPoint) => dataPoint.productName.isNotEmpty && dataPoint.remainingDays > 0).toList();

    return SfCartesianChart(
      legend: Legend(isVisible: true, position: LegendPosition.bottom),
      tooltipBehavior: TooltipBehavior(enable: true),
      series: <CartesianSeries>[
        LineSeries<ProductData, String>(
          dataSource: data,
          xValueMapper: (ProductData product, _) => product.productName
          ,
          yValueMapper: (ProductData product, _) => product.remainingDays.toDouble(),
          dataLabelSettings: DataLabelSettings(isVisible: true),
          name: 'Remaining Days',
          color: AppColor.primary,
        ),
      ],
      primaryXAxis: CategoryAxis(
        title: AxisTitle(
          text: xAxisTitle,
          textStyle: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: AppColor.grey,
          ),
        ),
      ),
      primaryYAxis: NumericAxis(
        title: AxisTitle(
          text: yAxisTitle,
          textStyle: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: AppColor.grey,
          ),
        ),
      ),
    );
  }
}