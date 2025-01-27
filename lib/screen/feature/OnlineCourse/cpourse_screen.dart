import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'CourseController.dart';

class CourseListView extends StatefulWidget {
  @override
  State<CourseListView> createState() => _CourseListViewState();
}

class _CourseListViewState extends State<CourseListView> {
  // Correctly formatted input string with escaped double quotes
  final String input =
      "Provide the top 10 React courses as a valid JSON array. Each course should include the following fields: "
      "\"name\" (the name of the course), "
      "\"urlLink\" (a URL link to access the course). "
      "\"content\" (a URL pointing to the course image), "
      "Ensure the response is a valid JSON string without any additional text, formatting, or characters outside the JSON structure.";



  late CourseController courseController;

  @override
  void initState() {
    super.initState();
    // Initialize and fetch courses
    courseController = Get.put(CourseController());
    courseController.fetchCourses(input);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Courses'),
      ),
      body: Obx(() {
        if (courseController.isLoading.value ) {
          return Center(child: CircularProgressIndicator());
        } else if (courseController.errorMessage.value.isNotEmpty) {
          return Center(
              child: Text('Error: ${courseController.errorMessage.value}'));
        } else if (courseController.courses.isEmpty) {
          return Center(child: Text('No courses available.'));
        }
        return ListView.builder(
          itemCount: courseController.courses.length,
          itemBuilder: (context, index) {
            final course = courseController.courses[index];
            return Card(
              margin: EdgeInsets.all(8.0),
              child: ListTile(
                title: Text(course.name),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(course.content),
                    Text(course.urlLink, style: TextStyle(color: Colors.blue)),
                  ],
                ),
              ),
            );
          },
        );
      }),
    );
  }
}