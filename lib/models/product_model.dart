class ProductModel{
  double price,quantity=1;
  String name,productId,imageUrl;

  ProductModel(String pId, double price, String name, String imageUrl){
    this.productId = pId;
    this.name = name;
    this.price = price;
    this.imageUrl = imageUrl;
  }

  Map toJson() => {
    'name': name,
    'quantity': quantity,
    "price" : price,
  };
}