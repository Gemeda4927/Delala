
class Todo {
  final int id;
  final String title;
 

  Todo({required this.id,required this.title});


  // 1. fromJson -> dart object
      factory Todo.fromJson(Map<String,dynamic> json){
        return Todo( id: json['id'],title: json['title'],);
      }
  // 2. toJson *means convert dart object to json 
  // thus we can send that to backend.
  Map<String,dynamic> toJson(){
    return {
      'id':id,
      'title':title,
     
    };
  }
}