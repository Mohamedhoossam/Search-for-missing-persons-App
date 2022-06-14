import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newnew/modules/admin_screen/admin_screen.dart';
import 'package:newnew/modules/user_screen/aboutus_screen.dart';
import 'package:newnew/modules/user_screen/contactus_screen.dart';
import 'package:newnew/modules/user_screen/setting_screen.dart';
import 'package:newnew/shared/bloc/main_cubit/main_cubit.dart';
import 'package:newnew/shared/bloc/main_cubit/main_state.dart';
import 'package:newnew/shared/components/components.dart';
import 'package:newnew/shared/constant.dart';
import 'package:newnew/shared/local/share_pereference.dart';
import 'package:newnew/shared/style/colors.dart';
import 'package:newnew/shared/style/icon_broken.dart';

import '../modules/user_screen/user_case/user_case_screen.dart';

class LayoutScreen extends StatelessWidget {
   var scaffoldKey = GlobalKey<ScaffoldState>();

  LayoutScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    AppBar appBar = AppBar(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
        Text('M',style: TextStyle(fontFamily: 'Jannah',color: defaultColor,fontSize: 20),),
        const Text('issing',),
      ],),
      centerTitle: true,
      actions: const [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Icon(
               IconBroken.Search
          ),
        ),
      ],
      leading: IconButton(onPressed:(){
        result == true ? scaffoldKey.currentState!.openDrawer():null;
        } ,icon:const Icon(Icons.menu) ),

    );

    return BlocConsumer<MainCubit, MainState>(
  listener: (context, state) {
  },
  builder: (context, state) {
    MainCubit cubit = MainCubit.get(context);
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Colors.white,
      appBar:appBar,
      body:result == true? ConditionalBuilder(
        builder: (BuildContext context) => cubit.screen[cubit.currentIndex],
        condition: MainCubit.get(context).getProfileModel != null,
        fallback: (BuildContext context)  => const Center(child: CircularProgressIndicator(),) ,):
      SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Icon(Icons.wifi_off,size: 180,color: Colors.grey,),
            Text('No Internet Connection'),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(icon:Icon(IconBroken.Profile),label: "Personal"),
          BottomNavigationBarItem(icon:Icon(IconBroken.Paper),label: "Things"),
          BottomNavigationBarItem(icon:Icon(IconBroken.Upload),label: "Upload"),

        ],
        elevation: 0.0,
        currentIndex: result == true?cubit.currentIndex:0,
        onTap: (index){
          result == true? cubit.changeIndex(index):0;
        },
        iconSize: 26,
        selectedItemColor: defaultColor,
        unselectedIconTheme: const IconThemeData(color: Colors.grey,),
        selectedIconTheme: IconThemeData(color: defaultColor,),
        unselectedLabelStyle:  const TextStyle(color: Colors.grey,fontSize: 12),
        showUnselectedLabels: true,


      ),

      drawer:result == true? Drawer(
        shape:const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(topRight: Radius.circular(100),),
        ),
        child: ListView(
          children:<Widget> [
             ConditionalBuilder(
               builder: (BuildContext context)=>UserAccountsDrawerHeader(
                       accountName: Text(cubit.getProfileModel!.data!.name.toString()),
                       accountEmail: Text(cubit.getProfileModel!.data!.email.toString()),
                       currentAccountPicture: CircleAvatar(
                       backgroundImage:NetworkImage(cubit.getProfileModel!.data!.photo.toString()) ,
                              ),
                        decoration: const BoxDecoration(),
                         ),
                        condition: cubit.getProfileModel != null,
                        fallback: (BuildContext context) =>const Center(child: CircularProgressIndicator(),) ,

             ),
            ListTile(
              leading: const Icon(Icons.account_circle_outlined),
              title: const Text('Account Profile',style: TextStyle(fontFamily: 'jannah',fontSize: 14),),
              textColor: Colors.white,
              iconColor: Colors.white,
              onTap: (){
                navigateTo(context,  const UserCaseScreen());
              },
            ),
            if(CacheHelper.getData(key: 'role')=='admin')
            ListTile(
              leading: const Icon(Icons.admin_panel_settings_outlined),
              title: const Text('Adimn',style: TextStyle(fontFamily: 'jannah',fontSize: 14),),
              textColor: Colors.white,
              iconColor: Colors.white,
              onTap: (){
                cubit.getAdminThingsCase();
                cubit.getAdminSearchForFamilyCase();
                cubit.getAdminMissingCase();
                navigateTo(context, AdminScreen());

              },
            ),

            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text('Setting',style: TextStyle(fontFamily: 'jannah',fontSize: 14),),
              textColor: Colors.white,
              iconColor: Colors.white,
              onTap: (){
                navigateTo(context,const SettingScreen());
              },
            ),
            ListTile(
              leading: const Icon(Icons.group),
              title: const Text('About us',style: TextStyle(fontFamily: 'jannah',fontSize: 14),),
              textColor: Colors.white,
              iconColor: Colors.white,
              onTap: (){navigateTo(context, const AboutUsScreen());},
            ),
            ListTile(
              leading: const Icon(Icons.phone),
              title: const Text('Contact us',style: TextStyle(fontFamily: 'jannah',fontSize: 14),),
              textColor: Colors.white,
              iconColor: Colors.white,
              onTap: (){navigateTo(context, ContactUsScreen());},
            ),
            myDivider(),
            ListTile(
              leading: const Icon(Icons.logout_outlined),
              title: const Text('Logout',style: TextStyle(fontFamily: 'jannah',fontSize: 14),),
              textColor: Colors.white,
              iconColor: Colors.white,
              onTap: (){
                showDialog(context: context, builder: (context){
                  return AlertDialog(
                   // title: Text('you sure logout?'),
                    content: const Text('you want logout?'),
                    actions: [
                      MaterialButton(onPressed: (){
                        Navigator.of(context).pop();
                      },child: Text('cancel',style: TextStyle(color: defaultColor),),),
                      MaterialButton(onPressed: (){
                        cubit.missingLogout(context);
                      },child: const Text('ok',style: TextStyle(color: Colors.red),),),
                    ],
                    elevation: 24,

                  );

                },
                );
              },
            ),
          ],
        ),

      ):null,
      
      

    );
  },

);
  }
}

