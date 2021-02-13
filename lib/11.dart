//
 Widget build([BuildContext context]) {
    final Widget calendar = Container(
      height: 250,
      padding: const EdgeInsets.fromLTRB(5, 0, 5, 5),
      color: model.cardThemeColor,
      child: Theme(
        data: model.themeData.copyWith(accentColor: model.backgroundColor),
        child: _getVerticalCalendar(),
      ),
    );
    final Widget _cardView = Card(
        elevation: 5,
        margin: const EdgeInsets.fromLTRB(10, 10, 10, 10),
        child: calendar);
    return Scaffold(
        backgroundColor: model.themeData == null ||
                model.themeData.brightness == Brightness.light
            ? null
            : const Color(0x171A21),
        body: Column(children: <Widget>[
          Expanded(
              flex: 9,
              child: model.isWeb
                  ? Center(
                      child:

                          /// 580 defines 550 height and 30 margin
                          Container(width: 400, height: 580, child: _cardView))

                  /// 590 defines 550 height and 40 margin
                  : ListView(children: <Widget>[
                      Container(
                        height: MediaQuery.of(context).size.height * 0.85,
                        child: calendar,
                      )
                    ]))
        ]));
  }

  /// Returns the date range picker widget based on the properties passed.
  SfDateRangePicker _getVerticalCalendar() {
    return SfDateRangePicker(
            toggleDaySelection: true,
      enableMultiView: true,
      navigationDirection: DateRangePickerNavigationDirection.vertical,
      selectionMode: DateRangePickerSelectionMode.multiRange,
      startRangeSelectionColor: Colors.deepPurple,
      // selectionShape: DateRangePickerSelectionShape.rectangle,

    );
  }

  
   
/// Dart import
import 'dart:math';

///Package import
import 'package:flutter/material.dart';

///Date picker imports
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

///Local import
//import '../../model/sample_view.dart';

/// Render datepicker widget with customized options
class CustomizedDatePicker extends SampleView {
  /// Creates datepicker widget with customized options
  const CustomizedDatePicker(Key key) : super(key: key);

  @override
  _CustomizedDatePickerState createState() => _CustomizedDatePickerState();
}

class _CustomizedDatePickerState extends SampleViewState {
  _CustomizedDatePickerState();

  List<DateTime> _specialDates;
  Orientation _deviceOrientation;

  @override
  void initState() {
    _specialDates = _getSpecialDates();
    super.initState();
  }

  /// Returns the list of dates which will set to the special dates of the
  /// date range picker.
  List<DateTime> _getSpecialDates() {
    final List<DateTime> dates = <DateTime>[];
    final DateTime startDate =
        DateTime.now().subtract(const Duration(days: 200));
    final DateTime endDate = DateTime.now().add(const Duration(days: 500));
    final Random random = Random();
    for (DateTime date = startDate;
        date.isBefore(endDate);
        date = date.add(const Duration(days: 25))) {
      for (int i = 0; i < 3; i++) {
        dates.add(date.add(Duration(days: random.nextInt(i + 4))));
      }
    }

    return dates;
  }

  @override
  void didChangeDependencies() {
    _deviceOrientation = MediaQuery.of(context).orientation;
    super.didChangeDependencies();
  }

  @override
  Widget build([BuildContext context]) {
    final Widget _datePicker = Card(
      elevation: 10,
      margin:  EdgeInsets.all(30),
      child: Container(
          padding: const EdgeInsets.fromLTRB(5, 0, 5, 5),
         // color: model.cardThemeColor,
          child: _getCustomizedDatePicker(_specialDates, model.themeData)),
    );
    return Scaffold(
      backgroundColor:  Color(0x171A21),
      body: Column(children: <Widget>[
        Expanded(
            flex:  8,
            child: ListView(children: <Widget>[
                    Container(height: 450, child: _datePicker)
                  ])),
        Expanded( 
            child: Container())
      ]),
    );
  }

  /// Returns the date range picker based on the properties passed
  SfDateRangePicker _getCustomizedDatePicker(
      [List<DateTime> specialDates, ThemeData theme]) {
    final bool isDark = theme != null &&
        theme.brightness != null &&
        theme.brightness == Brightness.dark;

    final Color monthCellBackground =
        isDark ? const Color(0xFF232731) : const Color(0xfff7f4ff);
    final Color indicatorColor =
        isDark ? const Color(0xFF5CFFB7) : const Color(0xFF1AC4C7);
    final Color highlightColor =
        isDark ? const Color(0xFF5CFFB7) : Colors.deepPurpleAccent;
    final Color cellTextColor =
        isDark ? const Color(0xFFDFD4FF) : const Color(0xFF130438);

    return SfDateRangePicker(
      selectionShape: DateRangePickerSelectionShape.rectangle,
      selectionColor: highlightColor,
      selectionTextStyle:
          TextStyle(color: isDark ? Colors.black : Colors.white, fontSize: 14),
      minDate: DateTime.now().add(const Duration(days: -200)),
      maxDate: DateTime.now().add(const Duration(days: 500)),
      headerStyle: DateRangePickerHeaderStyle(
          textAlign: TextAlign.center,
          textStyle: TextStyle(
            fontSize: 18,
            color: cellTextColor,
          )),
      monthCellStyle: DateRangePickerMonthCellStyle(
          cellDecoration: _MonthCellDecoration(
              borderColor: null,
              backgroundColor: monthCellBackground,
              showIndicator: false,
              indicatorColor: indicatorColor),
          todayCellDecoration: _MonthCellDecoration(
              borderColor: highlightColor,
              backgroundColor: monthCellBackground,
              showIndicator: false,
              indicatorColor: indicatorColor),
          specialDatesDecoration: _MonthCellDecoration(
              borderColor: null,
              backgroundColor: monthCellBackground,
              showIndicator: true,
              indicatorColor: indicatorColor),
          disabledDatesTextStyle: TextStyle(
            color: isDark ? const Color(0xFF666479) : const Color(0xffe2d7fe),
          ),
          weekendTextStyle: TextStyle(
            color: highlightColor,
          ),
          textStyle: TextStyle(color: cellTextColor, fontSize: 14),
          specialDatesTextStyle: TextStyle(color: cellTextColor, fontSize: 14),
          todayTextStyle: TextStyle(color: highlightColor, fontSize: 14)),
      yearCellStyle: DateRangePickerYearCellStyle(
        todayTextStyle: TextStyle(color: highlightColor, fontSize: 14),
        textStyle: TextStyle(color: cellTextColor, fontSize: 14),
        disabledDatesTextStyle: TextStyle(
            color: isDark ? const Color(0xFF666479) : const Color(0xffe2d7fe)),
        leadingDatesTextStyle:
            TextStyle(color: cellTextColor.withOpacity(0.5), fontSize: 14),
      ),
      showNavigationArrow: true,
      todayHighlightColor: highlightColor,
      monthViewSettings: DateRangePickerMonthViewSettings(
        firstDayOfWeek: 1,
        viewHeaderStyle: DateRangePickerViewHeaderStyle(
            textStyle: TextStyle(
                fontSize: 10,
                color: cellTextColor,
                fontWeight: FontWeight.w600)),
        dayFormat: 'EEE',
        showTrailingAndLeadingDates: false,
        specialDates: specialDates,
      ),
    );
  }
}

/// [_MonthCellDecoration] used to customize the month cell
/// background of [SfDateRangePicker].
/// [backgroundColor] property used to draw the fill color the month cell
/// [borderColor] property used to draw the border to highlight the
/// today month cell.
/// [showIndicator] property used to decide whether the cell
/// have indicator or not.
/// it is enabled then draw the circle on right top corner
/// with [indicatorColor].
class _MonthCellDecoration extends Decoration {
  const _MonthCellDecoration(
      {this.borderColor,
      this.backgroundColor,
      this.showIndicator,
      this.indicatorColor});

  final Color borderColor;
  final Color backgroundColor;
  final bool showIndicator;
  final Color indicatorColor;

  @override
  BoxPainter createBoxPainter([VoidCallback onChanged]) {
    return _MonthCellDecorationPainter(
        borderColor: borderColor,
        backgroundColor: backgroundColor,
        showIndicator: showIndicator,
        indicatorColor: indicatorColor);
  }
}

/// [_MonthCellDecorationPainter] used to paint month cell decoration.
class _MonthCellDecorationPainter extends BoxPainter {
  _MonthCellDecorationPainter(
      {this.borderColor,
      this.backgroundColor,
      this.showIndicator,
      this.indicatorColor});

  final Color borderColor;
  final Color backgroundColor;
  final bool showIndicator;
  final Color indicatorColor;

  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration configuration) {
    final Rect bounds = offset & configuration.size;
    _drawDecoration(canvas, bounds);
  }

  void _drawDecoration(Canvas canvas, Rect bounds) {
    final Paint paint = Paint()..color = backgroundColor;
    canvas.drawRRect(
        RRect.fromRectAndRadius(bounds, const Radius.circular(5)), paint);
    paint.style = PaintingStyle.stroke;
    paint.strokeWidth = 1;
    if (borderColor != null) {
      paint.color = borderColor;
      canvas.drawRRect(
          RRect.fromRectAndRadius(bounds, const Radius.circular(5)), paint);
    }

    if (showIndicator) {
      paint.color = indicatorColor;
      paint.style = PaintingStyle.fill;
      canvas.drawCircle(Offset(bounds.right - 6, bounds.top + 6), 2.5, paint);
    }
  }
}


import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

void main() => runApp(CellBuilderPicker());

class CellBuilderPicker extends StatefulWidget {
  @override
  ViewNavigationState createState() => ViewNavigationState();
}

class ViewNavigationState extends State<CellBuilderPicker> {
  DateRangePickerController _controller;

  @override
  initState() {
    _controller = DateRangePickerController();

    super.initState();
  }

  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: SafeArea(
          child: Card(
            margin: const EdgeInsets.fromLTRB(50, 150, 50, 150),
            child: SfDateRangePicker(
              view: DateRangePickerView.month,
              selectionMode: DateRangePickerSelectionMode.multiRange,
              controller: _controller,
              cellBuilder: cellBuilder,
            ),
          ),
        ),
      ),
    );
  }

  Widget cellBuilder(
      BuildContext context, DateRangePickerCellDetails cellDetails) {
    if (_controller.view == DateRangePickerView.month) {
      return Column(
        children: [
          Container(
            child: Icon(
              Icons.wb_sunny,
              color: Colors.yellow,
            ),
          ),
          Container(
            child: Text(DateFormat('dd').format(cellDetails.date) + " - 0"),
          )
        ],
      );
    } else if (_controller.view == DateRangePickerView.year) {
      return Column(
        children: [
          Container(
            child: Icon(
              Icons.wb_sunny,
              color: Colors.yellow,
            ),
          ),
          Container(
            child: Text(DateFormat('MMM').format(cellDetails.date)),
          )
        ],
      );
    } else if (_controller.view == DateRangePickerView.decade) {
      return Column(
        children: [
          Container(
            child: Icon(
              Icons.wb_sunny,
              color: Colors.yellow,
            ),
          ),
          Container(
            child: Text(DateFormat('yyy').format(cellDetails.date)),
          )
        ],
      );
    } else if (_controller.view == DateRangePickerView.century) {
      final int yearValue = cellDetails.date.year;
      return Column(
        children: [
          Container(
            child: Icon(
              Icons.wb_sunny,
              color: Colors.yellow,
            ),
          ),
          Container(
            child:
                Text(yearValue.toString() + ' - ' + (yearValue + 9).toString()),
          )
        ],
      );
    }
  }
}