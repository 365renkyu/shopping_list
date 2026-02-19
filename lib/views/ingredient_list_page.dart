import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/ingredient_provider.dart';
import 'add_ingredient_page.dart';

//トップ画面（食材リスト）
class IngredientListPage extends ConsumerStatefulWidget {
  @override
  ConsumerState<IngredientListPage> createState() => _IngredientListPageState();
}

class _IngredientListPageState extends ConsumerState<IngredientListPage> {
  //チェックされたアイテムのIDを保持
  final Set<String> _checkedIds = {};

  @override
  Widget build(BuildContext context) {
    final ingredients = ref.watch(ingredientProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('食材リスト')),
      body: ingredients.isEmpty
          ? const Center(child: Text('食材がありません'))
          : Column(
              children: [
                //ヘッダー
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: Row(
                    children: [
                      SizedBox(width: 48),
                      Expanded(
                        child: Text(
                          '項目',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      Text(
                        '数量',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      SizedBox(width: 48),
                    ],
                  ),
                ),
                const Divider(),
                //リスト
                Expanded(
                  child: ListView.builder(
                    itemCount: ingredients.length,
                    itemBuilder: (context, index) {
                      final item = ingredients[index];
                      final isChecked = _checkedIds.contains(item.id);
                      return ListTile(
                        leading: Checkbox(
                          value: isChecked,
                          onChanged: (value) {
                            setState(() {
                              if (value == true) {
                                _checkedIds.add(item.id);
                              } else {
                                _checkedIds.remove(item.id);
                              }
                            });
                          },
                        ),
                        title: Row(
                          children: [
                            Expanded(
                              child: Text(
                                item.name,
                                style: TextStyle(
                                  decoration: isChecked
                                      ? TextDecoration.lineThrough
                                      : TextDecoration.none,
                                  color: isChecked ? Colors.grey : null,
                                ),
                              ),
                            ),
                            Text(
                              '${item.quantity}',
                              style: TextStyle(
                                decoration: isChecked
                                    ? TextDecoration.lineThrough
                                    : TextDecoration.none,
                                color: isChecked ? Colors.grey : null,
                              ),
                            ),
                          ],
                        ),
                        trailing: IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: () {
                            ref
                                .read(ingredientProvider.notifier)
                                .remove(item.id);
                            _checkedIds.remove(item.id);
                          },
                        ),
                      );
                    },
                  ),
                ),
                //完了ボタン
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: ElevatedButton(
                      onPressed: () {
                        for (final id in _checkedIds) {
                          ref.read(ingredientProvider.notifier).remove(id);
                        }
                        setState(() {
                          _checkedIds.clear();
                        });
                      },
                      child: Text('完了'),
                    ),
                  ),
              ],
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => AddIngredientPage()),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
