import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:icgc/core/presentation/text/title_text.dart';
import 'package:icgc/features/reader_page/presentation/bloc/font_bloc.dart';
import 'package:icgc/features/reader_page/presentation/bloc/font_events.dart';
import 'package:icgc/features/reader_page/presentation/bloc/font_states.dart';

class FontModal extends StatefulWidget {
  const FontModal({super.key});

  @override
  State<FontModal> createState() => _FontModalState();
}

class _FontModalState extends State<FontModal> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FontBloc, FontStates>(
      buildWhen: (previous, current) {
        return previous != current;
      },
      builder: (context, state) {
        if (state is FontState) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Gap(10),
                TitleText(
                  text: 'Font ${state.fontSize.toStringAsFixed(1)}',
                  textAlign: TextAlign.left,
                  fontSize: 20,
                ),
                const Gap(10),
                Slider.adaptive(
                  value: state.fontSize,
                  min: 12,
                  max: 30,
                  allowedInteraction: SliderInteraction.tapAndSlide,
                  onChanged: (value) {
                    context.read<FontBloc>().add(UpdateFontEvent(value));
                  },
                ),
                const Gap(30),
              ],
            ),
          );
        }

        return const SizedBox.shrink();
      },
    );
  }
}
