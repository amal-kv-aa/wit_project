import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:wit_test_app/view/todo_page.dart';
import 'package:wit_test_app/view_models/home_view_models.dart';
import 'package:wit_test_app/view_models/todo_viewmodel.dart';

class Homescreen extends StatelessWidget {
  const Homescreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal,
      appBar: AppBar(
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: InkWell(
              onTap: (() {
                context.read<HomeProvider>().displayDialog(context);
              }),
              child: CircleAvatar(
                radius: 25,
                backgroundColor: Colors.black,
                child: Image.network(
                    "https://upload.wikimedia.org/wikipedia/commons/a/ad/Circle_%28transparent%29.png"),
              ),
            ),
          )
        ],
      ),
      body: SizedBox(
        height: double.infinity,
        child: StreamBuilder<List<dynamic>>(
          stream: context.watch<TodoProvider>().getdatas(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Text(
                "Somthing went wrong${snapshot.error}",
                style: const TextStyle(
                  color: Color.fromARGB(255, 0, 0, 0),
                ),
              );
            } else if (snapshot.hasData) {
              final user = snapshot.data;
              return ListView.builder(
                  itemCount: user!.length,
                  itemBuilder: ((context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        decoration:  BoxDecoration(color: const Color.fromARGB(255, 11, 78, 66).withOpacity(0.6)),
                        child: ListTile(
                          leading: InkWell(
                            onTap: (){
                              context.read<TodoProvider>().delete(user[index].id,context);
                            },
                            child: Container(
                              height: 18.h,
                              width: 18.w,
                              decoration:  BoxDecoration(border: Border.all(width: 1,color: Colors.white)),),
                          ),
                          title: Text(user[index].task,style: const TextStyle(color: Colors.white)),
                          subtitle: Row(
                            children: [
                              Text("${user[index].date}",style: const TextStyle(color: Colors.white30),),
                              SizedBox(width: 20.w),
                              Text("${user[index].time}",style: const TextStyle(color: Colors.white30)),
                            ],
                          ),
                        ),
                      ),
                    );
                  }));
            }
            return const Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
      ),
      floatingActionButton: Padding(
        padding:  EdgeInsets.only(bottom:10.h),
        child: FloatingActionButton(
          onPressed: () {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (ctx) => const TodoScreen()));
          },
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
