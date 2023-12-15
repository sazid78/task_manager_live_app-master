import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:task_manager_live_app/UI/controller/authentication_controller.dart';
import 'package:task_manager_live_app/data.network_caller/models/user_model.dart';
import 'package:task_manager_live_app/data.network_caller/network_caller.dart';
import 'package:task_manager_live_app/data.network_caller/network_response.dart';
import 'package:task_manager_live_app/data.network_caller/utility/urls.dart';

class LoginController extends GetxController{
  bool _loginInProgress = false;
  String _failureMassage = '';

  bool get loginInProgress => _loginInProgress;

  String get failureMassage => _failureMassage;

  Future<bool> login(String email, String password) async {
    _loginInProgress = true;
    update();
    NetworkResponse response = await NetworkCaller().postRequest(Urls.login,
        body: {
          "email": email,
          "password": password
        }, isLogin: true);
    _loginInProgress = false;
    update();
    if (response.isSuccess) {
      await AuthenticationController.saveUserInformation(
          response.jsonResponse["token"], UserModel.fromJson(response.jsonResponse["data"]));
      return true;
    } else {
      if (response.statusCode == 401) {
        _failureMassage = 'Please check email/password';
      } else {
        _failureMassage = 'Login Failed, Try again!';
      }
    }
    return false;
  }
}