import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newnew/model/get_model/user_search_for_family_case.dart';
import 'package:newnew/shared/bloc/main_cubit/main_cubit.dart';
import 'package:newnew/shared/bloc/main_cubit/main_state.dart';
import 'package:newnew/shared/components/components.dart';
import 'package:newnew/shared/style/colors.dart';
import 'package:newnew/shared/style/icon_broken.dart';
import 'package:intl/intl.dart';

class UpdateUserSearchForFamilyCaseScreen extends StatelessWidget {
  var nameController = TextEditingController();
  var fatherNameController = TextEditingController();
  var motherNameController = TextEditingController();
  var weightController = TextEditingController();
  var heightController = TextEditingController();
  var characteristicsController = TextEditingController();
  var lastSeenController = TextEditingController();
  var cityController = TextEditingController();
  var countryController = TextEditingController();
  var stateController = TextEditingController();
  var accidentController = TextEditingController();
  var messengerUserNameController = TextEditingController();
  var yearOfBirthController = TextEditingController();
  var phoneNumberController = TextEditingController();
  var whatsNumberController = TextEditingController();
  final _nameFocusNode = FocusNode();
  final _fatherNameFocusNode = FocusNode();
  final _motherNameFocusNode = FocusNode();
  final _weightFocusNode = FocusNode();
  final _heightFocusNode = FocusNode();
  final _characteristicsFocusNode = FocusNode();
  final _lastSeenFocusNode = FocusNode();
  final _cityFocusNode = FocusNode();
  final _countryFocusNode = FocusNode();
  final _stateFocusNode = FocusNode();
  final _accidentFocusNode = FocusNode();
  final _messengerUserNameFocusNode = FocusNode();
  final _phoneFocusNode = FocusNode();
  final _whatsNumberFocusNode = FocusNode();
  final _yearOfBirthFocusNode = FocusNode();
  final _gender = FocusNode();
  final _changeCountry = FocusNode();
  String? phoneNum;
  String? whatsNum;
  SearchForFamilyCaseData? model;

  UpdateUserSearchForFamilyCaseScreen({Key? key,
    required this.model}) : super(key: key);

  void changeGender (String? val){
    ganderValue = val!;
  }
  String? ganderValue ;

  void changeCountry (String? val){
    countryName = val!;
  }
  String? countryName ;

  var keyForm1=GlobalKey<FormState>();
  var keyForm2=GlobalKey<FormState>();
  var keyForm3=GlobalKey<FormState>();
  var keyForm4=GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {

    return BlocConsumer<MainCubit, MainState>(

      listener: (context, state) {
        // if(state is UploadMissingPersonSuccessState){
        //   if(state.uploadPersonModel.status == 'success'){
        //     Fluttertoast.showToast(
        //       msg:state.uploadPersonModel.message!,
        //       toastLength: Toast.LENGTH_LONG,
        //       gravity: ToastGravity.BOTTOM,
        //       timeInSecForIosWeb: 2,
        //       backgroundColor: Colors.green,
        //       textColor: Colors.white,
        //       fontSize: 16.0,
        //
        //     );
        //   }else{
        //     Fluttertoast.showToast(
        //       msg:state.uploadPersonModel.message!,
        //       toastLength: Toast.LENGTH_LONG,
        //       gravity: ToastGravity.BOTTOM,
        //       timeInSecForIosWeb: 2,
        //       backgroundColor: Colors.red,
        //       textColor: Colors.white,
        //       fontSize: 16.0,
        //
        //     );
        //   }
        //
        // }
      },
      builder: (context, state) {

        nameController.text = nameController.text.isEmpty ? model!.name! : nameController.text;
        fatherNameController.text = fatherNameController.text.isEmpty?model!.fatherName! : fatherNameController.text;
        motherNameController.text = motherNameController.text.isEmpty?model!.motherName! :motherNameController.text;
        weightController.text = weightController.text.isEmpty?model!.weight!.toString() : weightController.text;
        heightController.text = heightController.text.isEmpty?model!.height!.toString() : heightController.text;
        characteristicsController.text =  characteristicsController.text.isEmpty ? model!.characteristics! : characteristicsController.text;
        lastSeenController.text = lastSeenController.text.isEmpty? formattedDate(model!.date!) : lastSeenController.text;
        cityController.text = cityController.text.isEmpty? model!.city! : cityController.text ;
        countryController.text = countryController.text.isEmpty? model!.country! : countryController.text;
        stateController.text = stateController.text.isEmpty ? model!.state! : stateController.text;
        accidentController.text = accidentController.text.isEmpty ? model!.circumstances! : accidentController.text;
        messengerUserNameController.text = messengerUserNameController.text.isEmpty? model!.messangerUserName! : messengerUserNameController.text;
        yearOfBirthController.text = yearOfBirthController.text.isEmpty? model!.yearOfBirth!.toString() : yearOfBirthController.text;
        phoneNumberController.text = phoneNumberController.text.isEmpty? model!.phone! : phoneNumberController.text;
        whatsNumberController.text = whatsNumberController.text.isEmpty ? model!.whatsApp! : whatsNumberController.text;
        changeGender(ganderValue?? model!.gender!);
        changeCountry(countryName?? model!.nationality!);
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
                    onEditingComplete: ()=>FocusScope.of(context).requestFocus(_fatherNameFocusNode),
                    textInputAction:TextInputAction.next ,
                    type: TextInputType.name,
                    hint: "name",
                    validate: (value){
                      if(value!.isEmpty){
                        // return 'required';
                      }
                      return null;
                    }, prefix: IconBroken.Profile),
                const  SizedBox(height: 10,),
                defaultFormField(
                    controller: fatherNameController,
                    focusNode: _fatherNameFocusNode,
                    onEditingComplete: ()=>FocusScope.of(context).requestFocus(_motherNameFocusNode),
                    textInputAction:TextInputAction.next ,
                    type: TextInputType.name,
                    hint: "Father name",
                    validate: (value){
                      // if(value!.isEmpty){
                      //   return 'name must not be empty';
                      // }
                      return null;
                    }, prefix: IconBroken.Profile),
                const  SizedBox(height: 10,),
                defaultFormField(
                    controller: motherNameController,
                    focusNode: _motherNameFocusNode,
                    onEditingComplete: ()=>FocusScope.of(context).requestFocus(_gender),
                    textInputAction:TextInputAction.next ,
                    type: TextInputType.name,
                    hint: "Mother name",
                    validate: (value){
                      // if(value!.isEmpty){
                      //   return 'name must not be empty';
                      // }
                      return null;
                    }, prefix: IconBroken.Profile),
                const  SizedBox(height: 10,),

                dropDownButtonFormField(
                    change: changeGender,
                    focusNode: _gender,
                    value: ganderValue,
                    hintColor: Colors.grey,
                    prefixIcon: IconBroken.Filter_2,
                    itemsList: <String>['male','female'],
                    hintText: 'select gender',
                    validate: (value){
                      // if(value!.isEmpty){
                      //   return 'name must not be empty';
                      // }
                      return null;
                    }

                ),
                const  SizedBox(height: 10,),
                defaultFormField(
                  controller: yearOfBirthController,
                  focusNode: _yearOfBirthFocusNode,
                  onEditingComplete: ()=>FocusScope.of(context).requestFocus(_weightFocusNode),
                  textInputAction:TextInputAction.next ,
                  type: TextInputType.number,
                  hint: "yearOfBirth",
                  validate: (value){
                    if(value!.isEmpty){
                      return 'required';
                    }
                    else{
                      if(int.parse(value!) >2022 || int.parse(value!) < 1960){
                        return 'yearOfBirth must be between 2022 and 1960';
                      }
                      return null;
                    }



                  }, ),
                const  SizedBox(height: 10,),
                // height weight
                Row(children: [
                  Expanded(
                    child: defaultFormField(
                      controller: weightController,
                      focusNode: _weightFocusNode,
                      onEditingComplete: ()=>FocusScope.of(context).requestFocus(_heightFocusNode),
                      textInputAction:TextInputAction.next ,
                      type: TextInputType.number,
                      hint: "weight",
                      counterText: 'Kg',

                      validate: (value){
                        if(value!.isEmpty){
                          //  return 'required';
                        }
                        return null;

                      }, ),
                  ),
                  const  SizedBox(width: 15,),

                  Expanded(
                    child: defaultFormField(
                      controller: heightController,
                      focusNode: _heightFocusNode,
                      onEditingComplete: ()=>FocusScope.of(context).requestFocus(_changeCountry),
                      textInputAction:TextInputAction.next ,
                      type: TextInputType.number,
                      hint: "height",
                      counterText: "Cm",
                      validate: (value){
                        if(value!.isEmpty){
                          //  return 'required';
                        }
                        return null;
                      },

                    ),
                  ),
                ],),
                dropDownButtonFormField(
                    change: changeCountry,
                    focusNode: _changeCountry,
                    value: countryName,
                    hintColor: Colors.grey,
                    prefixIcon: IconBroken.Filter_2,
                    itemsList: <String>['Egypt','Palestine','Tunisia','Algeria','Morocco'
                      ,'Iraq','Syria','Yemen','Libya','Jordan','Emirates','Lebanon'
                      ,'Mauritania','Kuwait','Oman','Qatar','Jubbuti','Bahrain','Union of Comoros'
                      ,'Palestine','Somalia'],
                    hintText: 'select Nationality',
                    validate: (value){
                      // if(value!.isEmpty){
                      //   return 'required';
                      // }
                      // return null;
                    }

                ),
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
                    controller: characteristicsController,
                    focusNode: _characteristicsFocusNode,
                    textInputAction:TextInputAction.next ,
                    maxLines: 5,
                    type: TextInputType.multiline,
                    hint: "Some distinguishing signs, if any, such as blind or mentally disturbed ...",
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

                            MainCubit.get(context).searchForFamilyImage == null ?  Image(image: NetworkImage(model!.photo!),height: 180,) :
                            Image(image:FileImage(MainCubit.get(context).searchForFamilyImage!),height: 180,),
                            const SizedBox(height: 20,),
                            Row(
                              children: [
                                Expanded(
                                  child: defaultButton(function: (){
                                    cubit.deleteSearchForFamilyImage();
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
                                    MainCubit.get(context).getPersonImage(context: context);

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
                      controller:lastSeenController,
                      focusNode: _lastSeenFocusNode,
                      onEditingComplete: ()=>FocusScope.of(context).requestFocus(_countryFocusNode),
                      textInputAction:TextInputAction.next ,
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
                      controller: countryController,
                      focusNode: _countryFocusNode,
                      onEditingComplete: ()=>FocusScope.of(context).requestFocus(_stateFocusNode),
                      textInputAction:TextInputAction.next ,
                      type: TextInputType.text,

                      hint: "Country",
                      validate: (value){
                        if(value!.isEmpty){
                          return 'required';
                        }
                        return null;
                      }, prefix: IconBroken.Profile),
                  const  SizedBox(height: 20,),

                  defaultFormField(
                      controller: stateController,
                      focusNode: _stateFocusNode,
                      onEditingComplete: ()=>FocusScope.of(context).requestFocus(_cityFocusNode),
                      textInputAction:TextInputAction.next ,
                      type: TextInputType.text,
                      hint: "state",


                      validate: (value){
                        if(value!.isEmpty){
                          return 'required';
                        }
                        return null;
                      }, prefix: IconBroken.Profile),
                  const  SizedBox(height: 20,),

                  defaultFormField(
                      controller: cityController,
                      focusNode: _cityFocusNode,
                      onEditingComplete: ()=>FocusScope.of(context).requestFocus(_accidentFocusNode),
                      textInputAction:TextInputAction.next ,
                      type: TextInputType.text,
                      hint: "City",
                      validate: (value){
                        if(value!.isEmpty){
                          return 'required';
                        }
                        return null;
                      }, prefix: IconBroken.Profile),
                  const  SizedBox(height: 20,),

                  defaultFormField(
                    controller: accidentController,
                    focusNode: _accidentFocusNode,
                    textInputAction:TextInputAction.next ,
                    type: TextInputType.text,
                    hint: "Information about the accident",
                    maxLines: 5,
                    validate: (value){
                      if(value!.isEmpty){
                        return 'required';
                      }
                      return null;
                    },),


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
                    focusNode: _phoneFocusNode,
                    onEditingComplete: ()=>FocusScope.of(context).requestFocus(_whatsNumberFocusNode),
                    textInputAction:TextInputAction.next ,
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
                    focusNode: _whatsNumberFocusNode,
                    onEditingComplete: ()=>FocusScope.of(context).requestFocus(_messengerUserNameFocusNode),
                    textInputAction:TextInputAction.next ,
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
                    textInputAction:TextInputAction.next ,
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
                              child: defaultButton(
                                function: (){
                                  MainCubit.get(context).updateSearchFamilyCase(
                                    height: heightController.text,
                                    name: nameController.text,
                                    state: stateController.text,
                                    fatherName: fatherNameController.text,
                                    motherName: motherNameController.text,
                                    gender: ganderValue,
                                    yearOfBirth: yearOfBirthController.text,
                                    weight: weightController.text,
                                    nationality: countryName,
                                    photo: cubit.searchForFamilyImage,
                                    characteristics: characteristicsController.text,
                                    date: lastSeenController.text,
                                    country: countryController.text,
                                    city: cityController.text,
                                    messengerUserName: messengerUserNameController.text,
                                    circumstances: accidentController.text,
                                    phone: phoneNum,
                                    whatApp: whatsNum,
                                    id: model!.sId!,
                                  );
                                },
                                text: 'update', style: const TextStyle(color: Colors.white),background: defaultColor ,
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
                      ],),
                  );
                },
              ),
            ),
          ),
        );
      },
    );

  }
}
