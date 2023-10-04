import 'package:flutter/material.dart';
import 'package:student_records/database/db_functions.dart';

import 'package:student_records/screen/addstudent.dart';
import 'package:student_records/screen/gridscreen.dart';
import 'package:student_records/screen/listscreen.dart';
import 'package:student_records/screen/searchscreen.dart';

class HomeScreeen extends StatefulWidget {
  const HomeScreeen({super.key});

  @override
  State<HomeScreeen> createState() => _HomeScreeenState();
}

class _HomeScreeenState extends State<HomeScreeen> {
  int _selectedIndex = 0;
  int _viewMode = 0; // 0 for list, 1 for grid

  @override
  Widget build(BuildContext context) {
    getstudentdata();
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 186, 246, 240),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 197, 169, 248),
        title: const Text('Students Record'),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (ctxs) => const SearchScreen()));
              },
              icon: const Icon(Icons.search_rounded))
        ],
      ),
      body: Column(
        children: [
          Expanded(
              child: _viewMode == 0
                  ? const StudentListGridView()
                  : const StudentList()),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Visibility(
        visible: true, // Show the add button
        child: FloatingActionButton(
          shape: const CircleBorder(),
          elevation: 2, // shadow
          onPressed: () {
            addstudent(context);
          },
          child: const Icon(Icons.add),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: const Color.fromARGB(255, 214, 199, 243),
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.grid_3x3_rounded), label: 'Grid'),
          BottomNavigationBarItem(icon: Icon(Icons.list), label: 'List')
        ],
        currentIndex: _selectedIndex,
        onTap: (int index) {
          setState(() {
            _selectedIndex = index;
            _viewMode = index;
          });
        },
      ),
    );
  }

  void addstudent(gtx) {
    Navigator.of(gtx)
        .push(MaterialPageRoute(builder: (gtx) => const AddStudent()));
  }
}
