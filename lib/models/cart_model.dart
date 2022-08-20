class CartModel {
  int? id;
  String? name;
  int? price;
  String? img;
  String? color;
  int? size;
  int? idOrder;
  int? quantity;
  bool? isExist;
  String? time;
  String? idProduct;
  String? createdAt;
  String? updatedAt;


  CartModel(
      {this.id,
        this.name,
        this.price,
        this.img,
        this.color,
        this.size,
        this.idOrder,
        this.quantity,
        this.isExist,
        this.time,
        this.idProduct,
        this.createdAt,
        this.updatedAt,
      });

  CartModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    price = json['price'];
    img = json['img'];
    color = json['color'];
    size = json['size'];
    idOrder = json['id_order'];
    quantity = json['quantity'];
    isExist = json['isExist'];
    time = json['time'];
    idProduct = json['id_product'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];

  }

  Map<String, dynamic> toJson(){
    return {
      "id":this.id,
      "name":this.name,
      "price":this.price,
      "img":this.img,
      "color":this.color,
      "size":this.size,
      "quantity":this.quantity,
      "isExist":this.isExist,
      "idProduct":this.idProduct,
      "time":this.time,
      "createdAt": this.createdAt,
      "updatedAt": this.updatedAt,
    };

  }

}
