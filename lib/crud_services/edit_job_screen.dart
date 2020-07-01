import 'package:authmabform/crud_services/database.dart';
import 'package:authmabform/crud_services/job_model.dart';
import 'package:authmabform/widgest/platform_alert_dailog.dart';
import 'package:authmabform/widgest/platform_excption_alert_dailog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class EditJobPage extends StatefulWidget {
  final Database database;
  final Job job;

  EditJobPage({@required this.database, this.job});

  static Future<void> show(BuildContext context, {Job job}) async {
    final database = Provider.of<Database>(context, listen: false);
    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => EditJobPage(
          database: database,
          job: job,
        ),
        fullscreenDialog: true,
      ),
    );
  }

  @override
  _EditJobPageState createState() => _EditJobPageState();
}

class _EditJobPageState extends State<EditJobPage> {
  final _formKey = GlobalKey<FormState>();
  String _name;
  int _salary;

  @override
  void initState(){
    super.initState();
    if(widget.job != null){
      _name = widget.job.name;
      _salary = widget.job.salary;
    }
  }
  bool validateAndSaveForm() {
    final form = _formKey.currentState;
    if (form.validate()) {
      form.save();
      return true;
    }
    return false;
  }

  Future<void> _submit() async {
    if (validateAndSaveForm()) {
      try {
        final firstJob = await widget.database.jobsStream().first;
        final names = firstJob.map((job) => job.name).toList();
        if(widget.job != null){
          names.remove(widget.job.name);
        }
        if (names.contains(_name)) {
          PlatformAlertDialog(
            title: 'Name already used',
            content: 'Please choose a different job name',
            defaultActionText: 'OK',
          ).show(context);
        } else {
          final id = widget.job?.id ?? documentIdFromCurrentDate();
          final job = Job(id: id, name: _name, salary: _salary);
          await widget.database.createAndEditJob(job);
          Navigator.of(context).pop();
        }
      } on PlatformException catch (e) {
        PlatformExceptionAlertDialog(
          title: 'Operation failed',
          exception: e,
        ).show(context);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.job == null? 'Add Job' : 'Edit Job'),
        actions: <Widget>[
          FlatButton(
            child: Text(
              'Save',
              style: TextStyle(
                fontSize: 18,
                color: Colors.white,
              ),
            ),
            onPressed: _submit,
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Card(
            child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: 'Name',
                        ),
                        initialValue: _name,
                        validator: (value) =>
                            value.isNotEmpty ? null : 'Name can\'t be empty',
                        onSaved: (value) => _name = value,
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: 'Salary',
                        ),
                        initialValue: _salary != null? '$_salary' : null,
                        keyboardType: TextInputType.number,
                        onSaved: (value) => _salary = int.tryParse(value) ?? 0,
                      ),
                    ],
                  ),
                )),
          ),
        ),
      ),
    );
  }
}
