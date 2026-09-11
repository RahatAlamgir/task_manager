class Urls {
  static String baseURL = 'https://task-manager-api.ostad.live/api/v1';
  static String signUpURL = '$baseURL/Registration';
  static String loginURL = '$baseURL/Login';
  static String taskStatusCountURL = '$baseURL/taskStatusCount';
  static String taskListByStatusURL(String status) =>
      '$baseURL/listTaskByStatus/$status';
  static String deleteURL(String id) => '$baseURL/deleteTask/$id';

  static String addNewTaskURL = '$baseURL/createTask';

  static String updateTaskStatusURL(String ID, String status) =>
      '$baseURL/updateTaskStatus/$ID/$status';

  static String ProfileUpdateURL = '$baseURL/ProfileUpdate';
}
