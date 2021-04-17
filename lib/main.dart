import 'package:demo1/SecondPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'variables.dart';

void main() async{
  await DotEnv().load('.env');
  runApp(Myhome());
}

class Myhome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MeetMeWhere(),
    );
  }
}

class MeetMeWhere extends StatefulWidget {
  @override
  _MeetMeWhereState createState() => _MeetMeWhereState();
}

class _MeetMeWhereState extends State<MeetMeWhere> {
  Keys formKey = Keys();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top:60.0,left: 20,right: 20),
        child: Center(
          child: Container(
            child: Form(
              key: formKey.k1,
              child: Column(
                children: [
                  TextFormField(
                    validator: (value) {
                      if (int.parse(value) <= 0) {
                        return 'Enter a valid number';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      NoOfPeople = int.parse(value);
                    },
                    keyboardType: TextInputType.number,
                  ),
                  ElevatedButton(
                      onPressed: () {
                        if (formKey.k1.currentState.validate()) {
                          formKey.k1.currentState.save();
                          print(NoOfPeople);
                        }
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SecondPage()));
                      },
                      child: Text("Save and Next"))
                ],
              ),
            ),
          ),
        ),
      ),
    ));
  }
}
