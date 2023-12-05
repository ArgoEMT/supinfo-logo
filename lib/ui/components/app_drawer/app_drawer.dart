import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supinfo_logo/core/global_blocs/user_cubit/user_cubit.dart';
import 'package:supinfo_logo/ui/components/app_button.dart';

import '../../../config/app_router.dart';
import '../../../config/theme/app_colors.dart';
import 'drawer_user_header.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  Widget _buildItem({
    required String name,
    Function()? onTap,
    required bool isActive,
  }) {
    return Container(
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: appPurple,
          ),
        ),
      ),
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
        border: Border(
          right: BorderSide(
            color: appPurple,
          ),
        ),
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
          _buildItem(
            name: 'Editeur de script',
            onTap: () => context.go(RoutePaths.script),
            isActive: checkIfActive(RoutePaths.script),
          ),
          _buildItem(name: 'Recherche de script', isActive: false),
          _buildItem(
            name: 'Ma classe',
            onTap: () => context.go(RoutePaths.myClasses),
            isActive: checkIfActive(RoutePaths.myClasses),
          ),
          const Spacer(),
          const Divider(color: appPurple),
          _buildItem(
            name: 'Logout',
            isActive: false,
            onTap: () async {
              await FirebaseAuth.instance.signOut().then(
                    (value) => context.go(RoutePaths.login),
                  );
            },
          ),
        ],
      ),
    );
  }
}
