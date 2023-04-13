import 'package:flutter/material.dart';
import 'package:timezone/timezone.dart';

class DatePickerButton extends StatefulWidget {
  final ValueSetter<TZDateTime> callback;

  const DatePickerButton({Key? key, required this.callback}) : super(key: key);

  @override
  State<DatePickerButton> createState() => _DatePickerButtonState();
}

class _DatePickerButtonState extends State<DatePickerButton> {
  final todayDate = TZDateTime.now(local);
  ValueNotifier<TZDateTime?> pickedDate = ValueNotifier<TZDateTime?>(null);

  @override
  void initState() {
    super.initState();

    pickedDate.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    final buttonDate = pickedDate.value ?? todayDate;
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 10.0, 0, 10.0),
      child: GestureDetector(
        onTap: () async => pickedDate.value = await selectDate(context),
        child: Container(
          alignment: Alignment.center,
          width: 200.0,
          padding: const EdgeInsets.all(5.0),
          decoration: ShapeDecoration(
              color: Theme.of(context).colorScheme.primary,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(3.0)),
              shadows: const [
                BoxShadow(
                  color: Colors.grey,
                  offset: Offset(0, 1.0),
                  blurRadius: 2.0,
                )
              ]),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              const Icon(
                Icons.date_range,
                size: 14.0,
              ),
              Expanded(
                child: Container(
                  height: 20.0,
                  alignment: Alignment.center,
                  child: Text(
                    formatDate(buttonDate),
                    style: const TextStyle(
                        fontWeight: FontWeight.normal, fontSize: 14.0),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<TZDateTime?> selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: todayDate,
        firstDate: TZDateTime(local, 2022),
        lastDate: TZDateTime(local, 2100));
    if (picked == null) {
      return todayDate;
    }
    final pickedFormatted = TZDateTime.from(picked, local);
    widget.callback(pickedFormatted);
    return pickedFormatted;
  }

  String formatDate(TZDateTime date) {
    late String weekday;
    final weekdayNames = [
      "Monday",
      "Tuesday",
      "Wednesday",
      "Thursday",
      "Friday",
      "Saturday",
      "Sunday",
    ];

    for (var day in weekdayNames) {
      weekday = weekdayNames[date.weekday - 1];
    }

    final formattedDate = "${date.year}-${date.month}-${date.day}, $weekday";
    return formattedDate;
  }
}
