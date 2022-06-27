import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/cubit/cubit.dart';
import 'package:todo/cubit/states.dart';

class MainScreen extends StatelessWidget {
  MainScreen({Key? key}) : super(key: key);

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => ToDoCubit()..createDatabase(),
      child: BlocConsumer<ToDoCubit, ToDoStates>(
        listener: (context, state) {},
        builder: (context, state) {
          ToDoCubit toDoCubit = ToDoCubit.get(context);

          return Scaffold(
            key: scaffoldKey,
            appBar: AppBar(
              backgroundColor: Colors.purple[600],
              title: Text(toDoCubit.titles[toDoCubit.currentIndex]),
            ),
            body: toDoCubit.screens[toDoCubit.currentIndex],
            bottomNavigationBar: BottomNavigationBar(
              elevation: 10.0,
              currentIndex: toDoCubit.currentIndex,
              //backgroundColor: Colors.purple[400],
              fixedColor: Colors.purple[400],
              onTap: (index) {
                toDoCubit.changeCurrentIndexValue(index);
              },
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(Icons.done),
                  label: "done",
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.menu),
                  label: "New",
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.archive),
                  label: "Archive",
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
