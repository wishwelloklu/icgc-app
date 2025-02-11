import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:icgc/app/utils/screen_size.dart';
import 'package:icgc/core/presentation/app_states/app_loading_state.dart';
import 'package:icgc/core/presentation/read_widgets.dart';
import 'package:icgc/features/reader_page/presentation/bloc/font_bloc.dart';
import 'package:icgc/features/reader_page/presentation/bloc/font_states.dart';
import 'package:icgc/features/theme/data/models/theme_model.dart';

class ThemeDetails extends StatelessWidget {
  const ThemeDetails({super.key});

  @override
  Widget build(BuildContext context) {
    var isTablet = ScreenSizeHelper(context).isTablet;
    final theme = ModalRoute.settingsOf(context)?.arguments as ThemeModel;
    return BlocBuilder<FontBloc, FontStates>(builder: (context, state) {
      if (state is FontState) {
        return Scaffold(
          body: ReadWidgets(
              title: theme.theme,
              child: Center(
                child: SingleChildScrollView(
                  child: Text(
                    theme.declaration,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: state.fontSize + (isTablet ? 10 : 0),
                      fontFamily: state.fontName,
                    ),
                  ),
                ),
              )),
        );
      }

      return const AppLoadingState();
    });
  }
}
