import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class APIService {
  static const _api_key = '';
  static const String _base_url =
       "https://twinword-emotion-analysis-v1.p.rapidapi.com/analyze/";
  static const Map<String, String> _header = {
    "content-type": "application/x-www-form-urlencoded",
	  "x-rapidapi-key": _api_key,
	  "x-rapidapi-host": "twinword-emotion-analysis-v1.p.rapidapi.com",
    "useQueryString": "true",
  };

  Future<SentAnalysis> post({@required Map<String, String> query}) async {
    final response = await http.post(_base_url, headers: _header, body: query);
    if (response.statusCode == 200) {
      print('success' + response.body);
      return SentAnalysis.fromJson(json.decode(response.body));
    } else {
      throw Exception('Faild To load json data');
    }
  }
}

class SentAnalysis {
  final String emotions;
  SentAnalysis({this.emotions});

  factory SentAnalysis.fromJson(Map<String, dynamic> json) {
    return SentAnalysis(emotions: json['emotions_detected'][0]);
  }
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool _loading = true;
  final myController = TextEditingController();

  APIService apiService = APIService();
  Future<SentAnalysis> analysis;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            stops: [0.004, 1],
            colors: [Color(0xFFe100ff), Color(0xFFe20fff)],
          ),
        ),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 34),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: MediaQuery.of(context).size.width / 4.5),
              Text(
                "Sentiment Analysis",
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w800,
                    fontSize: 28),
              ),
              SizedBox(
                height: 40,
              ),
              Container(
                padding: EdgeInsets.all(30),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.5),
                        spreadRadius: 5,
                        blurRadius: 7,
                      ),
                    ]),
                child: Column(
                  children: [
                    Container(
                      child: Center(
                          child: _loading
                              ? Container(
                                  width: 300,
                                  child: Column(
                                    children: [
                                      TextField(
                                        controller: myController,
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.w600,
                                        ),
                                        decoration: InputDecoration(
                                            labelStyle: TextStyle(
                                              color: Colors.black,
                                              fontSize: 21,
                                            ),
                                            labelText: 'Enter a Search Term: '),
                                      ),
                                      SizedBox(height: 30),
                                    ],
                                  ),
                                )
                              : Container()),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      child: Column(
                        children: [
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                // _loading = false;
                                
                                analysis = apiService
                                    .post(query: {'text': myController.text});
                                print('object');
                                print(myController.text);
                              });
                            },
                            child: Container(
                              width: MediaQuery.of(context).size.width - 180,
                              alignment: Alignment.center,
                              padding: EdgeInsets.symmetric(
                                  horizontal: 24.0, vertical: 17),
                              decoration: BoxDecoration(
                                color: Color(0xFF56ab2f),
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: Text("Find Emotions",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 18)),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          FutureBuilder<SentAnalysis>(
                            future: analysis,
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                return Text(
                                  'Prediction Is :' + snapshot.data.emotions,
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 29,
                                  ),
                                );
                              } else if (snapshot.hasError) {
                                return Text('${snapshot.error}');
                              }
                              return CircularProgressIndicator();
                            },
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
