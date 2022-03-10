import 'package:conditional_builder_rec/conditional_builder_rec.dart';
import 'package:date_picker_timeline/date_picker_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:intl/intl.dart';
import 'package:noteeee/provider/cuibt.dart';

import '../archived_tasks/Archived.dart';
import '../done_tasks/Done.dart';
import '../new_tasks/New.dart';

class layout extends StatefulWidget {
  @override
  State<layout> createState() =>_layoutState();
}

class _layoutState extends State<layout> with SingleTickerProviderStateMixin {
  late TabController tabController;
  List<Tab>myTabs=[
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
  IconData fabIcon=Icons.edit;


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
                              return 'title can not be empty';
                            }
                            return null;
                          },
                          controller: titleController,
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: "Tasks Title",
                            prefixIcon: Icon(Icons.title),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          controller: timeController,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'time can not be empty';
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
                            labelText: "Tasks Time",
                            prefixIcon: Icon(Icons.timelapse),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          controller: dateController,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'date can not be empty';
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
                            labelText: "Tasks Date",
                            prefixIcon: Icon(Icons.date_range),
                          ),
                        ),

                      ],
                    ),
                  ),
                ),
            ).closed.then((value) {
              isBottomSheetShown=false;
            });
            isBottomSheetShown=true;
          }
        },
        child: Icon(Icons.add),
      ),

      appBar: AppBar(
        elevation: 0.0,
        leading: Icon(Icons.menu,),
        title: Text('Todo App',style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: IconButton(icon: Icon( Todo_cuibt.get(context).isdark?Icons.wb_sunny_rounded:Icons.nightlight_round),onPressed: (){
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
                fontWeight: FontWeight.bold,
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
                      fontWeight: FontWeight.bold,
                    ),
                    labelColor: Colors.grey,
                    tabs: [
                      Tab(text: 'Tasks',),
                      Tab(text: 'Done',),
                      Tab(text: 'archive',),
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
  }
}
Widget itemBuilder()=>Scaffold(
  appBar: AppBar(
    backgroundColor: Colors.white.withOpacity(0.4),
    elevation: 0.0,
    leading: Icon(Icons.menu,color: Colors.black,),
    title: Text('Todo App',style: TextStyle(
      color: Colors.black,
      fontSize: 20,
      fontWeight: FontWeight.bold,
    ),),
    actions: [

    ],
  ),
  floatingActionButton: FloatingActionButton(
    onPressed: (){},child: Text('save'),
  ),
  body: Padding(
    padding: const EdgeInsets.all(8.0),
    child: Column(
      children:
      [
        Container(
          width: 135,
          height: 175,
          decoration: BoxDecoration(
            color: Colors.blueGrey,
            borderRadius: BorderRadius.all(Radius.circular(20)),
          ),
          child: ListTile(
            title: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children:
              [
                Align( alignment: Alignment.topLeft,
                    child: Text('Note',style: TextStyle(
                        color: Colors.white
                    ),)),
                SizedBox(),
                Align( alignment: Alignment.topLeft,
                    child: Text('12345',style: TextStyle(
                        color: Colors.white
                    ))),

              ],
            ),
          ),
        ),
      ],
    ),
  ),
);
Widget buildtasksItem(Map model,context)=>Dismissible(
  background: Container(
    alignment: Alignment.centerLeft,
    padding: EdgeInsets.symmetric(horizontal: 20),
    color: Colors.red,
    child: Icon(Icons.delete_forever,color: Colors.white,size: 32,),
  ),
  secondaryBackground: Container(
    alignment: Alignment.centerRight,
    padding: EdgeInsets.symmetric(horizontal: 20),
    color: Colors.red,
    child: Icon(Icons.delete_forever,color: Colors.white,size: 32,),
  ),
  key: Key(model['id'].toString()),
  onDismissed: (direction){
    Todo_cuibt.get(context).DeleteDatabase(id: model['id']);
  },
  child:Padding(

    padding: const EdgeInsets.all(10.0),

    child: Row(

      children:

      [

        CircleAvatar(

          radius: 40.0,

          child: Text('${model['time']}'),

        ),

        SizedBox(

          width: 20.0,

        ),

        Expanded(

          child: Column(

            crossAxisAlignment: CrossAxisAlignment.start,

            mainAxisSize: MainAxisSize.min,

            children:

            [

              Text('${model['title']}',

                style: Theme.of(context).textTheme.bodyText1,

              ),
              SizedBox(
                height: 5,
              ),
              Text('${model['date']}',

                style: Theme.of(context).textTheme.bodyText2,

              ),



            ],

          ),

        ),

        IconButton(onPressed: (){

          Todo_cuibt.get(context).updateDatabase(status: 'done', id: model['id']);

        }, icon: Icon(Icons.check_box,color: Colors.green,)),

        IconButton(onPressed: (){

          Todo_cuibt.get(context).updateDatabase(status: 'archive', id: model['id']);



        }, icon: Icon(Icons.archive,color: Colors.black45,)),



      ],

    ),

  ),
);
