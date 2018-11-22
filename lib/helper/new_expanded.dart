import 'package:flutter/material.dart';

class NewExpanded extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return NewExpandedState();
  }
}

class NewExpandedState extends State<NewExpanded> {
  TextEditingController finalLocationCtrl = new TextEditingController();
  TextEditingController finalTimeCtrl = new TextEditingController();
  TextEditingController finalHeightCtrl = new TextEditingController();
  TextEditingController location1Ctrl = new TextEditingController();
  TextEditingController location2Ctrl = new TextEditingController();
  TextEditingController location3Ctrl = new TextEditingController();
  TextEditingController location4Ctrl = new TextEditingController();
  TextEditingController location5Ctrl = new TextEditingController();
  TextEditingController location6Ctrl = new TextEditingController();
  TextEditingController time1Ctrl = new TextEditingController();
  TextEditingController time2Ctrl = new TextEditingController();
  TextEditingController time3Ctrl = new TextEditingController();
  TextEditingController time4Ctrl = new TextEditingController();
  TextEditingController time5Ctrl = new TextEditingController();
  TextEditingController time6Ctrl = new TextEditingController();
  TextEditingController height1Ctrl = new TextEditingController();
  TextEditingController height2Ctrl = new TextEditingController();
  TextEditingController height3Ctrl = new TextEditingController();
  TextEditingController height4Ctrl = new TextEditingController();
  TextEditingController height5Ctrl = new TextEditingController();
  TextEditingController height6Ctrl = new TextEditingController();
  List<Widget> widgetList = [];

  @override
  Widget build(BuildContext context) {
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
                startCard(),
                ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: widgetList.length,
                  itemBuilder: (context, index) {
                    return widgetList[index];
                  },
                ),
                endCard(),
                widgetList.length != 4 ? myAddBtn() : Container(),
                widgetList.length > 0 ? myRemoveBtn() : Container(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void addNewInput(TextEditingController locationCtrl, TextEditingController timeCtrl, TextEditingController heightCtrl) {
    if (widgetList.length < 4) {
      int no = widgetList.length + 1;
      setState(() {
        widgetList.add(Container(
          padding: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 0.0),
          child: Card(
            elevation: 4.0,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Container(
                  padding: EdgeInsets.all(10.0),
                  child: Text('Vmesni cilj $no:', style: TextStyle(fontSize: 20.0, color: Colors.blue, fontWeight: FontWeight.bold), textAlign: TextAlign.left,),
                ),
                myInputTitle('Ura:'),
                myInputField('Vnesite uro', timeCtrl, TextInputType.datetime),
                myInputTitle('Lokacija:'),
                myInputField('Vnesite lokacijo', locationCtrl, TextInputType.text),
                myInputTitle('Višina:'),
                myInputField('Vnesite nadmorsko višino', heightCtrl, TextInputType.number),
              ],
            ),
          ),
        ));
      });
    } else {
      Scaffold.of(context).showSnackBar(SnackBar(content: Text('Maksimalmo število ciljev že doseženo')));
    }
  }

  Widget myAddBtn() {
    return Center(
      child: myButton(1, 'Dodaj vmesni cilj', Colors.blue),
    );
  }

  Widget myRemoveBtn() {
    return Center(
      //child: IconButton(icon: Icon(Icons.remove), onPressed: removeInput,)
      child: myButton(0, 'Odstrani vmesni cilj', Colors.red),
    );
  }

  Widget myButton(int fun, String text, Color color) {
    return Container(
      padding: fun == 1
          ? EdgeInsets.fromLTRB(16.0, 10.0, 16.0, 10.0)
          : EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 10.0),
      child: SizedBox(
        width: double.infinity,
        height: 40.0,
        child: RaisedButton(
          elevation: 4.0,
          color: color,
          onPressed: () {
              if (fun == 1) {
                int size = widgetList.length;
                if (size == 0) {
                  addNewInput(location2Ctrl, time2Ctrl, height2Ctrl);
                } else if (size == 1) {
                  addNewInput(location3Ctrl, time3Ctrl, height3Ctrl);
                } else if (size == 2) {
                  addNewInput(location4Ctrl, time4Ctrl, height4Ctrl);
                } else if (size == 3) {
                  addNewInput(location5Ctrl, time5Ctrl, height5Ctrl);
                } else {
                  setState(() {

                  });
                }
              } else {
                removeInput();
              }
          },
          child: Text(
            text,
            style: TextStyle(color: Colors.white, fontSize: 20.0),
          ),
        ),
      ),
    );
  }

  void removeInput() {
    if (widgetList.length > 0) {
      setState(() {
        widgetList.removeLast();
      });
    } else {
      Scaffold.of(context).showSnackBar(SnackBar(content: Text('Vsi vmesni postanki so že izbrisani')));
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

  Widget startCard() {
    return Container(
      padding: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 0.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(10.0),
            child: Text('Podatki:', style: TextStyle(fontSize: 20.0, color: Colors.blue, fontWeight: FontWeight.bold), textAlign: TextAlign.left,),
          ),
          Card(
            elevation: 4.0,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Container(
                  padding: EdgeInsets.all(10.0),
                  child: Text('Začetek izleta:', style: TextStyle(fontSize: 20.0, color: Colors.blue, fontWeight: FontWeight.bold), textAlign: TextAlign.left,),
                ),
                myInputTitle('Ura starta:'),
                myInputField('Vnesite čas', time1Ctrl, TextInputType.datetime),
                myInputTitle('Lokacija starta:'),
                myInputField('Vnesite lokacijo', location1Ctrl, TextInputType.text),
                myInputTitle('Višina starta:'),
                myInputField('Vnesite nadmorsko višino', height1Ctrl, TextInputType.number),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget endCard() {
    return Container(
      padding: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 0.0),
      child: Card(
        elevation: 4.0,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(10.0),
              child: Text('Konec izleta:', style: TextStyle(fontSize: 20.0, color: Colors.blue, fontWeight: FontWeight.bold), textAlign: TextAlign.left,),
            ),
            myInputTitle('Ura konca:'),
            myInputField('Vnesite čas', time6Ctrl, TextInputType.datetime),
            myInputTitle('Lokacija konca:'),
            myInputField('Vnesite lokacijo', location6Ctrl, TextInputType.text),
            myInputTitle('Višina konca:'),
            myInputField('Vnesite nadmorsko višino', height6Ctrl, TextInputType.number),
          ],
        ),
      ),
    );
  }
}
