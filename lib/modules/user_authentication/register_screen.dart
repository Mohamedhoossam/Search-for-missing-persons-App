import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:newnew/shared/bloc/login_register_cubit/login_cubit.dart';
import 'package:newnew/shared/style/colors.dart';
import 'package:newnew/shared/style/icon_broken.dart';
import 'package:newnew/shared/components/components.dart';
import '../../shared/bloc/login_register_cubit/login_state.dart';
import 'login_screen.dart';




// ignore: must_be_immutable
class RegisterScreen extends StatelessWidget {

  var emailController =TextEditingController();
  var nameController =TextEditingController();
  var configPasswordController =TextEditingController();
  var passwordController =TextEditingController();
  var formKey = GlobalKey<FormState>();
  bool isPassword = true;

  RegisterScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final appBar=AppBar(
      backgroundColor: Colors.white,
      elevation: 0.0,
      leading: IconButton(
        icon:  Icon(IconBroken.Arrow___Left,color: defaultColor,),
        color: Colors.black,
        onPressed: (){
          Navigator.pop(context);
        },
      ),
    );
    final Size size =MediaQuery.of(context).size;
    return BlocConsumer<LoginCubit, LoginState>(
  listener: (context, state) {
    if(state is SignupSuccessState){
      if(state.registerDataModel.status == "success"){
        Fluttertoast.showToast(
          msg:state.registerDataModel.message!,
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 2,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0,

        );
      }
      if(state.registerDataModel.status == "fail"){
        Fluttertoast.showToast(
          msg:state.registerDataModel.message!,
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
    onTap:() {
      FocusScope.of(context).unfocus();
    },
    child: Container(
      color: Colors.white,

      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: appBar,
        body: Padding(
          padding: const EdgeInsets.all(14.0),
          child: Form(
            key: formKey,
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                   const Text(
                    'Let\'s Get Started!',
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.black

                    ),
                  ),
                  const Text(
                    'Create an account to Missing to get all features',
                    style: TextStyle(
                        fontSize: 11.35,
                        color: Colors.grey
                    ),
                  ),
                   SizedBox(
                    height: size.height/24.6,
                  ),
                  defaultFormField(
                    controller: nameController,
                    hint: 'JhonWilliams',

                    prefix: IconBroken.Profile,
                    type: TextInputType.emailAddress,
                    validate: (value){
                      if(value!.isEmpty){
                        return 'user name must not be empty';
                      }
                      return null;
                    },
                    onChange: (value) {
                      // print(value);
                    },
                    oSubmit: (value) {
                      //  print(value);
                    },

                  ),// user name
                   SizedBox(
                    height: size.height/24.6,
                  ),
                  defaultFormField(
                      controller: emailController,
                      hint: 'Jhonewilliams@gmail.com',

                      prefix: IconBroken.Message,
                      type: TextInputType.emailAddress,
                      validate: (value){
                        if(value!.isEmpty){
                          return 'email must not be empty';
                        }
                        return null;
                      },
                    oSubmit: (value) {
                        //  print(value);
                      },

                  ),
                   SizedBox(
                    height: size.height/24.6,
                  ),
                  defaultFormField(
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
                   SizedBox(
                    height: size.height/24.6,
                  ),

                  defaultFormField(
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
                   SizedBox(
                    height: size.height/18.45,
                  ),

                  // create button
                  ConditionalBuilder(
                    builder: (BuildContext context) => defaultButton(
                      radius: 15,
                        function: (){
                          if(formKey.currentState!.validate()){
                            cubit.signUpPostData(
                                name: nameController.text,
                                email: emailController.text,
                                password: passwordController.text,
                                passwordConfirm: configPasswordController.text,
                                context: context);

                               }

                        },
                        text: 'Create',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                        width: size.width/1.992,
                        height: size.height/14.7,
                    ), fallback: (BuildContext context) =>Center(child: CircularProgressIndicator(color: defaultColor,)),
                    condition: state is! SignupLoadingState,
                  ),// email
                   SizedBox(
                    height: size.height/18.45,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Already have an account? ',
                        style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey
                        ),

                      ),
                       SizedBox(width:size.width/70,),
                      TextButton(
                        onPressed:(){
                          navigateToAndRemove(context,  LoginScreen());
                        },

                        child: Text(
                          'Login',
                          style: TextStyle(
                              fontFamily: 'Jannah',
                            color: HexColor('025B89'),
                            fontSize: 15
                          ),
                        ),
                      )
                    ],
                  ),

                ],
              ),
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
