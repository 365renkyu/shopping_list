import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/ingredient.dart';

//食材リストを管理するProvider
class IngredientNotifier extends StateNotifier<List<Ingredient>> {
  IngredientNotifier() : super([]); //初期は空リスト

  //追加
  void add(Ingredient ingredient) {
    //state = [...state, ingredient];
  }

  //削除
  void remove(String id) {
    state = state.where((item) => item.id != id).toList();
  }
}

//Providerを定義（ref.watchで読む）
final ingredientProvider =
    StateNotifierProvider<IngredientNotifier, List<Ingredient>>((ref) {
  return IngredientNotifier();
});
