import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../config/app_router.dart';
import '../../components/app_button.dart';
import 'components/init_breadcrumb.dart';
import 'components/profil_picture_selector.dart';
import 'init_user_cubit/init_user_cubit.dart';

class InitUserScreen extends StatelessWidget {
  const InitUserScreen({super.key});

  Widget _buildScreen(
    String? data,
    int index, {
    required Function(String) onSaved,
    required Future Function() onNext,
  }) {
    final controller = TextEditingController(
      text: data,
    );
    final title = index == 0
        ? 'Quel est votre nom d\'utilisateur ?'
        : index == 1
            ? 'Quel est votre email de contact ?'
            : 'Choisissez votre photo de profil';
    final formKey = GlobalKey<FormState>();
    return Form(
      key: formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: 48),
          InitBreadcrumb(index: index),
          const SizedBox(height: 48),
          Text(
            title,
            style: const TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 48),
          if (index < 2)
            TextFormField(
              validator: (value) => value!.isEmpty ? 'Champ obligatoire' : null,
              controller: controller,
              decoration: InputDecoration(
                border: const OutlineInputBorder(),
                hintText: index == 0
                    ? 'Entrez votre nom d\'utilisateur'
                    : 'Entrez votre adresse email',
              ),
            )
          else
            ProfilPictureSelector(image: data, onSave: onSaved),
          const SizedBox(height: 16),
          AppButton(
            isActive: true,
            label: index == 2 ? 'Terminer' : 'Suivant',
            onPressed: () async {
              if (formKey.currentState?.validate() == true || index == 2) {
                await onNext();
                if (index < 2) {
                  onSaved(controller.text);
                }
              }
            },
          ),
          const Spacer(),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final cubit = InitUserCubit(context.read());
    return Scaffold(
      body: BlocBuilder<InitUserCubit, InitUserState>(
          bloc: cubit,
          builder: (context, state) {
            WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
              if (state is InitUserSuccessState) {
                context.go(RoutePaths.console);
              }
            });
            return Center(
              child: SizedBox(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width / 2,
                child: _buildScreen(
                  state.data,
                  cubit.index,
                  onSaved: (value) {
                    state.index == 0
                        ? cubit.username = value
                        : state.index == 1
                            ? cubit.email = value
                            : cubit.profilPicture = value;
                  },
                  onNext: cubit.emitNext,
                ),
              ),
            );
          }),
    );
  }
}
