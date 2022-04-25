import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newnew/modules/user_screen/user_profile/edit_profile_screen.dart';
import 'package:newnew/modules/user_screen/user_case/user_case_screen.dart';
import 'package:newnew/shared/bloc/main_cubit/main_cubit.dart';
import 'package:newnew/shared/bloc/main_cubit/main_state.dart';
import 'package:newnew/shared/components/components.dart';
import 'package:newnew/shared/style/colors.dart';
import 'package:newnew/shared/style/icon_broken.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MainCubit, MainState>(
      listener: (context, state) {
        if(state is UpdateProfileSuccessState){
          if(state.updateProfileModel.status == 'success'){
            showToast(text: state.updateProfileModel.message!, state:ToastStates.SUCCESS );
          }else{
            showToast(text: state.updateProfileModel.message!, state:ToastStates.ERROR );
          }
        }
      },
      builder: (context,state){
        MainCubit cubit = MainCubit.get(context);
        return   Scaffold(
          appBar: AppBar(
            title: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [

                Text('P',style: TextStyle(fontFamily: 'Jannah',color: defaultColor,fontSize: 20),),
                const Text('rofile',),
              ],),
            leading:IconButton(
              icon: const Icon(IconBroken.Arrow___Left),
              onPressed: (){
                Navigator.of(context).pop();
              },
            ),
            centerTitle: true,
          ),
          body: ConditionalBuilder(
            builder:(BuildContext context) {
              return SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(children: [
                  AnimatedContainer(
                    // color: Colors.red,
                    width: double.infinity,
                    height: 140,
                    duration: const Duration(milliseconds: 750),
                    curve:Curves.fastOutSlowIn,
                    child: Stack(
                      alignment: AlignmentDirectional.topCenter,
                      children: [
                        Stack(
                          alignment: AlignmentDirectional.bottomEnd,
                          children: [
                            cubit.profileImage ==null ?
                            CircleAvatar(
                              radius: 62,
                              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                              child:  CircleAvatar(
                                radius: 60,
                                backgroundImage:NetworkImage(cubit.getProfileModel!.data!.photo.toString(),) ,
                              ),
                            ):
                            CircleAvatar(
                              radius: 62,
                              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                              child:  CircleAvatar(
                                radius: 60,
                                backgroundImage:FileImage(cubit.profileImage!) ,
                              ),
                            ),
                            // edit image
                              CircleAvatar(
                                  radius: 20,
                                  backgroundColor: Colors.grey[300],
                                  child: IconButton(onPressed: (){
                                    cubit.getProfileImage(context: context);
                                  },
                                    icon: const Icon(IconBroken.Camera,
                                      color: Colors.black,
                                    ),
                                  )
                              ),
                          ],
                        )
                      ],),
                  ),
                  const SizedBox(height: 10,),
                  Text(cubit.getProfileModel!.data!.name.toString(),style: TextStyle(fontFamily: 'Jannah',color:cubit.isDark==false ? Colors.black:Colors.white,fontSize: 20) ,),
                  const SizedBox(height: 5,),
                  Text(cubit.getProfileModel!.data!.email.toString(),style: TextStyle(fontFamily: 'Jannah',color: defaultColor,fontSize: 16) ,),
                  const SizedBox(height: 20,),
                  myDivider(),
                  if(cubit.profileImage != null)
                  const SizedBox(height: 20,),
                  if(cubit.profileImage != null)
                  Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: AnimatedContainer(
                          duration: const Duration(milliseconds: 750),
                          curve:Curves.fastLinearToSlowEaseIn,
                          child:  ConditionalBuilder(
                            builder: (BuildContext context) => Row(
                                children:[
                                  defaultButton(function: (){cubit.deleteProfileImage();},
                                      text: "Cancel ",
                                      style: const TextStyle(color: Colors.white), background: Colors.red, width: 130),
                                      const Spacer(),
                                     defaultButton(
                                         function: (){cubit.updateProfile(email:cubit.getProfileModel!.data!.email ,
                                           name:cubit.getProfileModel!.data!.name ,
                                           photo:cubit.profileImage,);
                                         },
                                         text: "Save ",
                                         style: const TextStyle(
                                             color: Colors.white
                                         ),
                                         background: Colors.teal,
                                         width: 130
                                     ),

                                ]
                            ),

                            fallback: (BuildContext context)  =>const Center(child:  LinearProgressIndicator(),),
                            condition: state is! UpdateProfileLoadingState,
                          ),
                      ),
                    ),
                  const SizedBox(height: 20,),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 750),
                      curve:Curves.fastLinearToSlowEaseIn,
                      child: MaterialButton(
                        color: defaultColor,
                        onPressed: (){
                          navigateTo(context, EditProfileScreen());
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Text('Edit your profile',style: TextStyle(color: Colors.white),),
                            SizedBox(width: 20,),
                            Icon(Icons.arrow_forward_ios_outlined,color: Colors.white,),
                          ],
                        ),

                      )
                    ),
                  ),
                  const SizedBox(height: 5,),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: AnimatedContainer(
                        duration: const Duration(milliseconds: 750),
                        curve:Curves.fastLinearToSlowEaseIn,
                        child: MaterialButton(
                          color: defaultColor,
                          onPressed: (){
                            navigateTo(context, const UserCaseScreen());
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Text('My status',style: TextStyle(color: Colors.white),) ,
                              SizedBox(width: 20,),
                              Icon(Icons.arrow_forward_ios_outlined,color: Colors.white,),
                            ],
                          ),

                        )
                    ),
                  ),

                ],
                ),
              ),
            ) ;
              },
            fallback: (BuildContext context) { return  const Center(child: CircularProgressIndicator(),) ;},
            condition: cubit.getProfileModel != null,
          ),
        );
      },




    );
  }
}
