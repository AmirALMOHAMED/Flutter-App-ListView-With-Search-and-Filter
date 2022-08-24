import 'package:employees_catalogue/data/component.dart';
import 'package:employees_catalogue/data/person.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:employees_catalogue/data/extensions.dart';

class PersonDetailsPage extends StatefulWidget {
  final int? personId;

  const PersonDetailsPage({Key? key, required this.personId}) : super(key: key);

  @override
  _PersonDetailsPageState createState() => _PersonDetailsPageState();
}

class _PersonDetailsPageState extends State<PersonDetailsPage> {
  Person? person;

  @override
  void initState() {
    if (widget.personId != null) {
      person = Component.instance.api.getPerson(widget.personId);
      if (person==null)
        Navigator.pop(context);
    }
    else{
      Navigator.pop(context);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Person details'), leading: CloseButton()),
        body: SingleChildScrollView(
          child: SizedBox(
            child: Column(
              children: [
                Padding(
                  padding:const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 8,
                  ),
                  child: Container(
                    width: double.maxFinite,
                    height: 200,
                    decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(8)),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child:  Container(
                        width: 100,
                        height: 80,
                        color: Colors.grey,
                      )
                    ),
                  ),
                ),
                const SizedBox(
                  height: 32,
                ),
                SizedBox(
                  //height: 200,
                  child: Card(
                    color: Colors.grey[100],
                    elevation: 2,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Row(
                              children: [
                                const Text(
                                  "Person full name: ",
                                ),
                                Text(person!.fullName),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Row(
                              children: [
                                const Text(
                                  "person responsibility: ",
                                ),
                                Text(person!.responsibility.toNameString()),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Row(
                              children:[
                                const Text(
                                  "Person Email Address: ",
                                ),
                                Text(person!.email),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Row(
                              children:[
                                const Text(
                                  "Person Phone: ",
                                ),
                                Text(person!.phone),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Row(
                              children:[
                                const Text(
                                  "Person Room: ",
                                ),
                                Text(person!.room),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          ) ,
        ),
    );
  }
}
