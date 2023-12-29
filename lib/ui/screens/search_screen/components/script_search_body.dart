import 'package:flutter/material.dart';
import 'package:supinfo_logo/config/theme/app_colors.dart';
import 'package:supinfo_logo/ui/components/app_button.dart';
import 'package:supinfo_logo/ui/screens/search_screen/search_cubit/search_cubit.dart';

import '../../../../config/app_router.dart';
import '../../../../core/models/script_model.dart';
import '../../script_screen/script_screen.dart';

class ScriptSearchBody extends StatelessWidget {
  const ScriptSearchBody({
    super.key,
    required this.onSearch,
    required this.scripts,
    required this.onTypeChanged,
    required this.currentType,
  });

  final Function(String) onSearch;
  final List<ScriptModel> scripts;
  final Function(SearchType) onTypeChanged;
  final SearchType currentType;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          onChanged: onSearch,
          decoration: const InputDecoration(
            hintText: 'Rechercher un script',
            border: OutlineInputBorder(),
            prefixIcon: Icon(Icons.search),
          ),
        ),
        const SizedBox(height: 24),
        Row(
          children: SearchType.values
              .map(
                (type) => Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: AppButton(
                    onPressed: () => onTypeChanged(type),
                    label: type.name,
                    isActive: currentType == type,
                    isRound: false,
                  ),
                ),
              )
              .toList(),
        ),
        const SizedBox(height: 8),
        ...scripts.map(
          (script) => Container(
            decoration: const BoxDecoration(
              border: Border(bottom: BorderSide(color: appPurple)),
            ),
            child: ListTile(
              trailing: script.isPublic ? null : const Icon(Icons.lock),
              title: Text(script.name!),
              subtitle: Text(
                script.username,
                style: const TextStyle(color: appGreen),
              ),
              onTap: () => context.go(
                RoutePaths.scriptEditor,
                arguments: ArgumentsScriptScreen(scriptId: script.id),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
