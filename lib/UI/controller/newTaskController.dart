import 'package:get/get.dart';
import 'package:task_manager_live_app/data.network_caller/models/task_list_model.dart';
import 'package:task_manager_live_app/data.network_caller/network_caller.dart';
import 'package:task_manager_live_app/data.network_caller/network_response.dart';
import 'package:task_manager_live_app/data.network_caller/utility/urls.dart';

class NewTaskController extends GetxController{
  bool _getNewTaskInProgress = false;

  TaskListModel _taskListModel = TaskListModel();

  bool get getTaskInProgress => _getNewTaskInProgress;
  TaskListModel get taskListModel => _taskListModel;

  Future<bool> getNewTaskList() async{
    bool isSuccess = false;
    _getNewTaskInProgress = true;
    update();
    final NetworkResponse response = await NetworkCaller().getRequest(Urls.getNewTask);
    _getNewTaskInProgress = false;
    if(response.isSuccess){
      _taskListModel = TaskListModel.fromJson(response.jsonResponse);
      isSuccess = true;
    }
    update();
    return isSuccess;
  }
}