import 'package:employees_catalogue/data/component.dart';
import 'package:employees_catalogue/data/person.dart';
import 'package:employees_catalogue/person_details_page.dart';
import 'package:employees_catalogue/widget_keys.dart';
import 'package:flutter/material.dart';
import 'package:employees_catalogue/data/extensions.dart';

class PeopleListPage extends StatefulWidget {
  final String title;

  const PeopleListPage({Key? key, required this.title}) : super(key: key);

  @override
  _PeopleListPageState createState() => _PeopleListPageState();
}

class _PeopleListPageState extends State<PeopleListPage> {
  late List<Person> people;
  late TextEditingController _searchController;
  bool _isSearching = false;
  Responsibility? responsibilityFilter;
  String previousQuery = '';

  @override
  void initState() {
    _searchController = TextEditingController();
    people = Component.instance.api.searchPeople();
    super.initState();
  }

  @override
  void setState(VoidCallback fn) {
    super.setState(() {});
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: LeadingWidget(
            isSearching: _isSearching,
            onClick: () {
                _isSearching = !_isSearching;
                setState((){});
            },
          ),
          title: _isSearching
              ? TextField(
                  key: WidgetKey.search,
                  controller: _searchController,
                  autofocus: true,
                  decoration: InputDecoration(
                    hintText: "Search employee...",
                    border: InputBorder.none,
                    hintStyle: TextStyle(color: Colors.white30),
                  ),
                  style: TextStyle(color: Colors.white, fontSize: 16.0),
                  onChanged: (value){
                    previousQuery = value;
                    people = Component.instance.api.searchPeople(query: previousQuery, responsibility: responsibilityFilter);
                    setState((){});
                  },
                )
              : Text(widget.title),
          actions: [
            responsibilityFilter != null
                ? InkWell(
                    key: WidgetKey.clearFilter,
                    child: Center(
                        child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text('CLEAR'),
                    )),
                    onTap: () {
                      responsibilityFilter = null;
                      people = Component.instance.api.searchPeople(query: previousQuery,responsibility: responsibilityFilter);
                      setState((){});
                    },
                  )
                : PopupMenuButton<Responsibility>(
                    key: WidgetKey.filter,
                    icon: Icon(Icons.filter_list),
                    onSelected: (responsibility) {
                      responsibilityFilter = responsibility;
                      people = Component.instance.api.searchPeople(query: previousQuery,responsibility: responsibilityFilter);
                      setState((){});
                    },
                    itemBuilder: (BuildContext context) => <PopupMenuEntry<Responsibility>>[
                      PopupMenuItem<Responsibility>(
                        key: WidgetKey.filter,
                        //checked: ,
                        value: Responsibility.IT_Support,
                        child: Text(Responsibility.IT_Support.toNameString()),
                      ),
                      const PopupMenuDivider(),
                      CheckedPopupMenuItem<Responsibility>(
                        key: WidgetKey.filter,
                        //checked: ,
                        value: Responsibility.Accounting,
                        child: Text(Responsibility.Accounting.toNameString()),
                      ),
                      const PopupMenuDivider(),
                      CheckedPopupMenuItem<Responsibility>(
                        key: WidgetKey.filter,
                        //checked: ,
                        value: Responsibility.DevOps,
                        child: Text(Responsibility.DevOps.toNameString()),
                      ),
                      const PopupMenuDivider(),
                      CheckedPopupMenuItem<Responsibility>(
                        key: WidgetKey.filter,
                        //checked: ,
                        value: Responsibility.Infrastructure,
                        child: Text(Responsibility.Infrastructure.toNameString()),
                      ),
                      const PopupMenuDivider(),
                      CheckedPopupMenuItem<Responsibility>(
                        key: WidgetKey.filter,
                        //checked: ,
                        value: Responsibility.Marketing,
                        child: Text(Responsibility.Marketing.toNameString()),
                      ),
                      const PopupMenuDivider(),
                      CheckedPopupMenuItem<Responsibility>(
                        key: WidgetKey.filter,
                        //checked: ,
                        value: Responsibility.Sales,
                        child: Text(Responsibility.Sales.toNameString()),
                      ),
                    ]
                  )
          ],
        ),
        body: ListView.builder(
          key: WidgetKey.listOfPeople,
          itemBuilder: (context, index) {
            return PersonItemWidget(id: people[index].id, fullName: people[index].fullName,responsibility: people[index].responsibility.toNameString());
          },
          itemCount: people.length,
        ));
  }
}

class LeadingWidget extends StatelessWidget {
  final bool isSearching;
  final Function() onClick;

  const LeadingWidget({Key? key, this.isSearching = false, required this.onClick}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: isSearching ? const Icon(Icons.clear) : const Icon(Icons.search),
      onPressed: () {
        onClick();
      },
    );
  }
}

class PersonItemWidget extends StatelessWidget {
  final int id;
  final String fullName;
  final String responsibility;

  const PersonItemWidget({Key? key, required this.id, required this.fullName, this.responsibility = ''})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    //throw UnimplementedError(); // TODO
    return InkWell(
      onTap: (){
        Navigator.of(context).push(MaterialPageRoute(
          builder:(context) => PersonDetailsPage(personId: this.id),
        ));
      },
      child: SizedBox(
        height: 100,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Card(
            elevation: 5,
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child:
                      Container(
                        width: 100,
                        //height: 100,
                        color: Colors.grey,
                      )
                  ),
                ),
                const SizedBox(width: 8),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 16,
                  ),
                  child:Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        this.fullName,
                        style: const TextStyle(fontSize: 14),
                      ),
                      Text(
                        this.responsibility,
                        style: const TextStyle(fontSize: 14),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),

      ),
    );
  }
}
