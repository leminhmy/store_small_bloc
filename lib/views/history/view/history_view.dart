import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/type/enum.dart';
import '../../widget/app_loading_widget.dart';
import '../../widget/no_account.dart';
import '../cubit/history_cubit.dart';
import 'history_page.dart';

class HistoryView extends StatelessWidget {
  const HistoryView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HistoryCubit, HistoryState>(
        buildWhen: (previous, current) => previous.status!=current.status,
      builder: (context, state) {
        switch (state.status) {
          case StatusType.init:
            return const Scaffold(body: Center(child: NoAccountWidget()),);
          case StatusType.loading:
            return const AppLoadingWidget();
          case StatusType.loaded:
            return const HistoryPage();
          default:
            return const SizedBox();
        }

      }
    );
  }
}