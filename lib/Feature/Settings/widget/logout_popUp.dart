import 'package:flutter/material.dart';

void showLogOutDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Log Out'),
        content: Text('Are you sure you want to log out?'),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              // Handle "Yes, Log Out" action
              Navigator.of(context).pop();
              print('User logged out');
            },
            child: Text(
              'Yes, Log Out',
              style: TextStyle(color: Colors.red),
            ),
          ),
          TextButton(
            onPressed: () {
              // Handle "Cancel" action
              Navigator.of(context).pop();
              print('Log out canceled');
            },
            child: Text('Cancel'),
          ),
        ],
      );
    },
  );
}
