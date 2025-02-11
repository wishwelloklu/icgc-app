import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:icgc/core/presentation/read_widgets.dart';
import 'package:icgc/features/reader_page/presentation/bloc/font_bloc.dart';
import 'package:icgc/features/reader_page/presentation/bloc/font_states.dart';
import 'package:icgc/features/sermons/data/models/sample_model.dart';

import '../../../app/utils/screen_size.dart';

class SampleDetails extends StatelessWidget {
  const SampleDetails({super.key});

  @override
  Widget build(BuildContext context) {
    var isTablet = ScreenSizeHelper(context).isTablet;
    final sample = ModalRoute.settingsOf(context)?.arguments as SampleModel;
    return Scaffold(
      body: ReadWidgets(
        title: sample.title,
        child: BlocBuilder<FontBloc, FontStates>(builder: (context, state) {
          if (state is FontState) {
            return Padding(
              padding: const EdgeInsets.all(16),
              child: HtmlWidget(
                sample.sample,
                renderMode: RenderMode.listView,
                textStyle: TextStyle(
                    fontFamily: state.fontName,
                    fontSize: state.fontSize + (isTablet ? 5 : 0),
                    color: Colors.black),
              ),
            );
          }
          return const SizedBox.shrink();
        }),
      ),
    );
  }
}
