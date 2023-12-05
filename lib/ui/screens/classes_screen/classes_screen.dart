import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supinfo_logo/ui/components/app_body.dart';
import 'package:supinfo_logo/ui/components/app_button.dart';
import 'package:supinfo_logo/ui/screens/classes_screen/classes_cubit/classes_cubit.dart';
import 'package:supinfo_logo/ui/screens/classes_screen/widgets/classes_loaded_body.dart';
import 'package:supinfo_logo/ui/screens/classes_screen/widgets/create_class_modal.dart';

class ClassesScreen extends StatelessWidget {
  const ClassesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = ClassesCubit()..init();
    return AppBody(
      title: 'Mes classes',
      body: BlocBuilder<ClassesCubit, ClassesState>(
        bloc: cubit,
        builder: (context, state) {
          if (state.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is ClassesNoClassState) {
            return Center(
              child: AppButton(
                isActive: true,
                label: 'Créer une classe',
                onPressed: () => showDialog(
                  context: context,
                  builder: (_) => CreateClassModal(
                    onCreate: cubit.createClasse,
                  ),
                ),
              ),
            );
          }
          if (state is ClassesLoadedState) {
            return Center(
              child: ClassesLoadedBody(
                classesAsAdmin: state.classesAsAdmin,
                classesAsStudent: state.classesAsStudent,
                onCreateClass: () => showDialog(
                  context: context,
                  builder: (_) => CreateClassModal(
                    onCreate: cubit.createClasse,
                  ),
                ),
              ),
            );
          }
          return const Center(child: Text("Une erreur s'est produite"));
        },
      ),
    );
  }
}
