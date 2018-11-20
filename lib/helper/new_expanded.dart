import 'package:flutter/material.dart';

class NewExpanded extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return NewExpandedState();
  }
}

class NewExpandedState extends State<NewExpanded> {
  static TextEditingController timeCtrl = new TextEditingController();
  static TextEditingController locationCtrl = new TextEditingController();
  static TextEditingController heightCtrl = new TextEditingController();

  var widgetList = [];

  @override
  Widget build(BuildContext context) {
    if(widgetList.length == 0) {
      widgetList.add(myInputTitle('Čas:'));
      widgetList.add(myInputField('Vnesite čas', timeCtrl, TextInputType.datetime));
      widgetList.add(myInputTitle('Lokacija:'));
      widgetList.add(myInputField('Vnesite lokacijo', locationCtrl, TextInputType.text));
      widgetList.add(myInputTitle('Višina:'));
      widgetList.add(myInputField('Vnesite nadmorsko višino', heightCtrl, TextInputType.number));
      widgetList.add(Container(child: Divider(height: 2.0, color: Colors.blueGrey), padding: EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0),));
    }
    return Card(
      elevation: 4.0,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: widgetList.length,
                  itemBuilder: (context, index) {
                    return widgetList[index];
                  },
                ),
                myAddBtn(),
              ],
            ),
          ),
          //items.length <= 6 ? myAddBtn : Container()
        ],
      ),
    );
  }

  void addNewInput() {
    if (widgetList.length < 29) {
      double no = widgetList.length / 7;
      setState(() {
        widgetList.add(myInputTitle('Čas $no:'));
        widgetList.add(myInputField('Vnesite čas', timeCtrl, TextInputType.datetime));
        widgetList.add(myInputTitle('Lokacija $no:'));
        widgetList.add(myInputField('Vnesite lokacijo', locationCtrl, TextInputType.text));
        widgetList.add(myInputTitle('Višina $no:'));
        widgetList.add(myInputField('Vnesite nadmorsko višino', heightCtrl, TextInputType.number));
        if (widgetList.length < 25) {
          widgetList.add(Container(child: Divider(height: 2.0, color: Colors.blueGrey), padding: EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0),));
        } else {
          widgetList.add(myRemoveBtn());
        }
      });
    } else {
      Scaffold.of(context).showSnackBar(SnackBar(content: Text('Maksimalmo število ciljev že doseženo')));
    }
  }

  Widget myAddBtn() {
    return Center(
      child: IconButton(icon: Icon(Icons.add), onPressed: addNewInput),
    );
  }

  Widget myRemoveBtn() {
    return Center(
      child: IconButton(icon: Icon(Icons.add), onPressed: removeInput),
    );
  }

  void removeInput() {
    if (widgetList.length == 28) {
      setState(() {
        widgetList.removeRange(21, 28);
      });
    } else if (widgetList.length > 7) {
      setState(() {
        widgetList.removeRange(widgetList.length - 7, widgetList.length);
      });
    } else {
      Scaffold.of(context).showSnackBar(SnackBar(content: Text('Maksimalmo število ciljev že doseženo')));
    }
  }

  Widget myInputTitle(String title) {
    return Container(
      padding: EdgeInsets.fromLTRB(20.0, 14.0, 20.0, 0.0),
      child: Text(
        title,
        style: TextStyle(
            fontSize: 20.0, color: Colors.blue, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget myInputField(String hint, TextEditingController controller, TextInputType input) {
    return Container(
      padding: EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 14.0),
      child: TextField(
        textCapitalization: TextCapitalization.sentences,
        keyboardType: input,
        controller: controller,
        maxLines: null,
        decoration: InputDecoration(
            hintText: hint,
            hintStyle: TextStyle(fontSize: 22.0, color: Colors.grey)),
        style: TextStyle(
          fontSize: 22.0,
          color: Colors.blueGrey,
          fontWeight: FontWeight.normal,
        ),
      ),
    );
  }
}
