import 'dart:io';
import 'dart:math';

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:newnew/modules/home_screen/description_screen.dart';
import 'package:newnew/shared/bloc/main_cubit/main_cubit.dart';
import 'package:newnew/shared/bloc/main_cubit/main_state.dart';
import 'package:newnew/shared/components/components.dart';
import 'package:newnew/shared/style/colors.dart';
import 'package:newnew/shared/style/icon_broken.dart';

class SearchScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    AppBar appBar =AppBar(
      elevation: 0.0,
      leading: IconButton(icon:const Icon(IconBroken.Arrow___Left_2) ,onPressed: (){
        MainCubit.get(context).searchByImage = null;
       Navigator.of(context).pop();
      },),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('M',style: TextStyle(fontFamily: 'Jannah',color: defaultColor,fontSize: 20),),
          const Text('issing',),
        ],),
      centerTitle: true,
    );
    return  BlocConsumer<MainCubit, MainState>(
  listener: (context, state) {
    
  },
  builder: (context, state) {
    return Scaffold(
      appBar:appBar,
      body: Center(
        child: MainCubit.get(context).searchByImage == null ?
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Icon(Icons.photo,size: 220,color: Colors.grey,),
            Text('Please add image to can search by it '),
          ],
        ):
        ConditionalBuilder(
          condition: state is ! SearchByImageLoadingState,
          fallback: (BuildContext context) =>Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children:  [
              Lottie.asset('assets/images/searchimage.json',
                key: Key('${Random().nextInt(999999999)}'),
                width: 300,
                height: 300,
                alignment: Alignment.topCenter,
                animate: true,
              ),
              const SizedBox(height: 30,),
              const Text('Please Wait ...')
            ],
          ),
          builder: (BuildContext context) =>ListView.separated(
            itemBuilder: (BuildContext context, int index) =>
                GestureDetector(
                  onTap: ()=>navigateTo(context, DescriptionScreen(
                    model: MainCubit.get(context).searchByImageModel!.data![index],
                  )),
                  child: buildItem(
                      context,
                      height: MediaQuery.of(context).size.height,
                      width: MediaQuery.of(context).size.width,
                      model:MainCubit.get(context).searchByImageModel!.data![index] ),
                ),
            separatorBuilder: (BuildContext context, int index) =>myDivider(),
            itemCount: MainCubit.get(context).searchByImageModel!.data!.length,

          ),

        )
    ),
      persistentFooterButtons: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: SizedBox(
            width: double.maxFinite,
            child: ConditionalBuilder(
              builder: (BuildContext context) =>MaterialButton(
                onPressed: (){
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      content: const Text('select image by?'),
                      actions: [
                        MaterialButton(onPressed: (){
                          MainCubit.get(context).getSearchByImageGallery(context: context);
                        },child: Text('Gallery',style: TextStyle(color: defaultColor),),),
                        MaterialButton(onPressed: (){
                          MainCubit.get(context).getSearchByImageCamera(context: context);
                        },child: const Text('Camera',style: TextStyle(color: Colors.red),),),
                      ],
                    ),
                  );
                },
                color:defaultColor ,
                child:Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children:  [
                    Text('add Image'.toUpperCase(),
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,

                      ),
                    ),
                    const SizedBox(width: 10,),
                    const  Icon(IconBroken.Camera,color: Colors.white,)
                  ],
                ),
                height: 50,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30)
                ),



              ),
              condition: 0 != 1,
              fallback:(BuildContext context) =>  const Center(child:  LinearProgressIndicator(),) ,

            ),
          ),
        ),
      ],
    );
  },
);





  }
}
