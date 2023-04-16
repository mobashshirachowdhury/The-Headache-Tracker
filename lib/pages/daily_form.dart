import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class DailyForm extends StatefulWidget {
  @override
  State<DailyForm> createState() => _DailyFormState();
}

class _DailyFormState extends State<DailyForm> {
  final _formKey = GlobalKey<FormState>();

  File? _image;

  Future getImage() async {
    final pickedFile = await ImagePicker().getImage(
        source: ImageSource.gallery);
    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  double _sleepQuality = 50;
  int _hours = 0;
  int _minutes = 0;
  TextEditingController _textController = TextEditingController();
  int _stressLevel = 1;
  String? _didExercise;
  String _exerciseType = '';
  String _exerciseDuration = '';

  void _submitForm() {
    // This is where you would handle the form submission.
    // You can access the values of the form inputs using the _sleepQuality,
    // _hours, _minutes, and _image variables.
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        border: Border.all(color: Colors.white),
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'How did you sleep?',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20),
            Row(
              children: [
                Text(
                  'Sleep quality:',
                  style: TextStyle(fontSize: 16),
                ),
                Expanded(
                  child: Slider(
                    value: _sleepQuality,
                    min: 0,
                    max: 100,
                    onChanged: (value) {
                      setState(() {
                        _sleepQuality = value;
                      });
                    },
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            Row(
              children: [
                Text(
                  'Sleep duration:',
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(
                  width: 70.0,
                  child: TextField(
                    keyboardType: TextInputType.number,
                    onChanged: (value) {
                      setState(() {
                        _hours = int.tryParse(value) ?? 0;
                      });
                    },
                    decoration: InputDecoration(
                      labelText: 'H',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                SizedBox(width: 16.0),
                SizedBox(
                  width: 70.0,
                  child: TextField(
                    keyboardType: TextInputType.number,
                    onChanged: (value) {
                      setState(() {
                        _minutes = int.tryParse(value) ?? 0;
                      });
                    },
                    decoration: InputDecoration(
                      labelText: 'M',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            Row(
              children: [
                Text(
                  'What did you eat?',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                SizedBox(width: 16.0),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      GestureDetector(
                        onTap: getImage,
                        child: Container(
                          height: 50,
                          width: 50,
                          decoration: BoxDecoration(
                            color: Colors.grey.shade300,
                            border: Border.all(color: Colors.black),
                          ),
                          child: _image == null
                              ? Icon(Icons.image)
                              : Image.file(_image!),
                        ),
                      ),
                      SizedBox(height: 10),

                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 5),
            Row(
              children: [
                Text(
                  'What happened today?',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            SizedBox(height: 5),
            TextField(
              maxLength: 50,
              decoration: InputDecoration(
                hintText: 'Enter your text here',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Stress level:',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: Slider(
                    value: _stressLevel.toDouble(),
                    min: 1,
                    max: 5,
                    divisions: 4,
                    onChanged: (double value) {
                      setState(() {
                        _stressLevel = value.round();
                      });
                    },
                  ),
                ),
                SizedBox(width: 10),
                Text(
                  _stressLevel.toString(),
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Text('Did you exercise today?'),
                SizedBox(width: 10),
                Radio(
                  value: 'Yes',
                  groupValue: _didExercise,
                  onChanged: (value) {
                    setState(() {
                      _didExercise = value;
                      if (value == 'No') {
                        _exerciseType = '';
                        _exerciseDuration = '';
                      }
                    });
                  },
                ),
                Text('Yes'),
                SizedBox(width: 10),
                Radio(
                  value: 'No',
                  groupValue: _didExercise,
                  onChanged: (value) {
                    setState(() {
                      _didExercise = value;
                      if (value == 'No') {
                        _exerciseType = '';
                        _exerciseDuration = '';
                      }
                    });
                  },
                ),
                Text('No'),
              ],
            ),
            if (_didExercise == 'Yes')
              Column(
                children: [
                  TextField(
                    decoration: InputDecoration(
                      labelText: 'Exercise type',
                    ),
                    onChanged: (value) {
                      _exerciseType = value;
                    },
                  ),
                  TextField(
                    decoration: InputDecoration(
                      labelText: 'Exercise duration',
                    ),
                    onChanged: (value) {
                      _exerciseDuration = value;
                    },
                  ),
                ],
              ),

            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _submitForm,
              child: Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }
}
