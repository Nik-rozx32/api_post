import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class UserData extends StatefulWidget {
  const UserData({Key? key}) : super(key: key);

  @override
  State<UserData> createState() => _UserDataState();
}

class _UserDataState extends State<UserData> {
  final _formKey = GlobalKey<FormState>();
  String name = '';
  String email = '';
  String message = '';

  Future<void> postData(String name, String email) async {
    final url = Uri.parse('https://eo2nzlcrlpp5fp7.m.pipedream.net');
    final headers = {'Content-type': 'application/json'};
    final body = jsonEncode({'name': name, 'email': email});

    try {
      final response = await http.post(url, headers: headers, body: body);
      if (response.statusCode == 200) {
        setState(() {
          message = 'Data posted successfully';
        });
      } else {
        setState(() {
          message = '❌ Failed to post. Status: ${response.statusCode}';
        });
      }
    } catch (e) {
      setState(() {
        message = '⚠️ Error: $e';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Post User Data'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                onChanged: (val) => name = val,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0xff5c5d5e), width: 2),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0xff636463), width: 2),
                  ),
                  labelText: 'Enter name',
                ),
              ),
              SizedBox(
                height: 20,
              ),
              TextFormField(
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0xff5c5d5e), width: 2),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0xff636463), width: 2),
                  ),
                  labelText: 'Enter email',
                ),
                onChanged: (val) => email = val,
              ),
              SizedBox(
                height: 20,
              ),
              ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      postData(name, email);
                    }
                  },
                  child: Text('Submit')),
              SizedBox(height: 20),
              Text(message, style: TextStyle(fontSize: 16)),
            ],
          ),
        ),
      ),
    );
  }
}
