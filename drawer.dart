import 'package:flutter/material.dart';



class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Drawer Example'),
        ),
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              UserAccountsDrawerHeader(
                accountName: Text('User'),
                accountEmail: null,
                currentAccountPicture: CircleAvatar(
                  backgroundColor: Colors.white,
                  child: Icon(
                    Icons.person,
                    size: 50.0,
                    color: Colors.blue,
                  ),
                ),
                decoration: BoxDecoration(
                  color: Colors.blue,
                ),
              ),
              ListTile(
                title: Text('Account'),
                onTap: () {
                  // Handle the Account tap
                },
              ),
              ListTile(
                title: Text('Edit Profile'),
                onTap: () {
                  // Handle the Edit Profile tap
                },
              ),
              ListTile(
                title: Text('Logout'),
                onTap: () {
                  // Handle the Logout tap
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}