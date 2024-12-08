import 'package:assignment_2/screens/about_us.dart';
import 'package:assignment_2/screens/detail.dart';
import 'package:flutter/material.dart';
import '../widgets/cards.dart';
import 'dart:convert'; // For jsonDecode
import 'dart:async'; // For jsonDecode
import 'package:flutter/services.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<dynamic> tasks = [];

  @override
  void initState() {
    super.initState();
    _fetchTasks();
  }
 
    Future<void> _fetchTasks() async {
      final String response = await rootBundle.loadString('assets/api/todos.json');
      final List<dynamic> decodedData = json.decode(response);  

      setState(() {
        tasks = decodedData;
      });
    }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          IconButton(
            onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Ini adalah snackbar"))
                );
              }, 
              icon: const Icon(Icons.search, color: Colors.white),
          )
        ],
        // TRY THIS: Try changing the color here to a specific color (to
        // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
        // change color while the other colors stay the same.
        backgroundColor: Colors.black,
        iconTheme: const IconThemeData(color: Colors.white),
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
        titleTextStyle: const TextStyle(
            color: Colors.white, // Warna teks di AppBar
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        centerTitle: true,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header Section
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Row(
              children: [
                Icon(Icons.account_circle, size: 48, color: Colors.white),
                SizedBox(width: 8),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Hello, Hisyam Humaidi.',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      'Im a full stack developer.\nYou have some tasks to do today.',
                      style: TextStyle(fontSize: 14, color: Colors.grey),
                    ),
                  ],
                ),
              ],
            ),
          ),

          Expanded(
              child: tasks.isEmpty
                ? const Center(child: CircularProgressIndicator())
                : ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: tasks.length,
                  itemBuilder: (context, index) {
                    var e = tasks[index] as Map<String,dynamic>;
                  return GestureDetector(
                    onTap: () {
                      final subtask = (e['subtasks'] as List).map((el) => {'title':el['title'],'status':el['status']}).toList();
                      final subcomments = (e['comments'] as List).map((els) => {'text':els['comment'],'time':els['timestamp']}).toList();
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DetailPage(
                            title: tasks[index]['title'],
                            description: tasks[index]['description'],
                            startDate: tasks[index]['startDate'],
                            endDate: tasks[index]['dueDate'],
                            imagePath: tasks[index]['backgroundImage'],
                            tasks: subtask,
                            comments: subcomments,
                          ),
                        ),
                      );
                    },
                    child: TaskCard(
                      color: Color(int.parse(tasks[index]['color'])),
                      title: tasks[index]['title'],
                      taskCount: tasks[index]['totalTask'],
                    ),
                  );
                },

                ),
            )

          // Cards Slider
          // Expanded(
          //   child: PageView(
          //     children: const [
          //       TaskCard(
          //         color: Colors.blueGrey,
          //         title: 'Travel to Japan',
          //         taskCount: 3,
          //       ),
          //       TaskCard(
          //         color: Colors.deepOrange,
          //         title: 'Do Laundry',
          //         taskCount: 3,
          //       ),
          //       TaskCard(
          //         color: Colors.teal,
          //         title: 'Meeting with Boss',
          //         taskCount: 2,
          //       ),
          //     ],
          //   ),
          // ),
        ],
      ),
      
      drawer: Drawer(
        child: Container(
          color: Colors.black,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Task Button
              GestureDetector(
                onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const AboutUs()),
                    );
                  },
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[800],
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        "Task",
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                      SizedBox(width: 150),
                      Icon(Icons.arrow_forward_ios, color: Colors.white, size: 16),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16), 
              const Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "About",
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                  SizedBox(width: 180),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}