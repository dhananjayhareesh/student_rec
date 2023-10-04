import 'dart:io';
import 'package:flutter/material.dart';
import 'package:student_records/database/db_functions.dart';
import 'package:student_records/database/db_model.dart';
import 'package:student_records/screen/studentdetails.dart';
import 'package:student_records/screen/editstudent.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  List<StudentModel> finduser = [];

  @override
  void initState() {
    super.initState();
    finduser = studentList.value;
    // Initialize with the current student list
  }

  void _runFilter(String enteredKeyword) {
    List<StudentModel> result = [];
    if (enteredKeyword.isEmpty) {
      result = studentList.value;
      // Reset to the original list if the search is empty
    } else {
      // Filter based on student properties
      result = studentList.value
          .where((student) =>
              student.name
                  .toLowerCase()
                  .contains(enteredKeyword.toLowerCase()) ||
              student.classname
                  .toLowerCase()
                  .contains(enteredKeyword.toLowerCase()))
          .toList();
    }
    setState(() {
      finduser = result;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 186, 246, 240),
      body: SafeArea(
        child: ValueListenableBuilder<List<StudentModel>>(
          valueListenable: studentList,
          builder: (context, studentListValue, child) {
            return Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    child: TextField(
                      onChanged: (value) => _runFilter(value),
                      decoration: const InputDecoration(
                        labelText: 'Search',
                        suffixIcon: Icon(Icons.search),
                      ),
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: finduser.length,
                      itemBuilder: (context, index) {
                        final finduserItem = finduser[index];
                        return Card(
                          elevation: 4,
                          margin: const EdgeInsets.symmetric(vertical: 10),
                          child: ListTile(
                            leading: CircleAvatar(
                              backgroundImage:
                                  FileImage(File(finduserItem.imagex)),
                            ),
                            title: Text(finduserItem.name),
                            subtitle: Text('CLASS : ${finduserItem.classname}'),
                            trailing: IconButton(
                                onPressed: () {
                                  Navigator.of(context)
                                      .pushReplacement(MaterialPageRoute(
                                    builder: (context) =>
                                        EditStudent(student: finduserItem),
                                  ));
                                },
                                icon: const Icon(Icons.edit)),
                            onTap: () {
                              Navigator.of(context)
                                  .pushReplacement(MaterialPageRoute(
                                builder: (ctr) =>
                                    StudentDetails(stdetails: finduserItem),
                              ));
                            },
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
