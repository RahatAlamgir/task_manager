import 'package:task_manager/model/api_response.dart';
import 'package:task_manager/model/task_model.dart';
import 'package:task_manager/model/task_status_count_model.dart';
import 'package:task_manager/services/api_caller.dart';
import 'package:task_manager/utils/urls.dart';

class TaskController {
  static List<TaskStatusCountModel> taskStatusCount = [];
  static List<TaskModel> taskList = [];
  static List<TaskModel> allTaskList = [];

  static Future<void> getTaskStatusCount() async {
    ApiResponse response = await ApiCaller.getRequest(
      url: Urls.taskStatusCountURL,
    );
    List<TaskStatusCountModel> taskCount = [];

    print('taskCount status ====== ${response.isSuccess}');

    if (response.isSuccess) {
      for (Map<String, dynamic> jsonData in response.responseData['data']) {
        taskCount.add(TaskStatusCountModel.fromJson(jsonData));
      }
      taskStatusCount = taskCount;
    }
  }

  static Future<void> getTaskListByStatus(String status) async {
    ApiResponse response = await ApiCaller.getRequest(
      url: Urls.taskListByStatusURL(status),
    );
    List<TaskModel> tasks = [];

    print('taskList status [$status]====== ${response.isSuccess}');

    if (response.isSuccess) {
      for (Map<String, dynamic> jsonData in response.responseData['data']) {
        tasks.add(TaskModel.fromJson(jsonData));
      }
      taskList = tasks;
    }
  }

  static Future<void> getAllTaskList() async {
    List<TaskModel> tasks = [];
    ApiResponse response = await ApiCaller.getRequest(
      url: Urls.taskListByStatusURL('New'),
    );

    if (response.isSuccess) {
      for (Map<String, dynamic> jsonData in response.responseData['data']) {
        tasks.add(TaskModel.fromJson(jsonData));
      }
    }
    response = await ApiCaller.getRequest(
      url: Urls.taskListByStatusURL('In Progress'),
    );

    if (response.isSuccess) {
      for (Map<String, dynamic> jsonData in response.responseData['data']) {
        tasks.add(TaskModel.fromJson(jsonData));
      }
    }
    response = await ApiCaller.getRequest(
      url: Urls.taskListByStatusURL('Completed'),
    );

    if (response.isSuccess) {
      for (Map<String, dynamic> jsonData in response.responseData['data']) {
        tasks.add(TaskModel.fromJson(jsonData));
      }
    }

    allTaskList = tasks;
  }
}
