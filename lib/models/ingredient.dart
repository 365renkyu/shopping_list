class Ingredient {
  final String id;
  final String name; //商品名
  final String quantity; //数量
  // final String category; //リファクタリング：カテゴリー（食材・日用品）

  Ingredient({
    required this.id,
    required this.name,
    required this.quantity,
    //required this.category,//リファクタリング
  });

  //JSON変換
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'quantity': quantity,
    };
  }

  //JSONから生成
  factory Ingredient.fromJson(Map<String, dynamic> json) {
    return Ingredient(
      id: json['id'],
      name: json['name'],
      quantity: json['quantity'],
    );
  }
}