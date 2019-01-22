import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: MainScreen(),
    theme: ThemeData(
        brightness: Brightness.dark,
        accentColor: Colors.indigoAccent,
        primaryColor: Colors.indigo),
  ));
}

class MainScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MainScreenState();
  }
}

class _MainScreenState extends State<MainScreen> {
  var _formKey = GlobalKey<FormState>();
  final double _minimumPadding = 5.0;
  String commission = "";
  TextEditingController dealValueController = TextEditingController();
  TextEditingController percentageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = Theme.of(context).textTheme.title;
    return Scaffold(
      appBar: AppBar(
        title: Text('Simple Commision Calculator'),
      ),
      body: Form(
        key: _formKey,
        child: Padding(
            padding: EdgeInsets.all(_minimumPadding * 2),
            child: ListView(
              children: <Widget>[
                getImageAsset(),
                Padding(
                    padding: EdgeInsets.only(
                        top: _minimumPadding, bottom: _minimumPadding),
                    child: TextFormField(
                      controller: dealValueController,
                      style: textStyle,
                      keyboardType: TextInputType.number,
                      validator: (String value) {
                        if (value.isEmpty) {
                          return 'Please enter deal value';
                        }
                        if (double.tryParse(value) == null) {
                          //if the input is not a number
                          return 'Please enter numbers only';
                        }
                      },
                      decoration: InputDecoration(
                          labelText: 'Deal Value',
                          hintText: 'Enter Value e.g. 120000',
                          labelStyle: textStyle,
                          hintStyle: textStyle,
                          errorStyle: TextStyle(color: Colors.red),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0))),
                    )),
                Padding(
                    padding: EdgeInsets.only(
                        top: _minimumPadding, bottom: _minimumPadding),
                    child: TextFormField(
                      controller: percentageController,
                      style: textStyle,
                      keyboardType: TextInputType.number,
                      validator: (String value) {
                        if (value.isEmpty || double.tryParse(value) == null) {
                          return 'Please enter valid commission percentage';
                        }
                        if (double.parse(value) > 100) {
                          return 'Commission percentage cant be more than 100';
                        }
                      },
                      decoration: InputDecoration(
                          labelText: 'Rate of Commission',
                          hintText: 'In percent',
                          labelStyle: textStyle,
                          hintStyle: textStyle,
                          errorStyle: TextStyle(color: Colors.red),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0))),
                    )),
                Padding(
                    padding: EdgeInsets.only(
                        bottom: _minimumPadding, top: _minimumPadding),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: RaisedButton(
                            elevation: 9.0,
                            shape: StadiumBorder(),
                            color: Theme.of(context).accentColor,
                            child: Text('Calculate', textScaleFactor: 1.5),
                            onPressed: () {
                              setState(() {
                                if (_formKey.currentState.validate()) {
                                  commission = _commissionCalculator();
                                }
                              });
                            },
                          ),
                        ),
                        Expanded(
                          child: RaisedButton(
                            splashColor: Colors.red,
                            shape: StadiumBorder(
                              side: BorderSide(color: Colors.red, width: 2.0),
                            ),
                            color: Theme.of(context).primaryColorLight,
                            child: Text(
                              'Reset',
                              textScaleFactor: 1.5,
                            ),
                            onPressed: () {
                              setState(() {
                                _reset();
                              });
                            },
                          ),
                        ),
                      ],
                    )),
                Padding(
                  padding: EdgeInsets.all(_minimumPadding * 2),
                  child: Text(
                    'Your Comission = $commission ',
                    style: Theme.of(context).textTheme.display1,
                  ),
                )
              ],
            )),
      ),
    );
  }

  Widget getImageAsset() {
    AssetImage assetImage = AssetImage('images/money.png');
    Image image = Image(
      image: assetImage,
      width: 125.0,
      height: 125.0,
    );

    return Container(
      child: image,
      margin: EdgeInsets.all(_minimumPadding * 10),
    );
  }

  String _commissionCalculator() {
    double _dealValueInput = double.parse(dealValueController.text);
    double _percentageInput = double.parse(percentageController.text);
    String commission = '${_dealValueInput * (_percentageInput / 100)}';
    return commission;
  }

  void _reset() {
    commission = '';
    dealValueController.clear();
    percentageController.clear();
  }
}
