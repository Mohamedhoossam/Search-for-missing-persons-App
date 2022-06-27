import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:newnew/shared/bloc/main_cubit/main_cubit.dart';
import 'package:newnew/shared/bloc/main_cubit/main_state.dart';
import 'package:newnew/shared/components/components.dart';
import 'package:newnew/shared/style/colors.dart';
import 'package:newnew/shared/style/icon_broken.dart';

class ContactUsScreen extends StatelessWidget {

  final messageController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final subjectController = TextEditingController();
  final nameController = TextEditingController();
  final _nameFocusNode = FocusNode();
  final _emailFocusNode = FocusNode();
  final _phoneNumFocusNode = FocusNode();
  final _subjectFocusNode = FocusNode();
  final _messageFocusNode = FocusNode();
  var keyForm = GlobalKey<FormState>();
  ContactUsScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MainCubit, MainState>(
  listener: (context, state) {
    if(state is ContactUsSuccessState){
      if(state.contactUsModel.status=='success'){
        showToast(state:ToastStates.SUCCESS ,text: state.contactUsModel.message!);
      }else{
        showToast(state:ToastStates.ERROR ,text: state.contactUsModel.message!);
      }
    }
  },
  builder: (context, state) {
    MainCubit cubit = MainCubit.get(context);
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('M',style: TextStyle(fontFamily: 'Jannah',color: defaultColor,fontSize: 20),),
            const Text('issing',),
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
        child: Form(
          key: keyForm,
          child: ListView(
          physics: const BouncingScrollPhysics(),
          children: [
            if(state is ContactUsLoadingState)
            const LinearProgressIndicator(),
            const SizedBox(height:15,),
             Text('Contact us',
              style: TextStyle(
                  fontFamily: 'Jannah',
                  color:cubit.isDark==false? Colors.black:Colors.white,
                  fontSize: 20),
            ),
            const SizedBox(height: 20,),
            Row(children: const [
              Expanded(child: Divider(color: Colors.grey,height: 1,)),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Text('with'),
              ),
              Expanded(child: Divider(color: Colors.grey,height: 1,)),

            ],),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(onPressed: (){
                  whatsappLink(phone: '201023319002', message: "", context: context);
                }, icon: const Icon(Icons.whatsapp),
                  color: Colors.green,
                  splashColor: Colors.green,
                  iconSize: 40,),
                IconButton(onPressed: (){
                  messengerLink(userName: 'mohamedhossam.mohamed.3', context: context);
                }, icon: const Icon(Icons.facebook),
                  color: HexColor('3b5998'),
                  splashColor: Colors.blue,
                  iconSize: 40,),
                IconButton(onPressed: (){
                  callingLink(phone: '+201023319002', context: context);
                }, icon:  const Icon(Icons.add_ic_call_outlined,color: Colors.green,),
                  splashColor: Colors.green,
                  iconSize: 30,)

              ],),
            const SizedBox(height: 20,),
            Row(children: const [
              Expanded(child: Divider(color: Colors.grey,height: 1,)),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Text('Or'),
              ),
              Expanded(child: Divider(color: Colors.grey,height: 1,)),

            ],),
            defaultFormField2(
                controller:nameController ,
                type: TextInputType.name,
                hint: 'Name',
                focusNode: _nameFocusNode,
                textInputAction: TextInputAction.next,
                onEditingComplete: ()=>FocusScope.of(context).requestFocus(_emailFocusNode),
                validate: (value) {
                  if(value!.isEmpty){
                    return 'Required';
                  }
                  return null;
                }

                ),
            const SizedBox(height: 8,),
            defaultFormField2(
                controller:emailController ,
                type: TextInputType.emailAddress,
                hint: 'Email',
                focusNode: _emailFocusNode,
                textInputAction: TextInputAction.next,
                onEditingComplete: ()=>FocusScope.of(context).requestFocus(_phoneNumFocusNode),
                validate: (value) {
                  if(value!.isEmpty){
                    return 'Required';
                  }
                  return null;
                }),
            const SizedBox(height: 8,),
            defaultFormField2(
                controller:phoneController ,
                type: TextInputType.phone,
                hint: 'Phone num',
                focusNode: _phoneNumFocusNode,
                textInputAction: TextInputAction.next,
                onEditingComplete: ()=>FocusScope.of(context).requestFocus(_subjectFocusNode),
                validate: (value) {
                  if(value!.isEmpty){
                    return 'Required';
                  }
                  return null;
                }),
            const SizedBox(height: 8,),
            defaultFormField2(
                controller:subjectController,
                type: TextInputType.text,
                hint: 'Subject',
                focusNode: _subjectFocusNode,
                textInputAction: TextInputAction.next,
                onEditingComplete: ()=>FocusScope.of(context).requestFocus(_messageFocusNode),
                validate: (value) {
                  if(value!.isEmpty){
                    return 'Required';
                  }
                  return null;
                }),
            const SizedBox(height: 8,),
            defaultFormField2(
                controller:messageController ,
                type: TextInputType.text,
                hint: 'Tell us how we can help',
                focusNode: _messageFocusNode,
                textInputAction: TextInputAction.done,
                maxLines: 6,
                validate: (value) {
                  if(value!.isEmpty){
                    return 'Describe your problem further';
                  }
                  return null;
                }),
          ],
            ),
        ),
      ),
      floatingActionButtonLocation:FloatingActionButtonLocation.centerFloat ,
      persistentFooterButtons: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: SizedBox(
            width: double.maxFinite,
            child: Row(
              children: [
                Column(
                  children:  [
                    Text('We will respond to you ',style: TextStyle(fontFamily: 'Jannah',color:cubit.isDark==false? Colors.black:Colors.white),),
                    Text('as soon as possible ',style: TextStyle(fontFamily: 'Jannah',color: cubit.isDark==false? Colors.black:Colors.white),),
                   ],
                ),
                const Spacer(),
                MaterialButton(
                  onPressed: (){
                   if( keyForm.currentState!.validate()){
                     cubit.contactUs(
                       name:nameController.text,
                       email: emailController.text,
                       message: messageController.text,
                       subject: subjectController.text,
                       phone: phoneController.text,
                     );
                   }
                    },
                  color:defaultColor ,
                  child:const Text('Send',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                  height: 50,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30)
                  ),
                ),
                // contact
              ]
            ),
          ),
        ),
      ],
    );
  },
);
  }
}
