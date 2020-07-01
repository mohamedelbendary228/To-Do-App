import 'package:authmabform/crud_services/job_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class APIPath {
  static String job(String uid, String jobId) => '/users/$uid/jobs/$jobId';

  static String jobs(String uid) => 'users/$uid/jobs/';
}

String documentIdFromCurrentDate() => DateTime.now().toIso8601String();

class Database {
  final String uid;

  Database({@required this.uid}) : assert(uid != null);

  Future<void> createAndEditJob(Job job) async {
    final path = APIPath.job(uid, job.id);
    final documentReference = Firestore.instance.document(path);
    await documentReference.setData(job.toMap());
  }

  Stream<List<Job>> jobsStream() {
    final path = APIPath.jobs(uid);
    final reference = Firestore.instance.collection(path);
    final snapshots = reference.snapshots();
    return snapshots.map(
      (snapshot) => snapshot.documents.map(
        (snapshot) => Job.fromMap(snapshot.data, snapshot.documentID),
      ).toList());
  }

  Future<void> deleteJob(Job job) async{
    final path = APIPath.job(uid, job.id);
    final reference = Firestore.instance.document(path);
    await reference.delete();
  }


}
