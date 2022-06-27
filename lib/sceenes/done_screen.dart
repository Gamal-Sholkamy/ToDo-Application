import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/cubit.dart';
import 'package:todo/cubit/cubit.dart';
import 'package:todo/cubit/states.dart';

import '../reusable/task_item_design.dart';

class DoneScreen extends StatelessWidget{
   DoneScreen({Key? key}) : super(key: key);
  var scaffoldKey = GlobalKey<ScaffoldState>();
  var formKey = GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {
    ToDoCubit toDoCubit=ToDoCubit.get(context);
    return Scaffold(
      key: scaffoldKey,
      body: BlocConsumer<ToDoCubit,ToDoStates>(
        listener:(context,state){
          if (state is ToDoInsertToDatabaseState) {
            Navigator.pop(context);
            toDoCubit.changeButtonSheetValue(isShown: false, icon: Icons.edit);
          }

        } ,
        builder:(context,state){
          return ListView.separated(
              itemBuilder: (context, index) => TaskItemDesign(toDoCubit.doneTasks![index]),
              separatorBuilder: (context, index) => Container(
                height: 1.0,
                color: Colors.purple[500],
              ),
              itemCount: toDoCubit.doneTasks?.length ?? 0);
        } ,
      ),

    );

  }

}