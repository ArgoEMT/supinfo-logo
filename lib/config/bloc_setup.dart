import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../core/global_blocs/user_cubit/user_cubit.dart';


class BlocSetup {
  static getBlocs(BuildContext context) =>
      [BlocProvider(create: (context) => UserCubit())];
}
