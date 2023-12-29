import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supinfo_logo/ui/components/app_body.dart';
import 'package:supinfo_logo/ui/screens/search_screen/components/script_search_body.dart';
import 'package:supinfo_logo/ui/screens/search_screen/search_cubit/search_cubit.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = SearchCubit()..init();
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: AppBody(
        title: 'Recherche de script',
        body: Padding(
          padding: const EdgeInsets.all(24.0),
          child: BlocBuilder(
            bloc: cubit,
            builder: (context, state) {
              if (state is SearchInitialState) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is SearchLoadedState) {
                return ScriptSearchBody(
                  onSearch: cubit.search,
                  scripts: state.scripts,
                  onTypeChanged: cubit.changeType,
                  currentType: state.type,
                );
              }
              return const Center(child: Text('Error'));
            },
          ),
        ),
      ),
    );
  }
}
