
import 'package:flutter/material.dart';
import 'package:flutter_lec_36_making_apis/view/student_list_class_code.dart';

class StudentList extends StatefulWidget {
  const StudentList({Key? key}) : super(key: key);

  @override
  State<StudentList> createState() => _StudentListState();
}

class _StudentListState extends State<StudentList> {
 
  @override
  Widget build(BuildContext context) {
    return  const StudentListClass();
  }}

  