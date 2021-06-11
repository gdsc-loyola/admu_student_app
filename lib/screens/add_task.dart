import 'package:admu_student_app/constants/app_utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:admu_student_app/constants/app_colors.dart';
import 'package:admu_student_app/models/calendar_events.dart';
import 'package:admu_student_app/models/event.dart';
import 'package:admu_student_app/widgets/groups/input_group.dart';
import 'package:admu_student_app/widgets/groups/select_date.dart';
import 'package:admu_student_app/widgets/groups/select_time.dart';
import 'package:admu_student_app/widgets/modals/alert.dart';
import 'package:admu_student_app/widgets/modals/custom_snack_bar.dart';
import 'package:admu_student_app/widgets/buttons.dart';

class AddTaskPage extends StatefulWidget {
  final Event event;

  final DateTime date;
  final bool isEditing;

  AddTaskPage({this.event, this.date, this.isEditing = false});

  @override
  _AddTaskPageState createState() => _AddTaskPageState();
}

class _AddTaskPageState extends State<AddTaskPage> {
  bool _shouldPop = false;

  TextEditingController _eventCtrl = TextEditingController();
  TextEditingController _tagCtrl = TextEditingController();
  TextEditingController _agendaCtrl = TextEditingController();

  DateTime _startDate;
  TimeOfDay _startTime;
  DateTime _endDate;
  TimeOfDay _endTime;

  @override
  void initState() {
    super.initState();

    if (widget.event != null) {
      _eventCtrl.text = widget.event.name;
      _tagCtrl.text = widget.event.tags;
      _agendaCtrl.text = widget.event.agenda;

      if (widget.event.start != null) {
        _startDate = widget.event.start;
        _startTime = TimeOfDay(
            hour: widget.event.start.hour, minute: widget.event.start.minute);
      }

      if (widget.event.end != null) {
        _endDate = widget.event.end;
        _endTime = TimeOfDay(
            hour: widget.event.end.hour, minute: widget.event.end.minute);
      }
    } else if (widget.date != null) {
      if (widget.date.minute % 5 == 0) {
        _startDate = widget.date;
        _startTime =
            TimeOfDay(hour: widget.date.hour, minute: widget.date.minute);

        DateTime useEnd = widget.date.add(Duration(hours: 1));
        _endDate = useEnd;
        _endTime = TimeOfDay(hour: useEnd.hour, minute: useEnd.minute);
      } else {
        DateTime useStart =
            widget.date.add(Duration(minutes: 5 - (widget.date.minute % 5)));

        _startDate = useStart;
        _startTime = TimeOfDay(hour: useStart.hour, minute: useStart.minute);

        DateTime useEnd = useStart.add(Duration(hours: 1));
        _endDate = useEnd;
        _endTime = TimeOfDay(hour: useEnd.hour, minute: useEnd.minute);
      }
    }
  }

  @override
  void dispose() {
    _eventCtrl.dispose();
    _tagCtrl.dispose();
    _agendaCtrl.dispose();

    super.dispose();
  }

  Future<bool> _onBack() async {
    if (_shouldPop) return true;

    bool willPop = false;

    await AlertModal.showAlert(
      context,
      header: 'Discard changes?',
      acceptText: 'Discard',
      onAccept: () {
        Navigator.of(context).pop();
        willPop = true;
      },
    );

    return willPop;
  }

  void _onSave() async {
    DateTime fStart = _checkDateTime(_startDate, _startTime);
    DateTime fEnd = _checkDateTime(_endDate, _endTime, true);

    if (_eventCtrl.text.isEmpty)
      return await AlertModal.showIncompleteError(context);

    if (fStart != null && fEnd != null) {
      if ((fStart.year == 0 && fEnd.year != 0) ||
          (fStart.year != 0 && fEnd.year == 0))
        return await AlertModal.showError(
            context, 'your start and end times are both correct.');

      if (fStart.isAfter(fEnd))
        return await AlertModal.showInverseTimeError(context);
    }

    if (widget.isEditing) {
      Provider.of<CalendarEvents>(context, listen: false).editEvent(
        widget.event,
        _eventCtrl.text,
        _agendaCtrl.text,
        _tagCtrl.text,
        fStart,
        fEnd,
        widget.event.isDone,
      );

      CustomSnackBar.showSnackBar(context, 'Event edited!');
    } else {
      Provider.of<CalendarEvents>(context, listen: false).addEvent(
        _eventCtrl.text,
        _agendaCtrl.text,
        _tagCtrl.text,
        fStart,
        fEnd,
        false,
      );

      CustomSnackBar.showSnackBar(context, 'Event added!');
    }

    _shouldPop = true;
    Navigator.of(context).pop();
  }

  void _onDelete() async {
    bool toDelete = false;

    await AlertModal.showAlert(context, header: 'Delete event?', onAccept: () {
      toDelete = true;
    });

    if (!toDelete) return;

    Provider.of<CalendarEvents>(context, listen: false)
        .deleteEvent(widget.event);

    CustomSnackBar.showSnackBar(context, 'Event deleted!');

    _shouldPop = true;
    Navigator.of(context).pop();
  }

  DateTime _checkDateTime(DateTime dt, TimeOfDay td,
      [bool isEnd = false]) {
    if (dt != null && td != null)
      return DateTime(dt.year, dt.month, dt.day, td.hour, td.minute);
    else if (dt == null && td != null)
      return DateTime(0, 1, 1, td.hour, td.minute);
    else if (dt != null && td == null) {
      if (!isEnd) return DateTime(dt.year, dt.month, dt.day);
      else return DateTime(dt.year, dt.month, dt.day, 23, 59);
    } else
      return null;
  }

  void _onStartDateChange(DateTime dt) {
    setState(() {
      _startDate = dt;
    });
  }

  void _onStartTimeChange(TimeOfDay td) {
    setState(() {
      _startTime = td;
    });
  }

  void _onEndDateChange(DateTime dt) {
    setState(() {
      _endDate = dt;
    });
  }

  void _onEndTimeChange(TimeOfDay td) {
    setState(() {
      _endTime = td;
    });
  }

  @override
  Widget build(BuildContext context) {
    Scaffold scaffold = Scaffold(
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: Icon(Icons.close_rounded),
          onPressed: _onBack,
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 16),
            child: TextButton(
              onPressed: _onSave,
              child: Text(
                'Done',
                style: Theme.of(context).textTheme.headline6.copyWith(
                      fontWeight: FontWeight.w500,
                      color: AppColors.GRAY_LIGHT[2],
                    ),
              ),
            ),
          ),
        ],
      ),
      backgroundColor: AppColors.PRIMARY_MAIN,
      body: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(16, 32, 16, 32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            // header
            Text(
              '${widget.isEditing ? 'Edit' : 'Add'} Event',
              style: Theme.of(context)
                  .textTheme
                  .headline4
                  .copyWith(color: AppColors.GRAY_LIGHT[2]),
            ),
            SizedBox(height: 40),

            // name
            Row(
              children: [
                Expanded(child: InputGroup('Event*', _eventCtrl)),
              ],
            ),
            SizedBox(height: 16),

            // start
            Row(
              children: [
                // date
                Expanded(
                  child: SelectDateGroup(
                    'Start',
                    date: _startDate,
                    onDateChange: _onStartDateChange,
                  ),
                ),
                SizedBox(width: 8),

                // time
                Expanded(
                  child: SelectTimeGroup(
                    '',
                    time: _startTime,
                    onTimeChange: _onStartTimeChange,
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),

            // end
            Row(
              children: [
                // date
                Expanded(
                  child: SelectDateGroup(
                    'End',
                    date: _endDate,
                    onDateChange: _onEndDateChange,
                  ),
                ),
                SizedBox(width: 8),

                // time
                Expanded(
                  child: SelectTimeGroup(
                    'End',
                    time: _endTime,
                    onTimeChange: _onEndTimeChange,
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),

            // tags
            Row(
              children: [
                Expanded(child: InputGroup('Tags', _tagCtrl)),
              ],
            ),
            SizedBox(height: 16),

            // agenda
            Row(
              children: [
                Expanded(child: InputGroup('Agenda', _agendaCtrl)),
              ],
            ),
            SizedBox(height: 48),

            if (widget.isEditing)
              CustomButton(
                ButtonSize.medium,
                'Delete Event',
                AppColors.SECONDARY_MAIN,
                AppColors.GRAY_LIGHT[2],
                _onDelete,
              ),
          ],
        ),
      ),
    );

    return WillPopScope(
      onWillPop: _onBack,
      child: scaffold,
    );
  }
}
