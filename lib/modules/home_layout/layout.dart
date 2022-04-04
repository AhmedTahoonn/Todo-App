import 'package:conditional_builder_rec/conditional_builder_rec.dart';
import 'package:date_picker_timeline/date_picker_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:noteeee/provider/cuibt.dart';
import 'package:noteeee/styles/icon_broken.dart';

import '../../provider/states.dart';
import '../archived_tasks/Archived.dart';
import '../done_tasks/Done.dart';
import '../new_tasks/New.dart';

class layout extends StatefulWidget {
  @override
  State<layout> createState() =>_layoutState();
}

class _layoutState extends State<layout> with SingleTickerProviderStateMixin {
  late TabController tabController;
  List<Tab>myTabs=
  [
    Tab(text: 'Tasks',),
    Tab(text: 'Done',),
    Tab(text: 'archive',),
  ];
  var scaffoldKey=GlobalKey<ScaffoldState>();
  var titleController=TextEditingController();
  var timeController=TextEditingController();
  var dateController=TextEditingController();
  var formKey=GlobalKey<FormState>();
  bool isBottomSheetShown=false;
  List<String> mainTitleNames=[
  'Tasks',
  'Done',
  'archive',
];
  @override
   void initState() {
    tabController = TabController(length: mainTitleNames.length, vsync: this);
    super.initState();
  }
  @override
  void dispose() {
tabController.dispose()  ;
super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<Todo_cuibt,TodoStates>(
      builder: (context, state) {
        return Scaffold(
          key: scaffoldKey,
          floatingActionButton: FloatingActionButton(
            onPressed: (){
              if(isBottomSheetShown)
              {
                if(formKey.currentState!.validate())
                {
                  Todo_cuibt.get(context).InsertDatabase(title: titleController.text, time: timeController.text, date: dateController.text);
                  Navigator.pop(context);
                  titleController.text='';
                  timeController.text='';
                  dateController.text='';

                }

              }else {
                scaffoldKey.currentState!.showBottomSheet((context) =>
                    Container(
                      padding: EdgeInsets.all(20.0),
                      child: Form(
                        key: formKey,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children:
                          [
                            TextFormField(
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Title can\'t be empty';
                                }
                                return null;
                              },
                              controller: titleController,
                              keyboardType: TextInputType.text,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: "Task Title",
                                labelStyle: TextStyle(
                                  fontStyle: FontStyle.italic,

                                ),
                                prefixIcon: Icon(IconBroken.Work),
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            TextFormField(
                              controller: timeController,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Time can\'t be empty';
                                }
                                return null;
                              },
                              keyboardType: TextInputType.text,
                              onTap: () {
                                showTimePicker(context: context,
                                    initialTime: TimeOfDay.now()).then((
                                    value) {
                                  timeController.text =
                                      value!.format(context).toString();
                                }).catchError((error) {


                                });
                              },
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                labelStyle: TextStyle(
                                  fontStyle: FontStyle.italic,


                                ),

                                labelText: "Task Time",
                                prefixIcon: Icon(IconBroken.Time_Circle),
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            TextFormField(
                              controller: dateController,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Date can\'t be empty';
                                }
                                return null;
                              },
                              onTap: () {
                                showDatePicker(context: context,
                                    initialDate: DateTime.now(),
                                    firstDate: DateTime.now(),
                                    lastDate: DateTime.parse('2022-05-04'))
                                    .then((value) {
                                  dateController.text =
                                      DateFormat.yMMMd().format(value!);
                                }).catchError((error) {

                                });
                              },
                              keyboardType: TextInputType.datetime,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: "Task Date",
                                labelStyle: TextStyle(
                                  fontStyle: FontStyle.italic,

                                ),

                                prefixIcon: Icon(IconBroken.Calendar),
                              ),
                            ),

                          ],
                        ),
                      ),
                    ),
                ).closed.then((value) {
                  setState(() {
                    isBottomSheetShown=false;

                  });
                });
                setState(() {
                  isBottomSheetShown=true;

                });
              }
            },
            child: isBottomSheetShown?Icon(IconBroken.Plus):Icon(IconBroken.Edit),
          ),

          appBar: AppBar(
            elevation: 0.0,
            automaticallyImplyLeading: false,
            title: Image(
              image: AssetImage('assets/images/logo1.png'),
              height: 55,
              width: 55,
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: IconButton(icon: Todo_cuibt.get(context).isdark?Icon(Icons.wb_sunny,color: Colors.white,):Icon(Icons.nightlight_round,color: Colors.black,),onPressed: (){

                  Todo_cuibt.get(context).changeAppMode();
                },),
              ),
            ],
          ),

          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children:
              [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('Today',style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    fontStyle: FontStyle.italic,

                  ),),
                ),
                Container(
                  child: DatePicker(
                    DateTime.now(),
                    dayTextStyle: TextStyle(
                      color: Colors.blueGrey,
                    ),
                    monthTextStyle: TextStyle(
                      color: Colors.blueGrey,
                    ),
                    height: 120,
                    width: 90,
                    initialSelectedDate: DateTime.now(),
                    selectionColor: Colors.blueGrey,
                    selectedTextColor: Colors.white,
                    dateTextStyle: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey,
                    ),

                  ),
                ),
                Column(
                  children: [
                    TabBar(
                        controller: tabController,
                        indicatorSize: TabBarIndicatorSize.label,
                        indicatorColor: Colors.grey,
                        unselectedLabelColor: Colors.blueGrey,
                        labelStyle: TextStyle(
                          fontSize: 15,
                          fontStyle: FontStyle.italic,
                          fontWeight: FontWeight.bold,
                        ),
                        labelColor: Colors.grey,
                        tabs:
                        [

                          Tab(text: 'Tasks',),
                          Tab(text: 'Done',),
                          Tab(text: 'Archive',),
                        ]),
                  ],
                ),
                Flexible(child: TabBarView(
                    controller: tabController,
                    children: [
                      New_tasks(),
                      Done_tasks(),
                      Archives_tasks(),

                    ]
                ),
                ),
              ],
            ),
          ),
        );
      },
      listener: (context, state) {
      },
    );
  }
}

