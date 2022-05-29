import 'package:animate_do/animate_do.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:newnew/modules/home_screen/description_screen.dart';
import 'package:newnew/shared/bloc/main_cubit/main_cubit.dart';
import 'package:newnew/shared/bloc/main_cubit/main_state.dart';
import 'package:newnew/shared/components/components.dart';
import 'package:newnew/shared/style/colors.dart';
import 'package:newnew/shared/style/icon_broken.dart';


class AdminScreen extends StatelessWidget {
  var missingKey = GlobalKey<ScaffoldState>();
  var searchedKey = GlobalKey<ScaffoldState>();
  var thingsKey = GlobalKey<ScaffoldState>();

  AdminScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MainCubit, MainState>(
      listener: (context, state) {
        if(state is DeleteAdminCaseSuccessState){
          showToast(text:'delete success', state:ToastStates.SUCCESS );
        }
      },
      builder: (context,state){
        MainCubit cubit = MainCubit.get(context);
        return   Scaffold(
          body: DefaultTabController(
              animationDuration: const Duration(
                milliseconds: 750,
              ),
              length: 3,
              child: Scaffold(
                appBar:AppBar(
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
                  bottom: TabBar(
                    indicatorColor: defaultColor,
                    physics: const BouncingScrollPhysics(),
                    tabs: [
                      Tab(
                        child: Text(
                          'Missing',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: defaultColor,
                              fontSize: 16
                          ),

                        ),

                      ),
                      Tab(
                        child: Text(
                          'Founded',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: defaultColor,
                              fontSize: 16
                          ),

                        ),

                      ),
                      Tab(
                        child: Text(
                          'Things',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: defaultColor,
                              fontSize: 16
                          ),

                        ),

                      ),
                    ],
                  ),

                ) ,
                body: TabBarView(
                  physics: const BouncingScrollPhysics(),
                  children: [
                    Scaffold(
                      key: missingKey,
                      body: ConditionalBuilder(
                        builder: (BuildContext context) {
                          return ListView.separated(
                            shrinkWrap: true,
                            itemBuilder: (context, index) =>FadeInLeft(
                              child: GestureDetector(
                                onTap: (){
                                  navigateTo(context, DescriptionScreen(
                                    model: MainCubit.get(context).adminMissingPersonModel!.data![index],
                                  ));
                                },
                                child: Container(
                                  clipBehavior: Clip.antiAliasWithSaveLayer,
                                  decoration: const BoxDecoration(
                                    borderRadius: BorderRadius.all(Radius.circular(20)),


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
                                        cubit.deleteAdminMissingCase(id:cubit.adminMissingPersonModel!.data![index].sId.toString(),);
                                      },
                                    ),

                                    actions: [

                                      IconSlideAction(
                                        caption: 'delete',
                                        color: Colors.red,
                                        icon: Icons.delete,
                                        onTap: (){
                                         cubit.deleteAdminMissingCase(id:cubit.adminMissingPersonModel!.data![index].sId.toString(),);
                                         },
                                      ),
                                    ],
                                    secondaryActions: [

                                      IconSlideAction(
                                        caption: 'not accept',
                                        color: Colors.deepOrange,
                                        icon: Icons.highlight_remove_outlined,
                                        onTap: () {
                                          missingKey.currentState?.showBottomSheet(
                                                  (context) => buildBottomSheet(context));
                                        }
                                      ),
                                      IconSlideAction(
                                        caption: 'Accept',
                                        color: Colors.green,
                                        icon: Icons.done,
                                        onTap: (){
                                          //AppCubit.get(context).updateDatabase(id: model['id'], status: 'new');
                                        },
                                      )


                                    ],
                                    child: Stack(
                                      alignment: AlignmentDirectional.topEnd,

                                      children: [
                                        buildCaseItem(context,
                                          height: MediaQuery.of(context).size.height,
                                          width: MediaQuery.of(context).size.width,
                                          model:MainCubit.get(context).adminMissingPersonModel!.data![index],
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.fromLTRB(0, 20, 20, 0),
                                          child: Container(

                                            decoration: BoxDecoration(
                                              borderRadius: const BorderRadius.all(Radius.circular(7)),
                                              color: MainCubit.get(context).adminMissingPersonModel!.data![index].accept == true?Colors.green:Colors.red,

                                            ),
                                            child:   Padding(
                                              padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                              child: MainCubit.get(context).adminMissingPersonModel!.data![index].accept == true?const Text('Accept',
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
                            ) ,
                            separatorBuilder: (context,index)=>myDivider(),
                            itemCount: MainCubit.get(context).adminMissingPersonModel!.data!.length,
                            physics: const BouncingScrollPhysics(),
                          );
                        },
                        fallback: (BuildContext context) =>SizedBox(
                          height: double.infinity,
                          width:double.infinity ,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: const[
                              Icon(Icons.menu_open,size: 300,color: Colors.grey,),
                              SizedBox(height: 20,),
                              Text('There are no cases',style: TextStyle(fontSize: 16),)
                            ],
                          ),
                        ),
                        condition: cubit.adminMissingPersonModel!.data!.isNotEmpty,

                      ),
                    ),
                    Scaffold(
                      key: searchedKey,
                      body: ConditionalBuilder(
                        builder: (BuildContext context) {
                          return  ListView.separated(
                            shrinkWrap: true,
                            itemBuilder: (context, index) =>FadeInLeft(
                              child: GestureDetector(
                                onTap: (){
                                  navigateTo(context, DescriptionScreen(
                                    model: MainCubit.get(context).adminSearchForFamilyModel!.data![index],
                                  ));
                                },
                                child: Container(
                                  clipBehavior: Clip.antiAliasWithSaveLayer,
                                  decoration: const BoxDecoration(
                                    borderRadius: BorderRadius.all(Radius.circular(20)),


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
                                        cubit.deleteAdminSearchForFamilyCase(id:cubit.adminSearchForFamilyModel!.data![index].sId.toString(),);
                                      },
                                    ),

                                    actions: [

                                      IconSlideAction(
                                        caption: 'Delete',
                                        color: Colors.red,
                                        icon: Icons.delete,
                                        onTap: (){
                                          cubit.deleteAdminSearchForFamilyCase(id:cubit.adminSearchForFamilyModel!.data![index].sId.toString(),);

                                        },
                                      ),
                                    ],
                                    secondaryActions: [
                                      IconSlideAction(
                                        caption: 'Not Accept',
                                        color: Colors.deepOrange,
                                        icon: Icons.highlight_remove_outlined,
                                        onTap: (){
                                          searchedKey.currentState?.showBottomSheet(
                                                  (context) => buildBottomSheet(context));
                                        },
                                      ),
                                      IconSlideAction(
                                        caption: 'Accept',
                                        color: Colors.green,
                                        icon: Icons.done,
                                        onTap: (){
                                          //AppCubit.get(context).updateDatabase(id: model['id'], status: 'new');
                                        },
                                      )


                                    ],
                                    child: Stack(
                                      alignment: AlignmentDirectional.topEnd,

                                      children: [
                                        buildCaseItem(context,
                                          height: MediaQuery.of(context).size.height,
                                          width: MediaQuery.of(context).size.width,
                                          model:MainCubit.get(context).adminSearchForFamilyModel!.data![index],
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.fromLTRB(0, 20, 20, 0),
                                          child: Container(

                                            decoration: BoxDecoration(
                                              borderRadius: const BorderRadius.all(Radius.circular(7)),
                                              color: MainCubit.get(context).adminSearchForFamilyModel!.data![index].accept == true?Colors.green:Colors.red,

                                            ),
                                            child:   Padding(
                                              padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                              child: MainCubit.get(context).adminSearchForFamilyModel!.data![index].accept == true?const Text('Accept',
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
                            ) ,
                            separatorBuilder: (context,index)=>myDivider(),
                            itemCount: MainCubit.get(context).adminSearchForFamilyModel!.data!.length,
                            physics: const BouncingScrollPhysics(),
                          );
                        },
                        fallback: (BuildContext context) =>SizedBox(
                          height: double.infinity,
                          width:double.infinity ,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: const[
                              Icon(Icons.menu_open,size: 300,color: Colors.grey,),
                              SizedBox(height: 20,),
                              Text('There are no cases',style: TextStyle(fontSize: 16),)
                            ],
                          ),
                        ),
                        condition: cubit.adminSearchForFamilyModel!.data!.isNotEmpty,

                      ),
                    ),
                    Scaffold(
                      key: thingsKey,
                      body: ConditionalBuilder(
                        builder: (BuildContext context) {
                          return  ListView.separated(
                            shrinkWrap: true,
                            itemBuilder: (context, index) =>FadeInLeft(
                              child: GestureDetector(
                                onTap: (){
                                  navigateTo(context, DescriptionScreen(
                                    model: cubit.adminThingsModel!.data![index],
                                  ));
                                },
                                child: Container(
                                  clipBehavior: Clip.antiAliasWithSaveLayer,
                                  decoration: const BoxDecoration(
                                    borderRadius: BorderRadius.all(Radius.circular(20)),


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
                                        cubit.deleteAdminThingsCase(id:cubit.adminThingsModel!.data![index].sId.toString(),);
                                      },
                                    ),

                                    actions: [

                                      IconSlideAction(
                                        caption: 'delete',
                                        color: Colors.red,
                                        icon: Icons.delete,
                                        onTap: (){
                                          cubit.deleteAdminThingsCase(id:cubit.adminThingsModel!.data![index].sId.toString(),);
                                          },
                                      ),
                                    ],
                                    secondaryActions: [
                                      IconSlideAction(
                                        caption: 'Not Accept',
                                        color: Colors.deepOrange,
                                        icon: Icons.highlight_remove_outlined,
                                        onTap: (){
                                          thingsKey.currentState?.showBottomSheet(
                                                  (context) => buildBottomSheet(context));
                                        },
                                      ),
                                      IconSlideAction(
                                        caption: 'Accept',
                                        color: Colors.green,
                                        icon: Icons.done,
                                        onTap: (){
                                          //AppCubit.get(context).updateDatabase(id: model['id'], status: 'new');
                                        },
                                      ),


                                    ],
                                    child: Stack(
                                      alignment: AlignmentDirectional.topEnd,

                                      children: [
                                        buildThingsItem(context,
                                          height: MediaQuery.of(context).size.height,
                                          width: MediaQuery.of(context).size.width,
                                          model:cubit.adminThingsModel!.data![index],
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.fromLTRB(0, 20, 20, 0),
                                          child: Container(

                                            decoration: BoxDecoration(
                                              borderRadius: const BorderRadius.all(Radius.circular(7)),
                                              color: cubit.adminThingsModel!.data![index].accept == true?Colors.green:Colors.red,

                                            ),
                                            child:   Padding(
                                              padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                              child: cubit.adminThingsModel!.data![index].accept == true?const Text('Accept',
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
                            ) ,
                            separatorBuilder: (context,index)=>myDivider(),
                            itemCount: MainCubit.get(context).adminThingsModel!.data!.length,
                            physics: const BouncingScrollPhysics(),
                          );
                        },
                        fallback: (BuildContext context) =>SizedBox(
                          height: double.infinity,
                          width:double.infinity ,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: const[
                              Icon(Icons.menu_open,size: 300,color: Colors.grey,),
                              SizedBox(height: 20,),
                              Text('There are no cases',style: TextStyle(fontSize: 16),)
                            ],
                          ),
                        ),
                        condition: cubit.adminThingsModel!.data!.isNotEmpty,

                      ),
                    ),
                  ],
                ),
              )
          ),
        );
      },
    );
  }

  Container buildBottomSheet( BuildContext context){
    return Container(
      height: 300,
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        border: Border.all(color: defaultColor,width: 2),
        borderRadius: BorderRadius.circular(8),
      ),
      child: ListView(
        children: <Widget> [
           ListTile(title: Text('Send the reason for not being accepted ',style: TextStyle(fontSize: 14,color: MainCubit.get(context).isDark ==false? Colors.black : Colors.white,),)),
          const TextField(
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              icon:  Icon(Icons.text_fields_outlined),
              labelText: 'Enter The Message',
            ),
          ),
          Container(
            alignment:Alignment.center ,
            child: ElevatedButton.icon(
                onPressed: ()=> Navigator.pop(context),
                icon:  const Icon(Icons.send,
                  color: Colors.white,),
                label:  const Text('Send',style:   TextStyle(color:  Colors.white,),)),
          )
        ],
      ),
    );
}
}
