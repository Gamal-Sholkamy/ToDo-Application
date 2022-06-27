import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/cubit/cubit.dart';

class TaskItemDesign extends StatelessWidget {
  final Map<String, dynamic> task;

  const TaskItemDesign(this.task, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final toDoCubit = ToDoCubit.get(context);
    return Padding(
      padding: const EdgeInsets.all(8.0),
         // color: Colors.purple[200],
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircleAvatar(
              //backgroundImage:const AssetImage("assets/images/splash.jpg",) ,
              backgroundColor: Colors.purple[500],
              radius: 40.0,
              child:  Text(
                task['time'],
                style: const TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
            ),
            const SizedBox(width: 20.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    task['title'],
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 18.0,
                      color: Colors.purple,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8.0),
                  Row(
                    children: [
                      Text(
                        task['date'],
                        style: const TextStyle(
                          fontSize: 14.0,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(width: 10,),
                      Text(
                        task['time'],
                        style: const TextStyle(
                          fontSize: 14.0,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),


                ],
              ),
            ),
            if (task['status'] != 'Done')
            IconButton(
                onPressed: () {
                  toDoCubit.updateINDatabase(task['id'], 'Done');
                },
                icon: const Icon(
                  Icons.done_outline_outlined,
                  color: Colors.green,
                )),
            //const SizedBox(width: 6.0),
            if (task['status'] != 'Archive')
              IconButton(
                onPressed: () {
                  toDoCubit.updateINDatabase(task['id'], 'Archive');
                },
                icon: const Icon(
                  Icons.archive_outlined,
                  color: Colors.orange,
                )),
            //const SizedBox(width: 6.0),
            IconButton(

                onPressed: () {
                  toDoCubit.deleteFromDatabase(task['id']);
                },
                icon: const Icon(
                  Icons.delete_outlined,
                  color: Colors.red,
                ))
          ],
        ),

    );
  }
}
