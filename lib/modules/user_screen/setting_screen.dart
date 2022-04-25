import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newnew/modules/user_screen/user_profile/profile_screen.dart';
import 'package:newnew/shared/bloc/main_cubit/main_cubit.dart';
import 'package:newnew/shared/bloc/main_cubit/main_state.dart';
import 'package:newnew/shared/components/components.dart';
import 'package:newnew/shared/style/colors.dart';
import 'package:newnew/shared/style/icon_broken.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MainCubit, MainState>(
      listener: (context, state) {
      },
      builder: (context, state){
        MainCubit cubit = MainCubit.get(context);
        return  Scaffold(
            appBar: AppBar(
              title: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('S',style: TextStyle(fontFamily: 'Jannah',color: defaultColor,fontSize: 20),),
                  const Text('etting', ),
                ],),
              centerTitle: true,
              leading:IconButton(
                icon: const Icon(IconBroken.Arrow___Left),
                onPressed: (){
                  Navigator.of(context).pop();
                },
              ),

            ),
            body: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView(
                physics: const BouncingScrollPhysics(),
                children:[
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
                    onTap: (){navigateToAndRemove(context,const ProfileScreen());},
                  ),
                  myDivider(),
                  ListTile(
                    leading: const Icon(Icons.language_outlined),
                    title: const Text('Language',style: TextStyle(fontFamily: 'jannah'),),
                    iconColor:cubit.isDark == false? Colors.black:Colors.white,
                    onTap: (){},
                  ),
                  const SizedBox(height: 10,),
                  ListTile(
                    leading: const Icon(Icons.brightness_4_outlined),
                    title: const Text('Theme',style: TextStyle(fontFamily: 'jannah'),),
                    iconColor:cubit.isDark == false? Colors.black:Colors.white,
                    onTap: (){cubit.changeAppMode();},
                  ),
                  const SizedBox(height: 10,),
                  ListTile(
                    leading: const Icon(Icons.info_outline),
                    title: const Text('App info',style: TextStyle(fontFamily: 'jannah'),),
                    iconColor:cubit.isDark == false? Colors.black:Colors.white,
                    onTap: (){},
                  ),
                  const SizedBox(height: 40,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('M',style: TextStyle(fontFamily: 'Jannah',color: defaultColor,fontSize: 20),),
                       Text('issing',style:TextStyle(color: cubit.isDark ==false ? Colors.black : Colors.white)),
                      Text(' A',style: TextStyle(fontFamily: 'Jannah',color: defaultColor,fontSize: 20),),
                       Text('pp',style:TextStyle(color: cubit.isDark ==false ? Colors.black : Colors.white)),
                    ],
                  )
                ],
              ),
            )

        );
      },
    );



  }
}
