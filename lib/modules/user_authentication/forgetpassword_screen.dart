import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:newnew/modules/user_authentication/verify_code_screen.dart';
import 'package:newnew/shared/bloc/login_register_cubit/login_cubit.dart';
import 'package:newnew/shared/bloc/login_register_cubit/login_state.dart';
import 'package:newnew/shared/components/components.dart';
import 'package:newnew/shared/style/colors.dart';
import 'package:newnew/shared/style/icon_broken.dart';

class ForgetPassword extends StatelessWidget {
  var myEmail = "";
  var emailController = TextEditingController();
  var formKey = GlobalKey<FormState>();


  ForgetPassword(this.myEmail, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    
    return BlocConsumer<LoginCubit, LoginState>(
      listener: (context, state) {
        if(state is ForgetPasswordSuccessState){
          if(state.forgetPasswordDataModel.status == "success"){
            Fluttertoast.showToast(
              msg:state.forgetPasswordDataModel.message!,
              toastLength: Toast.LENGTH_LONG,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 2,
              backgroundColor: Colors.green,
              textColor: Colors.white,
              fontSize: 16.0,

            ).then((value) {

              navigateToAndRemove(context, VerifyCodeScreen(emailController.text));

            }).catchError((error){
                print(error);
            });
          }
          if(state.forgetPasswordDataModel.status == "fail"){
            Fluttertoast.showToast(
              msg:state.forgetPasswordDataModel.message!,
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
        emailController.text=myEmail;
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
                      const Image(
                        image: AssetImage('assets/images/forgetpassword.png'),
                        width: 220, height: 220,),
                      Text('Reset Password',
                        style: TextStyle(color: defaultColor, fontSize: 25),),
                      const SizedBox(height: 16,),
                      const Text('Enter the email associated with your '
                          'account and we will sent you a code to reset your password',
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
                        prefix: IconBroken.Message,
                        hint: 'Email',
                        controller: emailController,
                        validate: (value) {
                          if (value!.isEmpty) {
                            return 'Email must not be empty';
                          }
                          return null;
                        },

                      ),
                      const SizedBox(height: 20,),
                      ConditionalBuilder(
                        builder: (BuildContext context)=>defaultButton(
                          function: () {
                            if (formKey.currentState!.validate()) {
                              cubit.forgetPasswordPostData(email: emailController.text);
                            }
                          },
                          text: "Sent code",
                          style: const TextStyle(color: Colors.white),
                          //   width: 190,
                          // height: 50

                        ), fallback: (BuildContext context) => LinearProgressIndicator(color: defaultColor,),
                        condition: state is ! ForgetPasswordLoadingState,
                      ),
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
