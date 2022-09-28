
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:wit_test_app/model/todo_model.dart';
import 'package:wit_test_app/util/snackbar/custom_snack.dart';

class TodoProvider with ChangeNotifier {
    final formkeytodo = GlobalKey<FormState>();
  TextEditingController dateinputcontroller = TextEditingController();
  TextEditingController timeinputcontroller = TextEditingController();
  TextEditingController taskcontroller = TextEditingController();

String? taskvalidate(String? value){
  if(value == null){
    return "required";
  }
  return null;
}
String? datevalidate(String? value){
  if(value == null){
    return "required";
  }
  return null;
}
String? timevalidate(String? value){
  if(value == null){
    return "required";
  }
  return null;
}

void delete(id,BuildContext context)async{
  final firestore = FirebaseFirestore.instance.collection(FirebaseAuth.instance.currentUser!.email!).doc(id);
   firestore.delete().then((value) {
  Showsnackbar.showsnack(context, "Task finished");
   });
}

  datecontrollerupdate(String value) {
    dateinputcontroller.text = value;
    notifyListeners();
  }

  timecontrollerupdate(String value) {
    timeinputcontroller.text = value;
    notifyListeners();
  }

void validate(BuildContext context){
  if (formkeytodo.currentState!.validate() == true )
  {
   addTodos(context);     
  }return;
}

  //================add==todo=datas=to=firebase============//
  addTodos(BuildContext context) {
    final firestore = FirebaseFirestore.instance.collection(FirebaseAuth.instance.currentUser!.email!).doc();
    final data = TodoData(
       id: firestore.id,
        task: taskcontroller.text.trim(),
        date: dateinputcontroller.text.trim(),
        time: timeinputcontroller.text.trim());
    firestore.set(data.toJson()).then((value) 
    {
      clearfields();
      Navigator.pop(context);
      getdatas();
    });
  }

  Stream<List<dynamic>> getdatas() {
    return FirebaseFirestore.instance.collection(FirebaseAuth.instance.currentUser!.email!).snapshots().map(
        (snapshot) =>
            snapshot.docs.map((e) => TodoData.fromJson(e.data())).toList());
  }

  void clearfields() {
    dateinputcontroller.clear();
    timeinputcontroller.clear();
    taskcontroller.clear();
    notifyListeners();
  }
}
