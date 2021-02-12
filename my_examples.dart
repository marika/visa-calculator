///Вывод массива виджетов
 // map() + toList() + Spread Property
  Widget method2() {
    return Column(
      children: <Widget>[
        Text('You can put other Widgets here'),
        ...items.map((item) => Text(item)).toList(),
      ],
    );
  }

  // map() + toList()
  Widget method3() {
    return Column(
      // Text('You CANNOT put other Widgets here'),
      children: items.map((item) => Text(item)).toList(),
    );
  }


/// Format date
import 'package:intl/intl.dart';

DateTime now = DateTime.now();
String formattedDate = DateFormat('yyyy-MM-dd – kk:mm').format(now);
// //////
// margin: item == null
//           ? const EdgeInsets.fromLTRB(30, 60, 30, 0)
//           : const EdgeInsets.all(30),
          
          ////
          ///
///// floatingActionButton: FloatingActionButton(
      //   onPressed: () => {},
      //   tooltip: 'Increment',
      //   child: Icon(Icons.add),
      // ),

borderRadius: BorderRadius.only(
  topRight: Radius.circular(10.0),
  bottomRight: Radius.circular(10.0))),

 
 // Choose theme 
 final bool isDark = theme != null &&
        theme.brightness != null &&
        theme.brightness == Brightness.dark;

    final Color monthCellBackground =
        isDark ? const Color(0xFF232731) : const Color(0xfff7f4ff);
