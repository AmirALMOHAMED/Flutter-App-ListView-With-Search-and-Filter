# Employees catalogue is A FLUTTER APP (Stateful widget + ListView + Search bar + filter by responsibility + UI Testing)
## Introduction
The project is a simple app that displays a search with a list of people responsible for different areas in the company, for example, IT, Payroll, etc. It should allow for checking where selected employees sit, their phone number or their email address.

You can find two Pages in the project: `PeopleListPage` and `PersonDetailsPage`. When an employee is selected in the `PeopleListPage`, the user is taken to the `PersonDetailsPage`.

## State Management
I used the stateful widget for state management for this project.

```dart
class PeopleListPage extends StatefulWidget {
  final String title;

  const PeopleListPage({Key? key, required this.title}) : super(key: key);

  @override
  _PeopleListPageState createState() => _PeopleListPageState();
}
```

## Note
It is better to replace the stateful widget with BLoC state management for big applications.

### Author
Amir ALMOHAMED (amir-almohamed) ([@amir-almohamed-58717383](https://www.linkedin.com/in/amir-almohamed-58717383/))