import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../core/global_blocs/connectivity_cubit/user_cubit.dart';

class BlocSetup {
  static getBlocs(BuildContext context) =>
      [BlocProvider(create: (context) => UserCubit())];
}
