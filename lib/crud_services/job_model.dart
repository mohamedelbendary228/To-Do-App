import 'package:flutter/cupertino.dart';
class Job{
  Job({@required this.id, @required this.name, @required this.salary});
  final String id;
  final String name;
  final int salary;

  factory Job.fromMap(Map<String , dynamic> data, String documentId){
    if(data == null){
      return null;
    }
    final String name = data['name'];
    final int salary = data['salary'];
    return Job(
      id: documentId,
      name: name,
      salary: salary,
    );
  }
  Map<String, dynamic> toMap(){
    return {
      'name': name,
      'salary' : salary,
    };
  }

}