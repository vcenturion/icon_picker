import 'package:flutter/material.dart';
import 'package:icon_picker/icon_picker.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Flutter IconPicker Demo',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final GlobalKey<FormState> _oFormKey = GlobalKey<FormState>();
  TextEditingController? _controller;
  //String _initialValue = '';
  String _valueChanged = '';
  String _valueToValidate = '';
  String _valueSaved = '';

  @override
  void initState() {
    super.initState();

    //_initialValue = 'home';
    _controller = TextEditingController(text: 'home');

    _getValue();
  }

  /// This implementation is just to simulate a load data behavior
  /// from a data base sqlite or from a API
  Future<void> _getValue() async {
    await Future.delayed(const Duration(seconds: 3), () {
      setState(() {
        //_initialValue = 'favorite';
        _controller?.text = 'favorite';
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter IconPicker Demo'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
        child: Form(
          key: _oFormKey,
          child: Column(
            children: <Widget>[
              IconPicker(
                controller: _controller,
                //initialValue: _initialValue,
                icon: const Icon(Icons.apps),
                labelText: "Icon",
                enableSearch: true,
                onChanged: (val) => setState(() => _valueChanged = val),
                validator: (val) {
                  setState(() => _valueToValidate = val ?? '');
                  return null;
                },
                onSaved: (val) => setState(() => _valueSaved = val ?? ''),
              ),
              const SizedBox(height: 30),
              const Text(
                'IconPicker data value onChanged:',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              SelectableText(_valueChanged),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: () {
                  final loForm = _oFormKey.currentState;

                  if (loForm?.validate() == true) {
                    loForm?.save();
                  }
                },
                child: const Text('Submit'),
              ),
              const SizedBox(height: 30),
              const Text(
                'IconPicker data value validator:',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              SelectableText(_valueToValidate),
              const SizedBox(height: 30),
              const Text(
                'IconPicker data value onSaved:',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              SelectableText(_valueSaved),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: () {
                  final loForm = _oFormKey.currentState;
                  loForm?.reset();

                  setState(() {
                    _valueChanged = '';
                    _valueToValidate = '';
                    _valueSaved = '';
                  });
                },
                child: const Text('Reset'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
