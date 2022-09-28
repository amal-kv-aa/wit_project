import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:wit_test_app/view_models/todo_viewmodel.dart';

class TodoScreen extends StatelessWidget {
  const TodoScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final watch = context.watch<TodoProvider>();
    final read =  context.read<TodoProvider>();
    return
    Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
      ),
      body: Form(
        key: watch.formkeytodo,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(
              height: 20,
            ),
            const Text(
              "What is to be done?",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextFormField(
                controller: watch.taskcontroller,
                decoration: const InputDecoration(
                  hintText: 'Enter Task Here',
                ),
                validator: (value)=> read.taskvalidate(value),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(16),
              height: 150,
              child: Center(
                child: TextFormField(
                  validator: (value) => read.datevalidate(value),
                  controller: watch.dateinputcontroller,
                  decoration: const InputDecoration(
                      suffixIcon: Icon(Icons.calendar_today),
                      labelText: "Enter Date"),
                  readOnly: true,
                  
                  onTap: () async {
                    DateTime? pickedDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(2010),
                        lastDate: DateTime(2100));
                    if (pickedDate != null) {
                      String formattedDate =
                          DateFormat('dd - MM - yyyy').format(pickedDate);
                      context.read<TodoProvider>().datecontrollerupdate(formattedDate);
      
                    } else {
                      log("Date is not selected");
                    }
                    
                  },
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextFormField(
                validator: (value) => read.timevalidate(value),
                controller: watch.timeinputcontroller,
                decoration: const InputDecoration(
                    suffixIcon: Icon(Icons.timer), labelText: "Enter Time"),
                readOnly: true,
                onTap: () async {
                  TimeOfDay? pickedTime = await showTimePicker(
                    initialTime: TimeOfDay.now(),
                    context: context,
                  );
                  if (pickedTime != null) {
                    log(pickedTime.format(context));
                    DateTime parsedTime = DateFormat.jm()
                        .parse(pickedTime.format(context).toString());
                    String formattedTime =
                        DateFormat('HH:mm:ss').format(parsedTime);
                     context.read<TodoProvider>().timecontrollerupdate(formattedTime);
                  } else {
                    log("Time is not selected");
                  }
                },
              ),
            )
          ],
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(30),
        child: FloatingActionButton(
          onPressed: (() {
            read.validate(context);
          }),
          child: const Icon(Icons.done_outline),
        ),
      ),
    );
  }
}