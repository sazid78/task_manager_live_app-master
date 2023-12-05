import 'package:flutter/material.dart';
import 'package:task_manager_live_app/data.network_caller/models/task_list_model.dart';
import 'package:task_manager_live_app/data.network_caller/network_caller.dart';
import 'package:task_manager_live_app/data.network_caller/network_response.dart';
import 'package:task_manager_live_app/data.network_caller/utility/urls.dart';
import 'package:task_manager_live_app/widgets/profile_summery_card.dart';
import 'package:task_manager_live_app/widgets/task_item_card.dart';

class ProgressTaskScreen extends StatefulWidget {
  const ProgressTaskScreen({Key? key}) : super(key: key);

  @override
  State<ProgressTaskScreen> createState() => _ProgressTaskScreenState();
}

class _ProgressTaskScreenState extends State<ProgressTaskScreen> {

  bool getProgressTaskInProgress = false;
  TaskListModel taskListModel = TaskListModel();
  Future<void> getProgressTaskList() async{
    getProgressTaskInProgress = true;

    if(mounted){
      setState(() {

      });
    }
    final NetworkResponse response = await NetworkCaller().getRequest(Urls.getProgressTask);

    if(response.isSuccess){
      taskListModel = TaskListModel.fromJson(response.jsonResponse);
    }
    getProgressTaskInProgress = false;
    if(mounted){
      setState(() {

      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getProgressTaskList();
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Column(
      children: [
        const ProfileSummeryCard(),
        Expanded(
          child: Visibility(
            visible: getProgressTaskInProgress == false,
            replacement: const Center(
              child: CircularProgressIndicator(),
            ),
            child: RefreshIndicator(
              onRefresh: () async{
                getProgressTaskList();
              },
              child: ListView.builder(
                  itemCount: taskListModel.taskList?.length ?? 0,
                  itemBuilder: (context, index) {
                    return TaskItemCard(
                      task: taskListModel.taskList![index],
                      onStatusChange: (){
                        getProgressTaskList();
                      },
                      showProgress: (inProgress){
                        if(mounted){
                          setState(() {

                          });
                        }
                      },
                    );
                  }),
            ),
          ),
        ),
      ],
    ));
  }
}
