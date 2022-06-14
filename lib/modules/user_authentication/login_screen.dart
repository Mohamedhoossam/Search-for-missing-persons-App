import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:newnew/missing_layout/layout.dart';
import 'package:newnew/modules/user_authentication/forgetpassword_screen.dart';
import 'package:newnew/modules/user_authentication/register_screen.dart';
import 'package:newnew/shared/components/components.dart';
import 'package:newnew/shared/style/colors.dart';
import 'package:newnew/shared/style/icon_broken.dart';
import '../../shared/bloc/login_register_cubit/login_cubit.dart';
import '../../shared/bloc/login_register_cubit/login_state.dart';





class LoginScreen extends StatelessWidget {
  final emailController =TextEditingController();
  final passwordController =TextEditingController();
  final _emailFocusNode = FocusNode();
  final _passwordFocusNode = FocusNode();
  final formKey = GlobalKey<FormState>();

  LoginScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {

   late  double widthScreen =MediaQuery.of(context).size.width;
   late  double heightScreen =MediaQuery.of(context).size.height;
   return BlocProvider(
  create: (context) => LoginCubit(),
  child: BlocConsumer<LoginCubit,LoginState>(
   listener: (context, state) {
    if(state is LoginSuccessState){
    if(state.userDataModel.status == "success"){
      Fluttertoast.showToast(
        msg:state.userDataModel.message!,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 2,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 16.0,

      ).then((value) {
        navigateToAndRemove(context,  LayoutScreen());
      });
    }
    if(state.userDataModel.status == "fail"){
      Fluttertoast.showToast(
        msg:state.userDataModel.message!,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,


      );
    }

    }

  },
  builder: (context, state) {
    LoginCubit cubit =LoginCubit.get(context);
    return GestureDetector(

      onTap:() {
        FocusScope.of(context).unfocus();
      },
      child:Scaffold(
        backgroundColor: Colors.white,
        body: Form(
      key: formKey,
      child: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 2),
              child: Container(
                height: 250,
                decoration: BoxDecoration(
                  color: defaultColor,
                  borderRadius: const BorderRadius.only(
                    bottomRight: Radius.circular(50),

                  ),

                ),
                child: Stack(
                  children: [
                    Positioned(
                        top: 80,
                        left: 0,
                        child:Container(
                          height: 100,
                          width: 300,
                          decoration: const BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.only(
                                topRight: Radius.circular(50),
                                bottomRight: Radius.circular(50),

                              )
                          ),
                        )
                    ),
                    Positioned(
                        top:90,
                        left: 20,
                        child: Row(
                          children: [

                            Text('M',style: TextStyle(fontFamily: 'Jannah',fontSize: 30,color: defaultColor),),
                            const Text('issing App',style: TextStyle(fontSize: 20,color: Colors.black),),
                            const SizedBox(width: 20,),
                            const Image(image:  AssetImage('assets/images/missing3.png'),width: 80,height: 80,)
                          ],
                        )
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 0,),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Welcome !',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Jannah'
                    ),
                  ),

                  defaultFormField(
                    controller: emailController,
                    hint: 'Example@gmail.com',
                    focusNode: _emailFocusNode,
                    textInputAction: TextInputAction.next,
                    onEditingComplete: ()=>FocusScope.of(context).requestFocus(_passwordFocusNode),
                    prefix: IconBroken.Message,
                    type: TextInputType.emailAddress,
                    validate: (value){
                      if(value!.isEmpty){
                        return 'email must not be empty';
                      }
                      return null;
                    },
                    onChange: (value) {
                      // print(value);
                    },
                    oSubmit: (value) {
                      //  print(value);
                    },
                  ),
                  SizedBox(
                    height: heightScreen/49,//15
                  ),
                  defaultFormField(
                      controller: passwordController,
                      hint: 'Password',
                      focusNode: _passwordFocusNode,
                      textInputAction: TextInputAction.done,
                      prefix: IconBroken.Lock,
                      type: TextInputType.visiblePassword,
                      validate: (value){
                        if(value!.isEmpty){
                          return 'password must not be empty';
                        }
                        return null;
                      },
                      onChange: (value) {

                      },
                      oSubmit: (value) {

                      },
                      suffix:cubit.isPassword ==true?cubit.visibilityOff : cubit.visibility ,
                      isPassword: cubit.isPassword ,
                      suffixPressed: (){
                        cubit.changePassword();
                      }
                  ),
                  // forget password
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        onPressed:(){
                          navigateTo(context, ForgetPassword(emailController.text));
                        },
                        child: Text(
                          '  Forget Password ?',
                          style: TextStyle(
                              color: defaultColor,
                              fontSize: 14,
                              fontFamily: 'Jannah'
                          ),
                        ),
                      ),
                    ],
                  ),

                  // login button
                  ConditionalBuilder(
                    builder: (context)=>defaultButton(
                      function:(){
                        if(formKey.currentState!.validate()){
                          cubit.loginPostData(email: emailController.text, password: passwordController.text,context: context);
                        }
                      },
                      width: widthScreen/1.992,
                      height: heightScreen/14.7,
                      fontSize: 15,
                      text: 'login',
                      radius: 10,
                      style: const TextStyle(
                          color: Colors.white
                      ),
                    ),
                    fallback: (BuildContext context)=> Center(child: CircularProgressIndicator(color: defaultColor,)),

                    condition: state  is! LoginLoadingState,
                  ),


                  SizedBox(
                    height: heightScreen/37,//20
                  ),
                  // or
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Container(
                          height: 1.0,
                          width: double.infinity,
                          color:  Colors.grey,
                        ),
                      ),
                      const Text('    Or    ',style: TextStyle(
                          color: Colors.grey,
                          fontFamily: 'Jannah'
                      ),),
                      Expanded(
                        child: Container(
                          height: 1.0,
                          width: double.infinity,
                          color:  Colors.grey,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: heightScreen/74,//10
                  ),
                  // facebook google
                  Row(
                    children: [
                      Expanded(
                        child: defaultButton(
                          function:(){
                           //cubit.signOut();
                          },
                          background:Colors.black12,
                          height: heightScreen/14.7,
                          text: 'Facebook',fontSize: 16,
                          icon: Icons.facebook,
                          iconColor: HexColor('3b5998'),
                          radius: 15,
                          style:  TextStyle(
                              color: HexColor('3b5998')
                          ),



                        ),
                      ),
                      const SizedBox(
                        width: 10,

                      ),// button
                      Expanded(
                        child: defaultButton(
                          function:(){
                           // cubit.signIn();

                          },
                          // width:150,
                          fontSize: 17,
                          height: heightScreen/14.7,
                          text: 'Google',
                          icon: Icons.mail,
                          iconColor: HexColor('#DB4437'),
                          radius: 15,
                          background: Colors.black12,
                          style:  TextStyle(
                              color: HexColor('#DB4437'),
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: heightScreen/74,//10
                  ),

                  // sign up
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Don\'t have an account? ',
                        style: TextStyle(
                            fontSize: 15,
                            color: Colors.grey,
                            fontFamily: 'Jannah'
                        ),

                      ),
                      SizedBox(width:widthScreen/34,),
                      TextButton(
                        onPressed:(){
                          navigateTo(context,RegisterScreen());
                        },
                        child: Text(
                          'Sign up',
                          style: TextStyle(
                              color: defaultColor,
                              fontFamily: 'Jannah'

                          ),
                        ),

                      )
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ),
    ),
    );
  },
),
);

  }
}