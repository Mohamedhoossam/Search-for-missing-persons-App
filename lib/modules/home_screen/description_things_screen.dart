import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:newnew/shared/bloc/main_cubit/main_cubit.dart';
import 'package:newnew/shared/bloc/main_cubit/main_state.dart';
import 'package:newnew/shared/components/components.dart';
import 'package:newnew/shared/style/colors.dart';
import 'package:newnew/shared/style/icon_broken.dart';

class DescriptionThingsScreen extends StatelessWidget {
   DescriptionThingsScreen({
    Key? key,
     required this.model
  }) : super(key: key);
  double height = 6;
  double font = 15;
   dynamic model ;

  @override
  Widget build(BuildContext context) {
    return  BlocConsumer<MainCubit,MainState>(
      listener: (BuildContext context, state) {  },
      builder: (BuildContext context, Object? state) {
        MainCubit cubit =MainCubit.get(context);
        return Scaffold(
        body: CustomScrollView(
          physics:const BouncingScrollPhysics(),
          slivers: [
            SliverAppBar(
              leading: IconButton(
                onPressed: (){
                  Navigator.of(context).pop();
                },
                icon:const Icon(IconBroken.Arrow___Left,color: Colors.white,),
              ),
              backgroundColor: defaultColor,
              expandedHeight:420,
              pinned: true,
              bottom: PreferredSize(
                preferredSize:const Size.fromHeight(-5),
                child: Container(
                  decoration: BoxDecoration(
                      color: defaultColor,
                      borderRadius: const BorderRadius.only(topLeft: Radius.circular(20),topRight: Radius.circular(20))
                  ),
                  child:  Padding(
                    padding: const EdgeInsets.all(0.0),
                    child: Center(
                      child: Text(model.name!,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                        maxLines: 2,
                      ),
                    ),
                  ),
                  width: double.maxFinite,
                  padding: const EdgeInsets.only(top: 5,bottom: 10),
                ),
              ),
              flexibleSpace: FlexibleSpaceBar(
                  background: Image.network(
                    model.photo!,
                    fit: BoxFit.fill,
                    // width: double.maxFinite,
                  )
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [

                    // Container(
                    //     height: 300,
                    //     width: double.infinity,
                    //     decoration: BoxDecoration(
                    //       borderRadius: BorderRadius.circular(10),
                    //       image:  DecorationImage(
                    //         image: NetworkImage(model.photo!,),
                    //        // fit: BoxFit.cover,
                    //       ),),),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text('Type : ',style: TextStyle(fontFamily: 'Jannah',fontSize: font,color:  cubit.isDark==false? Colors.black:Colors.white,),),
                        Text(model.type!,style: TextStyle(fontFamily: 'Jannah',fontSize: font,color: defaultColor),),
                      ],),
                    SizedBox(height: height,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text('State : ',style: TextStyle(fontFamily: 'Jannah',fontSize: font,color:  cubit.isDark==false? Colors.black:Colors.white,),),
                        Text(model.state!,
                          style: TextStyle(fontSize: font,color: defaultColor,fontFamily: 'Jannah' ),
                          maxLines: 2,overflow: TextOverflow.ellipsis,),
                      ],),
                    SizedBox(height: height,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text('Model : ',style: TextStyle(fontFamily: 'Jannah',fontSize: font,color:  cubit.isDark==false? Colors.black:Colors.white,),),
                        Text(model.model!,style: TextStyle(fontFamily: 'Jannah',fontSize: font,color: defaultColor),),

                      ],),
                    SizedBox(height: height,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text('Color : ',style: TextStyle(fontFamily: 'Jannah',fontSize: font,color:  cubit.isDark==false? Colors.black:Colors.white,),),
                        Text(model.color!,style: TextStyle(fontFamily: 'Jannah',fontSize: font,color: defaultColor, ),),
                      ],),
                    SizedBox(height: height,),
                    if(model?.carNumber != null)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text('Car num : ',style: TextStyle(fontFamily: 'Jannah',fontSize: font,color:  cubit.isDark==false? Colors.black:Colors.white,),),
                          Text(model.carNumber??'',style: TextStyle(fontFamily: 'Jannah',fontSize: font,color: defaultColor, ),),

                        ],),
                    if(model?.carNumber != null)
                      SizedBox(height: height,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text('Location : ',style: TextStyle(fontFamily: 'Jannah',fontSize: font,color:  cubit.isDark==false? Colors.black:Colors.white,),),
                        Text(model.location!,style: TextStyle(fontFamily: 'Jannah',fontSize: font,color: defaultColor, ),),
                      ],),
                    SizedBox(height: height,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text('Last seen : ',style: TextStyle(fontFamily: 'Jannah',fontSize: font,color:  cubit.isDark==false? Colors.black:Colors.white,),),
                        Text(formattedDate(model.date!),style: TextStyle(fontFamily: 'Jannah',fontSize: font,color: defaultColor, ),),
                        const SizedBox(width: 10,),
                        Icon(IconBroken.Calendar,color: defaultColor,)
                      ],),
                    SizedBox(height: height,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text('Description : ',style: TextStyle(fontFamily: 'Jannah',fontSize: font,color:  cubit.isDark==false? Colors.black:Colors.white,),),

                      ],),
                    Row(
                      children: [
                        Expanded(
                          child: Text(model.description,maxLines: 5,
                            textAlign: TextAlign.start,
                            style: TextStyle(fontFamily: 'Jannah',fontSize: 12,color: defaultColor, ),),
                        ),
                      ],
                    ),
                    SizedBox(height: height*5,),
                    Row(children:  [
                      const Expanded(child: Divider(color: Colors.grey,height: 1,)),
                      Padding(
                        padding:const EdgeInsets.symmetric(horizontal: 20),
                        child: Text('Contacts Data',style: TextStyle(color:  cubit.isDark==false? Colors.black:Colors.white,),),
                      ),
                      const Expanded(child: Divider(color: Colors.grey,height: 1,)),

                    ],),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(onPressed: (){
                          whatsappLink(phone: model.whatsNamber??'', message: "", context: context);
                        }, icon: const Icon(Icons.whatsapp),
                          color: Colors.green,
                          splashColor: Colors.green,
                          iconSize: 40,),

                        IconButton(onPressed: (){
                          messengerLink(userName:model.messengerUserName!, context: context);
                        }, icon: const Icon(Icons.facebook),
                          color: HexColor('3b5998'),
                          splashColor: Colors.blue,
                          iconSize: 40,),
                        IconButton(onPressed: (){
                          callingLink(phone: model.phone??'', context: context);
                        }, icon:  const Icon(Icons.add_ic_call_outlined,color: Colors.green,),
                          splashColor: Colors.green,
                          iconSize: 30,)

                      ],),

                  ],
                ),
              ),
            ),
          ],
        ),
      ); },

    );
  }
}
