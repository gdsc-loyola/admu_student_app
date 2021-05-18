import 'package:flutter/material.dart';

class ButtonRow extends StatefulWidget {
  final String text1;
  final String text2;
  final String text3;
  final VoidCallback return1;
  final VoidCallback return2;
  final VoidCallback return3;
  // change to one function
  // final Function(int) onSelect;
  // sample: onSelect: (val) { setState--- sel = val; }
  final int selected;
  final bool blocked;

  ButtonRow(this.text1, this.text2, this.text3, this.return1, this.return2,
      this.return3, this.selected, this.blocked);

  @override
  _ButtonRowState createState() => _ButtonRowState();
}

class _ButtonRowState extends State<ButtonRow> {
  bool isSelected1 = true;
  bool isSelected2 = false;
  bool isSelected3 = false;
  int selected;

  @override
  void initState() {
    super.initState();
    selected = widget.selected;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 36.54,
      padding: EdgeInsets.fromLTRB(1.19, 1, 1.19, 2.54),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.all(
          Radius.circular(20),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          // Item 1
          Expanded(
            flex: 1,
            child: Container(
              height: 33,
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                      color: selected == 0
                          ? Colors.grey.withOpacity(0.5)
                          : Colors.transparent,
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: Offset(0, 3)),
                ],
                color: selected == 0 ? Colors.white : Colors.transparent,
                borderRadius: BorderRadius.all(Radius.circular(20)),
              ),
              child: TextButton(
                onPressed: () {
                  setState(() {
                    if (widget.blocked) return;
                    selected = 0;
                    widget.return1();
                  });
                },
                child: Text(
                  "${widget.text1}",
                  style: TextStyle(
                      color: selected == 0 ? Colors.black : Colors.grey[600]),
                ),
              ),
            ),
          ),
          // Item 2
          Expanded(
            flex: 1,
            child: Container(
              height: 33,
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                      color: selected == 1
                          ? Colors.grey.withOpacity(0.5)
                          : Colors.transparent,
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: Offset(0, 3)),
                ],
                color: selected == 1 ? Colors.white : Colors.transparent,
                borderRadius: BorderRadius.all(Radius.circular(20)),
              ),
              child: TextButton(
                onPressed: () {
                  setState(() {
                    if (widget.blocked) return;
                    selected = 1;
                    widget.return2();
                  });
                },
                child: Text(
                  "${widget.text2}",
                  style: TextStyle(
                      color: selected == 1 ? Colors.black : Colors.grey[600]),
                ),
              ),
            ),
          ),
          // Item 3
          Expanded(
            flex: 1,
            child: Container(
              height: 33,
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                      color: selected == 2
                          ? Colors.grey.withOpacity(0.5)
                          : Colors.transparent,
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: Offset(0, 3)),
                ],
                color: selected == 2 ? Colors.white : Colors.transparent,
                borderRadius: BorderRadius.all(Radius.circular(20)),
              ),
              child: TextButton(
                onPressed: () {
                  setState(() {
                    if (widget.blocked) return;
                    selected = 2;
                    widget.return3();
                  });
                },
                child: Text(
                  "${widget.text3}",
                  style: TextStyle(
                      color: selected == 2 ? Colors.black : Colors.grey[600]),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
