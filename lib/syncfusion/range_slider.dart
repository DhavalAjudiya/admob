import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart' hide LabelPlacement;
import 'package:syncfusion_flutter_sliders/sliders.dart';

/// This widget is the home page of the application.
class SfRangeSlider extends StatefulWidget {
  const SfRangeSlider({Key? key}) : super(key: key);

  @override
  State<SfRangeSlider> createState() => _SfRangeSliderState();
}

class _SfRangeSliderState extends State<SfRangeSlider> {
  _SfRangeSliderState();

  final List<Data> _chartData = <Data>[
    Data(x: DateTime(2003, 01, 01), y: 3.4),
    Data(x: DateTime(2004, 01, 01), y: 2.8),
    Data(x: DateTime(2005, 01, 01), y: 1.6),
    Data(x: DateTime(2006, 01, 01), y: 2.3),
    Data(x: DateTime(2007, 01, 01), y: 2.5),
    Data(x: DateTime(2008, 01, 01), y: 2.9),
    Data(x: DateTime(2009, 01, 01), y: 3.8),
    Data(x: DateTime(2010, 01, 01), y: 2.0),
  ];

  final DateTime _dateMin = DateTime(2003, 01, 01);
  final DateTime _dateMax = DateTime(2010, 01, 01);
  final SfRangeValues _dateValues = SfRangeValues(DateTime(2005, 01, 01), DateTime(2008, 01, 01));
  SfDividerShape dividerShape = const SfDividerShape();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Syncfusion Flutter Range Selector'),
      ),
      body: Container(
          margin: EdgeInsets.zero,
          padding: EdgeInsets.zero,
          child: Stack(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Center(
                  // ignore: missing_required_param
                  child: SfRangeSelector(
                    dragMode: SliderDragMode.both,
                    dividerShape: dividerShape,
                    overlayShape: const SfOverlayShape(),
                    enabled: true,
                    enableTooltip: true,
                    activeColor: Colors.green,
                    showDividers: false,
                    shouldAlwaysShowTooltip: false,
                    tooltipShape: const SfPaddleTooltipShape(),
                    onChangeEnd: (SfRangeValues) {
                      DateTime rangend = SfRangeValues.end;
                      print("SfRangeValues---rangend----$rangend");
                    },
                    onChangeStart: (SfRangeValues) {
                      DateTime rangstart = SfRangeValues.start;
                      print("SfRangeValues---rangstart----$rangstart");
                    },
                    min: _dateMin,
                    max: _dateMax,
                    initialValues: _dateValues,
                    labelPlacement: LabelPlacement.betweenTicks,
                    interval: 1,
                    dateIntervalType: DateIntervalType.years,
                    dateFormat: DateFormat.y(),
                    showTicks: true,
                    showLabels: true,
                    child: SizedBox(
                      child: SfCartesianChart(
                        backgroundColor: Colors.transparent,
                        borderColor: Colors.transparent,
                        plotAreaBorderColor: Colors.transparent,
                        plotAreaBackgroundColor: Colors.transparent,
                        trackballBehavior: TrackballBehavior(
                          activationMode: ActivationMode.singleTap,
                        ),
                        title: ChartTitle(),
                        enableAxisAnimation: true, legend: Legend(),
                        enableSideBySideSeriesPlacement: true,
                        isTransposed: false,
                        // enableMultiSelection: true,
                        // selectionType: SelectionType.point,
                        crosshairBehavior: CrosshairBehavior(),

                        onChartTouchInteractionMove: (val) {
                          print("onChartTouchInteractionMove----$val");
                        },
                        margin: EdgeInsets.zero,
                        primaryXAxis: DateTimeAxis(
                          minimum: _dateMin,
                          maximum: _dateMax,
                          isVisible: false,
                        ),
                        primaryYAxis: NumericAxis(isVisible: false, maximum: 4),
                        series: <SplineAreaSeries<Data, DateTime>>[
                          SplineAreaSeries<Data, DateTime>(
                              dataSource: _chartData,
                              xValueMapper: (Data sales, int index) => sales.x,
                              yValueMapper: (Data sales, int index) => sales.y)
                        ],
                      ),
                      height: 200,
                    ),
                  ),
                ),
              ),
            ],
          )),
    );
  }
}

/// Storing the spline series data points.
class Data {
  /// Initialize the instance of the [Data] class.
  Data({required this.x, required this.y});

  /// Spline series x points.
  final DateTime x;

  /// Spline series y points.
  final double y;
}
