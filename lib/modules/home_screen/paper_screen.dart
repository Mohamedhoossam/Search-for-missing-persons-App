import 'package:animate_do/animate_do.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newnew/modules/home_screen/description_things_screen.dart';
import 'package:newnew/modules/home_screen/things_filter_screen.dart';
import 'package:newnew/shared/bloc/main_cubit/main_cubit.dart';
import 'package:newnew/shared/bloc/main_cubit/main_state.dart';
import 'package:newnew/shared/components/components.dart';
import 'package:newnew/shared/style/colors.dart';
import 'package:newnew/shared/style/icon_broken.dart';

class PaperScreen extends StatelessWidget {
  const PaperScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MainCubit,MainState>(
        listener: (context, state) {},
        builder: (context, state) {
          MainCubit cubit =MainCubit.get(context);
          return  ConditionalBuilder(
            condition: cubit.getAllThingsModel != null,
            fallback: (BuildContext context) =>const Center(child: CircularProgressIndicator(),),
            builder: (BuildContext context) =>Scaffold(
              body: CustomScrollView(
                physics: const BouncingScrollPhysics(),
                slivers: [
                  SliverAppBar(
                    pinned: true,
                    expandedHeight: 60,
                    // backgroundColor: defaultColor,
                    bottom: PreferredSize(
                      preferredSize: const Size.fromHeight(0),
                      //filter
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12,vertical: 0),
                        child: Container(
                          decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.3),
                                  offset: const Offset(-10, 10),
                                  blurRadius: 20,
                                  spreadRadius: 4,
                                ),
                              ]
                          ),

                          child: Row(
                            children:  [
                              Text('${cubit.getAllThingsModel!.data!.length}  ',style: TextStyle(
                                  fontFamily: 'Jannah',fontSize: 16,fontWeight: FontWeight.normal,color: defaultColor),),
                              const Text('Status found',style: TextStyle(
                                fontFamily: 'Jannah',fontSize: 16,fontWeight: FontWeight.normal,),),
                              const Spacer(),
                              MaterialButton(onPressed: (){
                                navigateTo(context,const ThingsFilterScreen());
                              },
                                child: Row(children: [
                                  const Text('Filter',style:TextStyle(
                                    fontFamily: 'Jannah',fontSize: 16,fontWeight: FontWeight.normal,),),
                                  const SizedBox(width: 10,),
                                  Icon(IconBroken.Filter,color: defaultColor,)
                                ],),)

                            ],
                          ),
                        ),
                      ),
                    ),

                  ),
                  SliverToBoxAdapter(
                    child:Padding(
                      padding: const EdgeInsets.all(0.0),
                      child: Column(
                        children: [
                          // list item
                          ListView.separated(
                            shrinkWrap: true,
                            itemBuilder: (context, index) =>FadeInLeft(
                              child: GestureDetector(
                                onTap: (){
                                  navigateTo(context, DescriptionThingsScreen(
                                    model: cubit.getAllThingsModel!.data![index],
                                  ));
                                },
                                child: buildThingsItem(context,
                                  height: MediaQuery.of(context).size.height,
                                  width: MediaQuery.of(context).size.width,
                                  model:cubit.getAllThingsModel!.data![index],
                                ),
                              ),
                            ) ,
                            separatorBuilder: (context,index)=>myDivider(),
                            itemCount: cubit.getAllThingsModel!.data!.length,
                            physics: const BouncingScrollPhysics(),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),

          );
        },
    );






  }
}

// ConditionalBuilder(
//               fallback: (BuildContext context) => const Center(child: CircularProgressIndicator(),),
//               condition: MainCubit.get(context).getAllThingsModel !=null,
//               builder: (BuildContext context) => Container(
//                 color: Colors.grey.withOpacity(.1),
//                 child: SingleChildScrollView(
//                   physics: const BouncingScrollPhysics(),
//                   child:
//                 ),
//               ),
//
//
//
//             ),