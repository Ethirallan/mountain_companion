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
    }
    return Card(
      elevation: 4.0,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Container(
            child: ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: widgetList.length,
              itemBuilder: (context, index) {
                return widgetList[index];
              },
            ),
          ),
          //items.length <= 6 ? myAddBtn : Container()
        ],
      ),
    );
  }

  void addNewInput() {
    /*
    setState(() {
      items.add();
    })
    */
  }

  Widget myAddBtn() {
    return Center(
      child: IconButton(icon: Icon(Icons.add), onPressed: addNewInput),
    );
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
