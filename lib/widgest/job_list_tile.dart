import 'package:authmabform/crud_services/job_model.dart';
import 'package:authmabform/them_service/app_theme_state.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class JobListTile extends StatelessWidget {
  final name;
  final VoidCallback onTap;

  JobListTile({@required this.name, @required this.onTap});


  @override
  Widget build(BuildContext context) {
    return ListTile(
        title: Text(name),
    trailing: Icon(Icons.chevron_right),
    onTap: onTap,
    );
  }
}
