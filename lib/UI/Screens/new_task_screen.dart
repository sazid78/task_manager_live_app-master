import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:http/http.dart';
import 'package:task_manager_live_app/UI/Screens/add_new_task_screen.dart';
import 'package:task_manager_live_app/UI/controller/newTaskController.dart';
import 'package:task_manager_live_app/data.network_caller/models/task_count.dart';
import 'package:task_manager_live_app/data.network_caller/models/task_list_model.dart';
import 'package:task_manager_live_app/data.network_caller/models/task_summery_count_list_model.dart';
import 'package:task_manager_live_app/data.network_caller/network_caller.dart';
import 'package:task_manager_live_app/data.network_caller/network_response.dart';
import 'package:task_manager_live_app/data.network_caller/utility/urls.dart';
import 'package:task_manager_live_app/widgets/profile_summery_card.dart';
import 'package:task_manager_live_app/widgets/summery_card.dart';
import 'package:task_manager_live_app/widgets/task_item_card.dart';

class NewTaskScreen extends StatefulWidget {
  const NewTaskScreen({Key? key}) : super(key: key);

  @override
  State<NewTaskScreen> createState() => _NewTaskScreenState();
}

class _NewTaskScreenState extends State<NewTaskScreen> {

  bool getTaskCountSummeryInProgress = false;
  TaskSummeryCountListModel taskSummeryCountListModel = TaskSummeryCountListModel();

  Future<void> getTaskCountSummaryList() async{
    getTaskCountSummeryInProgress = true;
    if(mounted){
      setState(() {

      });
    }
    final NetworkResponse response = await NetworkCaller().getRequest(Urls.getTaskSummeryCount);

    if(response.isSuccess){
      taskSummeryCountListModel = TaskSummeryCountListModel.fromJson(response.jsonResponse);
    }
    getTaskCountSummeryInProgress = false;
    if(mounted){
      setState(() {

      });
    }
  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
        Get.find<NewTaskController>().getNewTaskList();
        getTaskCountSummaryList();

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton:   FloatingActionButton(onPressed: (){
        Navigator.push(context, MaterialPageRoute(builder: (context) => AddNewTaskScreen()));
      },child: Icon(Icons.add),),
        body: SafeArea(
      child: Column(
        children: [
          ProfileSummeryCard(),
          Visibility(
              visible: getTaskCountSummeryInProgress == false && (taskSummeryCountListModel.taskCountList?.isNotEmpty ?? false),
              replacement: const LinearProgressIndicator(),
              child: SizedBox(
                height: 120,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: taskSummeryCountListModel.taskCountList?.length ?? 0,
                    itemBuilder: (context,index){
                    TaskCount taskCount = taskSummeryCountListModel.taskCountList![index];

                    return SummeryCard(
                        count: taskCount.sum.toString(),
                        title: taskCount.sId ?? "");
          }),
              )),
          Expanded(
            child: GetBuilder<NewTaskController>(
              builder: (newTaskController) {
                return Visibility(
                  visible: newTaskController.getTaskInProgress == false,
                  replacement: const Center(
                    child: CircularProgressIndicator(),
                  ),
                  child: RefreshIndicator(
                    onRefresh: () async{
                      newTaskController.getNewTaskList();
                    },
                    child: ListView.builder(
                      itemCount: newTaskController.taskListModel.taskList?.length ?? 0,
                        itemBuilder: (context, index) {
                      return TaskItemCard(
                        task: newTaskController.taskListModel.taskList![index],
                        onStatusChange: (){
                          newTaskController.getNewTaskList();
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
      ),
    ));
  }
}


