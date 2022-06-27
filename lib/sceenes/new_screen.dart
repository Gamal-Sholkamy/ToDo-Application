import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:todo/cubit/cubit.dart';
import 'package:todo/cubit/states.dart';

import '../reusable/task_item_design.dart';

class NewScreen extends StatefulWidget {
   NewScreen({Key? key}) : super(key: key);

  @override
  State<NewScreen> createState() => _NewScreenState();
}

class _NewScreenState extends State<NewScreen> {

  var scaffoldKey = GlobalKey<ScaffoldState>();
  var formKey = GlobalKey<FormState>();
  var titleController = TextEditingController();
  var dateController = TextEditingController();
  var timeController = TextEditingController();

  @override

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
              itemBuilder: (context, index) => TaskItemDesign(toDoCubit.newTasks![index]),
              separatorBuilder: (context, index) => Container(
                height: 1.0,
                color: Colors.purple[500],
              ),
              itemCount: toDoCubit.newTasks?.length ?? 0);
        } ,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (toDoCubit.isButtonSheetShow) {
            if (formKey.currentState!.validate()) {
              toDoCubit.insertToDatabase(
                      title: titleController.text,
                      date: dateController.text,
                      time: timeController.text);
            }
          } else {
            scaffoldKey.currentState
                ?.showBottomSheet((context) => Container(
                    padding: const EdgeInsets.all(12.0),
                    child: Form(
                      key: formKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          TextFormField(
                            controller: titleController,
                            keyboardType: TextInputType.text,
                            onFieldSubmitted: (value) {},
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Title must not be empty";
                              } else {
                                return null;
                              }
                            },
                            decoration: InputDecoration(
                                prefix: const Icon(Icons.title),
                                label: const Text("Enter Task Title"),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(0.0))),
                          ),
                          const SizedBox(
                            height: 12.0,
                          ),
                          TextFormField(
                            controller: dateController,
                            keyboardType: TextInputType.datetime,
                            onFieldSubmitted: (value) {},
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Title must not be empty";
                              } else {
                                return null;
                              }
                            },
                            onTap: () {
                              showDatePicker(
                                      context: context,
                                      initialDate: DateTime.now(),
                                      firstDate: DateTime.now(),
                                      lastDate: DateTime(2030))
                                  .then((value) {
                                dateController.text =
                                    DateFormat.MMMd().format(value!);
                              });
                            },
                            decoration: InputDecoration(
                                prefix: const Icon(Icons.calendar_view_day),
                                label: const Text("Enter Task Date"),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(0.0))),
                          ),
                          const SizedBox(
                            height: 12.0,
                          ),
                          TextFormField(
                            controller: timeController,
                            keyboardType: TextInputType.datetime,
                            onFieldSubmitted: (value) {},
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Title must not be empty";
                              } else {
                                return null;
                              }
                            },
                            onTap: () {
                              showTimePicker(
                                      context: context,
                                      initialTime: TimeOfDay.now())
                                  .then((value) {
                                timeController.text = value!.format(context);
                              });
                            },
                            decoration: InputDecoration(
                                prefix: const Icon(Icons.watch_later_outlined),
                                label: const Text("Enter Task Time"),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(0.0))),
                          ),
                        ],
                      ),
                    )))
                .closed
                .then((value) {

              titleController.clear();
              dateController.clear();
              timeController.clear();
              toDoCubit.changeButtonSheetValue(isShown: false, icon: Icons.edit);

            });
            toDoCubit.changeButtonSheetValue(isShown: true, icon: Icons.add);
          }
        },
        backgroundColor: Colors.purple[400],
        child: Icon(toDoCubit.fabIcon),
      ),
    );
  }





}

