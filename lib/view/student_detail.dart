import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_lec_36_making_apis/models/student_model.dart';
import 'package:flutter_lec_36_making_apis/view/student_editing.dart';
import 'package:http/http.dart' as http;

import '../utils/app_config.dart';

class StudentDetail extends StatefulWidget {
  const StudentDetail({Key? key, required this.student}) : super(key: key);
  final Student student;

  @override
  State<StudentDetail> createState() => _StudentDetailState();
}

class _StudentDetailState extends State<StudentDetail> {
  Student? student;
  bool isloading = false;
  @override
  void initState() {
    getUserDetails();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: isloading
              ? const Text("Student detail")
              : Text("${widget.student.firstName} ${widget.student.lastName}"),
          actions: [
            Row(
              children:  [
                InkWell(
                     onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>EditDetail(studentedit: widget.student,)));
                     },
                     child: Icon(Icons.edit)),
                SizedBox(width: 20),
                Icon(Icons.delete),
                SizedBox(width: 20),
                Icon(Icons.more_vert_rounded),
              ],
            )
          ],
        ),
        body: isloading
            ? const Center(child: CircularProgressIndicator.adaptive())
            : Padding(
                padding: const EdgeInsets.only(top: 30, left: 30, right: 30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 120,
                      width: 120,
                      decoration: BoxDecoration(
                          color: Colors.red,
                          shape: BoxShape.circle,
                          image: DecorationImage(
                              image: NetworkImage("${widget.student.avatar}"),
                              fit: BoxFit.cover)),
                    ),
                    const SizedBox(height: 10),
                    Text("${student?.firstName}",
                        style:
                            const TextStyle(color: Colors.black, fontSize: 30)),
                    const SizedBox(height: 70),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${student?.mobileNumber}",
                                style: const TextStyle(
                                    fontSize: 20,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                              ),
                              Row(children: [
                                const Text("Mobile"),
                                const SizedBox(width: 5),
                                const Text("|"),
                                const SizedBox(width: 5),
                                Text("${student?.countryName}")
                              ]),
                            ]),
                        const SizedBox(width: 220),
                        const Icon(Icons.call, size: 30),
                        const SizedBox(width: 50),
                        const Icon(Icons.message, size: 30)
                      ],
                    )
                    //Text("Last name : ${student?.lastName}"),
                  ],
                ),
              ));
  }

  void getUserDetails() async {
    setState(
      () => isloading = true,
    );
    http.Response response = await http.get(
      Uri.parse("${AppConfig.baseUrl}/users/${widget.student.id}"),
    );
    //print(response.statusCode);
    if (response.statusCode == 200) {
      var decoded = jsonDecode(response.body);
      student = Student.fromMap(decoded);
      setState(() => isloading = false);
      print(decoded);
    }
  }
}
