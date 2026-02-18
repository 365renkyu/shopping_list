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
}
