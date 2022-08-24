import 'person.dart';

extension ResponsibilityExtension on Responsibility {

  String toNameString() {
    //throw UnimplementedError(); // TODO
    if(this.name == Responsibility.IT_Support.name)
      return "IT Support";
    else
      return this.name;
  }

}