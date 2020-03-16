class ShoppingList {
  int id;
  String name;
  int priority;

  ShoppingList(this.id, this.name, this.priority);

  Map<String, dynamic> toMap() {
     return {
       'id': (id==0)?null:id,
       'name': name,
       'priority': priority,
     };
   }

   
}

