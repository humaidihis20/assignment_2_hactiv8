import 'package:flutter/material.dart';

class DetailPage extends StatelessWidget {
  final String title;
  final String description;
  final String startDate;
  final String endDate;
  final String imagePath;
  final List<Map<String, dynamic>> tasks;
  final List<Map<String, dynamic>> comments;

  const DetailPage({
    required this.title,
    required this.description,
    required this.startDate,
    required this.endDate,
    required this.imagePath,
    required this.tasks,
    required this.comments,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 250, 247, 247),
        title: Text(
          title,
          style: const TextStyle(color: Color.fromARGB(255, 1, 0, 0)),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              color: Colors.black,
              child: Column(
                children: [
                  Image.asset(
                    imagePath,
                    width: double.infinity,
                    height: 200,
                    fit: BoxFit.cover,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      title,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "$startDate — $endDate",
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
              ),
            ),
            
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                description,
                style: const TextStyle(fontSize: 16),
              ),
            ),
            
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                "List of Tasks",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            ListView(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              children: tasks
                  .map((task) => ListTile(
                        leading: Icon(
                          task['status'] == true
                              ? Icons.check_circle
                              : Icons.check_circle_outline,
                          color: task['status'] == true
                              ? Colors.green
                              : Colors.red,
                        ),
                        title: Text(task['title']!),
                      ))
                  .toList(),
            ),
            
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                "List of Comments",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            ListView(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              children: comments
                  .map((comment) => ListTile(
                        leading: const Icon(Icons.comment, color: Colors.black),
                        title: Text(comment['text']!),
                        subtitle: Text(comment['time']),
                      ))
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }
}