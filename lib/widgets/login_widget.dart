import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:habit_tracker/core/constants/app_style_constants.dart';
import 'package:habit_tracker/cubit/login_cubit.dart';
import 'package:habit_tracker/cubit/login_state.dart';
import 'package:habit_tracker/pages/habit_home.dart';

class LoginWidget extends StatefulWidget {
  const LoginWidget({super.key});

  @override
  State<LoginWidget> createState() => _LoginWidgetState();
}

class _LoginWidgetState extends State<LoginWidget> {
  final _userNameController = TextEditingController();
  final _passWordController = TextEditingController();

// ignore_for_file: prefer_final_fields
bool _passwordObscureText = true;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final loginCubit = BlocProvider.of<LoginCubit>(context);
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        children: [
          Row(
            children: [
              // IconButton(onPressed: () {}, icon: Icon(Icons.arrow_back)),
              SizedBox(width: 20.0),
              Text("Login / Signup", style: AppStyle.appbarTitle()),
            ],
          ),
          SizedBox(height: 50.0),
          BlocListener<LoginCubit, LoginState>(
            listener: (BuildContext context, LoginState state) {
              if(state is LoginErrorState){
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                   behavior: SnackBarBehavior.floating,
                    margin: EdgeInsets.all(8.0),
                    content: Text(state.msg),
                    duration: Duration(seconds: 1), // Optional: set duration
                  ),
                );
              }

            },
            child: Expanded(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Card(
                      elevation: 8,
                      shadowColor: Colors.black,
                      color: Colors.white,
                      child: Padding(
                        padding: const EdgeInsets.all(24.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Login", style: AppStyle.labelText()),
                            SizedBox(height: 24.0),
                            // user name field
                            Text("Name", style: AppStyle.fieldLabelText()),
                            SizedBox(height: 12.0),
                            TextField(
                              controller: _userNameController,
                              decoration: InputDecoration(
                                hintStyle: AppStyle.hintText(),
                                contentPadding: EdgeInsets.all(4.0),
                                prefixIcon: IconButton(
                                  onPressed: () {},
                                  icon: Icon(Icons.person),
                                ),

                                hintText: "User Name",
                              ),
                            ),
                            SizedBox(height: 24.0),
                            // password field
                            Text("Password",


                                style: AppStyle.fieldLabelText()),
                            SizedBox(height: 12.0),
                            TextField(
                              obscureText:_passwordObscureText ,
                              controller: _passWordController,
                              decoration: InputDecoration(
                                hintText: "Password",
                                hintStyle: AppStyle.hintText(),
                                suffixIcon: IconButton(
                                  onPressed: (){},
                                  icon: Icon(_passwordObscureText ?
                                  Icons.visibility_off : Icons.visibility),
                                ),
                                prefixIcon: IconButton(
                                  onPressed: () {},
                                  icon: Icon(Icons.password),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 24),
                    Align(
                      alignment: AlignmentDirectional.centerEnd,
                      child: ElevatedButton(
                        onPressed: () => loginCubit.userLogin(
                          userName: _userNameController.text,
                          password: _passWordController.text,
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text("LOG IN", style: AppStyle.buttonText()),
                        ),
                      ),
                    ),
                    SizedBox(height: 48),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Don't have an account",
                          style: AppStyle.normalText(),
                        ),
                        TextButton(
                          onPressed: () {},
                          child: Text(
                            "Sign Up",
                            style: AppStyle.normalText(
                              fontSize: 16,
                              color: Colors.blue,
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
