import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newnew/shared/bloc/main_cubit/main_cubit.dart';
import 'package:newnew/shared/bloc/main_cubit/main_state.dart';
import 'package:newnew/shared/components/components.dart';
import 'package:newnew/shared/style/colors.dart';


class PersonalFilterScreen extends StatefulWidget {
  const PersonalFilterScreen({Key? key}) : super(key: key);

  @override
  _PersonalFilterScreenState createState() => _PersonalFilterScreenState();
}

class _PersonalFilterScreenState extends State<PersonalFilterScreen> {
  int? _groupValue1 = 0;//male Female
  int? _groupValue2 = 0;//Adult child
  bool _checkBoxValue1 = false; // missing
  bool _checkBoxValue2 = false; // looking for family
  double maxAge = 150;
  double minAge = 18;
  int ageDivisions = 30;
  RangeValues ranges1 =  const RangeValues(18, 150);//age
  RangeValues rangesChildAge =  const RangeValues(0, 17);//age
  RangeValues rangesAllAge =  const RangeValues(0, 150);//age
  RangeValues range=const RangeValues(18, 150);
  RangeLabels labels = const RangeLabels("Start", "End");//age
  RangeValues ranges2 = const RangeValues(30, 220);//height
  RangeLabels labels2 = const RangeLabels("Start", "End");//height
  RangeValues ranges3 = const RangeValues(10, 250); // weight
  RangeLabels labels3 = const RangeLabels("Start", "End");// weight
  var nameController= TextEditingController();
  var personType= 'All';
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MainCubit, MainState>(
  listener: (context, state) {},
  builder: (context, state) {
    MainCubit cubit = MainCubit.get(context);
    return GestureDetector(
      onTap: (){
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          title:const Text('Filter'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(12.0),
          child: ListView(
            physics:const BouncingScrollPhysics(),
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(7.0),
                child: Text("Gender", style: Theme.of(context).textTheme.headline6),
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
                       Text("Male",style: TextStyle(color:  cubit.isDark==false? Colors.black:Colors.white,),)
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
                        Text("Female",style: TextStyle(color:  cubit.isDark==false? Colors.black:Colors.white,))
                    ],
                  ),
                  // Row(
                  //   children: <Widget>[
                  //     Radio(
                  //       groupValue: _groupValue1,
                  //       value: 2,
                  //       onChanged: (dynamic t) {
                  //         setState(() {
                  //           _groupValue1 = t;
                  //         });
                  //       },
                  //       activeColor: defaultColor,
                  //     ),
                  //     Text("All",style: TextStyle(color:  cubit.isDark==false? Colors.black:Colors.white,))
                  //   ],
                  // ),

                ],
              ),
              myDivider(),
              Row(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Radio(
                        groupValue: _groupValue2,
                        value: 0,
                        onChanged: (dynamic v) {
                          setState(() {
                            _groupValue2 = v;
                            _groupValue2==1?maxAge=17:maxAge=150;
                            _groupValue2==1?minAge=0:_groupValue2==0?minAge=18:minAge=0;
                            _groupValue2==1?range=rangesChildAge:_groupValue2==0?range=ranges1:range=rangesAllAge;
                            _groupValue2==1?ageDivisions=17:ageDivisions=30;


                          });
                        },
                        activeColor: defaultColor,

                      ),
                       Text("Adult",style: TextStyle(color:  cubit.isDark==false? Colors.black:Colors.white,))
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Radio(
                        groupValue: _groupValue2,
                        value: 1,
                        onChanged: (dynamic v) {
                          setState(() {
                            _groupValue2 = v;
                            _groupValue2==1?maxAge=17:maxAge=150;
                            _groupValue2==1?minAge=0:_groupValue2==0?minAge=18:minAge=0;
                            _groupValue2==1?range=rangesChildAge:_groupValue2==0?range=ranges1:range=rangesAllAge;
                            _groupValue2==1?ageDivisions=17:ageDivisions=30;

                          });
                        },
                        activeColor: defaultColor,
                      ),
                       Text("Child",style: TextStyle(color:  cubit.isDark==false? Colors.black:Colors.white,))
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Radio(
                        groupValue: _groupValue2,
                        value: 2,
                        onChanged: (dynamic v) {
                          setState(() {
                            _groupValue2 = v;
                            _groupValue2==1?maxAge=17:maxAge=150;
                            _groupValue2==1?minAge=0:_groupValue2==0?minAge=18:minAge=0;
                            _groupValue2==1?range=rangesChildAge:_groupValue2==0?range=ranges1:range=rangesAllAge;
                            _groupValue2==1?ageDivisions=17:ageDivisions=30;
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
                child:
                Text("Name", style: Theme.of(context).textTheme.headline6),
              ),
              Padding(
                padding:const EdgeInsets.all(10.0),
                child: TextFormField(
                  decoration: InputDecoration(
                    hoverColor:defaultColor ,
                    fillColor: defaultColor,
                    focusColor: defaultColor,
                    hintText: "Person name",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                  ),
                  cursorColor: defaultColor,
                  controller: nameController,

                ),
              ),

              myDivider(),
              const SizedBox(height: 10,),
              Padding(
                padding: const EdgeInsets.all(7.0),
                child: Text("Age",
                    style: Theme.of(context).textTheme.headline6),
              ),
              const SizedBox(height: 10.0),
              RangeSlider(
                onChanged: (RangeValues t) {
                  setState(() {
                    range = t;

                    labels = RangeLabels(t.start.floorToDouble().toString(), t.end.floorToDouble().toString());

                  });
                },
                labels: labels,
                values: range,
                min: minAge,
                max: maxAge,
                divisions:ageDivisions,
                inactiveColor: Colors.grey,
                activeColor: defaultColor,
              ),
              myDivider(),
              Padding(
                padding: const EdgeInsets.all(7.0),
                child: Text("Height", style: Theme.of(context).textTheme.headline6),
              ),
              RangeSlider(
                onChanged: (RangeValues t) {
                  setState(() {
                    ranges2 = t;
                    labels2 = RangeLabels("${t.start.floorToDouble().toString()} cm", '${t.end.floorToDouble().toString()} cm');
                  });
                },
                labels: labels2,
                values: ranges2,
                min: 30,
                max: 220,
                divisions: 30,
                inactiveColor: Colors.grey,
                activeColor: defaultColor,
              ),
              myDivider(),
              Padding(
                padding: const EdgeInsets.all(7.0),
                child: Text("Weight", style: Theme.of(context).textTheme.headline6),
              ),
              RangeSlider(
                onChanged: (RangeValues t) {
                  setState(() {
                    ranges3 = t;
                    labels3 = RangeLabels('${t.start.floorToDouble().toString()} kg', '${t.end.floorToDouble().toString()} kg');
                  });
                },
                labels: labels3,
                values: ranges3,
                min: 10,
                max: 250,
                divisions: 30,
                inactiveColor: Colors.grey,
                activeColor: defaultColor,
              ),
              myDivider(),
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
                            personType='All';
                          });
                        },
                        activeColor: defaultColor,
                        value: _checkBoxValue1 && _checkBoxValue2,
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
                        padding: const EdgeInsets.all(16.0),
                        child: Text("Missing", style: TextStyle(fontSize: 16,fontWeight: FontWeight.w600,color:  cubit.isDark==false? Colors.black:Colors.white,)),
                      ),
                      const Spacer(),
                      Switch(
                        onChanged: (t) {
                          setState(() {
                            _checkBoxValue1 =t ;
                            personType='missing';
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
                        padding:const  EdgeInsets.all(16.0),
                        child: Text("Looking for his family", style: TextStyle(fontSize: 16,fontWeight: FontWeight.w600,color:  cubit.isDark==false? Colors.black:Colors.white,)),
                      ),
                      const  Spacer(),
                      Switch(
                        onChanged: (v) {
                          setState(() {
                            _checkBoxValue2 = v;
                            personType='missingF';
                          });
                        },
                        activeColor: defaultColor,
                        value: _checkBoxValue2,
                      ),

                    ],
                  ),
                ],
              ),
              myDivider(),




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
                    cubit.getAllPersonFilter(context: context,
                      name:nameController.text,
                      gender:_groupValue1==0?'male':_groupValue1==1?'female':'',
                      maxAge:range.end.toString(),
                      minAge: range.start.toString(),
                      maxHeight:ranges2.end.toString(),
                      minHeight:ranges2.start.toString(),
                      maxWeight: ranges3.end.toString(),
                      minWeight:ranges3.start.toString(),
                      personType:personType
                    );
                    print(_groupValue1);
                   // print(labels.start);
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
                fallback: (BuildContext context) =>const Center(child: LinearProgressIndicator()),
                condition: state is! PersonFilterLoadingState,

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
