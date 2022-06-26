import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:newnew/shared/bloc/main_cubit/main_cubit.dart';
import 'package:newnew/shared/bloc/main_cubit/main_state.dart';
import 'package:newnew/shared/components/components.dart';
import 'package:newnew/shared/style/colors.dart';
import 'package:newnew/shared/style/icon_broken.dart';
import 'package:intl/intl.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

class UploadMissingPersonalScreen extends StatelessWidget {
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
  final _yearOfBirthFocusNode = FocusNode();
  final _gender = FocusNode();
  final _selectNationality = FocusNode();
  final _messengerUserNameFocusNode = FocusNode();
  final _teleNum = FocusNode();
  final _whatsapp = FocusNode();

  String? phoneNum;
  String? whatsNum;

  UploadMissingPersonalScreen({Key? key}) : super(key: key);
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
    if(state is UploadMissingPersonSuccessState){
      if(state.uploadPersonModel.status == 'success'){
        Fluttertoast.showToast(
          msg:state.uploadPersonModel.message!,
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 2,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0,

        );
      }else{
        Fluttertoast.showToast(
          msg:state.uploadPersonModel.message!,
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 2,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0,

        );
      }

    }
  },
     builder: (context, state) {
     var cubit = MainCubit.get(context);

     List<Step> step=[
      Step(
        title:  Text('Basic Information',style: TextStyle(color: cubit.isDark==false? Colors.black:Colors.white,),),
        content: Form(
          key: keyForm1,
          child: Column(children: [

            const SizedBox(height: 20,),

            defaultFormField(

                controller: nameController,
                focusNode: _nameFocusNode,
                textInputAction: TextInputAction.next,
                onEditingComplete: ()=>FocusScope.of(context).requestFocus(_fatherNameFocusNode),
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
                textInputAction: TextInputAction.next,
                onEditingComplete: ()=>FocusScope.of(context).requestFocus(_motherNameFocusNode),
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
                textInputAction: TextInputAction.next,
                onEditingComplete: ()=>FocusScope.of(context).requestFocus(_gender),
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
                focusNode: _gender,
                change: changeGender,
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
              textInputAction: TextInputAction.next,
              onEditingComplete: ()=>FocusScope.of(context).requestFocus(_weightFocusNode),
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
                  textInputAction: TextInputAction.next,
                  onEditingComplete: ()=>FocusScope.of(context).requestFocus(_heightFocusNode),
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
                  textInputAction: TextInputAction.next,
                  onEditingComplete: ()=>FocusScope.of(context).requestFocus(_selectNationality),
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
                focusNode: _selectNationality,
                change: changeCountry,
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
          title:  Text('Additional information',style: TextStyle(color: cubit.isDark==false? Colors.black:Colors.white,)),

          isActive: MainCubit.get(context).x>=1,
          state:cubit.x==1? StepState.editing:cubit.x==0?StepState.disabled:StepState.complete,

          content: Form(
            key: keyForm2,
            child: Column(children: [
              const SizedBox(height: 20,),

              defaultFormField(
                focusNode: _characteristicsFocusNode,
                textInputAction: TextInputAction.next,
                controller: characteristicsController,
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

                        MainCubit.get(context).personImage == null ? const Image(image: AssetImage('assets/images/missing3.png'),height: 180,) :
                        Image(image:FileImage(MainCubit.get(context).personImage!),height: 180,),
                        const SizedBox(height: 20,),
                        Row(
                          children: [
                            Expanded(
                              child: defaultButton(function: (){
                                cubit.deleteImage();
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
          title:  Text('Last seen',style: TextStyle(color: cubit.isDark==false? Colors.black:Colors.white,)),

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
                  onEditingComplete: ()=>FocusScope.of(context).requestFocus(_countryFocusNode),
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
                  type: TextInputType.text,
                  focusNode: _countryFocusNode,
                  textInputAction: TextInputAction.next,
                  onEditingComplete: ()=>FocusScope.of(context).requestFocus(_stateFocusNode),
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
                  type: TextInputType.text,
                  hint: "state",
                  focusNode: _stateFocusNode,
                  textInputAction: TextInputAction.next,
                  onEditingComplete: ()=>FocusScope.of(context).requestFocus(_cityFocusNode),
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
                  textInputAction: TextInputAction.next,
                  onEditingComplete: ()=>FocusScope.of(context).requestFocus(_accidentFocusNode),
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
                textInputAction: TextInputAction.next,
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
        title:  Text('Contact Info',style: TextStyle(color: cubit.isDark==false? Colors.black:Colors.white,)),
        content: Form(
          key: keyForm4,
          child: Column(children: [
            const SizedBox(height: 20,),
            IntlPhoneField(
              focusNode:_teleNum ,
              textInputAction: TextInputAction.next,
              onSubmitted:(String)=>FocusScope.of(context).requestFocus(_whatsapp),
              decoration: const InputDecoration(
                hintText: 'Phone',
                hintStyle: TextStyle(
                  color: Colors.grey,
                  fontSize: 15,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                  borderSide: BorderSide(
                  ),
                ),
              ),
              initialCountryCode: 'EG',

              onChanged: (phone) {
           phoneNum= phone.completeNumber;
              },


            ),
            IntlPhoneField(
              focusNode:_whatsapp ,
              textInputAction: TextInputAction.next,
              onSubmitted:(String)=>FocusScope.of(context).requestFocus(_messengerUserNameFocusNode),
              decoration: const InputDecoration(
                hintText: 'Whatsapp number',
                hintStyle: TextStyle(
                  color: Colors.grey,
                  fontSize: 15,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                  borderSide: BorderSide(
                  ),
                ),
              ),
              initialCountryCode: 'EG',
              onChanged: (phone) {
                whatsNum= phone.completeNumber;
              },

            ),
            defaultFormField(
                controller: messengerUserNameController,
                focusNode:_messengerUserNameFocusNode ,
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
                               MainCubit.get(context).uploadMissingPerson(
                                 height: heightController.text,
                                 name: nameController.text,
                                 state: stateController.text,
                                 fatherName: fatherNameController.text,
                                 motherName: motherNameController.text,
                                 gender: ganderValue,
                                 yearOfBirth: yearOfBirthController.text,
                                 weight: weightController.text,
                                 nationality: countryName,
                                 photo: cubit.personImage,
                                 characteristics: characteristicsController.text,
                                 date: lastSeenController.text,
                                 country: countryController.text,
                                 city: cityController.text,
                                 messengerUserName: messengerUserNameController.text,
                                 circumstances: accidentController.text,
                                 phone: phoneNum,
                                 whatApp: whatsNum,
                               );
                              },
                            text: 'upload', style: const TextStyle(color: Colors.white),background: defaultColor ,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 30,),
                    if(state is UploadMissingPersonLoadingState)
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
