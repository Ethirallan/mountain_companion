import 'package:flutter/material.dart';

class NewExpanded extends StatefulWidget {
  NewExpanded({this.finalLocationCtrl, this.finalTimeCtrl, this.finalHeightCtrl, this.location1Ctrl, this.location2Ctrl,
  this.location3Ctrl, this.location4Ctrl, this.location5Ctrl, this.location6Ctrl, this.time1Ctrl, this.time2Ctrl,
  this.time3Ctrl, this.time4Ctrl, this.time5Ctrl, this.time6Ctrl, this.height1Ctrl, this.height2Ctrl, this.height3Ctrl,
  this.height4Ctrl, this.height5Ctrl, this.height6Ctrl});
  final TextEditingController finalLocationCtrl, finalTimeCtrl, finalHeightCtrl;
  final TextEditingController location1Ctrl, location2Ctrl, location3Ctrl, location4Ctrl, location5Ctrl, location6Ctrl;
  final TextEditingController time1Ctrl, time2Ctrl, time3Ctrl, time4Ctrl, time5Ctrl, time6Ctrl;
  final TextEditingController height1Ctrl, height2Ctrl, height3Ctrl, height4Ctrl, height5Ctrl, height6Ctrl;
  @override
  State<StatefulWidget> createState() {
    return NewExpandedState();
  }
}

class NewExpandedState extends State<NewExpanded> {
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
                  addNewInput(widget.location2Ctrl, widget.time2Ctrl, widget.height2Ctrl);
                } else if (size == 1) {
                  addNewInput(widget.location3Ctrl, widget.time3Ctrl, widget.height3Ctrl);
                } else if (size == 2) {
                  addNewInput(widget.location4Ctrl, widget.time4Ctrl, widget.height4Ctrl);
                } else if (size == 3) {
                  addNewInput(widget.location5Ctrl, widget.time5Ctrl, widget.height5Ctrl);
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
                myInputField('Vnesite čas', widget.time1Ctrl, TextInputType.datetime),
                myInputTitle('Lokacija starta:'),
                myInputField('Vnesite lokacijo', widget.location1Ctrl, TextInputType.text),
                myInputTitle('Višina starta:'),
                myInputField('Vnesite nadmorsko višino', widget.height1Ctrl, TextInputType.number),
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
            myInputField('Vnesite čas', widget.time6Ctrl, TextInputType.datetime),
            myInputTitle('Lokacija konca:'),
            myInputField('Vnesite lokacijo', widget.location6Ctrl, TextInputType.text),
            myInputTitle('Višina konca:'),
            myInputField('Vnesite nadmorsko višino', widget.height6Ctrl, TextInputType.number),
          ],
        ),
      ),
    );
  }
}
