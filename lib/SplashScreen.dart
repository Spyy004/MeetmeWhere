import 'package:flutter/material.dart';

class Splash extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Center(
            child: Text(
          "Meet Me Where",
          style: TextStyle(fontWeight: FontWeight.bold),
        )),
      ),
      body: AnimatedContainer(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/MeetMeWhere.jpg'),
                fit: BoxFit.cover)),
        duration: Duration(seconds: 3),
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.location_on,
              color: Colors.red,
              size: 60,
            ),
          ],
        ),
      ),
    );
  }
}
