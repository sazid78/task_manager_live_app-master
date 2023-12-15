import 'package:get/get.dart';
import 'package:task_manager_live_app/data.network_caller/models/task_list_model.dart';
import 'package:task_manager_live_app/data.network_caller/network_caller.dart';
import 'package:task_manager_live_app/data.network_caller/network_response.dart';
import 'package:task_manager_live_app/data.network_caller/utility/urls.dart';

class CancelledTaskController extends GetxController{

  bool _getCancelledTaskInProgress = false;
  TaskListModel _taskListModel = TaskListModel();

  bool get getCancelledTaskInProgress => _getCancelledTaskInProgress;
  TaskListModel get taskListModel => _taskListModel;

  Future<bool> getCancelledTaskList() async{
    bool isSuccess = false;
    _getCancelledTaskInProgress = true;
    update();
    final NetworkResponse response = await NetworkCaller().getRequest(Urls.getCancelledTask);
    _getCancelledTaskInProgress = false;


    if(response.isSuccess){
      _taskListModel = TaskListModel.fromJson(response.jsonResponse);
      isSuccess = true;
    }
    update();
    return isSuccess;
  }
}