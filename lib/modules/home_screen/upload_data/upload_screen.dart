import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:newnew/modules/home_screen/upload_data/upload_missing_personal_screen.dart';
import 'package:newnew/modules/home_screen/upload_data/upload_search_for_family_screen.dart';
import 'package:newnew/modules/home_screen/upload_data/upload_things_screen.dart';
import 'package:newnew/shared/bloc/main_cubit/main_cubit.dart';
import 'package:newnew/shared/bloc/main_cubit/main_state.dart';
import 'package:newnew/shared/components/components.dart';


class UploadScreen extends StatelessWidget {
  const UploadScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MainCubit, MainState>(
  listener: (context, state) {
  },
  builder: (context, state) {
    MainCubit cubit = MainCubit.get(context);
    return Scaffold(

      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(children: [

          Expanded(
            child: GestureDetector(
              onTap: (){
                cubit.x=0;
                navigateTo(context, UploadMissingPersonalScreen());
              },


              child: Container(

                decoration: BoxDecoration(
                  color: Colors.orangeAccent,
                  borderRadius: BorderRadius.circular(20),
                    boxShadow:[
                      if(cubit.isDark==false)
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        offset: const Offset(-10, 10),
                        blurRadius: 20,
                        spreadRadius: 4,
                      )
                    ]


                ),
                child: Stack(
                  alignment: AlignmentDirectional.bottomCenter,
                  children: [
                  Lottie.asset('assets/images/search1.json',
                    width: double.maxFinite,
                   // height: 300,
                    alignment: Alignment.topCenter,
                    animate: true,

                  ),

                    Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Container(
                        width: 230,
                        height: 40,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(20)),

                        ),
                        child:   Center(
                          child: Text('add Missing'.toUpperCase(), style: const TextStyle(
                              color: Colors.orange,
                            fontSize: 15,
                            fontWeight: FontWeight.bold

                          ),),
                        ),
                      ),
                    ),


                ],),
              ),
            ),
          ),
          const SizedBox(height: 20,),
          Expanded(
            child: GestureDetector(

              onTap: (){
                cubit.x=0;

                navigateTo(context, UploadSearchForFamilyScreen());
              },
              child: Container(

                decoration: BoxDecoration(
                  color: Colors.redAccent,
                  borderRadius: BorderRadius.circular(20),

                boxShadow:[
                  if(cubit.isDark==false)
                    BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        offset: const Offset(-10, 10),
                        blurRadius: 20,
                        spreadRadius: 4,
                      )
                    ],


                ),
                child: Stack(
                  alignment: AlignmentDirectional.bottomCenter,
                  children: [
                    Lottie.asset('assets/images/search3.json',
                      width: double.maxFinite,
                      // height: 300,
                      alignment: Alignment.topCenter,
                      animate: true,

                    ),
                    Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Container(
                        width: 230,
                        height: 40,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(20)),

                        ),
                        child: Center(
                          child: Text('search for family'.toUpperCase(), style: const TextStyle(
                              color: Colors.red,
                          //  fontSize: 14,
                              fontWeight: FontWeight.bold


                          ),),
                        ),
                      ),
                    )


                  ],),
              ),
            ),
          ),
          const SizedBox(height: 20,),
          Expanded(
            child: GestureDetector(
              onTap: (){
                cubit.x=0;
                navigateTo(context, UploadSearchForThingsScreen());
              },
              child: Container(

                decoration: BoxDecoration(
                  color: Colors.blueAccent,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow:[
                    if(cubit.isDark==false)
                      BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      offset: const Offset(-10, 10),
                      blurRadius: 20,
                      spreadRadius: 4,
                    )
                  ],


                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [

                  Lottie.asset('assets/images/search2.json',
                    width: double.maxFinite,
                    height: 142,
                    fit: BoxFit.contain,
                    alignment: Alignment.topCenter,
                    animate: true,

                  ),
                    Container(
                      width: 230,
                      height: 40,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(20)),

                      ),
                      child:  Center(
                        child: Text('add things'.toUpperCase(), style: const TextStyle(
                            color: Colors.blue,
                          fontSize: 15,
                          fontWeight: FontWeight.bold

                        ),),
                      ),
                    ),
                    const SizedBox(height: 4,),

                ],),

              ),
            ),
          ),
        ],
        ),
      ),
    );
  },
);
  }
}
