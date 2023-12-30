import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supinfo_logo/config/theme/app_text_styles.dart';
import 'package:supinfo_logo/core/global_blocs/user_cubit/user_cubit.dart';
import 'package:supinfo_logo/ui/components/app_button.dart';
import 'package:supinfo_logo/ui/components/app_drawer/app_drawer_item.dart';
import 'package:supinfo_logo/ui/screens/script_screen/script_screen.dart';

import '../../../config/app_router.dart';
import '../../../config/theme/app_colors.dart';
import 'drawer_user_header.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  Widget _buildItem({
    required String name,
    Function()? onTap,
    required bool isActive,
    bool showBorder = true,
  }) {
    return Container(
      decoration: showBorder
          ? const BoxDecoration(
              border: Border(bottom: BorderSide(color: appPurple, width: 2)),
            )
          : null,
      child: AppButton(
        isExpanded: true,
        onPressed: isActive ? () {} : onTap,
        isActive: isActive,
        label: name,
        isRound: false,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    bool checkIfActive(String route) {
      return ModalRoute.of(context)?.settings.name == route;
    }

    final cubit = context.read<UserCubit>();
    return Container(
      decoration: const BoxDecoration(
        border: Border(right: BorderSide(color: appPurple, width: 2)),
      ),
      width: 200,
      child: Column(
        children: [
          BlocBuilder(
            bloc: cubit,
            builder: (context, state) {
              if (state is UserInitializedState) {}
              return DrawerUserHeader(
                user: state is UserInitializedState ? state.user : null,
              );
            },
          ),
          _buildItem(
            name: 'Console',
            onTap: () => context.go(RoutePaths.console),
            isActive: checkIfActive(RoutePaths.console),
          ),
          AppDrawerItem(
            name: 'Script',
            isExpanded: checkIfActive(RoutePaths.scriptEditor) ||
                checkIfActive(RoutePaths.scriptSearch),
            children: [
              _buildItem(
                name: 'Editeur de script',
                onTap: () => context.go(
                  RoutePaths.scriptEditor,
                  arguments: ArgumentsScriptScreen(),
                ),
                isActive: checkIfActive(RoutePaths.scriptEditor),
              ),
              _buildItem(
                name: 'Recherche de script',
                onTap: () => context.go(RoutePaths.scriptSearch),
                isActive: checkIfActive(RoutePaths.scriptSearch),
                showBorder: false,
              ),
            ],
          ),
          _buildItem(
            name: 'Mes classes',
            onTap: () => context.go(RoutePaths.myClasses),
            isActive: checkIfActive(RoutePaths.myClasses),
          ),
          const Spacer(),
          const Text(
            'Version 1.0.0 | Build 5',
            style: normal12White,
          ), //TODO: increment build version
          const Divider(color: appPurple, thickness: 2),
          const SizedBox(height: 12),
          _buildItem(
            name: 'Se déconnecter',
            isActive: false,
            onTap: () => FirebaseAuth.instance.signOut().then(
                  (value) => context.go(RoutePaths.login),
                ),
            showBorder: false,
          ),
          const SizedBox(height: 12),
        ],
      ),
    );
  }
}
