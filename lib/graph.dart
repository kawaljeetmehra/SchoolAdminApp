import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import '/components/drawer/custom_drawer.dart';
import 'footer.dart';
import '../controller/Home_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'dart:convert';
import 'package:intl/intl.dart';



class _PageGraph extends StatefulWidget {
  late List<_ChartData> data;
  // ignore: prefer_const_constructors_in_immutables
  _PageGraph({Key? key, required this.data}) : super(key: key);

  @override
  PageGraph createState() => PageGraph();
}

class PageGraph extends State<_PageGraph> {
  late TooltipBehavior _tooltip;

  @override
  void initState() {
    _tooltip = TooltipBehavior(enable: true);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double gapHeight = screenHeight * 0.24;
    return Container(
        height: gapHeight,
        child: SfCartesianChart(
            primaryXAxis: CategoryAxis(),
            primaryYAxis: NumericAxis(minimum: 0, maximum: 40, interval: 10),
            tooltipBehavior: _tooltip,
            series: <ChartSeries<_ChartData, String>>[
              ColumnSeries<_ChartData, String>(
                  dataSource: widget.data,
                  xValueMapper: (_ChartData data, _) => data.x,
                  yValueMapper: (_ChartData data, _) => data.y,
                  name: 'Gold',
                  color: Color(0xFFff753a))
            ]));
  }
}

class _ChartData {
  _ChartData(this.x, this.y);

  final String x;
  final double y;
}

class PieChart extends StatefulWidget {
  final double initialValue;
  late List<ChartDataPoint> data;
  PieChart({Key? key, required this.initialValue, required this.data})
      : super(key: key);

  @override
  _PieChartState createState() => _PieChartState();
}

class _PieChartState extends State<PieChart> {
  late TooltipBehavior _tooltip;

  @override
  void initState() {
    _tooltip = TooltipBehavior(enable: false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double gapHeight = screenHeight * widget.initialValue;
    return Container(
      height: gapHeight,
      child: SfCircularChart(
        tooltipBehavior: _tooltip,
        series: <DoughnutSeries<ChartDataPoint, String>>[
          DoughnutSeries<ChartDataPoint, String>(
            dataSource: widget.data,
            xValueMapper: (ChartDataPoint data, _) => data.x,
            yValueMapper: (ChartDataPoint data, _) => data.y,
            pointColorMapper: (ChartDataPoint data, _) => data.color,
            dataLabelMapper: (ChartDataPoint data, _) => data.x, // Use the first parameter as the label
            dataLabelSettings: DataLabelSettings(
              isVisible: true, // Show data labels
              labelPosition: ChartDataLabelPosition.outside, // Position of the labels
              connectorLineSettings: ConnectorLineSettings(
                type: ConnectorType.line, // Connector line type
                color: Colors.grey, // Connector line color
              ),
            ),
          ),

        ],
      ),
    );
  }
}

class ChartDataPoint {
  ChartDataPoint(this.x, this.y, this.color);

  final String x;
  final double y;
  final Color color;
}