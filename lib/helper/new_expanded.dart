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
    if (widgetList.length == 0) {
      widgetList.add(myInputTitle('Čas izleta:'));
      widgetList.add(myInputField('Vnesite čas', timeCtrl, TextInputType.datetime));
      widgetList.add(myInputTitle('Lokacija izleta:'));
      widgetList.add(myInputField('Vnesite lokacijo', locationCtrl, TextInputType.text));
      widgetList.add(myInputTitle('Višinska razlika:'));
      widgetList.add(myInputField('Vnesite nadmorsko višino', heightCtrl, TextInputType.number));
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
                widgetList.length != 11 ? myAddBtn() : Container(),
                widgetList.length > 6 ? myRemoveBtn() : Container(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void addNewInput() {
    if (widgetList.length < 11) {
      int no = widgetList.length - 5;
      setState(() {
        widgetList.add(Container(
          padding: EdgeInsets.fromLTRB(10.0, 4.0, 10.0, 0.0),
          child: Card(
            elevation: 4.0,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                myInputTitle('Ura $no:'),
                myInputField('Vnesite uro', timeCtrl, TextInputType.datetime),
                myInputTitle('Lokacija $no:'),
                myInputField(
                    'Vnesite lokacijo', locationCtrl, TextInputType.text),
                myInputTitle('Višina $no:'),
                myInputField('Vnesite nadmorsko višino', heightCtrl,
                    TextInputType.number),
              ],
            ),
          ),
        ));
      });
    } else {
      Scaffold.of(context).showSnackBar(
          SnackBar(content: Text('Maksimalmo število ciljev že doseženo')));
    }
  }

  Widget myAddBtn() {
    return Center(
      child: myButton(1, 'Dodaj nov cilj', Colors.blue),
    );
  }

  Widget myRemoveBtn() {
    return Center(
      //child: IconButton(icon: Icon(Icons.remove), onPressed: removeInput,)
      child: myButton(0, 'Odstrani zadnjega', Colors.red),
    );
  }

  Widget myButton(int fun, String text, Color color) {
    return Container(
      padding: fun == 1 ? EdgeInsets.fromLTRB(16.0, 10.0, 16.0, 10.0) : EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 10.0) ,
      child: SizedBox(
        width: double.infinity,
        height: 40.0,
        child: RaisedButton(
          elevation: 4.0,
          color: color,
          onPressed: fun == 1 ? addNewInput : removeInput,
          child: Text(
            text,
            style: TextStyle(color: Colors.white, fontSize: 20.0),
          ),
        ),
      ),
    );
  }

  void removeInput() {
    setState(() {
      widgetList.removeLast();
    });
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
      padding: EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 10.0),
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
