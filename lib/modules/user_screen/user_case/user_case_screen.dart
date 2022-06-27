import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newnew/modules/user_screen/user_case/missing_person_case.dart';
import 'package:newnew/modules/user_screen/user_case/search_for_family_case.dart';
import 'package:newnew/modules/user_screen/user_case/things_case.dart';
import 'package:newnew/shared/bloc/main_cubit/main_cubit.dart';
import 'package:newnew/shared/bloc/main_cubit/main_state.dart';
import 'package:newnew/shared/components/components.dart';
import 'package:newnew/shared/style/colors.dart';
import 'package:newnew/shared/style/icon_broken.dart';

class UserCaseScreen extends StatelessWidget {
  const UserCaseScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MainCubit, MainState>(
  listener: (context, state) {},
  builder: (context, state) {
   MainCubit cubit =  MainCubit.get(context);
    return Scaffold(
      appBar: AppBar(
    title: Row(
    mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('U',style: TextStyle(fontFamily: 'Jannah',color: defaultColor,fontSize: 20),),
        const Text('ser Case',),
      ],),
    leading:IconButton(
    icon: const Icon(IconBroken.Arrow___Left),
    onPressed: (){
    Navigator.of(context).pop();
    },
    ),
    centerTitle: true,

    ),
      body:Column(children: [
        ListTile(
          leading:  CircleAvatar(
            backgroundImage: NetworkImage(cubit.getProfileModel!.data!.photo.toString()),
            radius: 25,
          ),
          title:  Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(cubit.getProfileModel!.data!.name.toString(),style: TextStyle(fontFamily: 'jannah',color: cubit.isDark==false? Colors.black:Colors.white,),),
               Text('See your profile',style: TextStyle(fontSize: 11, color: cubit.isDark==false? Colors.black:Colors.white,),)
            ],),
          textColor: Colors.black,
          iconColor: Colors.black,
          onTap: (){Navigator.of(context).pop();},
        ),
        myDivider(),
        const SizedBox(height: 20,),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: AnimatedContainer(
              duration: const Duration(milliseconds: 750),
              curve:Curves.fastLinearToSlowEaseIn,
              child: MaterialButton(
                color: defaultColor,
                onPressed: (){
                  navigateTo(context, const MissingPersonCaseScreen());
                  //cubit.getUserMissingCase();

                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Text('Missing Case',style: TextStyle(color: Colors.white),) ,
                    SizedBox(width: 20,),
                    Icon(Icons.arrow_forward_ios_outlined,color: Colors.white,),
                  ],
                ),

              )
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

                  navigateTo(context, const SearchForFamilyCaseScreen());
                 // cubit.getUserSearchForFamilyCase();


                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Text('Search For Family Case',style: TextStyle(color: Colors.white),) ,
                    SizedBox(width: 20,),
                    Icon(Icons.arrow_forward_ios_outlined,color: Colors.white,),
                  ],
                ),

              )
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

                  navigateTo(context, const ThingsCaseScreen());
                //  cubit.getUserThingsCase();


                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Text('Things Case',style: TextStyle(color: Colors.white),) ,
                    SizedBox(width: 20,),
                    Icon(Icons.arrow_forward_ios_outlined,color: Colors.white,),
                  ],
                ),
              )
          ),
        ),
      ],),    );
    },
);


  }
}
