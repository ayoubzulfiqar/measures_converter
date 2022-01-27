import 'package:flutter/material.dart';

class MeasuringConversion extends StatefulWidget {
  const MeasuringConversion({Key? key}) : super(key: key);

  @override
  _MeasuringConversionState createState() => _MeasuringConversionState();
}

class _MeasuringConversionState extends State<MeasuringConversion> {
  final TextStyle inputStyle = const TextStyle(
    fontSize: 18,
    color: Colors.black87,
  );

  final TextStyle labelStyle = const TextStyle(
    fontSize: 20,
    color: Colors.black,
  );
  String? _startMeasure;
  String? _convertedMeasure;
  double? _numberForm;
  String _resultMessage = '';

  @override
  void initState() {
    _numberForm = 0;
    super.initState();
  }

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
  final Map<String, int> _measuresMap = {
    'meters': 0,
    'kilometers': 1,
    'grams': 2,
    'kilograms': 3,
    'feet': 4,
    'miles': 5,
    'pounds (lbs)': 6,
    'ounces': 7,
  };

  final dynamic _formulas = {
    '0': [1, 0.001, 0, 0, 3.28084, 0.000621371, 0, 0],
    '1': [1000, 1, 0, 0, 3280.84, 0.621371, 0, 0],
    '2': [0, 0, 1, 0.0001, 0, 0, 0.00220462, 0.035274],
    '3': [0, 0, 1000, 1, 0, 0, 2.20462, 35.274],
    '4': [0.3048, 0.0003048, 0, 0, 1, 0.000189394, 0, 0],
    '5': [1609.34, 1.60934, 0, 0, 5280, 1, 0, 0],
    '6': [0, 0, 453.592, 0.453592, 0, 0, 1, 16],
    '7': [0, 0, 28.3495, 0.0283495, 3.28084, 0, 0.0625, 1],
  };

  void convert(double value, String from, String to) {
    int? nFrom = _measuresMap[from];
    int? nTo = _measuresMap[to];
    var multiplier = _formulas[nFrom.toString()][nTo];
    var result = value * multiplier;
    if (result == 0) {
      _resultMessage = 'This conversion cannot be performed';
    } else {
      _resultMessage =
          '${_numberForm.toString()} $_startMeasure are ${result.toString()} $_convertedMeasure';
    }
    setState(() {
      _resultMessage = _resultMessage;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        centerTitle: true,
        elevation: 0.0,
        title: const Text(
          'Measures Converter',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 23),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
          child: Column(
            children: [
              const Text(
                'Value',
                style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.only(
                    left: 0, top: 3, bottom: 3, right: 10),
                child: TextField(
                  keyboardType: TextInputType.number,
                  style: inputStyle,
                  decoration: InputDecoration(
                    focusedBorder: InputBorder.none,
                    filled: true,
                    fillColor: Colors.grey.withOpacity(0.2),
                    enabledBorder: InputBorder.none,
                    hintText: "Please enter the value",
                  ),
                  onChanged: (text) {
                    var rv = double.tryParse(text);
                    if (rv != null) {
                      setState(() {
                        _numberForm = rv;
                      });
                    }
                  },
                ),
              ),
              const SizedBox(height: 40),
              const Text(
                'From',
                style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue),
              ),
              const SizedBox(height: 20),

              //Text((_numberForm==null)? '' : _numberForm.toString())
              Container(
                decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(5)),
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 20, top: 3, bottom: 3, right: 20),
                  child: DropdownButton(
                    underline: const SizedBox(),
                    isExpanded: true,
                    style: inputStyle,
                    hint: Text(
                      "Select value",
                      style: inputStyle,
                    ),
                    items: _measures.map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (String? value) {
                      setState(() {
                        _startMeasure = value!;
                      });
                    },
                    value: _startMeasure,
                  ),
                ),
              ),

              // Icon(
              //   Icons.arrow_forward,
              //   color: Colors.blue[600],
              //   size: 24.0,
              //   semanticLabel: 'Text to announce in accessibility modes',
              // ),
              const SizedBox(height: 30),
              const Text(
                'To',
                style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue),
              ),
              const SizedBox(height: 20),
              Container(
                decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(5)),
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 20, top: 3, bottom: 3, right: 20),
                  child: DropdownButton(
                    // style: Theme.of(context).textTheme.headline6,
                    isExpanded: true,
                    underline: const SizedBox(),
                    hint: Text(
                      "Select value",
                      style: inputStyle,
                    ),
                    style: inputStyle,
                    items: _measures.map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(
                          value,
                          style: inputStyle,
                        ),
                      );
                    }).toList(),
                    onChanged: (String? value) {
                      setState(() {
                        _convertedMeasure = value;
                      });
                    },
                    value: _convertedMeasure,
                  ),
                ),
              ),

              const SizedBox(height: 60),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.blue,
                  elevation: 0.0,
                  minimumSize: const Size(370, 50),
                ),
                child: const Text('Convert',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold)),
                onPressed: () {
                  if (_startMeasure!.isEmpty ||
                      _convertedMeasure!.isEmpty ||
                      _numberForm == 0) {
                    return;
                  } else {
                    convert(_numberForm!, _startMeasure!, _convertedMeasure!);
                  }
                },
              ),

              const SizedBox(height: 20),
              Text((_resultMessage), style: labelStyle),
            ],
          ),
        ),
      ),
    );
  }
}
