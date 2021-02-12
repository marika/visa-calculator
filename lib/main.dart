// import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:intl/intl.dart';
import 'package:flutter_application_1/theme.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Калькулятор Шенгенской визы',
      theme: ThemeData(
        primarySwatch: primarySwatch,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Калькулятор Шенгенской визы 90/180'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  //DateRangePickerSelectionChangedArgs _counter;
  DateRangePickerController _controller;
  List<PickerDateRange> _ranges = [];
  DateTime _today;
  String _rangeCount;
  int _difference;

  @override
  void initState() {
    _difference = 0;
    _rangeCount = '0';
    _controller = DateRangePickerController();
    _today = DateTime.now();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Container(
       // alignment: Alignment.topLeft,
        margin: EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            SfDateRangePicker(
              controller: _controller,
              view: DateRangePickerView.month,
              monthViewSettings: DateRangePickerMonthViewSettings(
                firstDayOfWeek: 1,
                //showTrailingAndLeadingDates: true,
                dayFormat: 'EEE',
              ),
              // initialSelectedRanges: [
              //   PickerDateRange(
              //       DateTime.now().subtract(const Duration(days: 4)),
              //       DateTime.now().add(const Duration(days: 3)))
              // ],
              //todayHighlightColor: redText,
               minDate: DateTime.now().add(const Duration(days: -800)),
              //maxDate: DateTime.now().add(const Duration(days: 800)),
              onSelectionChanged: _onSelectionChanged,
              selectionMode: DateRangePickerSelectionMode.multiRange,
              //backgroundColor: lightbackgroundColor,
              rangeSelectionColor: rangeSelectionColor,
              endRangeSelectionColor:  endRangeSelectionColor,
              startRangeSelectionColor: startRangeSelectionColor,
              //selectionRadius: 10,
              selectionShape: DateRangePickerSelectionShape.circle,

              headerStyle: DateRangePickerHeaderStyle(
                textAlign: TextAlign.center,
                textStyle: TextStyle(
                    color: blackText,
                    fontSize: 20,
                    fontWeight: FontWeight.w400),
                //backgroundColor: lightbackgroundColor,
              ),

              // monthCellStyle: DateRangePickerMonthCellStyle(
              //   weekendDatesDecoration: BoxDecoration(
              //       color: lightbackgroundColor, shape: BoxShape.circle),
              //   leadingDatesTextStyle: TextStyle(color: Colors.black38),
              //   trailingDatesTextStyle: TextStyle(color: Colors.black38),
              // ),

              cellBuilder: bildCell,

              /////////////////////////////////////
            ),
            rangeWidget(),
          ],
        ),
      ),
    );
  }

  void _onSelectionChanged(DateRangePickerSelectionChangedArgs args) {
    setState(() {
      _ranges = args.value;
      _rangeCount = args.value.length.toString();

      _difference = 0;
      args.value.forEach((item) {
        if (item.endDate != null)
          _difference += item.endDate.difference(item.startDate).inDays + 1;
      });
    });
  }

  Widget bildCell(
      BuildContext context, DateRangePickerCellDetails cellDetails) {
    int res = dateCalculator(cellDetails.date);
    bool today = false;
    if(DateFormat('yyyy-MM-dd').format(cellDetails.date) == DateFormat('yyyy-MM-dd').format(_today)) today = true;
    
    return Container(
        
        //width: cellDetails.bounds.width,
        //height: cellDetails.bounds.height,
        //alignment: Alignment.center,
        //margin: EdgeInsets.all(2),
        padding: EdgeInsets.all(5),
        //decoration: BoxDecoration(color: lightbackgroundColor, shape: BoxShape.rectangle),
        child: Stack(
          children: [
            Positioned(
                top: 10,
                left: 20,
                child: Text(
                  res.toString(),
                  style: TextStyle(color: res == 0 ? redText : greenText),
                )),

             
            Text(cellDetails.date.day.toString(), 
            style: TextStyle(fontWeight: today ? FontWeight.w800 : FontWeight.w400,
                                //color: today ? Colors.blue : blackText,
                                fontSize: 15,
                                ),),
            //Text(DateFormat('d').format(cellDetails.date)),
          ],
        ));
  }

  Widget rangeWidget() {
    return Column(
        //mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Периодов: $_rangeCount продолжительностью: $_difference дней \n',
            style: Theme.of(context).textTheme.subtitle1,
          ), //
          ..._ranges.map((item) {
            if (item.endDate != null) {
              String startDate =
                  DateFormat('yyyy-MM-dd').format(item.startDate);
              String endDate = DateFormat('yyyy-MM-dd').format(item.endDate);
              int d = item.endDate.difference(item.startDate).inDays + 1;

              return Text('$startDate - $endDate - дней $d ');
            } else
              return Text(' ');
          }).toList(),
        ]);
  }

  int dateCalculator(DateTime date) {
    int res = 0;
    int differrence = 0;
    DateTime border =
        date.subtract(const Duration(days: 180)); //граница 180 дневного периода
    //print ('Border - $border for day $date' );
    _ranges.forEach((item) {
      if (item.startDate != null && item.endDate != null) {
        if (!item.startDate.isBefore(border) && !item.endDate.isAfter(date)) {
          //внутри диапазона
          differrence += item.endDate.difference(item.startDate).inDays + 1;
        } else if (item.startDate.isBefore(border) &&
            !item.endDate.isBefore(border)) {
          differrence += item.endDate.difference(border).inDays + 1;
        } else if (!item.startDate.isAfter(date) &&
            item.endDate.isAfter(date)) {
          differrence += date.difference(item.startDate).inDays + 1;
        }
        //else print('ERROR date!!!!!!!!!!  $date');
      }
    });
    //DateTime curr = new DateTime(2021, 08, 03);
    //if(date.compareTo(curr) == 0) { print ('date $date border $border' );}
    if (differrence < 90) res = 90 - differrence;

    //print ('date - ${DateFormat('yyyy-MM-dd').format(date)} diff- $differrence, res- $res');
    return res;
  }
}
