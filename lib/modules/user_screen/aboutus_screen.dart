import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newnew/shared/bloc/main_cubit/main_cubit.dart';
import 'package:newnew/shared/bloc/main_cubit/main_state.dart';
import 'package:newnew/shared/components/components.dart';
import 'package:newnew/shared/style/colors.dart';
import 'package:newnew/shared/style/icon_broken.dart';

class AboutUsScreen extends StatelessWidget {
  const AboutUsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MainCubit, MainState>(
      listener: (BuildContext context, state) {  },
      builder: (BuildContext context,state) {
        MainCubit cubit = MainCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('A',style: TextStyle(fontFamily: 'Jannah',color: defaultColor,fontSize: 20),),
                const Text('bout us',),
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
            padding: const EdgeInsets.all(15.0),
            child: ListView(
              physics: const BouncingScrollPhysics(),
              children:  [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text('M',style: TextStyle(fontFamily: 'Jannah',color: defaultColor,fontSize: 20),),
                     Text('issing',style: TextStyle(fontFamily: 'Jannah',color:cubit.isDark==false ? Colors.black:Colors.white),),
                    Text(' A',style: TextStyle(fontFamily: 'Jannah',color: defaultColor,fontSize: 20),),
                     Text('pp',style: TextStyle(fontFamily: 'Jannah',color:cubit.isDark==false ? Colors.black:Colors.white),),
                  ],
                ),
                myDivider(),
                const SizedBox(height: 20,),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Text(
                        'We draw a smile, Wipe a tear and bring back the lost hope .',
                        style: TextStyle(
                          fontFamily: 'Jannah',
                          color:cubit.isDark==false? Colors.black:Colors.white,
                            fontSize: 14
                        ),
                      ),
                      Text(
                        'We are a work team that helps people by trying to find their missing loved ones (children or adults), and finding lost personal belongings of all kinds, by displaying them on our program for other people to see, who may meet them or find them. And if someone finds a missing person and puts him in the program, you can search for him in more than one way, the most important of them is to search through his picture, and then you will see quick results about that person, and through the program you can contact us by sending a message or messaging through social media',
                        style: TextStyle(
                          fontFamily: 'Jannah',
                          color: cubit.isDark==false? Colors.black:Colors.white,
                          fontSize: 14
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20,),
                myDivider(),

              ],
            ),
          ),
        );
      },
    );
  }
}
