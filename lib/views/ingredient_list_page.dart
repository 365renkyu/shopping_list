import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/ingredient_provider.dart';
import 'add_ingredient_page.dart';

//食材一覧画面
class IngredientListPage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ingredients = ref.watch(ingredientProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('食材リスト')),
      body: ingredients.isEmpty
          ? const Center(child: Text('食材がありません'))
          : ListView.builder(
              itemCount: ingredients.length,
              itemBuilder: (context, index) {
                final item = ingredients[index];
                return ListTile(
                  title: Text(item.name),
                  subtitle: Text('${item.quantity}'),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () {
                      ref.read(ingredientProvider.notifier).remove(item.id);
                    },
                  ),
                );
              },
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
