import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:noteeee/provider/cuibt.dart';
import 'package:noteeee/provider/states.dart';
import 'package:noteeee/modules/home_layout/layout.dart';

import 'constant/constant.dart';
import 'provider/bloc observer.dart';

void main()
{
  Bloc.observer=MyBlocObserver();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => Todo_cuibt()..createDatabase(),
      child: BlocConsumer<Todo_cuibt,TodoStates>(
        listener:  (context, state) {

        },
        builder: (context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            darkTheme:dark,
            theme:light,
            themeMode: Todo_cuibt.get(context).isdark?ThemeMode.dark:ThemeMode.light,
            home: AnimatedSplashScreen(
              nextScreen:layout() ,
              backgroundColor: Colors.white,
              duration: 2000,
              splash:Image(image: AssetImage('assets/images/logo1.png'),),


            ),
          );
        },
      ),
    );
  }
}


