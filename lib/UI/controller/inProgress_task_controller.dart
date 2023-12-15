import 'package:get/get.dart';
import 'package:task_manager_live_app/data.network_caller/models/task_list_model.dart';
import 'package:task_manager_live_app/data.network_caller/network_caller.dart';
import 'package:task_manager_live_app/data.network_caller/network_response.dart';
import 'package:task_manager_live_app/data.network_caller/utility/urls.dart';

class InProgressTaskController extends GetxController{

  bool _getProgressTaskInProgress = false;
  TaskListModel _taskListModel = TaskListModel();

  bool get getProgressTaskInProgress => _getProgressTaskInProgress;
  TaskListModel get taskListModel => _taskListModel;

  Future<bool> getProgressTaskList() async{
    bool isSuccess = false;
    _getProgressTaskInProgress = true;
    update();
    final NetworkResponse response = await NetworkCaller().getRequest(Urls.getProgressTask);
    _getProgressTaskInProgress = false;
    if(response.isSuccess){
      _taskListModel = TaskListModel.fromJson(response.jsonResponse);
      isSuccess =  true;
    }
    update();
    return isSuccess;
  }
}