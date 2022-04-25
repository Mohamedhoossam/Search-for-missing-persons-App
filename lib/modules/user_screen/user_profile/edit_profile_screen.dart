import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newnew/modules/user_screen/user_profile/change_password_screen.dart';
import 'package:newnew/shared/bloc/main_cubit/main_cubit.dart';
import 'package:newnew/shared/bloc/main_cubit/main_state.dart';
import 'package:newnew/shared/components/components.dart';
import 'package:newnew/shared/style/colors.dart';
import 'package:newnew/shared/style/icon_broken.dart';

class EditProfileScreen extends StatelessWidget {
   EditProfileScreen({Key? key}) : super(key: key);
  var formKey = GlobalKey<FormState>();
   var nameController = TextEditingController();
   var emailController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MainCubit,MainState>(
        listener: (context, state) {
          if(state is UpdateProfileSuccessState){
            if(state.updateProfileModel.status == 'success'){
              showToast(text: state.updateProfileModel.message!, state:ToastStates.SUCCESS );
            }else{
              showToast(text: state.updateProfileModel.message!, state:ToastStates.ERROR );
            }
          }
        },
        builder: (context, state) {
          MainCubit cubit = MainCubit.get(context);
          return Scaffold(
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
                padding: const EdgeInsets.all(8.0),
                child: Form(
                  key: formKey,
                  child: Column(
                    children: [
                      ListTile(
                        leading:  CircleAvatar(
                          backgroundImage: NetworkImage(cubit.getProfileModel!.data!.photo.toString()),

                          radius: 25,
                        ),
                        title:  Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                          Text(cubit.getProfileModel!.data!.name.toString(),style:const TextStyle(fontFamily: 'jannah'),),
                          const Text('See your profile',style: TextStyle(fontSize: 11),)
                        ],),
                        textColor:cubit.isDark==false? Colors.black: Colors.white,
                        onTap: (){Navigator.of(context).pop();},
                      ),
                      myDivider(),
                      const SizedBox(height: 20,),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                         children: [
                           Row(
                             crossAxisAlignment: CrossAxisAlignment.start,
                             children: const [
                               Text('Edit name'),
                             ],),
                           const SizedBox(height: 10,),

                           defaultFormField2(
                             hint: cubit.getProfileModel!.data!.name,
                             controller: nameController,
                             type: TextInputType.name,
                             validate:  (value){}
                               ),
                           const SizedBox(height: 20,),
                           Row(
                             crossAxisAlignment: CrossAxisAlignment.start,
                             children: const [
                               Text('Edit Email Address'),
                             ],),
                           const SizedBox(height: 10,),

                           defaultFormField2(
                               hint: cubit.getProfileModel!.data!.email,
                               controller: emailController,
                               type: TextInputType.emailAddress,
                               validate:  (value){}),
                           const SizedBox(height: 10,),
                           Padding(
                             padding: const EdgeInsets.all(8.0),
                             child: AnimatedContainer(
                                 duration: const Duration(milliseconds: 750),
                                 curve:Curves.fastLinearToSlowEaseIn,
                                 child: ConditionalBuilder(
                                   builder: (BuildContext context)=>defaultButton(
                                       function: (){

                                         cubit.updateProfile(
                                           name: nameController.text,
                                           email: emailController.text.isEmpty ? cubit.getProfileModel!.data!.email:emailController.text ,
                                         );
                                       },
                                       text: "Update",
                                       style: const TextStyle(
                                           color: Colors.white
                                       ),
                                       background: Colors.teal
                                   ),
                                   fallback: (BuildContext context)=>const Center(child: LinearProgressIndicator(),),
                                   condition: state is! UpdateProfileLoadingState,
                                    ),
                             ),
                           ),
                           Padding(
                             padding: const EdgeInsets.all(8.0),
                             child: AnimatedContainer(
                                 duration: const Duration(milliseconds: 750),
                                 curve:Curves.fastLinearToSlowEaseIn,
                                 child: MaterialButton(
                                   color: defaultColor,
                                   onPressed: (){
                                     navigateTo(context, ChangePasswordScreen());
                                   },
                                   child: Row(
                                     mainAxisAlignment: MainAxisAlignment.center,
                                     children: const [
                                       Text('Change password',style: TextStyle(color: Colors.white),) ,
                                       SizedBox(width: 20,),
                                       Icon(Icons.arrow_forward_ios_outlined,color: Colors.white,),
                                     ],
                                   ),

                                 )
                             ),
                           ),
                           ],
                          ),
                      )
                        ]
                     )
                  ),
                ),
              ),
            );


        },
    );
  }
}
