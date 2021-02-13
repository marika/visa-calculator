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
        margin: EdgeInsets.all(10),
        child:
            //Expanded(
            //flex: 9,

            Container(
          child:
              //  ListView(children: <Widget>[
              Container(
            //height: MediaQuery.of(context).size.height * 0.85,
            child: calendar(),
            // rangeWidget(),
          ),
          // ]),
          //      )
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
        print('start - ${item.startDate},  end - ${item.endDate}');
        if (item.endDate != null)
          _difference += item.endDate.difference(item.startDate).inDays + 1;
      });

      _ranges.forEach((element) {
        print('ranges- ${element.startDate} - ${element.endDate}');
      });
    });
  }

  Widget calendar() {
    return SfDateRangePicker(
      controller: _controller,
      view: DateRangePickerView.month,
      navigationDirection: DateRangePickerNavigationDirection.vertical,
      enableMultiView: true,
      viewSpacing: 0,
      
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
      //toggleDaySelection: true,
      //backgroundColor: lightbackgroundColor,
      selectionRadius: 20,
      rangeSelectionColor: rangeSelectionColor,
      endRangeSelectionColor: endRangeSelectionColor,
      startRangeSelectionColor: startRangeSelectionColor,
      
      selectionShape: DateRangePickerSelectionShape.circle,

      headerStyle: DateRangePickerHeaderStyle(
        textAlign: TextAlign.left,
        textStyle: TextStyle(
            color: blackText, fontSize: 20, fontWeight: FontWeight.w400),
        backgroundColor: lightbackgroundColor,
      ),

      // monthCellStyle: DateRangePickerMonthCellStyle(
      //   weekendDatesDecoration: BoxDecoration(
      //       color: lightbackgroundColor, shape: BoxShape.circle),
      //   leadingDatesTextStyle: TextStyle(color: Colors.black38),
      //   trailingDatesTextStyle: TextStyle(color: Colors.black38),
      // ),
/////////CELL BUILDER
      cellBuilder: buildCell,

      /////////////////////////////////////
    );
  }

  Widget buildCell(
      BuildContext context, DateRangePickerCellDetails cellDetails) {
    int res = dateCalculator(cellDetails.date);
    bool today = false;
    if (DateFormat('yyyy-MM-dd').format(cellDetails.date) ==
        DateFormat('yyyy-MM-dd').format(_today)) today = true;

    return Container(

        // width: cellDetails.bounds.width,
        // height: cellDetails.bounds.height,
        // padding: EdgeInsets.all(5),

        // //decoration: BoxDecoration(color: lightbackgroundColor, shape: BoxShape.rectangle),
        // child: Stack(
        //   children: [
        //     Positioned(
        //         bottom: 10,
        //         left: 20,
        //         child: Text(
        //           res.toString(),
        //           style: TextStyle(color: res == 0 ? redText : greenText),
        //         )),

        //     Text(cellDetails.date.day.toString(),
        //       style: TextStyle(
        //         fontWeight: today ? FontWeight.w800 : FontWeight.w400,
        //         fontSize: 20,
        //      ), ),
        //     //Text(DateFormat('d').format(cellDetails.date)),
        //   ],
        // )
        ////////////////
        child: Column(
      children: [
        Container(
          padding: EdgeInsets.fromLTRB(0, 15, 0, 0),
          child: Text(
            cellDetails.date.day.toString(),
            style: TextStyle(
              fontWeight: today ? FontWeight.w800 : FontWeight.w400,
              fontSize: 15,
            ),
          ),
        ),
        Container(
          alignment: Alignment.bottomRight,
          margin: EdgeInsets.only(left: 15),
          // decoration: BoxDecoration(
          //   shape: BoxShape.circle, color: lightbackgroundColor,),
          padding: EdgeInsets.all(3),
          child: Text(res.toString(),
              style: TextStyle(color: res == 0 ? redText : greenText)),
        ),
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
        //поправка выделенного диапазона +1
        if (!item.endDate.isBefore(date) && !item.startDate.isAfter(date)) { differrence --;}
        
        //if(item.startDate.compareTo(date) == 0) differrence --;
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
