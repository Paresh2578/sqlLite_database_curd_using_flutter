import 'package:curd_opration/Widget/addOrEditTodu.dart';
import 'package:curd_opration/database/database.dart';
import 'package:curd_opration/model/ToduModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../todu.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  MyDatabase myDatabase = MyDatabase();

  // List<Todu> todu = [];

  TextEditingController titleCon = TextEditingController();

  TextEditingController decCon = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // insertData();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: const Text('All Todu' , style: TextStyle(color: Colors.white),),
        centerTitle: true,
      ),
      body: FutureBuilder(
        future: myDatabase.getAllTodu(),
        // future: futureTodu,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasData) {
            final toduList = snapshot.data as List<Todu> ?? [];
            if(toduList.isEmpty){
              return Center(child: Text('No data' , style: TextStyle(color: Colors.grey , fontSize: 20),));
            }
            return Expanded(
              child: ListView.builder(
                scrollDirection: Axis.vertical,
                itemCount: toduList.length,
                // itemCount: 20,
                itemBuilder: (context, index) {
                  Todu currTodu = toduList[index];
                  return Card(
                    margin: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 8),
                    elevation: 8,
                    child: ListTile(
                      leading: CircleAvatar(
                        child: Text('${index + 1}'),
                      ),
                      title: Text(currTodu.title!),
                      subtitle: Text(currTodu.dec!),
                      trailing: Container(
                        width: 50,
                        child: Row(
                          children: [
                            Expanded(
                                child: InkWell(
                                    onTap: () {
                                      showDialog(
                                          context: context,
                                          builder: (context) {
                                            return addOrEditTodu(
                                              title: currTodu.title,
                                              dec: currTodu.dec,
                                            );
                                          }).then((value) async => {
                                              await  myDatabase.updateTodu(Todu(id: currTodu.id , title: value.title ,dec: value.dec)),
                                          // futureTodu = myDatabase.getAllTodu(),
                                         setState(() {
                                         })
                                          });
                                    },
                                    child: const Icon(Icons.edit))),
                            const SizedBox(
                              width: 10,
                            ),
                            Expanded(
                                child: InkWell(
                                  onTap: (){
                                     showDialog(context: context, builder: (context) {
                                        return AlertDialog(
                                          title: Text('Are you sure delete ?'),
                                          actions: [
                                            TextButton(onPressed: (){Navigator.of(context).pop(true);}, child: Text('Yes')),
                                            TextButton(onPressed: (){Navigator.of(context).pop(false);}, child: Text('No'))
                                          ],
                                        );
                                     },).then((value) async {
                                        if(value){
                                          await  myDatabase.deleteTodu(currTodu.id!);
                                          // futureTodu = myDatabase.getAllTodu();
                                          setState(() {});
                                        }
                                     });
                                  },
                                    child: const Icon(
                                      Icons.delete,
                                      color: Colors.redAccent,
                                    ))),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            );
          } else {
            return const Text('error');
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
              context: context,
              builder: (context) {
                return addOrEditTodu();
              }).then((value) => {
                setState(() {
                  myDatabase.insert(value);

                  // futureTodu = myDatabase.getAllTodu();
                }),
              });
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
