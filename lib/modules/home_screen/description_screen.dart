import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:newnew/shared/bloc/main_cubit/main_cubit.dart';
import 'package:newnew/shared/bloc/main_cubit/main_state.dart';
import 'package:newnew/shared/components/components.dart';
import 'package:newnew/shared/style/colors.dart';
import 'package:newnew/shared/style/icon_broken.dart';


class DescriptionScreen extends StatelessWidget {
  double height = 6;
  double font = 15;
   dynamic model;

  DescriptionScreen( {required this.model,Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MainCubit,MainState>(
      builder: (BuildContext context, state) {
        MainCubit cubit = MainCubit.get(context);
        return Scaffold(
        body: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            SliverAppBar(
              pinned: true,
              expandedHeight: 420,
              backgroundColor: defaultColor,
              leading: IconButton(onPressed: (){
                Navigator.of(context).pop();
              },
                  icon: const Icon(IconBroken.Arrow___Left,color: Colors.white,)),
              bottom: PreferredSize(
                preferredSize: const Size.fromHeight(0),
                child: Container(
                  decoration: BoxDecoration(
                      color: defaultColor,
                      borderRadius: const BorderRadius.only(topLeft: Radius.circular(20),topRight: Radius.circular(20))
                  ),
                  child:  Padding(
                    padding: const EdgeInsets.all(0.0),
                    child: Center(
                        child: Text(model!.name!,
                          style: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold,color: Colors.white
                          ),
                          maxLines: 2,
                        )
                    ),
                  ),
                  width: double.maxFinite,
                  padding: const EdgeInsets.only(top: 5,bottom: 10),
                ),
              ),
              flexibleSpace: FlexibleSpaceBar(
                background: Image.network(model!.photo!,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SliverToBoxAdapter(
              child:  Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [

                      // Container(
                      //   height: 300,
                      //   width: double.maxFinite,
                      //   decoration: BoxDecoration(
                      //     borderRadius: BorderRadius.circular(10),
                      //     // image:  DecorationImage(
                      //     //   image: NetworkImage(photo,),
                      //     //
                      //     //    fit: BoxFit.cover,
                      //     // ),
                      //      ),
                      //   child: Image(image: NetworkImage(photo),),
                      // ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text('Country : ',style: TextStyle(fontFamily: 'Jannah',fontSize: font,color:  cubit.isDark==false? Colors.black:Colors.white,),),
                          Text(model!.country!,style: TextStyle(fontFamily: 'Jannah',fontSize: font,color: defaultColor),),
                        ],),
                      SizedBox(height: height,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text('Mother n : ',style: TextStyle(fontFamily: 'Jannah',fontSize: font,color:  cubit.isDark==false? Colors.black:Colors.white,),),
                          Text(model!.motherName!,
                            style: TextStyle(fontSize: font,color: defaultColor,fontFamily: 'Jannah' ),
                            maxLines: 2,overflow: TextOverflow.ellipsis,),
                        ],),
                      SizedBox(height: height,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text('yearOfBirth : ',style: TextStyle(fontFamily: 'Jannah',fontSize: font,color:  cubit.isDark==false? Colors.black:Colors.white,),),
                          Text(model!.yearOfBirth.toString(),style: TextStyle(fontFamily: 'Jannah',fontSize: font,color: defaultColor),),
                          const SizedBox(width: 10,),
                          Icon(IconBroken.Calendar,color: defaultColor,)
                        ],),
                      SizedBox(height: height,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text('Colors : ',style: TextStyle(fontFamily: 'Jannah',fontSize: font,color:  cubit.isDark==false? Colors.black:Colors.white,),),
                          Text('wheat',style: TextStyle(fontFamily: 'Jannah',fontSize: font,color: defaultColor, ),),
                        ],),
                      SizedBox(height: height,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text('height : ',style: TextStyle(fontFamily: 'Jannah',fontSize: font,color:  cubit.isDark==false? Colors.black:Colors.white,),),
                          Text('${model!.height} cm',style: TextStyle(fontFamily: 'Jannah',fontSize: font,color: defaultColor, ),),

                        ],),
                      SizedBox(height: height,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text('weight : ',style: TextStyle(fontFamily: 'Jannah',fontSize: font,color:  cubit.isDark==false? Colors.black:Colors.white,),),
                          Text('${model!.weight} kg',style: TextStyle(fontFamily: 'Jannah',fontSize: font,color: defaultColor, ),),
                        ],),
                      SizedBox(height: height,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text('Eye Colors : ',style: TextStyle(fontFamily: 'Jannah',fontSize: font,color:  cubit.isDark==false? Colors.black:Colors.white,),),
                          Text('Black',style: TextStyle(fontFamily: 'Jannah',fontSize: font,color: defaultColor, ),),
                        ],),
                      SizedBox(height: height,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text('Last seen : ',style: TextStyle(fontFamily: 'Jannah',fontSize: font,color:  cubit.isDark==false? Colors.black:Colors.white,),),
                          Text(formattedDate(model!.date),style: TextStyle(fontFamily: 'Jannah',fontSize: font,color: defaultColor, ),),
                          const SizedBox(width: 10,),
                          Icon(IconBroken.Calendar,color: defaultColor,)
                        ],),
                      SizedBox(height: height,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text('Phone num : ',style: TextStyle(fontFamily: 'Jannah',fontSize: font,color:  cubit.isDark==false? Colors.black:Colors.white,),),
                          Text(model!.phone!,style: TextStyle(fontFamily: 'Jannah',fontSize: font,color: defaultColor, ),),

                        ],),
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
                            whatsappLink(phone: model!.phone!, message: "", context: context);
                          }, icon: const Icon(Icons.whatsapp),
                            color: Colors.green,
                            splashColor: Colors.green,
                            iconSize: 40,),

                          IconButton(onPressed: (){
                            messengerLink(userName:model!.messengerUserName!, context: context);

                          }, icon: const Icon(Icons.facebook),
                            color: HexColor('3b5998'),
                            splashColor: Colors.blue,
                            iconSize: 40,),
                          IconButton(onPressed: (){
                            callingLink(phone: model!.phone!, context: context);
                          }, icon:  const Icon(Icons.add_ic_call_outlined,color: Colors.green,),
                            splashColor: Colors.green,
                            iconSize: 30,)

                        ],),

                    ],)
              ),
            )
          ],
        ),
      );
        },
      listener: (BuildContext context, state) {  },

    );
  }
}
