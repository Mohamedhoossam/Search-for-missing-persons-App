import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newnew/shared/bloc/main_cubit/main_cubit.dart';
import 'package:newnew/shared/bloc/main_cubit/main_state.dart';
import 'package:newnew/shared/components/components.dart';
import 'package:newnew/shared/style/colors.dart';
import 'package:newnew/shared/style/icon_broken.dart';

class ChangePasswordScreen extends StatelessWidget {
   ChangePasswordScreen({Key? key}) : super(key: key);
   var formKey = GlobalKey<FormState>();
   var currentPasswordController = TextEditingController();
   var newPasswordController = TextEditingController();
   var confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MainCubit,MainState>(
      listener: (context, state) {
        if(state is UpdatePasswordSuccessState){
          if(state.updatePasswordModel.status == 'success'){
            showToast(text: state.updatePasswordModel.message!, state:ToastStates.SUCCESS );
          }else{
            showToast(text: state.updatePasswordModel.message!, state:ToastStates.ERROR );
          }
        }
      },
      builder: (context, state) {
        MainCubit cubit = MainCubit.get(context);
        return GestureDetector(
          onTap: (){
            FocusScope.of(context).unfocus();
            },
          child: Scaffold(
            appBar: AppBar(
              title: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [

                  Text('E',style: TextStyle(fontFamily: 'Jannah',color: defaultColor,fontSize: 20),),
                  const Text('dit profile',),
                ],),
              leading:IconButton(
                icon: const Icon(IconBroken.Arrow___Left),
                onPressed: (){
                  Navigator.of(context).pop();
                },
              ),
              centerTitle: true,
            ),
            body: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Form(
                    key: formKey,
                    child: Column(
                        children: [
                          Column(
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: const [
                                  Text('Current Password'),
                                ],),
                              const SizedBox(height: 10,),

                              defaultFormField(
                                  hint: 'Password',
                                  controller: currentPasswordController,
                                  type: TextInputType.name,
                                  validate:  (value){
                                    if(value!.isEmpty){
                                      return 'Current  password must not be Empty';
                                    }
                                    return null;
                                  },
                                  suffix:cubit.currentIsPassword ==true?cubit.visibilityOff : cubit.visibility,
                                  isPassword: cubit.currentIsPassword ,
                                  suffixPressed: (){
                                    cubit.changePassword();
                                  },
                                prefix: IconBroken.Lock,
                              ),
                              const SizedBox(height: 20,),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: const [
                                  Text('New password'),
                                ],),
                              const SizedBox(height: 10,),

                              defaultFormField(
                                  suffix:cubit.newIsPassword ?IconBroken.Hide : IconBroken.Show ,
                                  isPassword: cubit.newIsPassword ,
                                  suffixPressed: (){
                                    cubit.changeNewPassword();
                                  },
                                  prefix: IconBroken.Lock,
                                  hint: 'Password',
                                  controller: newPasswordController,
                                  type: TextInputType.visiblePassword,
                                  validate:  (value){
                                    if(value!.isEmpty){
                                      return 'New  password must not be Empty';
                                    }
                                    return null;
                                  }),
                              const SizedBox(height: 10,),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: const [
                                  Text('Confirm password'),
                                ],),
                              const SizedBox(height: 10,),

                              defaultFormField(
                                  suffix:cubit.confirmIsPassword ?IconBroken.Hide: IconBroken.Show ,
                                  isPassword: cubit.confirmIsPassword ,
                                  suffixPressed: (){
                                    cubit.changeConfirmRegisterPassword();
                                  },
                                  prefix: IconBroken.Lock,
                                  onChange: (value){},
                                  oSubmit: (value){},
                                  hint: 'Password',
                                  controller: confirmPasswordController,
                                  type: TextInputType.visiblePassword,
                                  validate:  (value){
                                    if(value!.isEmpty){
                                      return 'Confirm password must not be Empty';
                                    }
                                    if(confirmPasswordController.text != newPasswordController.text){
                                      return 'Confirm password not as new password';
                                    }
                                    return null;
                                  },),
                              const SizedBox(height: 20,),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: AnimatedContainer(
                                    duration: const Duration(milliseconds: 750),
                                    curve:Curves.fastLinearToSlowEaseIn,
                                    child:ConditionalBuilder(

                                      condition: state is! UpdatePasswordLoadingState,
                                      builder: (BuildContext context) => defaultButton(
                                          function: (){
                                            if(formKey.currentState!.validate()){}
                                            cubit.updatePassword(
                                              newPassword:newPasswordController.text ,
                                              passwordConfirm:confirmPasswordController.text ,
                                              passwordCurrent:currentPasswordController.text ,
                                            );
                                          },
                                          text: "Change",
                                          style: const TextStyle(
                                              color: Colors.white
                                          ),
                                          background: defaultColor
                                      ),
                                      fallback: (BuildContext context) =>const Center(child: LinearProgressIndicator(),),
                                    )
                                ),
                              ),

                            ],
                          )
                        ]
                    )
                ),
              ),
            ),
          ),
        );


      },
    );
  }
}
