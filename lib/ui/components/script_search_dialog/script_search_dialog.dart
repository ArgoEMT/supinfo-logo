import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../config/app_router.dart';
import 'script_search_dialog_cubit/script_search_dialog_cubit.dart';

class ScriptSearchDialog extends StatelessWidget {
  const ScriptSearchDialog({
    super.key,
    required this.title,
    required this.onConfirm,
    this.scriptId,
  });

  final String title;
  final Function(String) onConfirm;
  final String? scriptId;

  @override
  Widget build(BuildContext context) {
    final cubit = ScriptSearchDialogCubit()..init(scriptId);
    return AlertDialog(
      title: Text(title),
      actions: [
        TextButton(
          onPressed: context.pop,
          child: const Text('Annuler'),
        ),
        TextButton(
          onPressed: () {
            if (cubit.canConfirm) {
              onConfirm(cubit.selectedScript!.id!);
              Navigator.of(context).pop();
            }
          },
          child: const Text('Confirmer'),
        ),
      ],
      content: BlocBuilder<ScriptSearchDialogCubit, ScriptSearchDialogState>(
        bloc: cubit,
        builder: (context, state) {
          if (state is ScriptSearchDialogInitialState) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is ScriptSearchDialogLoadedState) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  decoration: const InputDecoration(
                    hintText: 'Rechercher un script',
                    border: OutlineInputBorder(),
                  ),
                  onChanged: cubit.search,
                ),
                const SizedBox(height: 16),
                if (state.scripts.isNotEmpty)
                  ConstrainedBox(
                    constraints: BoxConstraints(
                      maxHeight: MediaQuery.of(context).size.height * 0.5,
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        ...state.scripts.map(
                          (script) => ListTile(
                            title: Text(script.name!),
                            leading: Icon(
                              cubit.isSelected(script)
                                  ? Icons.circle_rounded
                                  : Icons.circle_outlined,
                            ),
                            onTap: () => cubit.toggleScript(script),
                          ),
                        ),
                      ],
                    ),
                  ),
                if (state.scripts.isEmpty) const Text('Aucun résultat'),
              ],
            );
          }
          return const Text('Error');
        },
      ),
    );
  }
}
