class Products {

    int? pid;
    String? pname;
    int? price;
    String? pimage;
    String? pdescr;

    Products({
      this.pid,
      this.pname,
      this.price,
      this.pimage,
      this.pdescr,
    });

    factory Products.fromJson(Map data){
      return Products(
        pid : data['pid'],
        pname : data['pname'],
        price : data['price'],
        pimage : data['pimage'],
        pdescr : data['pdescr']
      );
    }

    Map<String, dynamic> toJson(){

      Map<String, dynamic> data = new Map<String, dynamic>();

      data['pid'] = this.pid;
      data['pname'] = this.pname;
      data['price'] = this.price;
      data['pimage'] = this.pimage;
      data['pdescr'] = this.pdescr;

      return data;
    }


}