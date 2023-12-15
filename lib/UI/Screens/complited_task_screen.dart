import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager_live_app/UI/controller/complited_task_controller.dart';
import 'package:task_manager_live_app/data.network_caller/models/task_list_model.dart';
import 'package:task_manager_live_app/data.network_caller/network_caller.dart';
import 'package:task_manager_live_app/data.network_caller/network_response.dart';
import 'package:task_manager_live_app/data.network_caller/utility/urls.dart';
import 'package:task_manager_live_app/widgets/profile_summery_card.dart';
import 'package:task_manager_live_app/widgets/task_item_card.dart';

class ComplitedTaskScreen extends StatefulWidget {
  const ComplitedTaskScreen({Key? key}) : super(key: key);

  @override
  State<ComplitedTaskScreen> createState() => _ComplitedTaskScreenState();
}

class _ComplitedTaskScreenState extends State<ComplitedTaskScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Get.find<ComplitedTaskController>().getComplitedTaskList();
  }


  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Column(
      children: [
        const ProfileSummeryCard(),
        Expanded(
          child: GetBuilder<ComplitedTaskController>(
            builder: (complitedTaskController) {
              return Visibility(
                visible: complitedTaskController.getComplitedTaskInProgress == false,
                replacement: const Center(
                  child: CircularProgressIndicator(),
                ),
                child: RefreshIndicator(
                  onRefresh: () async{
                    complitedTaskController.getComplitedTaskList();
                  },
                  child: ListView.builder(
                      itemCount: complitedTaskController.taskListModel.taskList?.length ?? 0,
                      itemBuilder: (context, index) {
                        return TaskItemCard(
                          task: complitedTaskController.taskListModel.taskList![index],
                          onStatusChange: (){
                            complitedTaskController.getComplitedTaskList();
                          },
                          showProgress: (inProgress){
                          },
                        );
                      }),
                ),
              );
            }
          ),
        ),
      ],
    ));
  }
}
