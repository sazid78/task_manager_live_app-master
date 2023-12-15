import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:task_manager_live_app/UI/controller/inProgress_task_controller.dart';
import 'package:task_manager_live_app/widgets/profile_summery_card.dart';
import 'package:task_manager_live_app/widgets/task_item_card.dart';

class ProgressTaskScreen extends StatefulWidget {
  const ProgressTaskScreen({Key? key}) : super(key: key);

  @override
  State<ProgressTaskScreen> createState() => _ProgressTaskScreenState();
}

class _ProgressTaskScreenState extends State<ProgressTaskScreen> {


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Get.find<InProgressTaskController>().getProgressTaskList();
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Column(
      children: [
        const ProfileSummeryCard(),
        Expanded(
          child: GetBuilder<InProgressTaskController>(
            builder: (inProgressTaskController) {
              return Visibility(
                visible: inProgressTaskController.getProgressTaskInProgress == false,
                replacement: const Center(
                  child: CircularProgressIndicator(),
                ),
                child: RefreshIndicator(
                  onRefresh: () async{
                    inProgressTaskController.getProgressTaskList();
                  },
                  child: ListView.builder(
                      itemCount: inProgressTaskController.taskListModel.taskList?.length ?? 0,
                      itemBuilder: (context, index) {
                        return TaskItemCard(
                          task: inProgressTaskController.taskListModel.taskList![index],
                          onStatusChange: (){
                            inProgressTaskController.getProgressTaskList();
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
