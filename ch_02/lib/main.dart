import 'package:flutter/material.dart';
import 'util/conver_util.dart';

void main() {
  runApp(MaterialApp(
    title: 'Measures Converter',
    home: MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  @override
  MyAppState createState() => MyAppState();
}

class MyAppState extends State<MyApp> {
  double _numberFrom = 0;
  String _startMeasure ;
  String _convertedMeasure ;
  double _result = 0;
  String _resultMessage = '';
  @override
  Widget build(BuildContext context) {
    double sizeX = MediaQuery.of(context).size.width;
    double sizeY = MediaQuery.of(context).size.height;
    final TextStyle inputStyle = TextStyle(
      fontSize: 20,
      color: Colors.blue[900],
    );
    final TextStyle labelStyle = TextStyle(
      fontSize: 24,
      color: Colors.grey[700],
    );

    final spacer = Padding(padding: EdgeInsets.only(bottom: sizeY/40));
    final List<String> _measures = [
      'meters',
      'kilometers',
      'grams',
      'kilograms',
      'feet',
      'miles',
      'pounds (lbs)',
      'ounces',
    ];
    return Scaffold(
      appBar: AppBar(
        title: Text('Measures Converter'),
      ),
      body: Container(
        width: sizeX, 
        padding: EdgeInsets.all(sizeX/20),
        child: SingleChildScrollView(child: Column(
          children: [
            Text('Value', style: labelStyle,),
            spacer,
            TextField(
              style: inputStyle,
              decoration: InputDecoration( 
                    hintText: "Please insert the measure to be converted", 
                  ), 
              onChanged: (text) {
                setState(() {
                  _numberFrom = double.parse(text);
                });
              },
            ),
            spacer,
            Text('From', style: labelStyle,),
            spacer,
            DropdownButton(
              isExpanded: true,
              style: inputStyle,
              value: _startMeasure,
              items: _measures.map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value, style: inputStyle,),
                );
              }).toList(),
              onChanged: (value) {
                onStartMeasureChanged(value);
              },
            ),
            spacer,
            Text('To', style: labelStyle,),
            spacer,
            DropdownButton(
              isExpanded: true,
              style: inputStyle,
              value: _convertedMeasure,
              items: _measures.map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value, style: inputStyle,),
                );
              }).toList(),
              onChanged: (value) {
                onConvertedMeasureChanged(value);
              },
            ),
            spacer,
            RaisedButton(child:Text('Convert', style: inputStyle),
              onPressed: ()=>convert(),),
            spacer,
            Text(_resultMessage, style: labelStyle,)
          ],
        )),
      ),
    );
  }

  void onStartMeasureChanged(String value) {
    setState(() {
      _startMeasure = value;
    });
  }
  void onConvertedMeasureChanged(String value) {
    setState(() {
      _convertedMeasure = value;
    });
  }

  void convert() {
    if (_startMeasure.isEmpty || _convertedMeasure.isEmpty || _numberFrom==0) {
      return;
    }
    Conversion c = Conversion();
    double result = c.convert(_numberFrom, _startMeasure, _convertedMeasure);
    setState(() {
      _result = result;
      if (result == 0) {
        _resultMessage = 'This conversion cannot be performed';
      }
      else {
        _resultMessage = '${_numberFrom.toString()} $_startMeasure are ${_result.toString()} $_convertedMeasure';   
      }

    });
  }

}
