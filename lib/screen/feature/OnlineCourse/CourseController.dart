import 'package:get/get.dart';
import '../../../ApiService/api_service.dart';
import 'Model/CourseModel.dart';

class CourseController extends GetxController {
  // Observable list of courses
  var courses = <CourseModel>[].obs;
  // Observable loading state
  var isLoading = true.obs;
  // Observable error message
  var errorMessage = ''.obs;

  // Fetch courses from the API
  Future<void> fetchCourses(String input) async {
    isLoading.value = true; // Set loading to true

    try {
      // Fetch courses using the ApiService
      var fetchedCourses = await ApiService().fetchCourses(input);
      courses.assignAll(fetchedCourses); // Update the courses list
      errorMessage.value = ''; // Clear any previous error
    } catch (e) {
      errorMessage.value = e.toString(); // Set the error message
      courses.clear(); // Clear courses on error
    } finally {
      isLoading.value = false; // Set loading to false
    }
  }
}