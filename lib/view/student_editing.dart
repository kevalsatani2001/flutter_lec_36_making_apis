import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../models/student_model.dart';
import '../utils/app_config.dart';

class EditDetail extends StatefulWidget {
  const EditDetail({Key? key, required this.studentedit}) : super(key: key);
  final Student studentedit;

  @override
  State<EditDetail> createState() => _EditDetailState();
}

class _EditDetailState extends State<EditDetail> {
  Student? studentedit;
  bool isloading = false;
  @override
  void initState() {
    studentedit = widget.studentedit;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Dialog(
        child: Form(
            child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                  initialValue: widget.studentedit.firstName,
                  decoration: const InputDecoration(
                      labelText: 'First Name', border: OutlineInputBorder())),
              const SizedBox(height: 20),
              TextFormField(
                  initialValue: widget.studentedit.lastName,
                  decoration: const InputDecoration(
                      labelText: 'Last Name', border: OutlineInputBorder())),
              const SizedBox(height: 20),
              TextFormField(
                  initialValue: widget.studentedit.mobileNumber,
                  decoration: const InputDecoration(
                      labelText: 'Mobile Number',
                      border: OutlineInputBorder())),
              const SizedBox(height: 20),
              TextFormField(
                  initialValue: widget.studentedit.avatar,
                  decoration: const InputDecoration(
                      labelText: 'Image', border: OutlineInputBorder())),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(onPressed: () {}, child: const Text("UPDATE")),
                    TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text("CANCLE")),
                  ],
                ),
              )
            ],
          ),
        )),
      ),
    );
  }
}
