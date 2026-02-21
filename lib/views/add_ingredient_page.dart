import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/ingredient.dart';
import '../providers/ingredient_provider.dart';

//買い物リスト画面
class AddIngredientPage extends ConsumerStatefulWidget {
  final Ingredient? ingredient; //編集モードの場合

  AddIngredientPage({this.ingredient});

  @override
  ConsumerState<AddIngredientPage> createState() => _AddIngredientPageState();
}

class _AddIngredientPageState extends ConsumerState<AddIngredientPage> {
  final _nameController = TextEditingController();
  final _quantityController = TextEditingController();

  bool get isEdit => widget.ingredient != null;

  @override
  void initState() {
    super.initState();
    if (widget.ingredient != null) {
      _nameController.text = widget.ingredient!.name;
      _quantityController.text = widget.ingredient!.quantity;
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _quantityController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(isEdit ? '食材を編集' : '食材を追加')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(labelText: '食材名'),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _quantityController,
              decoration: const InputDecoration(
                labelText: '数量',
                hintText: '例：「2」、「3個」、「200g」',
              ),
            ),

            /*//リファクタリング
            const SizedBox(height: 16),
            TextField(
              controller: _categoryController,
              decoration: const InputDecoration(
                labelText: 'カテゴリ',
                hintText: '食品・日用品',
              ),
            ),
*/

            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: () {
                if (_nameController.text.isEmpty) return;

                if (isEdit) {
                  //編集モード
                  final updated = Ingredient(
                    id: widget.ingredient!.id,
                    name: _nameController.text,
                    quantity: _quantityController.text,
                  );
                  ref.read(ingredientProvider.notifier).update(updated);
                } else {
                  //新規追加モード
                  final ingredient = Ingredient(
                    id: DateTime.now().toString(),
                    name: _nameController.text,
                    quantity: _quantityController.text,
                  );
                  ref.read(ingredientProvider.notifier).add(ingredient);
                }
                Navigator.pop(context); //一覧画面に戻る
              },
              child: const Text('保存'),
            ),
          ],
        ),
      ),
    );
  }
}
