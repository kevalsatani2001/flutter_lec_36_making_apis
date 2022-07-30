import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_lec_36_making_apis/view/student_detail.dart';
import 'package:http/http.dart' as http;
import '../models/student_model.dart';
import '../utils/app_config.dart';

class StudentList extends StatefulWidget {
  const StudentList({Key? key}) : super(key: key);

  @override
  State<StudentList> createState() => _StudentListState();
}

class _StudentListState extends State<StudentList> {
  List<Student> studentes = [];
  GlobalKey <FormState> formkey=GlobalKey<FormState>();
  TextEditingController fname = TextEditingController();
  TextEditingController lname = TextEditingController();
  TextEditingController fnameerror = TextEditingController();
  TextEditingController lnameerror = TextEditingController();
  TextEditingController mnum = TextEditingController();
  TextEditingController mnumerror = TextEditingController();
  bool isloading = false;
 

  @override
  void initState() {
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
          showDialog(
              context: context,
              builder: (context) {
                return Dialog(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Form(
                      key: formkey,
                      child: Column(
                        children: [
                           TextFormField(
                            controller: fname,
                           
                            decoration: const InputDecoration(
                              
                                labelText: 'First Name',
                                border: OutlineInputBorder()),
                                validator: ((value){
                                  if(value!.isEmpty){
                                    return 'Please enter the first name';
                                  }
                                }),
                          ),
                          
                          const SizedBox(height: 20),
                          
                            TextFormField(
                           
                            decoration: const InputDecoration(
                                labelText: 'Last Name',
                                border: OutlineInputBorder()),
                                 validator: ((value){
                                  if(value!.isEmpty){
                                    return 'Please enter the last name';
                                  }
                                }),
                          ),
                          
                        
                          const SizedBox(height: 20),
                          
                           TextFormField(
                            
                            decoration: const InputDecoration(
                                labelText: 'Mobile Number',
                                border: OutlineInputBorder()),
                                 validator: ((value){
                                  if(value!.isEmpty){
                                    return 'Please enter the Mobile number';
                                  }
                                }),
                          ),
                         
                          const SizedBox(height: 50),
                          TextButton(
                            onPressed: () {
                              if(formkey.currentState!.validate()){
                                print("Success");
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
          // AlertDialog(
          //   title: Text("data"),
          //   content: Column(
          //     children: [Text("data")],
          //   ),
          // );
        },
        child: Icon(Icons.add),
      ),
      body: isloading
          ? const Center(child: CircularProgressIndicator.adaptive())
          : studentes.isEmpty
              ? const Center(child: Text("No student"))
              : ListView.builder(
                  itemCount: studentes.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    StudentDetail(student: studentes[index])));
                      },
                      title: Text(
                          "${studentes[index].firstName}  ${studentes[index].lastName}"),
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
      print(decoded.runtimeType);
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

  
}
