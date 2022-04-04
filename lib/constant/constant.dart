import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hexcolor/hexcolor.dart';

import '../provider/cuibt.dart';
import '../styles/icon_broken.dart';

var dark= ThemeData(
  primarySwatch: Colors.grey,
  scaffoldBackgroundColor: Colors.black,
  appBarTheme: AppBarTheme(
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarColor: Colors.black,
      statusBarBrightness: Brightness.light,
    ),
    backgroundColor: Colors.black,
    elevation: 0.0,
    titleTextStyle: TextStyle(
      color: Colors.white,
      fontSize: 20.0,
      fontWeight: FontWeight.bold,
    ),
    iconTheme: IconThemeData(
      color:Colors.white,
    ),
  ),
  floatingActionButtonTheme: FloatingActionButtonThemeData(
    backgroundColor: Colors.blueGrey,
  ),
  bottomSheetTheme: BottomSheetThemeData(
    backgroundColor: Colors.white,
  ),
  textTheme: TextTheme(
      bodyText1: TextStyle(
          fontSize: 18.0,
          fontWeight: FontWeight.w700,
          color: Colors.white
      ),
      bodyText2: TextStyle(
        fontSize: 14.0,
        color: Colors.grey,
      )
  ),
  tabBarTheme: TabBarTheme(
    labelColor: Colors.white,
    labelStyle:TextStyle(
        fontStyle: FontStyle.italic
    ),

    unselectedLabelColor: Colors.white,


  ),

);
////////////////////////////////////////////////////////////////////////////////
var light= ThemeData(
  primarySwatch: Colors.blueGrey,
  scaffoldBackgroundColor: Colors.white,
  appBarTheme: AppBarTheme(
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarColor: Colors.black,
      statusBarBrightness: Brightness.dark,
    ),
    backgroundColor: Colors.white,
    elevation: 0.0,
    titleTextStyle: TextStyle(
      color: Colors.black,
      fontSize: 20.0,
      fontWeight: FontWeight.bold,
    ),
    iconTheme: IconThemeData(
      color:Colors.black,
    ),
  ),
  floatingActionButtonTheme: FloatingActionButtonThemeData(
    backgroundColor: Colors.blueGrey,
  ),
  bottomSheetTheme: BottomSheetThemeData(
    backgroundColor: Colors.white,
  ),
  timePickerTheme: TimePickerThemeData(
    backgroundColor: Colors.white,
    dayPeriodTextColor: Colors.grey,
    dialBackgroundColor: Colors.blueGrey,
    dialHandColor: Colors.white60,
    entryModeIconColor: Colors.blueGrey,
    hourMinuteTextColor: Colors.black,

    hourMinuteShape: RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(20.0)),
      side: BorderSide(
          width: 1.5,
          color: Colors.blueGrey,
          style: BorderStyle.solid
      ),
    ),
    helpTextStyle: TextStyle(
        color: Colors.blueGrey,
        fontWeight: FontWeight.bold,
        fontSize: 14
    ),




  ),

  textTheme: TextTheme(
    bodyText1: TextStyle(
        fontSize: 18.0,
        fontWeight: FontWeight.w700,
        color: Colors.black
    ),
    bodyText2: TextStyle(
      fontSize: 14.0,
      color: Colors.blueGrey,
    ),
  ),

);
////////////////////////////////////////////////////////////////////////////////
Widget buildtasksItem(Map model,context)=>Dismissible(
  background: Container(
    alignment: Alignment.centerLeft,
    padding: EdgeInsets.symmetric(horizontal: 20),
    color: Colors.red,
    child: Icon(IconBroken.Delete,color: Colors.white,size: 25,),
  ),
  secondaryBackground: Container(
    alignment: Alignment.centerRight,
    padding: EdgeInsets.symmetric(horizontal: 20),
    color: Colors.red,
    child: Icon(IconBroken.Delete,color: Colors.white,size: 25,),
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

        }, icon: Icon(IconBroken.Tick_Square,color: Colors.green,size: 26)),

        IconButton(onPressed: (){

          Todo_cuibt.get(context).updateDatabase(status: 'archive', id: model['id']);



        },icon: Icon(Icons.archive,color: Todo_cuibt.get(context).isdark?Colors.white:Colors.black,size: 26)),



      ],

    ),

  ),
);
////////////////////////////////////////////////////////////////////////////////
