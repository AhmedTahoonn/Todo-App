
import 'dart:math';

import 'package:conditional_builder_rec/conditional_builder_rec.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:noteeee/provider/cuibt.dart';
import 'package:noteeee/provider/states.dart';



class New_tasks extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<Todo_cuibt,TodoStates>(
      listener: (context, state) {

      },
      builder: (context, state) {
        var tasks=Todo_cuibt.get(context).newTasks;
        return Scaffold(
          body: ConditionalBuilderRec(
            condition:tasks.length>0 ,
            builder:(context) =>  ListView.separated(
              itemBuilder: (context, index) => buildtasksItem(tasks[index],context),
              separatorBuilder: (context, index) =>
                  Container(
                    width: double.infinity,
                    height: 1,
                    color: Colors.grey[300],
                  ),
              itemCount: tasks.length,
            ),
            fallback: (context) =>Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children:
                [
                  Icon(
                    Icons.menu,
                    size: 100,
                    color: Colors.grey,

                  ),
                  Text('Not Tasks Yet ,PLEASE ADD SOME TASKS',
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey
                    ),
                  ),
                ],
              ),
            ) ,
          ),
        );
      },
    );
  }
}
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
Widget buildtasksItems(Map model,context)=>Dismissible(
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

