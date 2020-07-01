import 'package:authmabform/crud_services/database.dart';
import 'package:authmabform/crud_services/edit_job_screen.dart';
import 'package:authmabform/crud_services/job_model.dart';
import 'package:authmabform/home/empty_content.dart';
import 'package:authmabform/widgest/platform_excption_alert_dailog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'file:///C:/Users/moham/AndroidStudioProjects/auth_mab_form/lib/widgest/job_list_tile.dart';

class HomePage extends StatelessWidget {
  Future<void> _delete(BuildContext context, Job job) async {
    try {
      final database = Provider.of<Database>(context, listen: false);
      await database.deleteJob(job);
    } on PlatformException catch (e) {
      PlatformExceptionAlertDialog(
        title: 'Operation failed',
        exception: e,
      ).show(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context) {
    final database = Provider.of<Database>(context);
    return StreamBuilder<List<Job>>(
      stream: database.jobsStream(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final jobs = snapshot.data;
          if (jobs.isNotEmpty) {
            return ListView.separated(
              itemCount: jobs.length,
              separatorBuilder: (context, index) => Divider(
                height: 0.5,
                color: Theme.of(context).iconTheme.color,
              ),
              itemBuilder: (ctx, i) => Dismissible(
                key: Key('job-${jobs[i].id}'),
                background: Container(color: Colors.red),
                direction: DismissDirection.endToStart,
                onDismissed: (direction) => _delete(context, jobs[i]),
                child: JobListTile(
                  name: jobs[i].name,
                  onTap: () => EditJobPage.show(context, job: jobs[i]),
                ),
              ),
            );
          }
          return EmptyContent();
        }
        if (snapshot.hasError) {
          return Center(
            child: Text(
              'Some Error occurred',
              style: TextStyle(
                fontSize: 30,
                color: Colors.grey,
                fontWeight: FontWeight.bold,
              ),
            ),
          );
        }
        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}
