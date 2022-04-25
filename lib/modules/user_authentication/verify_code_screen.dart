import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:newnew/modules/user_authentication/reset_password_screen.dart';
import 'package:newnew/shared/components/components.dart';
import 'package:newnew/shared/style/colors.dart';
import 'package:newnew/shared/style/icon_broken.dart';
import '../../shared/bloc/login_register_cubit/login_cubit.dart';
import '../../shared/bloc/login_register_cubit/login_state.dart';




class VerifyCodeScreen extends StatelessWidget {
  String myEmail = '';
  var formKey = GlobalKey<FormState>();
  var codeController = TextEditingController();
  VerifyCodeScreen(this.myEmail, {Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {

    return BlocConsumer<LoginCubit, LoginState>(
      listener: (context, state) {

        if(state is VerifyCodeSuccessState){
          if(state.verifyCodeDataModel.status == "success"){
            Fluttertoast.showToast(
              msg:state.verifyCodeDataModel.message!,
              toastLength: Toast.LENGTH_LONG,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 2,
              backgroundColor: Colors.green,
              textColor: Colors.white,
              fontSize: 16.0,

            ).then((value) {

             navigateToAndRemove(context,ResetPasswordScreen(codeController.text) );

            }).catchError((error){
              print(error.toString());
            });
          }
          if(state.verifyCodeDataModel.status == "fail"){
            Fluttertoast.showToast(
              msg:state.verifyCodeDataModel.message!,
              toastLength: Toast.LENGTH_LONG,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 2,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16.0,
            );
          }
        }

      },

      builder: (context, state) {
        LoginCubit cubit = LoginCubit.get(context);

        return GestureDetector(
          onTap: (){
            FocusScope.of(context).unfocus();
          },
          child: Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(backgroundColor: Colors.white,),
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Form(
                  key: formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [

                      Text('Enter Code we sent to',
                        style: TextStyle(color: defaultColor, fontSize: 20),),
                      const SizedBox(height: 8,),
                      Text(myEmail,
                        style: TextStyle(
                          color: defaultColor,
                          fontSize: 18,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,

                      ),
                      const SizedBox(height: 40,),
                      const Text('We sent a 6-digit code to your email address enter that code to reset your password.',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                        ),
                        maxLines: 5,
                        overflow: TextOverflow.ellipsis,

                      ),
                      const SizedBox(height: 20,),
                      defaultFormField2(
                        type: TextInputType.emailAddress,
                        prefix: IconBroken.Password,
                        hint: 'Code',
                        controller: codeController,
                        validate: (value) {
                          if (value!.isEmpty) {
                            return 'code must not be empty';
                          }
                          if (codeController.text.length < 6) {
                            return 'code must not be less than 6 digit';
                          }
                          return null;

                        },

                      ),
                      const SizedBox(height: 20,),
                      defaultButton(
                          isUpperCase: false,

                          function: () {
                            if (formKey.currentState!.validate()) {
                              // navigateTo(context, ResetPasswordScreen());
                              cubit.verifyCodePostData(code: codeController.text);
                            }
                          },
                          text: "Continue",
                          style: const TextStyle(color: Colors.white),
                        ),

                      const SizedBox(height: 20,),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          defaultButton(
                            width: 205,
                            height: 50,
                            icon: IconBroken.Send,
                            iconColor: defaultColor,
                            background: Colors.white,
                            function: () {
                              cubit.forgetPasswordPostData(email: myEmail);
                              },
                            text: "Sent code again",
                            isUpperCase: false,
                            style:  TextStyle(color: defaultColor),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10,),
                      if(state is ForgetPasswordLoadingState|| state is VerifyCodeLoadingState)
                        LinearProgressIndicator(color: defaultColor,),
                    ],
                  ),
                ),
              ),
            ),

          ),
        );
      },
    );
  }
}
