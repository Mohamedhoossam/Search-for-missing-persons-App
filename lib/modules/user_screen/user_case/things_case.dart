import 'package:animate_do/animate_do.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:newnew/modules/home_screen/description_things_screen.dart';
import 'package:newnew/modules/user_screen/user_case_update/update_things_case.dart';
import 'package:newnew/shared/bloc/main_cubit/main_cubit.dart';
import 'package:newnew/shared/bloc/main_cubit/main_state.dart';
import 'package:newnew/shared/components/components.dart';
import 'package:newnew/shared/style/colors.dart';
import 'package:newnew/shared/style/icon_broken.dart';

class ThingsCaseScreen extends StatelessWidget {
  const ThingsCaseScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MainCubit, MainState>(
      listener: (context, state) {
        if(state is DeleteCaseSuccessState){
          showToast(text:'delete success', state:ToastStates.SUCCESS );
        }
      },
      builder: (context, state) {
        MainCubit cubit =MainCubit.get(context);
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
          body: ConditionalBuilder(
            condition: MainCubit.get(context).userThingsCaseModel!.data!.isNotEmpty,
            builder: (BuildContext context) => SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    const Text('Swap left and Right to update or delete'),
                    // list item
                    ListView.separated(
                      shrinkWrap: true,
                      itemBuilder: (context, index) =>FadeInLeft(
                        child: GestureDetector(
                          onTap: (){
                            navigateTo(context, DescriptionThingsScreen(
                              model:cubit.userThingsCaseModel!.data![index],
                            ));
                          },
                          child: Container(
                            clipBehavior: Clip.antiAliasWithSaveLayer,
                            decoration: const BoxDecoration(
                                borderRadius: BorderRadius.all(Radius.circular(20))

                            ),
                            child: Slidable(
                              actionPane:const SlidableScrollActionPane(),
                              actionExtentRatio: .25,
                              key: UniqueKey(),

                              dismissal: SlidableDismissal(
                                child: const SlidableDrawerDismissal(),
                                dismissThresholds: const <SlideActionType, double>{
                                  SlideActionType.secondary: 1.0
                                },
                                onDismissed: (actionType) {
                                  MainCubit.get(context).deleteThingsCase(id:cubit.userThingsCaseModel!.data![index].sId.toString());

                                },
                              ),

                              actions: [

                                IconSlideAction(
                                  caption: 'Delete',
                                  color: Colors.red,
                                  icon: Icons.delete,
                                  onTap: (){
                                    MainCubit.get(context).deleteThingsCase(id:cubit.userThingsCaseModel!.data![index].sId.toString());

                                  },
                                ),
                              ],
                              secondaryActions: [
                                IconSlideAction(
                                  caption: 'Update',
                                  color: Colors.green,
                                  icon: Icons.update,
                                  onTap: (){
                                    cubit.x=0;
                                    navigateTo(context,UpdateThingsCaseScreen(model: cubit.userThingsCaseModel!.data![index],));
                                  },
                                ),
                                IconSlideAction(
                                  caption: 'Found',
                                  color: Colors.limeAccent,
                                  icon: Icons.done,
                                  onTap: (){
                                    cubit.userThingsCaseFound(id: cubit.userThingsCaseModel!.data![index].sId.toString());

                                  },
                                )


                              ],
                              child: Stack(
                                alignment: AlignmentDirectional.topEnd,
                                children: [
                                  buildThingsItem(context,
                                    height: MediaQuery.of(context).size.height,
                                    width: MediaQuery.of(context).size.width,
                                    model:cubit.userThingsCaseModel!.data![index],
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(0, 20, 20, 0),
                                    child: Container(

                                      decoration: BoxDecoration(
                                        borderRadius: const BorderRadius.all(Radius.circular(0)),
                                        color: cubit.userThingsCaseModel!.data![index].accept == true?Colors.green:Colors.red,

                                      ),
                                      child:   Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                        child: cubit.userThingsCaseModel!.data![index].accept == true?const Text('Accept',
                                          style: TextStyle(color: Colors.white,fontSize: 13,),

                                        ):const Text('Not Accept',
                                          style: TextStyle(color: Colors.white,fontSize: 13,),

                                        ),
                                      ),
                                    ),
                                  ),

                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      separatorBuilder: (context,index)=>myDivider(),
                      itemCount: cubit.userThingsCaseModel!.data!.length,
                      physics: const BouncingScrollPhysics(),
                    ),
                  ],
                ),
              ),
            ),
            fallback: (BuildContext context) => SizedBox(
              height: double.infinity,
              width:double.infinity ,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: const[
                  Icon(Icons.menu_open,size: 300,color: Colors.grey,),
                  SizedBox(height: 20,),
                  Text('You not have any Case',style: TextStyle(fontSize: 16),)
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
