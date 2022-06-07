import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todoapp/component/component.dart';
import 'package:todoapp/cubit/cubit.dart';
import 'package:todoapp/cubit/states.dart';
class NewTask extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<cubitApp,states>(
        listener:(context,state){},
        builder: (context,state){
          List tasks = cubitApp().newTasks;
          return ListView.separated(
              itemBuilder: (context,index)=>buildTaskItem(tasks[index],context),
              separatorBuilder:(context,index)=> Container(
                color: Colors.grey[300],
                width: double.infinity,
              ),
              itemCount:tasks.length
          );
        }

    );
  }
}
