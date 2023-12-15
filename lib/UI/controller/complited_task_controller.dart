import 'package:get/get.dart';
import 'package:task_manager_live_app/data.network_caller/models/task_list_model.dart';
import 'package:task_manager_live_app/data.network_caller/network_caller.dart';
import 'package:task_manager_live_app/data.network_caller/network_response.dart';
import 'package:task_manager_live_app/data.network_caller/utility/urls.dart';

class ComplitedTaskController extends GetxController{

  bool _getComplitedTaskInProgress = false;
  TaskListModel _taskListModel = TaskListModel();

  bool get getComplitedTaskInProgress => _getComplitedTaskInProgress;
  TaskListModel get taskListModel => _taskListModel;

  Future<bool> getComplitedTaskList() async{
    bool isSuccess = false;
    _getComplitedTaskInProgress = true;
    update();
    final NetworkResponse response = await NetworkCaller().getRequest(Urls.getComplitedTask);
    _getComplitedTaskInProgress = false;


    if(response.isSuccess){
      _taskListModel = TaskListModel.fromJson(response.jsonResponse);
      isSuccess = true;
    }
    update();
    return isSuccess;
  }
}