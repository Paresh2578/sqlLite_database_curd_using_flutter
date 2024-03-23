class Todu {
   int? id;
   String? title;
   String? dec;

   Todu({this.id, this.title, this.dec});

   Todu.fromJson(Map<String, dynamic> json) {
      id = json['id'];
      title = json['title'];
      dec = json['dec'];
   }

  static Todu toJson(Map<String , dynamic> data) {

      return Todu(id: data['id'] , title: data['title'] , dec: data['dec']);
   }



  static Map<String , dynamic> toMap(Todu newTodu){
      Map<String , dynamic> data = new Map<String , dynamic>();
      // data['id'] = newTodu.id;
      data['title'] =newTodu.title;
      data['dec'] = newTodu.dec;

      return data;
   }
}
