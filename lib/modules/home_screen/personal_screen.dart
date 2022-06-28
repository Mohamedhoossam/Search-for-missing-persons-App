import 'package:animate_do/animate_do.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newnew/modules/home_screen/personal_filter_screen.dart';
import 'package:newnew/modules/home_screen/search_screen.dart';
import 'package:newnew/shared/bloc/main_cubit/main_cubit.dart';
import 'package:newnew/shared/bloc/main_cubit/main_state.dart';
import 'package:newnew/shared/components/components.dart';
import 'package:newnew/modules/home_screen/description_screen.dart';
import 'package:newnew/shared/style/colors.dart';
import 'package:newnew/shared/style/icon_broken.dart';



class PersonalScreen extends StatefulWidget {

 const PersonalScreen({Key? key}) : super(key: key);

  @override
  State<PersonalScreen> createState() => _PersonalScreenState();
}

class _PersonalScreenState extends State<PersonalScreen> {
  int indicatorIndex=0;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MainCubit, MainState>(
      listener: (context, state) {},
      builder: (context, state) {
       MainCubit cubit = MainCubit.get(context);
       return Scaffold(
         body:ConditionalBuilder(
           fallback: (BuildContext context) =>const Center(child: CircularProgressIndicator()),
           condition:MainCubit.get(context).getAllPersonModel!=null,
           builder: (BuildContext context)=> RefreshIndicator(
             onRefresh: () async{
               cubit.loadHomeScreenData();
             },
             triggerMode: RefreshIndicatorTriggerMode.onEdge,


             child: SingleChildScrollView(
               scrollDirection: Axis.vertical,
               physics: const BouncingScrollPhysics(),
               child: Column(
                 children: [
                   // if(cubit.oldTenModel != null)
                   //   FadeInLeft(
                   //     animate: true,
                   //     child: Stack(
                   //       alignment:AlignmentDirectional.bottomCenter,
                   //       children: [
                   //         GestureDetector(
                   //           onTap: (){
                   //             navigateTo(context, DescriptionScreen(
                   //               model: cubit.oldTenModel!.data![indicatorIndex],
                   //             ));
                   //           },
                   //           child: Container(
                   //             color: cubit.isDark == false ?Colors.grey.withOpacity(.3): Colors.black,
                   //             child: CarouselSlider(
                   //               items: cubit.oldTenModel!.data!.map((e) =>
                   //                   Container(
                   //                     decoration: BoxDecoration(
                   //                       borderRadius: BorderRadius.circular(10),
                   //                       image:  DecorationImage(
                   //                         image: NetworkImage(e.photo!, ),
                   //
                   //                         // centerSlice: Rect.largest,
                   //                         // fit: BoxFit.cover
                   //                       ),
                   //
                   //                     ),
                   //
                   //                   ),
                   //
                   //               ).toList(),
                   //               options:CarouselOptions(
                   //                 autoPlayCurve: Curves.fastOutSlowIn,
                   //                 initialPage: 0,
                   //                 enableInfiniteScroll: true,
                   //                 reverse: false,
                   //                 autoPlayInterval:const Duration(seconds: 3),
                   //                 autoPlayAnimationDuration: const Duration(seconds: 1),
                   //                 viewportFraction: .4,
                   //                 enlargeCenterPage: true,
                   //                 autoPlay: true,
                   //                 height: 210,
                   //                 onPageChanged: ( index,  reason) {
                   //                   setState(() {
                   //                     indicatorIndex=index;
                   //                   });
                   //
                   //                 },
                   //
                   //
                   //
                   //               ),
                   //
                   //
                   //
                   //             ),
                   //           ),
                   //         ),
                   //         Padding(
                   //           padding: const EdgeInsets.only(bottom: 10),
                   //           child: Row(
                   //             mainAxisAlignment: MainAxisAlignment.center,
                   //             children: [
                   //               for(int index = 0; index<cubit.oldTenModel!.data!.length; index++)
                   //                 DotIndicator(isSelected: index == indicatorIndex?true:false),
                   //
                   //
                   //
                   //             ],),
                   //         ),
                   //       ],
                   //     ),
                   //   ),
                   MaterialButton(
                     color: cubit.isDark==false? Colors.white:Colors.black,
                     onPressed: (){
                       navigateTo(context, SearchScreen());
                     },
                     padding:const EdgeInsets.symmetric(horizontal: 12.0,vertical:10) ,
                     child: Row(
                       children: [
                         Expanded(
                           child: Container(
                             height: 50,
                             // width: double.maxFinite,
                             decoration: BoxDecoration(
                                 border: Border.all(color:cubit.isDark==false? Colors.grey:Colors.white,width: 1),
                                 borderRadius:const BorderRadius.all(Radius.circular(50))
                             ),
                             child:const Center(child: Text('Search by image...')),
                           ),
                         ),
                         const  SizedBox(width: 20,),
                         Container(
                             height: 50,
                             width: 50,
                             decoration: BoxDecoration(
                               border: Border.all(color: Colors.grey,width: 1),
                               borderRadius:const BorderRadius.all(Radius.circular(50)),
                               color: defaultColor,

                             ),
                             child: const Icon(IconBroken.Camera,color: Colors.white,size: 25,))
                       ],
                     ),
                   ),

                   Container(
                     color: Colors.grey.withOpacity(.1) ,
                     child: Column(
                       children: [
                         //Filter
                         Padding(
                           padding: const EdgeInsets.symmetric(horizontal: 12,vertical: 4),
                           //filter
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
                             // filter
                             child: Row(
                               children:  [
                                 Text('${cubit.getAllPersonModel!.data!.length}  ',style: TextStyle(
                                     fontFamily: 'Jannah',fontSize: 16,fontWeight: FontWeight.normal,color: defaultColor),),
                                 Text('Status found',style: TextStyle(
                                   color: cubit.isDark==false? Colors.black:Colors.white,
                                   fontFamily: 'Jannah',fontSize: 16,fontWeight: FontWeight.normal,),),
                                 const Spacer(),
                                 MaterialButton(onPressed: (){
                                   navigateTo(context,const PersonalFilterScreen());

                                 },child: Row(children: [
                                   const Text('Filter',style:TextStyle(
                                     fontFamily: 'Jannah',fontSize: 16,fontWeight: FontWeight.normal,),),
                                   const SizedBox(width: 10,),
                                   Icon(IconBroken.Filter,color: defaultColor,)
                                 ],),)

                               ],
                             ),
                           ),
                         ),
                         const SizedBox(height: 10,),
                         // list item
                         ListView.separated(
                           shrinkWrap: true,
                           physics: const NeverScrollableScrollPhysics(),

                           itemBuilder: (context, index) =>FadeInLeft(
                             child: GestureDetector(
                               onTap: ()=>navigateTo(context, DescriptionScreen(
                                 model: cubit.getAllPersonModel!.data![index],
                               )),
                               child: buildItem(context,
                                   height: MediaQuery.of(context).size.height,
                                   width: MediaQuery.of(context).size.width,
                                   model: cubit.getAllPersonModel!.data![index]
                               ),

                             ),
                           ) ,
                           separatorBuilder: (context,index)=>myDivider(),
                           itemCount: cubit.getAllPersonModel!.data!.length,
                         ),
                       ],
                     ),
                   ),
                 ],
               ),
             ),
           ),

         ),
       );
  },
);

  }
}





 class DotIndicator extends StatelessWidget {
  final bool isSelected;

  const DotIndicator({Key? key, required this.isSelected}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 6.0),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        height: isSelected ==true?11:8,
        width: isSelected ==true?11:8,
        decoration: BoxDecoration(
          // borderRadius: BorderRadius.circular(5),
          shape: BoxShape.circle,
          color: !isSelected ? Colors.white : defaultColor,
        ),
      ),
    );
  }
}

// ConditionalBuilder(
//           fallback: (BuildContext context) =>const Center(child: CircularProgressIndicator()),
//           condition:MainCubit.get(context).getAllPersonModel!=null,
//           builder: (BuildContext context)=> SingleChildScrollView(
//             scrollDirection: Axis.vertical,
//             physics: const BouncingScrollPhysics(),
//             child: Column(
//               children: [
//                 if(cubit.oldTenModel != null)
//                   FadeInLeft(
//                     animate: true,
//                     child: Stack(
//                   alignment:AlignmentDirectional.bottomCenter,
//                     children: [
//                     GestureDetector(
//                       onTap: (){
//                         navigateTo(context, DescriptionScreen(
//                           model: cubit.oldTenModel!.data![indicatorIndex],
//                         ));
//                       },
//                       child: Container(
//                         color: cubit.isDark == false ?Colors.grey.withOpacity(.3): Colors.black,
//                         child: CarouselSlider(
//                           items: cubit.oldTenModel!.data!.map((e) =>
//                               Container(
//                                 decoration: BoxDecoration(
//                                   borderRadius: BorderRadius.circular(10),
//                                   image:  DecorationImage(
//                                     image: NetworkImage(e.photo!, ),
//
//                                     // centerSlice: Rect.largest,
//                                    // fit: BoxFit.cover
//                                   ),
//
//                                 ),
//
//                               ),
//
//                           ).toList(),
//                           options:CarouselOptions(
//                             autoPlayCurve: Curves.fastOutSlowIn,
//                             initialPage: 0,
//                             enableInfiniteScroll: true,
//                             reverse: false,
//                             autoPlayInterval:const Duration(seconds: 3),
//                             autoPlayAnimationDuration: const Duration(seconds: 1),
//                             viewportFraction: .4,
//                              enlargeCenterPage: true,
//                             autoPlay: true,
//                             height: 210,
//                             onPageChanged: ( index,  reason) {
//                               setState(() {
//                                 indicatorIndex=index;
//                               });
//
//                             },
//
//
//
//                           ),
//
//
//
//                         ),
//                       ),
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.only(bottom: 10),
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           for(int index = 0; index<cubit.oldTenModel!.data!.length; index++)
//                             DotIndicator(isSelected: index == indicatorIndex?true:false),
//
//
//
//                         ],),
//                     ),
//                   ],
//               ),
//                 ),
//                 MaterialButton(
//                   color: cubit.isDark==false? Colors.white:Colors.black,
//                   onPressed: (){
//                 navigateTo(context, SearchScreen());
//               },
//                 padding:const EdgeInsets.symmetric(horizontal: 12.0,vertical:10) ,
//                 child: Row(
//                   children: [
//                     Expanded(
//                       child: Container(
//                         height: 50,
//                         // width: double.maxFinite,
//                         decoration: BoxDecoration(
//                             border: Border.all(color:cubit.isDark==false? Colors.grey:Colors.white,width: 1),
//                             borderRadius:const BorderRadius.all(Radius.circular(50))
//                         ),
//                         child:const Center(child: Text('Search by image...')),
//                       ),
//                     ),
//                     const  SizedBox(width: 20,),
//                     Container(
//                         height: 50,
//                         width: 50,
//                         decoration: BoxDecoration(
//                           border: Border.all(color: Colors.grey,width: 1),
//                           borderRadius:const BorderRadius.all(Radius.circular(50)),
//                           color: defaultColor,
//
//                         ),
//                         child: const Icon(IconBroken.Camera,color: Colors.white,size: 25,))
//                   ],
//                 ),
//               ),
//
//                 Container(
//                 color: Colors.grey.withOpacity(.1) ,
//                 child: Column(
//                   children: [
//                     //Filter
//                     Padding(
//                       padding: const EdgeInsets.symmetric(horizontal: 12,vertical: 4),
//                       //filter
//                       child: Container(
//                         decoration: BoxDecoration(
//                             boxShadow: [
//                               BoxShadow(
//                                 color: Colors.grey.withOpacity(0.3),
//                                 offset: const Offset(-10, 10),
//                                 blurRadius: 20,
//                                 spreadRadius: 4,
//                               ),
//                             ]
//                         ),
//                         // filter
//                         child: Row(
//                           children:  [
//                             Text('${cubit.getAllPersonModel!.data!.length}  ',style: TextStyle(
//                                 fontFamily: 'Jannah',fontSize: 16,fontWeight: FontWeight.normal,color: defaultColor),),
//                              Text('Status found',style: TextStyle(
//                               color: cubit.isDark==false? Colors.black:Colors.white,
//                               fontFamily: 'Jannah',fontSize: 16,fontWeight: FontWeight.normal,),),
//                             const Spacer(),
//                             MaterialButton(onPressed: (){
//                               navigateTo(context,const PersonalFilterScreen());
//
//                             },child: Row(children: [
//                               const Text('Filter',style:TextStyle(
//                                 fontFamily: 'Jannah',fontSize: 16,fontWeight: FontWeight.normal,),),
//                               const SizedBox(width: 10,),
//                               Icon(IconBroken.Filter,color: defaultColor,)
//                             ],),)
//
//                           ],
//                         ),
//                       ),
//                     ),
//                     const SizedBox(height: 10,),
//                     // list item
//                     ListView.separated(
//                       shrinkWrap: true,
//                       physics: const NeverScrollableScrollPhysics(),
//
//                       itemBuilder: (context, index) =>FadeInLeft(
//                         child: GestureDetector(
//                           onTap: ()=>navigateTo(context, DescriptionScreen(
//                               model: cubit.getAllPersonModel!.data![index],
//                           )),
//                           child: buildItem(context,
//                               height: MediaQuery.of(context).size.height,
//                               width: MediaQuery.of(context).size.width,
//                             model: cubit.getAllPersonModel!.data![index]
//                           ),
//
//                         ),
//                       ) ,
//                       separatorBuilder: (context,index)=>myDivider(),
//                       itemCount: cubit.getAllPersonModel!.data!.length,
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//       ),
//
//     ),

// stack

// if(cubit.oldTenModel != null)
//                   FadeInLeft(
//                     animate: true,
//                     child: Stack(
//                   alignment:AlignmentDirectional.bottomCenter,
//                     children: [
//                     GestureDetector(
//                       onTap: (){
//                         navigateTo(context, DescriptionScreen(
//                           model: cubit.oldTenModel!.data![indicatorIndex],
//                         ));
//                       },
//                       child: Container(
//                         color: cubit.isDark == false ?Colors.grey.withOpacity(.3): Colors.black,
//                         child: CarouselSlider(
//                           items: cubit.oldTenModel!.data!.map((e) =>
//                               Container(
//                                 decoration: BoxDecoration(
//                                   borderRadius: BorderRadius.circular(10),
//                                   image:  DecorationImage(
//                                     image: NetworkImage(e.photo!, ),
//
//                                     // centerSlice: Rect.largest,
//                                    // fit: BoxFit.cover
//                                   ),
//
//                                 ),
//
//                               ),
//
//                           ).toList(),
//                           options:CarouselOptions(
//                             autoPlayCurve: Curves.fastOutSlowIn,
//                             initialPage: 0,
//                             enableInfiniteScroll: true,
//                             reverse: false,
//                             autoPlayInterval:const Duration(seconds: 3),
//                             autoPlayAnimationDuration: const Duration(seconds: 1),
//                             viewportFraction: .4,
//                              enlargeCenterPage: true,
//                             autoPlay: true,
//                             height: 210,
//                             onPageChanged: ( index,  reason) {
//                               setState(() {
//                                 indicatorIndex=index;
//                               });
//
//                             },
//
//
//
//                           ),
//
//
//
//                         ),
//                       ),
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.only(bottom: 10),
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           for(int index = 0; index<cubit.oldTenModel!.data!.length; index++)
//                             DotIndicator(isSelected: index == indicatorIndex?true:false),
//
//
//
//                         ],),
//                     ),
//                   ],
//               ),
//                 ),


// search MaterialButton(
//                   color: cubit.isDark==false? Colors.white:Colors.black,
//                   onPressed: (){
//                 navigateTo(context, SearchScreen());
//               },
//                 padding:const EdgeInsets.symmetric(horizontal: 12.0,vertical:10) ,
//                 child: Row(
//                   children: [
//                     Expanded(
//                       child: Container(
//                         height: 50,
//                         // width: double.maxFinite,
//                         decoration: BoxDecoration(
//                             border: Border.all(color:cubit.isDark==false? Colors.grey:Colors.white,width: 1),
//                             borderRadius:const BorderRadius.all(Radius.circular(50))
//                         ),
//                         child:const Center(child: Text('Search by image...')),
//                       ),
//                     ),
//                     const  SizedBox(width: 20,),
//                     Container(
//                         height: 50,
//                         width: 50,
//                         decoration: BoxDecoration(
//                           border: Border.all(color: Colors.grey,width: 1),
//                           borderRadius:const BorderRadius.all(Radius.circular(50)),
//                           color: defaultColor,
//
//                         ),
//                         child: const Icon(IconBroken.Camera,color: Colors.white,size: 25,))
//                   ],
//                 ),
//               ),



// //Filter
//                     Padding(
//                       padding: const EdgeInsets.symmetric(horizontal: 12,vertical: 4),
//                       //filter
//                       child: Container(
//                         decoration: BoxDecoration(
//                             boxShadow: [
//                               BoxShadow(
//                                 color: Colors.grey.withOpacity(0.3),
//                                 offset: const Offset(-10, 10),
//                                 blurRadius: 20,
//                                 spreadRadius: 4,
//                               ),
//                             ]
//                         ),
//                         // filter
//                         child: Row(
//                           children:  [
//                             Text('${cubit.getAllPersonModel!.data!.length}  ',style: TextStyle(
//                                 fontFamily: 'Jannah',fontSize: 16,fontWeight: FontWeight.normal,color: defaultColor),),
//                              Text('Status found',style: TextStyle(
//                               color: cubit.isDark==false? Colors.black:Colors.white,
//                               fontFamily: 'Jannah',fontSize: 16,fontWeight: FontWeight.normal,),),
//                             const Spacer(),
//                             MaterialButton(onPressed: (){
//                               navigateTo(context,const PersonalFilterScreen());
//
//                             },child: Row(children: [
//                               const Text('Filter',style:TextStyle(
//                                 fontFamily: 'Jannah',fontSize: 16,fontWeight: FontWeight.normal,),),
//                               const SizedBox(width: 10,),
//                               Icon(IconBroken.Filter,color: defaultColor,)
//                             ],),)
//
//                           ],
//                         ),
//                       ),
//                     ),

//    // list item
//                     ListView.separated(
//                       shrinkWrap: true,
//                       physics: const NeverScrollableScrollPhysics(),
//
//                       itemBuilder: (context, index) =>FadeInLeft(
//                         child: GestureDetector(
//                           onTap: ()=>navigateTo(context, DescriptionScreen(
//                               model: cubit.getAllPersonModel!.data![index],
//                           )),
//                           child: buildItem(context,
//                               height: MediaQuery.of(context).size.height,
//                               width: MediaQuery.of(context).size.width,
//                             model: cubit.getAllPersonModel!.data![index]
//                           ),
//
//                         ),
//                       ) ,
//                       separatorBuilder: (context,index)=>myDivider(),
//                       itemCount: cubit.getAllPersonModel!.data!.length,
//                     ),