import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/ingredient.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

//食材リストを管理するProvider
class IngredientNotifier extends StateNotifier<List<Ingredient>> {
  IngredientNotifier() : super([]){
    _loadFromStorage(); // 起動時に読み込み
  }

  static const _storageKey = 'ingredients';

//データ取得
  Future<void> _loadFromStorage() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString(_storageKey);
    if (jsonString != null) {
      final jsonList = jsonDecode(jsonString) as List;
      state = jsonList.map((json) => Ingredient.fromJson(json)).toList();
    }
  }

//データ追加
  Future<void> _saveToStorage() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonList = state.map((item) => item.toJson()).toList();
    await prefs.setString(_storageKey, jsonEncode(jsonList));
  }

  //データ更新
void update(Ingredient ingredient) {
  state = state.map((item) {
    return item.id == ingredient.id ? ingredient : item;
  }).toList();
  _saveToStorage();
}

  //stateに追加
  void add(Ingredient ingredient) {
    state = [...state, ingredient];
    _saveToStorage();
  }

  //stateから削除
  void remove(String id) {
    state = state.where((item) => item.id != id).toList();
    _saveToStorage();
  }
}

//Providerを定義（ref.watchで読む）
final ingredientProvider =
    StateNotifierProvider<IngredientNotifier, List<Ingredient>>((ref) {
  return IngredientNotifier();
});

