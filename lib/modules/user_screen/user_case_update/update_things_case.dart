import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newnew/model/get_model/user_missing_things_case.dart';
import 'package:newnew/shared/bloc/main_cubit/main_cubit.dart';
import 'package:newnew/shared/bloc/main_cubit/main_state.dart';
import 'package:newnew/shared/components/components.dart';
import 'package:newnew/shared/style/colors.dart';
import 'package:newnew/shared/style/icon_broken.dart';
import 'package:intl/intl.dart';

class UpdateThingsCaseScreen extends StatelessWidget {
  var nameController = TextEditingController();
  var modelController = TextEditingController();
  var messengerUserNameController = TextEditingController();
  var carNumberController = TextEditingController();
  var descriptionController = TextEditingController();
  var locationController = TextEditingController();
  var lastSeenController = TextEditingController();
  var phoneNumberController = TextEditingController();
  var whatsNumberController = TextEditingController();
  final _nameFocusNode = FocusNode();
  final _modelFocusNode = FocusNode();
  final _descriptionFocusNode = FocusNode();
  final _locationFocusNode = FocusNode();
  final _lastSeenFocusNode = FocusNode();
  final _selectType = FocusNode();
  final _selectColor = FocusNode();
  final _messengerUserNameFocusNode = FocusNode();
  final _phoneNum = FocusNode();
  final _whatsapp = FocusNode();
  final _changeState = FocusNode();
  String? phoneNum;
  String? whatsNum;
  ThingsCaseData? model;

  UpdateThingsCaseScreen({Key? key,
    required this.model
  }) : super(key: key);

  void changeState (String? val){
    stateValue = val!;
  }
  String? stateValue ;

  void changeType (String? val){
    typeValue = val!;
  }
  String? typeValue ;

  void changeColor (String? val){
    colorName = val!;
  }
  String? colorName ;

  var keyForm1=GlobalKey<FormState>();
  var keyForm2=GlobalKey<FormState>();
  var keyForm3=GlobalKey<FormState>();
  var keyForm4=GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {

    return BlocConsumer<MainCubit, MainState>(

      listener: (context, state) {
      },
      builder: (context, state) {

        nameController.text = nameController.text.isEmpty? model!.name??'' : nameController.text ;
        modelController.text = modelController.text.isEmpty? model!.model??'' : modelController.text;
        carNumberController.text = carNumberController.text.isEmpty ? model!.carNumber??'' : carNumberController.text;
        messengerUserNameController.text = messengerUserNameController.text.isEmpty? model!.messengerUserName??'' : messengerUserNameController.text;
        descriptionController.text = descriptionController.text.isEmpty? model!.description??''.toString() : descriptionController.text;
        locationController.text = locationController.text.isEmpty? model!.location??'' : locationController.text;
        lastSeenController.text = lastSeenController.text.isEmpty ? formattedDate(model!.date!) : lastSeenController.text;
        phoneNumberController.text = phoneNumberController.text.isEmpty ? model!.phone??'' : phoneNumberController.text;
        whatsNumberController.text = whatsNumberController.text.isEmpty ? model!.whatsNamber??'' : whatsNumberController.text;
        changeState(stateValue?? model!.state??'');
        changeType(typeValue?? model!.type??'');
        changeColor(colorName??model!.color??'');


        var cubit = MainCubit.get(context);

        List<Step> step=[
          Step(
            title:  Text('Basic Information',style: TextStyle(color:  cubit.isDark==false? Colors.black:Colors.white,)),
            content: Form(
              key: keyForm1,
              child: Column(children: [

                const SizedBox(height: 20,),

                defaultFormField(
                    controller: nameController,
                    focusNode: _nameFocusNode,
                    textInputAction: TextInputAction.next,
                    onEditingComplete: ()=>FocusScope.of(context).requestFocus(_selectType),
                    type: TextInputType.name,
                    hint: "name",
                    validate: (value){
                      if(value!.isEmpty){
                        // return 'required';
                      }
                      return null;
                    }, prefix: IconBroken.Profile),

                const  SizedBox(height: 10,),
                dropDownButtonFormField(
                    change: changeType,
                    focusNode: _selectType,
                    value: typeValue,
                    hintColor: Colors.grey,
                    prefixIcon: IconBroken.Filter_2,
                    itemsList: <String>['paper','Personal belongings','transportation','Other'],
                    hintText: 'select type',
                    validate: (value){
                      // if(value!.isEmpty){
                      //   return 'reqired';
                      // }
                      // return null;
                    }

                ),
                const  SizedBox(height: 10,),


                dropDownButtonFormField(
                    change: changeState,
                    focusNode: _changeState,
                    value: stateValue,
                    hintColor: Colors.grey,
                    prefixIcon: IconBroken.Filter_2,
                    itemsList: <String>['Missing','Found'],
                    hintText: 'select state',
                    validate: (value){
                      // if(value!.isEmpty){
                      //   return 'name must not be empty';
                      // }
                      // return null;
                    }

                ),
                const  SizedBox(height: 10,),
                defaultFormField(
                    controller: modelController,
                    focusNode: _modelFocusNode,
                    textInputAction: TextInputAction.next,
                    onEditingComplete: ()=>FocusScope.of(context).requestFocus(_selectColor),
                    type: TextInputType.number,
                    hint: "model",
                    validate: (value){
                      if(value!.isEmpty){
                        // return 'required';
                      }
                      return null;
                    }, prefix: IconBroken.Profile),

                const  SizedBox(height: 10,),

                dropDownButtonFormField(
                    change: changeColor,
                    focusNode: _selectColor,
                    value: colorName,
                    hintColor: Colors.grey,
                    prefixIcon: IconBroken.Filter_2,
                    itemsList: <String>['Red','black','silver','gray','white'
                      ,'maroon','purple','fuchsia','green','lime','olive'
                      ,'yellow','navy','blue','teal','aqua','blue','lawngreen',
                    ],
                    hintText: 'select Color',
                    validate: (value){
                      // if(value!.isEmpty){
                      //   return 'required';
                      // }
                      // return null;
                    }

                ),
                const  SizedBox(height: 10,),
                if(typeValue == 'transportation')
                  defaultFormField(
                      controller: carNumberController,
                      textInputAction: TextInputAction.next,
                      onEditingComplete: ()=>FocusScope.of(context).requestFocus(_selectType),
                      type: TextInputType.number,
                      hint: "car number",
                      validate: (value){
                        if(value!.isEmpty){
                          // return 'required';
                        }
                        return null;
                      }, prefix: IconBroken.Profile),

                const  SizedBox(height: 10,),
              ],),
            ),
            isActive: true,
            state:cubit.x==0? StepState.editing:StepState.complete,
          ),
          Step(
              title:  Text('Additional information',style: TextStyle(color:  cubit.isDark==false? Colors.black:Colors.white,)),

              isActive: MainCubit.get(context).x>=1,
              state:cubit.x==1? StepState.editing:cubit.x==0?StepState.disabled:StepState.complete,

              content: Form(
                key: keyForm2,
                child: Column(children: [
                  const SizedBox(height: 20,),

                  defaultFormField(
                    controller: descriptionController,
                    focusNode: _descriptionFocusNode,
                    textInputAction: TextInputAction.next,
                    maxLines: 5,
                    type: TextInputType.multiline,
                    hint: "Description...",
                    validate: (value){
                      if(value!.isEmpty){
                        //  return 'required';
                      }
                      return null;
                    }, ),
                  const SizedBox(height: 20,),
                  Container(
                      height: 260,
                      decoration: BoxDecoration(
                        border:Border.all(color: Colors.grey,style: BorderStyle.solid),
                      ),
                      child:  Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [

                            MainCubit.get(context).missingThingsImage == null ?  Image(image: NetworkImage(model!.photo!),height: 180,) :
                            Image(image:FileImage(MainCubit.get(context).missingThingsImage!),height: 180,),
                            const SizedBox(height: 20,),
                            Row(
                              children: [
                                Expanded(
                                  child: defaultButton(function: (){
                                    cubit.deleteMissingThingsImage();
                                  }, text: 'delete',
                                      style: const TextStyle(color: Colors.white),
                                      background: Colors.red
                                  ),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Expanded(
                                  child: defaultButton(function: (){
                                    MainCubit.get(context).getMissingThingsImage(context: context);

                                  }, text: '+add',
                                      style: const TextStyle(color: Colors.white),
                                      background: Colors.blue

                                  ),
                                ),
                              ],
                            )


                          ],
                        ),
                      )),





                  const  SizedBox(height: 20,),

                ],),
              )
          ),
          Step(
              title:  Text('Last seen',style: TextStyle(color:  cubit.isDark==false? Colors.black:Colors.white,)),

              isActive: MainCubit.get(context).x>=2,
              state:cubit.x==2? StepState.editing:cubit.x==0||cubit.x==1?StepState.disabled:StepState.complete,


              content: Form(
                key: keyForm3,
                child: Column(children: [
                  const SizedBox(height: 20,),
                  defaultFormField(
                      controller: lastSeenController,
                      focusNode: _lastSeenFocusNode,
                      textInputAction: TextInputAction.next,
                      onEditingComplete: ()=>FocusScope.of(context).requestFocus(_locationFocusNode),
                      type: TextInputType.none,
                      lockKeyboard: true,
                      hint: 'dd/mm/yyyy',
                      validate: (value){
                        if(value!.isEmpty){
                          return 'required';
                        }
                        return null;
                      }, prefix: IconBroken.Calendar,

                      onTap: (){
                        showDatePicker(context: context, initialDate: DateTime.now(),
                          firstDate: DateTime.parse('2000-12-30'),
                          lastDate: DateTime.now(),
                          initialDatePickerMode:DatePickerMode.year,
                          builder: (BuildContext context, Widget? child){
                            return Theme(
                                data: ThemeData(
                                    colorScheme: ColorScheme.light(primary: defaultColor)

                                ),
                                child: child!);
                          },

                        ).then((value){
                          lastSeenController.text=DateFormat.yMMMMd().format(value??DateTime.now());

                        } );

                      }
                  ),


                  const  SizedBox(height: 20,),

                  defaultFormField(
                      controller: locationController,
                      focusNode: _locationFocusNode,
                      textInputAction: TextInputAction.next,
                      type: TextInputType.text,

                      hint: "Location",
                      validate: (value){
                        if(value!.isEmpty){
                          return 'required';
                        }
                        return null;
                      }, prefix: IconBroken.Location),
                  const  SizedBox(height: 20,),




                ],),
              )
          ),
          Step(
            title:  Text('Contact Info',style: TextStyle(color:  cubit.isDark==false? Colors.black:Colors.white,)),
            content: Form(
              key: keyForm4,
              child: Column(children: [
                const SizedBox(height: 20,),
                defaultFormField(
                    controller: phoneNumberController,
                    focusNode: _phoneNum,
                    textInputAction: TextInputAction.next,
                    onEditingComplete: ()=>FocusScope.of(context).requestFocus(_whatsapp),
                    type: TextInputType.phone,
                    hint: "PhoneNumber",
                    validate: (value){
                      if(value!.isEmpty){
                        // return 'required';
                      }
                      return null;
                    },
                    prefix: IconBroken.Call
                ),
                const SizedBox(height: 20,),
                defaultFormField(
                    controller: whatsNumberController,
                    focusNode: _whatsapp,
                    textInputAction: TextInputAction.next,
                    onEditingComplete: ()=>FocusScope.of(context).requestFocus(_messengerUserNameFocusNode),
                    type: TextInputType.phone,
                    hint: "WhatsNumber",
                    validate: (value){
                      if(value!.isEmpty){
                        // return 'required';
                      }
                      return null;
                    },
                    prefix: Icons.whatsapp
                ),
                const SizedBox(height: 20,),
                defaultFormField(
                    controller: messengerUserNameController,
                    focusNode: _messengerUserNameFocusNode,
                    textInputAction: TextInputAction.next,
                    type: TextInputType.name,
                    hint: "MessengerUserName",
                    validate: (value){
                      if(value!.isEmpty){
                        // return 'required';
                      }
                      return null;
                    },
                    prefix: IconBroken.Message
                ),
                const SizedBox(height: 20,),

              ],
              ),
            ),
            isActive: MainCubit.get(context).x>=3,
            state:cubit.x==3? StepState.editing:cubit.x==0||cubit.x==1||cubit.x==2?StepState.disabled:StepState.complete,

          ),
        ];

        void next (){
          switch(cubit.x){
            case 0:
              if(keyForm1.currentState!.validate()){

                if(cubit.x+1 != step.length) {
                  cubit.tap(cubit.x+1);
                }      }
              break;
            case 1:  if(keyForm2.currentState!.validate()){

              if(cubit.x+1 != step.length) {
                cubit.tap(cubit.x+1);
              }      }
            break;
            case 2:
              if(keyForm3.currentState!.validate()){

                if(cubit.x+1 != step.length) {
                  cubit.tap(cubit.x+1);
                }      }
              break;
            case 3:
              if(keyForm4.currentState!.validate()){

                if(cubit.x+1 != step.length) {
                  cubit.tap(cubit.x+1);
                }      }
              break;
            default :
              print('000000000000000000000000');
          }


        }
        void cancel(){
          cubit.x>0 ? cubit.tap(cubit.x-1) : null;
        }
        return GestureDetector(
          onTap: (){
            FocusScope.of(context).unfocus();
          },
          child: Scaffold(
            appBar: AppBar(
              title: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('M',style: TextStyle(fontFamily: 'Jannah',color: defaultColor,fontSize: 20),),
                  const Text('issing',),
                ],),
              centerTitle: true,

            ),
            body: Theme(
              data: Theme.of(context).copyWith(
                colorScheme: ColorScheme.light(primary: defaultColor,),
              ),
              child: Stepper(
                steps: step,
                type: StepperType.vertical,
                onStepContinue: next,
                onStepCancel: cancel,
                onStepTapped:cubit.tap ,
                currentStep: MainCubit.get(context).x,
                physics: const ClampingScrollPhysics(),

                controlsBuilder:(x,y){
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child:cubit.x==0? defaultButton(function: (){
                      next();
                    }, text: 'next', style:const TextStyle(color: Colors.white),background: defaultColor ,) :cubit.x==3?
                    Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: defaultButton(function: (){
                                cancel();
                              }, text: 'Previous', style:const TextStyle(color: Colors.white),background: Colors.grey ,
                              ),
                            ),
                            const SizedBox(width: 20,),
                            Expanded(
                              child: defaultButton(function: (){
                                MainCubit.get(context).updateThingsCase(
                                    whatApp:whatsNum ,
                                    phone:phoneNum ,
                                    date:lastSeenController.text ,
                                    photo:cubit.missingThingsImage ,
                                    state:stateValue ,
                                    name:nameController.text ,
                                    color: colorName,
                                    type: typeValue,
                                    carNumber: carNumberController.text,
                                    description:descriptionController.text ,
                                    location: locationController.text,
                                    messengerUserName:messengerUserNameController.text ,
                                    model: modelController.text,
                                    id: model!.sId!,
                                );
                              }, text: 'update', style: const TextStyle(color: Colors.white),background: defaultColor ,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 30,),
                        if(state is UpdateUserCaseLoadingState)
                          const LinearProgressIndicator(),
                      ],
                    ):
                    Row(
                      children: [
                        Expanded(
                          child: defaultButton(function: (){
                            cancel();
                          }, text: 'Previous', style:const TextStyle(color: Colors.white),background: Colors.grey ,
                          ),
                        ),

                        const SizedBox(width: 20,),
                        Expanded(
                          child: defaultButton(function: (){
                            next();
                          }, text: 'next', style:const TextStyle(color: Colors.white),background: defaultColor ,
                          ),
                        ),

                      ],
                    ),


                  );
                } ,





              ),
            ),
          ),
        );
      },
    );

  }
}

