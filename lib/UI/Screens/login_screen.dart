import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/instance_manager.dart';
import 'package:task_manager_live_app/UI/Screens/forgot_password_screen.dart';
import 'package:task_manager_live_app/UI/Screens/main_bottom_nav_screen.dart';
import 'package:task_manager_live_app/UI/Screens/sign_up_screen.dart';
import 'package:task_manager_live_app/UI/controller/login_controller.dart';
import 'package:task_manager_live_app/widgets/body_background.dart';
import 'package:task_manager_live_app/widgets/snack_message.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController _emailTEcontroller = TextEditingController();
  TextEditingController _passwordTEcontroller = TextEditingController();
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final LoginController _loginController = Get.find<LoginController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BodyBackground(
            child: SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 80,
                ),
                Text("Get Started with",
                    style: Theme.of(context).textTheme.titleLarge),
                const SizedBox(
                  height: 24,
                ),
                TextFormField(
                  controller: _emailTEcontroller,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    hintText: "Email",
                  ),
                  validator: (String? value) {
                    if (value!.isEmpty ||
                        !RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w]{2,4}')
                            .hasMatch(value!)) {
                      return "Enter your valid email address";
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 16,
                ),
                TextFormField(
                  controller: _passwordTEcontroller,
                  obscureText: true,
                  decoration: InputDecoration(
                    hintText: "Password",
                  ),
                  validator: (String? value) {
                    if (value?.isEmpty ?? true) {
                      return "Enter Password";
                    }
                    if (value!.length < 6) {
                      return "Password length at least 6 disit";
                    } else {
                      return null;
                    }
                  },
                ),
                const SizedBox(
                  height: 24,
                ),
                SizedBox(
                  width: double.infinity,
                  child: GetBuilder<LoginController>(
                    builder: (LoginController){
                      return Visibility(
                        visible: LoginController.loginInProgress == false,
                        replacement: const Center(
                          child: CircularProgressIndicator(),
                        ),
                        child: ElevatedButton(
                            onPressed: login,
                            child: Icon(Icons.arrow_circle_right_outlined)),
                      );
                    },
                  ),
                ),
                const SizedBox(
                  height: 45,
                ),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ForgotPasswordScreen()));
                  },
                  child: Center(
                    child: Text(
                      "Forgot Password?",
                      style: TextStyle(color: Colors.grey, fontSize: 16),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Don't have an account?",
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.black54),
                    ),
                    TextButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SignUpScreen()));
                        },
                        child: Text(
                          "Sign Up",
                          style: TextStyle(fontSize: 16),
                        ))
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    )));
  }

  Future<void> login() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    final response = await _loginController.login(_emailTEcontroller.text.trim(), _passwordTEcontroller.text);
    if (response) {
     Get.offAll(const MainBottomNavScreen());
    } else {
        if (mounted) {
          SnackMessage(context, _loginController.failureMassage);
        }
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _emailTEcontroller.dispose();
    _passwordTEcontroller.dispose();
    super.dispose();
  }
}
