import 'package:flutter/material.dart';

void main() => runApp(TempConverterApp());

class TempConverterApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Temperature Converter',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: TempConverterHomePage(),
    );
  }
}

class TempConverterHomePage extends StatefulWidget {
  @override
  _TempConverterHomePageState createState() => _TempConverterHomePageState();
}

class _TempConverterHomePageState extends State<TempConverterHomePage> {
  final TextEditingController _tempController = TextEditingController();
  bool _isFahrenheitToCelsius = true;
  String _convertedTemp = '';
  List<String> _conversionHistory = [];

  void _convertTemperature() {
    setState(() {
      double inputTemp = double.tryParse(_tempController.text) ?? 0;
      double result;
      String historyEntry;

      if (_isFahrenheitToCelsius) {
        // Convert Fahrenheit to Celsius
        result = (inputTemp - 32) * 5 / 9;
        historyEntry = 'F to C: $inputTemp => ${result.toStringAsFixed(2)}';
      } else {
        // Convert Celsius to Fahrenheit
        result = inputTemp * 9 / 5 + 32;
        historyEntry = 'C to F: $inputTemp => ${result.toStringAsFixed(2)}';
      }

      _convertedTemp = result.toStringAsFixed(2);
      _conversionHistory.insert(0, historyEntry);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Temperature Converter',
          style: TextStyle(
            color: Colors.white, // Set title text color to white
          ),
        ),
        backgroundColor: Colors.blue, // Set AppBar color to blue
      ),
      body: OrientationBuilder(
        builder: (context, orientation) {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const Text(
                  'Conversion:',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.blue,
                    fontWeight: FontWeight.bold,
                    decoration: TextDecoration.underline,
                    decorationThickness: 1.5, // Control thickness of underline
                    decorationColor: Colors.blue, // Underline color
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: ListTile(
                        title: const Text('Fahrenheit to Celsius'),
                        leading: Radio<bool>(
                          value: true,
                          groupValue: _isFahrenheitToCelsius,
                          onChanged: (bool? value) {
                            setState(() {
                              _isFahrenheitToCelsius = value!;
                            });
                          },
                        ),
                      ),
                    ),
                    Expanded(
                      child: ListTile(
                        title: const Text('Celsius to Fahrenheit'),
                        leading: Radio<bool>(
                          value: false,
                          groupValue: _isFahrenheitToCelsius,
                          onChanged: (bool? value) {
                            setState(() {
                              _isFahrenheitToCelsius = value!;
                            });
                          },
                        ),
                      ),
                    ),
                  ],
                ),
                TextField(
                  controller: _tempController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: 'Enter Temperature',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 30),
                Center(
                  child: ElevatedButton(
                    onPressed: _convertTemperature,
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(3), // Border radius of 3px
                      ),
                    ),
                    child: const Text(
                      'CONVERT',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 23, 53, 201),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                if (_convertedTemp.isNotEmpty)
                  Text(
                    'Converted Value: $_convertedTemp',
                    style: const TextStyle(fontSize: 18),
                  ),
                SizedBox(height: 20),
                const Text(
                  'Conversion History',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.blue,
                    fontWeight: FontWeight.bold,
                    decoration: TextDecoration.underline,
                    decorationThickness: 1.5, // Thickness of underline
                    decorationColor: Colors.blue, // Color of underline
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: _conversionHistory.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(_conversionHistory[index]),
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.blue,
        child: Container(
          height: 60,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              GestureDetector(
                onTap: () {
                  // Handle bottom icon click
                },
                child: Image.asset(
                  'assets/circle.png',
                  height: 40,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
