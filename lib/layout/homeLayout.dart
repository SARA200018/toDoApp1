import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todoapp/component/component.dart';
import 'package:todoapp/cubit/cubit.dart';
import 'package:todoapp/cubit/states.dart';
import 'package:intl/intl.dart';
class homeLayout extends StatelessWidget {
var scaffoldKey = GlobalKey<ScaffoldState>();
var formKey = GlobalKey<FormState>();
var titleController = TextEditingController();
var timeController = TextEditingController();
var dateController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context)=>cubitApp()..createDatabase(),
      child: BlocConsumer<cubitApp,states>(
        listener: (context,state){
          if(state is getFromDatabaseState)
          {
            Navigator.pop(context);
          }
        },
        builder:  (context,state){
          cubitApp c = BlocProvider.of(context);
          return Scaffold(
            key: scaffoldKey,
            appBar: AppBar(
              title: Text(c.titles[c.currentIndex]),
            ),
            body: ConditionalBuilder(
              condition: state is! loadingDatabaseState,
              builder: (context)=>c.screens[c.currentIndex],
              fallback: (context)=>Center(child: CircularProgressIndicator()),
            ),
            floatingActionButton: FloatingActionButton(
              child: Icon(c.iconfab),
              onPressed: () {
                if (c.isbottomSheetShown) {
                  if(formKey.currentState!.validate()){
                  c.insertoDatabase(
                      title: titleController.text,
                      time: timeController.text,
                      date: dateController.text
                  );
                  }
                } else {
                  scaffoldKey.currentState!.showBottomSheet((context) =>
                      Container(
                        padding: EdgeInsets.all(20),
                        color: Colors.grey[200],
                        child: Form(
                          key: formKey,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              TextFromFieldDefualt(
                                controller: titleController,
                                label: 'Task Title',
                                prefixIcon:Icons.title,
                                keyboardType: TextInputType.text,
                                validator: (value){
                                  if(value!.isEmpty){
                                    return 'Title mustn\'t be empty';
                                  }
                                  return null;
                                }
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              TextFromFieldDefualt(
                                  controller: timeController,
                                  label: 'Task Time',
                                  prefixIcon:Icons.watch_later_outlined,
                                  keyboardType: TextInputType.text,
                                  onTap: (){
                                    showTimePicker(
                                        context: context,
                                        initialTime: TimeOfDay.now()
                                    ).then((value) => {
                                      timeController.text = value!.format(context).toString(),
                                    });
                                  },
                                validator: (value){
                                    if(value!.isEmpty){
                                      return 'Time mustn\'t be empty';
                                    }
                                    return null;
                                }
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              TextFromFieldDefualt(
                                  controller: dateController,
                                  label: 'Task Date',
                                  prefixIcon:Icons.calendar_today,
                                  keyboardType: TextInputType.datetime,
                                  onTap: (){
                                    showDatePicker(
                                        context: context,
                                        initialDate: DateTime.now(),
                                        firstDate: DateTime.now(),
                                        lastDate:DateTime.parse('2022-08-07')).then((value) {
                                      dateController.text = DateFormat.yMMMd().format(value!);

                                    });
                                  },
                                validator: (value){
                                    if(value!.isEmpty){
                                      return 'Date mustn\'t be empty';
                                    }
                                    return null;
                                }
                              ),
                            ],
                          ),
                        ),
                      )).
                  closed.then((value) {
                    c.changeIconBottomSheet(icon: Icons.edit, isShown: false);
                  });
                  c.changeIconBottomSheet(icon: Icons.add, isShown: true);
                }
              },
            ),
            bottomNavigationBar: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              currentIndex:c.currentIndex ,
              onTap: (index){
                c.change(index);
              },
              items: const [
                BottomNavigationBarItem(
                    icon: Icon(Icons.menu),
                    label: 'New Tasks'
                ),
                BottomNavigationBarItem(
                    icon: Icon(Icons.check_circle),
                    label: 'Done Tasks'
                ),
                BottomNavigationBarItem(
                    icon: Icon(Icons.archive_outlined),
                    label: 'Archived Tasks'),
              ],
            )
        );}
      ),
    );
  }

}
