import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_lec_36_making_apis/view/student_detail.dart';
import 'package:http/http.dart' as http;
import '../models/student_model.dart';
import '../utils/app_config.dart';

class StudentListClass extends StatefulWidget {
  const StudentListClass({Key? key}) : super(key: key);

  @override
  State<StudentListClass> createState() => _StudentListClassState();
}

class _StudentListClassState extends State<StudentListClass> {
  List<Student> studentes = [];
  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  TextEditingController firstnameController = TextEditingController();
  TextEditingController lastnameController = TextEditingController();
  TextEditingController mobailnumberController = TextEditingController();
  TextEditingController avatarController = TextEditingController();

  bool isloading = false;

  @override
  void initState() {
    //fname.text = "Kishor";
    getstudents();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Students"),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8),
            child: GestureDetector(
              onTap: () {
                getstudents();
              },
              child: const Icon(Icons.rotate_left),
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          openAddDialog();
        },
        child: const Icon(Icons.add),
      ),
      body: isloading
          ? const Center(child: CircularProgressIndicator.adaptive())
          : studentes.isEmpty
              ? const Center(child: Text("No student"))
              : ListView.builder(
                  itemCount: studentes.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding:
                          const EdgeInsets.only(left: 10, right: 10, top: 10),
                      child: ListTile(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => StudentDetail(
                                      student: studentes[index])));
                        },
                        title: Text(
                          "${studentes[index].firstName}  ${studentes[index].lastName}",
                          style: const TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        leading: CircleAvatar(
                          backgroundImage: NetworkImage(
                            studentes[index].avatar!,
                          ),
                          radius: 25,
                        ),
                      ),
                    );
                  }),
    );
  }

  void getstudents() async {
    setState(
      () => isloading = true,
    );
    http.Response response =
        await http.get(Uri.parse("${AppConfig.baseUrl}/users"));
    // print(response.body);
    // print(response.statusCode);
    if (response.statusCode == 200) {
      // Map<String, dynamic> res = {
      //   "createdeAt": 1658941192284,
      //   "firstName": "Robert",
      //   "avatar":
      //       "https://cloudflare-ipfs.com/ipfs/Qmd3W5DuhgHirLHGVixi6V76LhCkZUz6pnFt5AJBiyvHye/avatar/575.jpg",
      //   "lastName": "Ruthrford",
      //   "id": "1"
      // };
      //print(res["firstName"]);
      //print(response.body.runtimeType);
      var decoded = jsonDecode(response.body);
      //print(decoded.runtimeType);
      if (decoded is List) {
        for (var stud in decoded) {
          studentes.add(Student.fromMap(stud as Map<String, dynamic>));
        }
      }
      setState(
        () => isloading = false,
      );
    }
    // print(studentes);
  }

  void openAddDialog() async {
    var isAdded = await showDialog(
        context: context,
        builder: (context) {
          return Dialog(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Form(
                key: formkey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextFormField(
                      controller: firstnameController,
                      decoration: const InputDecoration(
                          labelText: 'First Name',
                          border: OutlineInputBorder()),
                      validator: ((value) {
                        if (value!.isEmpty) {
                          return 'Please enter the first name';
                        }
                        return null;
                      }),
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      controller: lastnameController,
                      decoration: const InputDecoration(
                          labelText: 'Last Name', border: OutlineInputBorder()),
                      validator: ((value) {
                        if (value!.isEmpty) {
                          return 'Please enter the last name';
                        }
                        return null;
                      }),
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      controller: mobailnumberController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        labelText: 'Mobile Number',
                        border: OutlineInputBorder(),
                      ),
                      validator: ((value) {
                        if (value!.isEmpty) {
                          return 'Please enter the Mobile number';
                        }
                        return null;
                      }),
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      controller: avatarController,
                      keyboardType: TextInputType.text,
                      decoration: const InputDecoration(
                        labelText: 'Enter image link',
                        border: OutlineInputBorder(),
                      ),
                      validator: ((value) {
                        if (value!.isEmpty) {
                          return 'Please enter the image link';
                        }
                        return null;
                      }),
                    ),
                    const SizedBox(height: 20),
                    TextButton(
                      onPressed: () {
                        if (formkey.currentState!.validate()) {
                          addUserApi(context);
                        }
                      },
                      child: const Text("Submit"),
                    ),
                  ],
                ),
              ),
            ),
          );
        });

    if (isAdded != null && isAdded) {
      getstudents();
    }
  }

  @override
  void dispose() {
    firstnameController.dispose();
    lastnameController.dispose();
    mobailnumberController.dispose();
    avatarController.dispose();
    super.dispose();
  }

  void addUserApi(context) async {
    http.Response response =
        await http.post(Uri.parse('${AppConfig.baseUrl}/users'), body: {
      "firstName": firstnameController.text,
      "lastName": lastnameController.text,
      "avatar": avatarController.text,
      "mobileNumber": mobailnumberController.text,
    });

    if (response.statusCode == 201) {
      firstnameController.clear();
      lastnameController.clear();
      mobailnumberController.clear();
      avatarController.clear();
      Navigator.pop(context, true);
    }
  }
}
