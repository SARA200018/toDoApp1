// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
//
// Widget gh(){
//   return Scaffold(
//     floatingActionButton: FloatingActionButton(
//       onPressed: () {
//         if(cubit.isbottomSheet)
//         {
//           if(formState.currentState!.validate())
//           {
//             cubit.insertToDatabase(
//               title: TaskController.text,
//               date: DateController.text,
//               time: TimeController.text,
//             );
//           }
//         }
//         else
//         {
//           ScaffoldKey.currentState?.showBottomSheet((context) =>
//               Container (
//                 padding: const EdgeInsets.all(20),
//                 child: Form(
//                   key: formState,
//                   child: Column(
//                     mainAxisSize: MainAxisSize.min,
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       TextFromFieldDefualt(
//                           controller: TaskController,
//                           label: 'New Task',
//                           hintText: 'Enter New Task',
//                           prefixIcon: Icons.line_weight_outlined,
//                           keyboardType: TextInputType.text,
//                           validator: (value)
//                           {
//                             if(value!.isEmpty){return 'New Task Field not be Empty!';}
//                           }
//                       ),
//                       const SizedBox(height: 15),
//                       TextFromFieldDefualt(
//                         isReadOnly: true,
//                         controller: DateController,
//                         label: 'Date Task',
//                         hintText: 'Enter Date Task',
//                         prefixIcon: Icons.today_outlined,
//                         keyboardType: TextInputType.datetime,
//                         validator: (value)
//                         {
//                           if(value!.isEmpty){return 'Date Task Field not be Empty!';}
//                         },
//                         onTap: ()
//                         {
//                           showDatePicker(
//                             context: context,
//                             initialDate: DateTime.now(),
//                             firstDate: DateTime(1998),
//                             lastDate: DateTime(2500),
//                           ).then((value)
//                           {
//                             DateController.text = DateFormat.yMMMEd().format(value!);
//                           }
//                           );
//                         },
//                       ),
//                       const SizedBox(height: 15),
//                       TextFromFieldDefualt(
//                         isReadOnly: true,
//                         controller: TimeController,
//                         label: 'Time Task',
//                         hintText: 'Enter Time Task',
//                         prefixIcon: Icons.watch_later_outlined,
//                         keyboardType: TextInputType.datetime,
//                         validator: (value)
//                         {
//                           if(value!.isEmpty){return 'Time Task Field not be Empty!';}
//                         },
//                         onTap: ()
//                         {
//                           showTimePicker(
//                             context: context,
//                             initialTime: TimeOfDay.now(),
//                           ).then((value)
//                           {
//                             TimeController.text = value!.format(context).toString();
//                           }
//                           );
//                         },
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//           ).closed.then((value){
//             clearText();
//             cubit.ChangeBottomSheet(
//                 isShow: false,
//                 icon: const Icon(Icons.edit)
//             );
//           });
//           cubit.ChangeBottomSheet(
//             isShow: true,
//             icon: const Icon(Icons.add),
//           );
//         }
//       },
//       child: cubit.iconfab,
//       backgroundColor: color.mainColor,
//     ),
//   );
// }