import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:newnew/modules/user_authentication/login_screen.dart';
import 'package:newnew/shared/components/components.dart';
import 'package:newnew/shared/style/colors.dart';
import 'package:newnew/shared/style/icon_broken.dart';
import '../../shared/bloc/login_register_cubit/login_cubit.dart';
import '../../shared/bloc/login_register_cubit/login_state.dart';


class ResetPasswordScreen extends StatelessWidget {
  var formKey = GlobalKey<FormState>();
  var configPasswordController = TextEditingController();
  var passwordController = TextEditingController();
  late String myCode ;
  ResetPasswordScreen(this.myCode, {Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {


    AppBar appBar = AppBar(
      backgroundColor: Colors.white,
    );
    return BlocConsumer<LoginCubit, LoginState>(
  listener: (context, state) {
    if(state is ResetPasswordSuccessState){
      if(state.resetPasswordDataModel.status == "success"){
        Fluttertoast.showToast(
          msg:state.resetPasswordDataModel.message!,
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 2,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0,

        ).then((value) {

          navigateToAndRemove(context,LoginScreen());

        }).catchError((error){
          print(error.toString());
        });
      }
      if(state.resetPasswordDataModel.status == "fail"){
        Fluttertoast.showToast(
          msg:state.resetPasswordDataModel.message!,
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
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: appBar,
      body: SingleChildScrollView(
        child: Form(
          key:formKey,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: [
                Text('Create New Password',
                  style: TextStyle(color: defaultColor, fontSize: 20),),
                const SizedBox(height: 40,),
                const Text('you will use this password to access your account Enter a combination  of at least six number,letters,and punctuation marks.',
                  style: TextStyle(color: Colors.black, fontSize: 15),),
                const SizedBox(height: 20,),

                defaultFormField2(
                    controller: passwordController,
                    hint: 'Password',
                    prefix: IconBroken.Lock,
                    type: TextInputType.visiblePassword,
                    validate: (value){
                      if(value!.isEmpty){
                        return 'password must not be empty';
                      }
                      return null;
                    },
                    onChange: (value) {
                      // print(value);
                    },
                    oSubmit: (value) {
                      //  print(value);
                    },
                    suffix:cubit.registerIsPassword ?IconBroken.Hide : IconBroken.Show ,
                    isPassword: cubit.registerIsPassword ,
                    suffixPressed: (){
                      cubit.changeRegisterPassword();
                    }
                ),
                const SizedBox(height: 20,),

                defaultFormField2(
                    controller: configPasswordController,
                    hint: 'ConfirmPassword',
                    prefix: IconBroken.Lock,
                    type: TextInputType.visiblePassword,
                    validate: (value){
                      if(value!.isEmpty){
                        return 'Confirm password must not be Empty';
                      }
                      if(configPasswordController.text != passwordController.text){
                        return 'Confirm password not as Password';
                      }
                      return null;
                    },
                    onChange: (value) {
                      // print(value);
                    },
                    oSubmit: (value) {
                      //  print(value);
                    },
                    suffix:cubit.confirmIsPassword ?IconBroken.Hide : IconBroken.Show ,
                    isPassword: cubit.confirmIsPassword ,
                    suffixPressed: (){
                      cubit.changeConfirmRegisterPassword();
                    }
                ),
                const SizedBox(height: 20,),
                defaultButton(
                  isUpperCase: false,

                  function: () {
                    if (formKey.currentState!.validate()) {

                      cubit.resetPasswordPatchData(
                          code: myCode,
                          newPassword: passwordController.text,
                          passwordConfirm: configPasswordController.text);

                    }
                  },
                  text: "Submit",
                  style: const TextStyle(color: Colors.white),
                ),
                const SizedBox(height: 20,),
                if(state is ResetPasswordLoadingState)
                  LinearProgressIndicator(color: defaultColor,),
              ],
            ),
          ),
        ),
      ),
    );
  },
);
  }
}
