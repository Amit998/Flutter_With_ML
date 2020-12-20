import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool _loading = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF101010),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 24),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 50.0,
              ),
              Text("TeachableMachine.com CNN",
                  style: TextStyle(color: Color(0xFFEEDAADA), fontSize: 16)),
              SizedBox(
                height: 20.0,
              ),
              Text(
                'Detect Dogs and Cats',
                style: TextStyle(
                    color: Color(0xFF0999FAA),
                    fontWeight: FontWeight.bold,
                    fontSize: 30),
              ),
              SizedBox(
                height: 40.0,
              ),
              // Center(
              //   child: _loading
              //       ? Container(
              //           // child: Column(
              //           //   children: [
              //           //     Image.asset('assets/catdog.png'),
              //           //     SizedBox(height: 50),
              //           //   ],
              //           // ),
              //           )
              //       : Container(),
              // )
            ],
          ),
        ),
      ),
    );
  }
}
