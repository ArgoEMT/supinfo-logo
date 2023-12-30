import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supinfo_logo/config/app_router.dart';
import 'package:supinfo_logo/ui/components/user_search/user_search_cubit/user_search_cubit.dart';

class AppUserSearchDialog extends StatelessWidget {
  const AppUserSearchDialog({
    super.key,
    required this.title,
    required this.onConfirm,
  });

  final String title;
  final Function(List<String>) onConfirm;

  @override
  Widget build(BuildContext context) {
    final cubit = UserSearchCubit()..init();
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
              final userIds = cubit.selectedUsers.map((e) => e.id).toList();
              onConfirm(userIds);
              Navigator.of(context).pop();
            }
          },
          child: const Text('Confirmer'),
        ),
      ],
      content: BlocBuilder<UserSearchCubit, UserSearchState>(
        bloc: cubit,
        builder: (context, state) {
          if (state is UserSearchInitialState) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is UserSearchLoadedState) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  decoration: const InputDecoration(
                    hintText: 'Rechercher un utilisateur',
                    border: OutlineInputBorder(),
                  ),
                  onChanged: cubit.search,
                ),
                const SizedBox(height: 16),
                if (state.users.isNotEmpty)
                  ConstrainedBox(
                    constraints: BoxConstraints(
                      maxHeight: MediaQuery.of(context).size.height * 0.5,
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        ...state.users.map(
                          (user) => ListTile(
                            title: Text(user.username),
                            subtitle: Text(user.email),
                            leading: Icon(
                              cubit.isSelected(user)
                                  ? Icons.check_box
                                  : Icons.check_box_outline_blank,
                            ),
                            onTap: () => cubit.toggleUser(user),
                          ),
                        ),
                      ],
                    ),
                  ),
                if (state.users.isEmpty) const Text('Aucun résultat'),
              ],
            );
          }
          return const Text('Error');
        },
      ),
    );
  }
}
