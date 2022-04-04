
import 'dart:math';

import 'package:conditional_builder_rec/conditional_builder_rec.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:noteeee/provider/cuibt.dart';
import 'package:noteeee/provider/states.dart';

import '../../constant/constant.dart';
import '../home_layout/layout.dart';



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
                    color: Colors.blueGrey,

                  ),
                  Text('Not Tasks Yet ,PLEASE ADD SOME TASKS',
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        fontStyle: FontStyle.italic,
                        color: Colors.blueGrey
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


