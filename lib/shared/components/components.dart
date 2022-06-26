import 'dart:io';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:newnew/shared/bloc/main_cubit/main_cubit.dart';
import 'package:newnew/shared/constant.dart';
import 'package:newnew/shared/style/colors.dart';
import 'package:newnew/shared/style/icon_broken.dart';
import 'package:page_transition/page_transition.dart';
import 'package:url_launcher/url_launcher.dart';

Widget defaultButton (
    {
  double width = double.infinity,
  Color? background  ,
  bool isUpperCase = true,
  double height = 40,
  double radius = 0,
  required VoidCallback function,
  required String text,
  required TextStyle style,
  double fontSize = 15,
  IconData? icon,
  Color? iconColor,

}) => Container(
    width: width,
    height: height,
    // decoration: BoxDecoration(
    //     borderRadius: BorderRadius.circular(15),
    //   gradient:LinearGradient(
    //     colors: [Colors.red],
    //
    //   )
    // ),
    child: MaterialButton(
      onPressed:function ,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if(icon != null)
           Icon(icon,color: iconColor,),
          const SizedBox(
            width: 2,
          ),
          Text(
            isUpperCase  ?  text.toUpperCase() : text,
            style: TextStyle(
                color: style.color,
                fontSize: style.fontSize
            ),

          ),
        ],
      ),


    ),

    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(
          radius
      ),
      color: background ?? defaultColor,

    )
);





Widget defaultFormField({
  required TextEditingController controller,
  required TextInputType type,
  bool lockKeyboard=false,
  ValueChanged? oSubmit,
  ValueChanged? onChange,
  GestureTapCallback? onTap,
  required FormFieldValidator validate,
  String? label,
  String? hint,
  Color? hintColor,
  double? hintFontSize,
  IconData? prefix,
  IconData? suffix ,
  bool isPassword =false,
  bool isClickable = true,
  VoidCallback? suffixPressed ,
  String? counterText,
  int? maxLines,
  Color? focusedColors,
  Color? textColor,
  Color? cursorColor,
  Color? counterColor,
  int? maxLength,
  FocusNode? focusNode,
  Function()? onEditingComplete,
  TextInputAction? textInputAction,


}) => TextFormField(
  controller:controller,
  onEditingComplete:onEditingComplete ,

  keyboardType: type,
  obscureText: isPassword,
  onFieldSubmitted :oSubmit,
  onChanged: onChange,
  validator: validate,
  onTap: onTap,
  enabled: isClickable,
  readOnly:lockKeyboard ,
  maxLength: maxLength,
  textInputAction: textInputAction,
  cursorColor:cursorColor??defaultColor,
  cursorWidth: 2,
  cursorHeight: 25,
  focusNode:focusNode ,

  style: TextStyle(color:textColor??defaultColor,),
  maxLines: maxLines??1,
  decoration: InputDecoration(

    labelText: label,
    hintText: hint,
    hintStyle:  TextStyle(
        color: hintColor ?? Colors.grey,
        fontSize: hintFontSize??15,
    ),
    prefixIcon: prefix != null? Icon(
        prefix,
      color: Colors.grey
    ):null,
    suffixIcon:suffix != null ? IconButton(
      onPressed:suffixPressed ,
      icon:   Icon(
          suffix,
        color: Colors.grey,

      ),) :null,
   counterText:counterText ,
    counterStyle:TextStyle(color: counterColor??Colors.grey) ,

    // الي مستخدمه
    // border:  OutlineInputBorder(
    //   borderRadius: BorderRadius.circular(15),
    //   borderSide: const BorderSide(
    //     color: Colors.red,
    //   ),
    //
    // ),

    //  الي مش مستخدمه
    enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),

        borderSide: const BorderSide(
          color: Colors.grey,

        ),

    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(15),


      borderSide:  BorderSide(
        color:focusedColors?? defaultColor,
        width: 2
      ),

    ),
    disabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(15),


      borderSide:  const BorderSide(
          color: Colors.grey,
          width: 2
      ),

    ),

  ),

);






void navigateTo(context,widget)=>Navigator.push(
  context, PageTransition(type: PageTransitionType.bottomToTop,child: widget)
);

void navigateToAndRemove(context,widget)=>Navigator.pushAndRemoveUntil(
    context, MaterialPageRoute(
  builder: (context)=>widget,

),
        (route){return false;}
);


Widget defaultFormField2({
  required TextEditingController controller,
  required TextInputType type,
  bool lockKeyboard=false,
  ValueChanged? oSubmit,
  ValueChanged? onChange,
  GestureTapCallback? onTap,
  required FormFieldValidator validate,
  String? label,
  String? hint,
   IconData? prefix,
  IconData? suffix ,
  bool isPassword =false,
  bool isClickable = true,
  VoidCallback? suffixPressed ,
  int? maxLines,
  int? maxLength,
  FocusNode? focusNode,
Function()? onEditingComplete,
  TextInputAction? textInputAction,



}) => TextFormField(
  controller: controller,

  keyboardType: type,
  focusNode:focusNode ,
  onEditingComplete:onEditingComplete ,
  obscureText: isPassword,
  onFieldSubmitted :oSubmit,
  maxLength: maxLength ,
  onChanged: onChange,
  validator: validate,
  textInputAction: textInputAction,
  onTap: onTap,
  enabled: isClickable,
  readOnly:lockKeyboard ,
  decoration: InputDecoration(
    labelText: label,
    hintText: hint,
    hintStyle: const TextStyle(
      color: Colors.grey,
      fontSize: 15,
    ),
    prefixIcon:prefix != null? Icon(
        prefix,
        color: Colors.grey
    ):null,


    suffixIcon:suffix != null ?
    IconButton(
      onPressed:suffixPressed ,
      icon: Icon(suffix, color: Colors.grey,),
    ) : null,








    // الي مستخدمه
    // border:  OutlineInputBorder(
    //   borderRadius: BorderRadius.circular(15),
    //   borderSide: const BorderSide(
    //     color: Colors.red,
    //   ),
    //
    // ),

    //  الي مش مستخدمه
    enabledBorder: UnderlineInputBorder(
      borderRadius: BorderRadius.circular(15),

      borderSide:  BorderSide(
        color: defaultColor,
        width: 2
      ),

    ),

    focusedBorder: UnderlineInputBorder(
      // borderRadius: BorderRadius.circular(15),


      borderSide:  BorderSide(
          color: defaultColor,
          width: 3
      ),

    ),

  ),
  cursorColor:defaultColor,
  cursorWidth: 2,
  cursorHeight: 25,
  style: TextStyle(color:defaultColor,),
  maxLines: maxLines??1,

  //textAlign:TextAlign.end,

);

// item
Widget buildItem(context ,{
  required double? height ,
  required double? width ,
  required  model,


}) => Padding(

  padding: const EdgeInsets.all(8.0),//4
  //parent container
  child: Container(
    //color: Colors.white,

    decoration: BoxDecoration(//remove
        color:MainCubit.get(context).isDark==false? Colors.white:Colors.black,
        borderRadius: const BorderRadius.all(Radius.circular(20)),//remove

        boxShadow:[
          if(MainCubit.get(context).isDark==false)
        BoxShadow(
          color: Colors.grey.withOpacity(0.3),
          offset: const Offset(-10, 10),
          blurRadius: 20,
          spreadRadius: 4,
        ),
          if(MainCubit.get(context).isDark==true)
            BoxShadow(
            color: Colors.grey.withOpacity(0.0),
            offset: const Offset(-10, 10),
            blurRadius: 20,
            spreadRadius: 4,
          ),
      ]
    ),
    height: 230,
    child: Stack(
      children: [
        //first position
        Positioned(
            top: 35,
            left: 10,
            right: 10,
            child:Material(

              // child container
              child: Container(

                height: 180,
                width:width!*0.9 ,
                decoration: BoxDecoration(
                    color: MainCubit.get(context).isDark==false? Colors.white:Colors.black,
                    borderRadius: BorderRadius.circular(0),
                    // boxShadow:[
                    //   BoxShadow(
                    //     color: Colors.grey.withOpacity(0.3),
                    //     offset: const Offset(-10, 10),
                    //     blurRadius: 20,
                    //     spreadRadius: 4,
                    //   )
                    // ]
                ),
              ),
            )
        ),
        //second position image
        Positioned(
            top: 20,//0
            left: 15,
            child:Card(
              elevation: 10,
              shadowColor: Colors.grey.withOpacity(0.5),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              // container for image
              child: Container(
                height: 190,
                width: 140,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  image:  DecorationImage(
                    image: NetworkImage(model.photo!),
                   // fit: BoxFit.cover,

                  ),
                ),
              ),
            )
        ),
        //third position data
        Positioned(
            top: 60,
            left: 175,
            //container for text
            child:SizedBox(
              height: 150,
              width: 160,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children:  [
                  //name
                   Text(model.name!,
                    style: TextStyle(
                      fontSize: 14,
                      color: defaultColor,
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  //Country
                   Text(model.nationality!,
                    style: Theme.of(context).textTheme.bodyText2,
                  ),
                  //line
                   Divider(color: MainCubit.get(context).isDark==false? Colors.black:Colors.white,),
                  //description
                  Text(model.stateType!.toUpperCase(),
                    style:Theme.of(context).textTheme.bodyText1,
                  ),
                  const SizedBox(height: 5,),
                  Row(
                    children:  [
                       Text(formattedDate(model.date!),
                     style:Theme.of(context).textTheme.bodyText1
                      ),
                      const SizedBox(width: 6,),
                      Icon(IconBroken.Calendar,color: defaultColor,),
                    ],
                  ),


                ],
              ),
            )
        )

      ],
    ),
  ),

);

// Case item
Widget buildCaseItem(context ,{
  required double? height ,
  required double? width ,
  required  model,


}) => Padding(

  padding: const EdgeInsets.all(8.0),//4
  //parent container
  child: Container(
    //color: Colors.white,

    decoration: BoxDecoration(//remove
        color:MainCubit.get(context).isDark==false? Colors.white:Colors.black,
        borderRadius: const BorderRadius.all(Radius.circular(20)),//remove

        boxShadow:[
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              offset: const Offset(-10, 10),
              blurRadius: 20,
              spreadRadius: 4,
            ),

        ]
    ),
    height: 230,
    child: Stack(
      children: [
        //first position
        Positioned(
            top: 35,
            left: 10,
            right: 10,
            child:Material(

              // child container
              child: Container(

                height: 180,
                width:width!*0.9 ,
                decoration: BoxDecoration(
                  color: MainCubit.get(context).isDark==false? Colors.white:Colors.black,
                  borderRadius: BorderRadius.circular(0),
                  // boxShadow:[
                  //   BoxShadow(
                  //     color: Colors.grey.withOpacity(0.3),
                  //     offset: const Offset(-10, 10),
                  //     blurRadius: 20,
                  //     spreadRadius: 4,
                  //   )
                  // ]
                ),
              ),
            )
        ),
        //second position image
        Positioned(
            top: 20,//0
            left: 15,
            child:Card(
              elevation: 10,
              shadowColor: Colors.grey.withOpacity(0.5),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              // container for image
              child: Container(
                height: 190,
                width: 140,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  image:  DecorationImage(
                    image: NetworkImage(model.photo!),
                    // fit: BoxFit.cover,

                  ),
                ),
              ),
            )
        ),
        //third position data
        Positioned(
            top: 60,
            left: 175,
            //container for text
            child:SizedBox(
              height: 150,
              width: 160,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children:  [
                  //name
                  Text(model.name!,
                    style: TextStyle(
                      fontSize: 14,
                      color: defaultColor,
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  //Country
                  Text(model.nationality!,
                    style: Theme.of(context).textTheme.bodyText2,
                  ),
                  //line
                  Divider(color: MainCubit.get(context).isDark==false? Colors.black:Colors.white,),
                  //description
                  Text(model.stateType!.toUpperCase(),
                    style:Theme.of(context).textTheme.bodyText1,
                  ),
                  const SizedBox(height: 5,),
                  Row(
                    children:  [
                      Text(formattedDate(model.date!),
                          style:Theme.of(context).textTheme.bodyText1
                      ),
                      const SizedBox(width: 6,),
                      Icon(IconBroken.Calendar,color: defaultColor,),
                    ],
                  ),


                ],
              ),
            )
        )

      ],
    ),
  ),

);

Widget buildThingsItem(context ,{
  required double? height ,
  required double? width ,
  required  model ,
}) => Padding(
  padding: const EdgeInsets.all(8.0),//4
  //parent container
  child: Container(
    //color: Colors.white,

    decoration: BoxDecoration(//remove
        color: MainCubit.get(context).isDark==false? Colors.white:Colors.black,
        borderRadius: const BorderRadius.all( Radius.circular(20)),//remove

        boxShadow:[
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            offset: const Offset(-10, 10),
            blurRadius: 20,
            spreadRadius: 4,
          )
        ]
    ),
    height: 230,
    child: Stack(
      children: [
        //first position
        Positioned(
            top: 35,
            left: 10,
            right: 10,
            child:Material(

              // child container
              child: Container(

                height: 180,
                width:width!*0.9 ,
                decoration: BoxDecoration(
                  color: MainCubit.get(context).isDark==false? Colors.white:Colors.black,
                  borderRadius: BorderRadius.circular(0),
                  // boxShadow:[
                  //   BoxShadow(
                  //     color: Colors.grey.withOpacity(0.3),
                  //     offset: const Offset(-10, 10),
                  //     blurRadius: 20,
                  //     spreadRadius: 4,
                  //   )
                  // ]
                ),
              ),
            )
        ),
        //second position image
        Positioned(
            top: 20,//0
            left: 15,
            child:Card(
              elevation: 10,
              shadowColor: Colors.grey.withOpacity(0.5),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              // container for image
              child: Container(
                height: 190,
                width: 140,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  image:  DecorationImage(
                    image: NetworkImage(model.photo!,),
                  ),

                ),
              ),
            ),
        ),
        //third position data
        Positioned(
            top: 60,
            left: 175,
            //container for text
            child:SizedBox(
              height: 150,
              width: 160,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children:  [
                  //name
                  Text(model.name!,
                    style: TextStyle(
                      fontSize: 14,
                      color: defaultColor,
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  //Country
                   Text(model.type!,
                    style:Theme.of(context).textTheme.bodyText2,
                  ),
                  //line
                   Divider(color: MainCubit.get(context).isDark==false? Colors.black:Colors.white,),
                  //description
                   Text(model.state!,
                    style:Theme.of(context).textTheme.bodyText1,
                  ),
                  const SizedBox(height: 5,),
                  Row(
                    children:  [
                       Text(formattedDate(model.date!),
                        style:Theme.of(context).textTheme.bodyText1
                      ),
                      const SizedBox(width: 6,),
                      Icon(IconBroken.Calendar,color: defaultColor,),
                    ],
                  ),


                ],
              ),
            )
        )

      ],
    ),
  ),

);


// list divider
Widget myDivider()=> Padding(
  padding: const EdgeInsetsDirectional.only(
      start: 20,
    top: 10,
    bottom: 10
  ),
  child: Container(
    width: double.infinity,
    height: 1,
    color: Colors.grey[300],

  ),
);


Widget dropDownButtonFormField({
  required  value,
  required ValueChanged<String?> change,
  IconData? prefixIcon,
  double? fontSize,
  Color? hintColor,
  required List<String> itemsList,
  required String hintText,
   required FormFieldValidator validate,
  FocusNode? focusNode,

})=> DropdownButtonFormField<String>(
  items: itemsList.map<DropdownMenuItem<String>>((String value){
    return DropdownMenuItem<String>(

      child:  Row(
        children: [
          Text(value),
        ],
      ),
      value: value,
    );
  } ).toList(),
  focusNode: focusNode,
  value: value,
  onChanged:change,
  validator:validate,
  style: TextStyle(color: defaultColor,),
  decoration: InputDecoration(
      focusColor: defaultColor,
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
        borderSide: BorderSide(
            color: defaultColor,
            width: 2,
          style: BorderStyle.solid
        ),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
        borderSide: const BorderSide(
            color: Colors.grey,
            width: 1
        ),
      ),
      hintText: hintText,
      hintStyle: TextStyle(fontSize: fontSize,color: hintColor??defaultColor ),
      prefixIcon:  Icon(prefixIcon,color: Colors.grey),
    iconColor: Colors.grey,

  ),

);


void whatsappLink({
  required String phone,
  required String message,
  required BuildContext context,
})async{
  url(){
    if(Platform.isAndroid){
      return "whatsapp://send?phone=$phone&text=$message";

    }else{
      return"whatsapp://wa.me/$phone/?text=${Uri.parse(message)}";

    }
  }
  // ignore: unnecessary_null_comparison
  await canLaunch(url()) ? launch(url()):
  ScaffoldMessenger.of(context).showSnackBar(

    const SnackBar(backgroundColor: Colors.red,
        content: Text('There is no Whatsapp on your Device')),
  );
}


void callingLink({
  required String phone,
  required BuildContext context

})async{
  String url = "tel:$phone";
  // ignore: unnecessary_null_comparison
  await canLaunch(url) ? launch(url):
  ScaffoldMessenger.of(context).showSnackBar(

    const SnackBar(backgroundColor: Colors.red,
        content: Text('error ')),
  );
}



void messengerLink({
  required String userName,
  required BuildContext context

})async{
  String url = "http://m.me/$userName";
  // ignore: unnecessary_null_comparison
  await canLaunch(url) ? launch(url):
  ScaffoldMessenger.of(context).showSnackBar(

    const SnackBar(backgroundColor: Colors.red,
        content: Text('error ')),
  );
}

String formattedDate(timeStamp){
  return DateFormat('yyyy-MM-dd').format(DateTime.parse(timeStamp));
}

void showToast({
  required String text,
  required ToastStates state,
}) {
  Fluttertoast.showToast(
      msg: text,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 5,
      backgroundColor: chooseToastColor(state),
      textColor: Colors.white,
      fontSize: 16.0);
}

enum ToastStates { SUCCESS, ERROR, WARNING }
Color chooseToastColor(ToastStates state) {
  Color color;

  switch (state)
  {
    case ToastStates.SUCCESS:
      color = Colors.green;
      break;
    case ToastStates.WARNING:
      color = Colors.amber;
      break;
    case ToastStates.ERROR:
      color = Colors.red;
      break;
  }
  return color;
}

checkNet(context) {
  if (!result) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('No internet connection'),
        content: Container(
          height: 60,
          width: 80,
          color: defaultColor,
          child: TextButton(
            onPressed: () {
              MainCubit.get(context).justEmitState();
              Navigator.pop(context);
            },
            child: const Text(
              'Click to retry',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }
}
