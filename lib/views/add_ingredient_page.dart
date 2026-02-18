import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/ingredient.dart';
import '../providers/ingredient_provider.dart';

//食材追加画面
class AddIngredientPage extends ConsumerStatefulWidget {
  @override
  ConsumerState<AddIngredientPage> createState() => _AddIngredientPageState();
}

class _AddIngredientPageState extends ConsumerState<AddIngredientPage> {
  final _nameController = TextEditingController();
  final _quantityController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _quantityController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('食材を追加')),
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

                final ingredient = Ingredient(
                  id: DateTime.now().toString(),
                  name: _nameController.text,
                  quantity: _quantityController.text,
                );

                ref.read(ingredientProvider.notifier).add(ingredient);
                Navigator.pop(context); //一覧画面に戻る
              },
              child: const Text('追加'),
            ),
          ],
        ),
      ),
    );
  }
}
