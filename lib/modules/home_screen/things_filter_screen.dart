import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newnew/shared/bloc/main_cubit/main_cubit.dart';
import 'package:newnew/shared/bloc/main_cubit/main_state.dart';
import 'package:newnew/shared/components/components.dart';
import 'package:newnew/shared/style/colors.dart';
import 'package:newnew/shared/style/icon_broken.dart';

class ThingsFilterScreen extends StatefulWidget {
  const ThingsFilterScreen({Key? key}) : super(key: key);

  @override
  _ThingsFilterScreenState createState() => _ThingsFilterScreenState();
}

class _ThingsFilterScreenState extends State<ThingsFilterScreen> {
  int? _groupValue1 = 0;
  bool _checkBoxValue1 = false;
  bool _checkBoxValue2 = false;
  bool _checkBoxValue3 = false;
  bool _checkBoxValue4 = false;
  var carNumberController = TextEditingController();
  var nameController = TextEditingController();
  var locationController = TextEditingController();
  String typeValue = '';
  String? colorName ;
  void changeColor (String? val){
    colorName = val!;
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MainCubit, MainState>(
      listener: (context, state){},
      builder: (context, state) {
        MainCubit cubit = MainCubit.get(context);
        return GestureDetector(
          onTap: (){
            FocusScope.of(context).unfocus();
          },
          child: Scaffold(
            appBar: AppBar(
              title:const Text('Things Filter'),
            ),
            body: Padding(
              padding: const EdgeInsets.all(12.0),
              child: ListView(
                physics:const BouncingScrollPhysics(),
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(7.0),
                    child: Text("Status", style: Theme.of(context).textTheme.headline6),
                  ),
                  Row(
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Radio(
                            groupValue: _groupValue1,
                            value: 0,
                            onChanged: (dynamic t) {
                              setState(() {
                                _groupValue1 = t;
                              });
                            },
                            activeColor: defaultColor,
                          ),
                           Text("Missing",style: TextStyle(color:  cubit.isDark==false? Colors.black:Colors.white,),)
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          Radio(
                            groupValue: _groupValue1,
                            value: 1,
                            onChanged: (dynamic t) {
                              setState(() {
                                _groupValue1 = t;
                              });
                            },
                            activeColor: defaultColor,
                          ),
                            Text("Founded",style: TextStyle(color:  cubit.isDark==false? Colors.black:Colors.white,))
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          Radio(
                            groupValue: _groupValue1,
                            value: 2,
                            onChanged: (dynamic t) {
                              setState(() {
                                _groupValue1 = t;
                              });
                            },
                            activeColor: defaultColor,
                          ),
                          Text("All",style: TextStyle(color:  cubit.isDark==false? Colors.black:Colors.white,))
                        ],
                      ),

                    ],
                  ),
                  myDivider(),
                  Padding(
                    padding: const EdgeInsets.all(7.0),
                    child: Text("Type", style: Theme.of(context).textTheme.headline6),
                  ),
                  Row(
                    children:[
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Text("All", style: Theme.of(context).textTheme.headline6),
                      ),
                      const Spacer(),
                      Row(
                        children: <Widget>[
                          Switch(
                            onChanged: (t) {
                              setState(() {
                                _checkBoxValue1 = t;
                                _checkBoxValue2 = t;
                                _checkBoxValue3 = t;
                                _checkBoxValue4 = t;
                                typeValue = '';
                              });
                            },
                            activeColor: defaultColor,
                            value: _checkBoxValue1 && _checkBoxValue2 && _checkBoxValue3 && _checkBoxValue4,
                          ),

                        ],
                      ),
                    ],
                  ),
                  Column(
                    children:[
                      Row(
                        children: <Widget>[
                           Padding(
                            padding:const EdgeInsets.all(16.0),
                            child: Text("Papers", style: TextStyle(fontSize: 16,fontWeight: FontWeight.w600,color:  cubit.isDark==false? Colors.black:Colors.white,)),
                          ),
                          const Spacer(),
                          Switch(
                            onChanged: (t) {
                              setState(() {
                                _checkBoxValue1 =t ;
                                typeValue = 'papers';
                              });
                            },
                            value: _checkBoxValue1,
                            activeColor: defaultColor,
                          ),

                        ],
                      ),
                      Row(
                        children: <Widget>[
                            Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Text("Devices", style: TextStyle(fontSize: 16,fontWeight: FontWeight.w600,color:  cubit.isDark==false? Colors.black:Colors.white,)),
                          ),
                          const  Spacer(),
                          Switch(
                            onChanged: (v) {
                              setState(() {
                                _checkBoxValue2 = v;
                                typeValue = 'devices';
                              });
                            },
                            activeColor: defaultColor,
                            value: _checkBoxValue2,
                          ),

                        ],
                      ),
                      Row(
                        children: <Widget>[
                            Padding(
                            padding:const EdgeInsets.all(16.0),
                            child: Text("Transportations", style: TextStyle(fontSize: 16,fontWeight: FontWeight.w600,color:  cubit.isDark==false? Colors.black:Colors.white,)),
                          ),
                          const  Spacer(),
                          Switch(
                            onChanged: (v) {
                              setState(() {
                                _checkBoxValue3 = v;
                                typeValue = "transportations";
                              });
                            },
                            activeColor: defaultColor,
                            value: _checkBoxValue3,
                          ),

                        ],
                      ),
                      Row(
                        children: <Widget>[
                            Padding(
                            padding:const  EdgeInsets.all(16.0),
                            child: Text("Others", style: TextStyle(fontSize: 16,fontWeight: FontWeight.w600,color:  cubit.isDark==false? Colors.black:Colors.white,)),
                          ),
                          const  Spacer(),
                          Switch(
                            onChanged: (v) {
                              setState(() {
                                _checkBoxValue4 = v;
                                typeValue = 'others';
                              });
                            },
                            activeColor: defaultColor,
                            value: _checkBoxValue4,
                          ),

                        ],
                      ),
                    ],
                  ),
                  myDivider(),
                  Padding(
                    padding:const EdgeInsets.all(10.0),
                    child: TextFormField(
                      controller:nameController ,
                      decoration: InputDecoration(
                        hoverColor:defaultColor ,
                        fillColor: defaultColor,
                        focusColor: defaultColor,
                        hintText: "things name",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                      ),
                      cursorColor: defaultColor,


                    ),
                  ),
                  myDivider(),
                  Padding(
                    padding:const EdgeInsets.all(10.0),
                    child:  dropDownButtonFormField(
                        change: changeColor,
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
                  ),
                  myDivider(),
                  Padding(
                    padding:const EdgeInsets.all(10.0),
                    child: TextFormField(
                      controller: locationController,
                      decoration: InputDecoration(
                        hoverColor:defaultColor ,
                        fillColor: defaultColor,
                        focusColor: defaultColor,
                        hintText: "Location",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                      ),
                      cursorColor: defaultColor,

                    ),
                  ),
                  myDivider(),
                  if( _checkBoxValue3 == true )
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: defaultFormField(
                          controller: carNumberController,
                          type: TextInputType.number,
                          hint: "car number",
                          validate: (value){
                            if(value!.isEmpty){
                              // return 'required';
                            }
                            return null;
                          }, prefix: IconBroken.Profile),
                    ),

                ],
              ),
            ),
            floatingActionButtonLocation:FloatingActionButtonLocation.centerFloat ,
            persistentFooterButtons: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: SizedBox(
                  width: double.maxFinite,
                  child: ConditionalBuilder(
                    builder: (BuildContext context) =>MaterialButton(
                      onPressed: (){
                        cubit.getAllThingsFilter(
                            context: context,
                            name:nameController.text ,
                            color:colorName,
                            state:_groupValue1 ==0 ? 'missing' :_groupValue1 ==1? 'found':'' ,
                            type: typeValue,
                            carNumber: carNumberController.text,
                            location: locationController.text,
                        );
                      },
                      color:defaultColor ,
                      child:const Text('CONTINUE',
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
                    condition: state is! ThingsFilterLoadingState,
                    fallback:(BuildContext context) =>  const Center(child:  LinearProgressIndicator(),) ,

                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}