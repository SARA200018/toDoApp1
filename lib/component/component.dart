import 'package:flutter/material.dart';
import 'package:todoapp/cubit/cubit.dart';

Widget TextFromFieldDefualt({
  required TextEditingController controller,
  required String label,
  required IconData prefixIcon,
  required TextInputType keyboardType,
  String? Function(String?)? validator,
  Function()? onTap,
  TextStyle? labelStyle,
  String? hintText,
  double hintStyleFS = 15,
  double borderSideWidth = 3,
  double borderRadiusCircular = 13,
}) =>
    TextFormField(
      validator: validator,
      controller: controller,
      onTap: onTap,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(
          fontSize: hintStyleFS,
        ),
        prefixIcon: Icon(prefixIcon),
        label: Text(label),
        labelStyle: labelStyle,
        border: OutlineInputBorder(
          borderSide: BorderSide(
            width: borderSideWidth,
          ),
          borderRadius: BorderRadius.all(Radius.circular(borderRadiusCircular)),
        ),
      ),
    );

Widget buildTaskItem(Map model,context){
  return Padding(
    padding: const EdgeInsets.all(20.0),
    child: Row(
      children: [
        CircleAvatar(
          child: Text(
            '${model['time']}',
            style: TextStyle(
                color: Colors.white
            ),
          ),
          radius: 40,
          backgroundColor: Colors.blue,
        ),
        SizedBox(
          width: 15,
        ),
        Expanded(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('${model['title']}',style: TextStyle(
                  fontWeight: FontWeight.bold
              ),
              ),
              SizedBox(
                height: 5,
              ),
              Text('${model['date']}',style: TextStyle(color: Colors.grey),)
            ],
          ),
        ),
        IconButton(onPressed:(){
          cubitApp.get(context).updataDataBase(
              status: 'done', id: model['id']);
        }, icon: Icon(Icons.check_box,color: Colors.green,)),
        IconButton(onPressed:(){
          cubitApp.get(context).updataDataBase(
              status: 'archive', id: model['id']);
        }, icon: Icon(Icons.archive_outlined,color:Colors.grey,))

      ],
    ),
  );
}