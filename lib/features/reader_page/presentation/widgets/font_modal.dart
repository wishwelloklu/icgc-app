import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:icgc/app/config/constant_config.dart';
import 'package:icgc/app/theme/app_color.dart';
import 'package:icgc/app/utils/string_extension.dart';
import '../../../../core/presentation/text/description_text.dart';
import '../../../../core/presentation/text/title_text.dart';
import '../bloc/font_bloc.dart';
import '../bloc/font_events.dart';
import '../bloc/font_states.dart';

class FontModal extends StatefulWidget {
  const FontModal({super.key});

  @override
  State<FontModal> createState() => _FontModalState();
}

class _FontModalState extends State<FontModal> {
  @override
  Widget build(BuildContext context) {
    final fontList = [ConstantConfig.mulish, ConstantConfig.satoshi];
    return BlocBuilder<FontBloc, FontStates>(
      buildWhen: (previous, current) {
        return previous != current;
      },
      builder: (context, state) {
        print(state);
        if (state is FontState) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Gap(10),
                const TitleText(
                  text: 'Size',
                  textAlign: TextAlign.left,
                  fontSize: 20,
                  color: Color(0xFF1D6948),
                ),
                const Gap(10),
                Row(
                  children: [
                    const DescriptionText(text: 'AA', fontSize: 14),
                    Expanded(
                      child: Slider.adaptive(
                        value: state.fontSize,
                        min: 12,
                        max: 30,
                        thumbColor: AppColor.whiteColor,
                        activeColor: AppColor.yellow,
                        inactiveColor: AppColor.grey,
                        overlayColor: WidgetStateProperty.resolveWith((state) {
                          if (state.contains(WidgetState.focused)) {
                            return const Color.fromARGB(60, 196, 196, 196);
                          }
                          return const Color.fromARGB(60, 196, 196, 196);
                        }),
                        allowedInteraction: SliderInteraction.tapAndSlide,
                        onChanged: (value) {
                          context
                              .read<FontBloc>()
                              .add(UpdateFontSizeEvent(value));
                        },
                      ),
                    ),
                    const DescriptionText(text: 'AA', fontSize: 14),
                  ],
                ),
                const Gap(20),
                const TitleText(
                  text: 'Style',
                  textAlign: TextAlign.left,
                  fontSize: 20,
                  color: Color(0xFF1D6948),
                ),
                const Gap(20),
                Row(
                    children: fontList
                        .map(
                          (font) => IconButton(
                            onPressed: () => context
                                .read<FontBloc>()
                                .add(UpdateFontFamillyEvent(font)),
                            icon: Column(
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(7),
                                  decoration: BoxDecoration(
                                      color: state.fontName == font
                                          ? AppColor.primaryColor
                                              .withOpacity(.2)
                                          : AppColor.whiteColor,
                                      shape: BoxShape.circle),
                                  child: const Text('Aa',
                                      style: TextStyle(
                                          fontSize: 25,
                                          fontFamily: ConstantConfig.mulish,
                                          fontWeight: FontWeight.bold)),
                                ),
                                Text(font.capitalizeFirst,
                                    style: const TextStyle(
                                        fontSize: 14,
                                        fontFamily: ConstantConfig.mulish,
                                        fontWeight: FontWeight.w500))
                              ],
                            ),
                          ),
                        )
                        .toList()),
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
