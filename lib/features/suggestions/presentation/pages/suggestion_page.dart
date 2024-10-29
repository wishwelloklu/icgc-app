import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:icgc/app/theme/app_font_size.dart';
import 'package:icgc/app/theme/app_string.dart';
import 'package:icgc/core/data/models/suggestion_model.dart';
import 'package:icgc/core/presentation/buttons/app_primary_button.dart';
import 'package:icgc/core/presentation/buttons/app_text_button.dart';
import 'package:icgc/core/presentation/text/title_text.dart';

class SuggestionPage extends StatelessWidget {
  const SuggestionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const Gap(10),
            const TitleText(
              text: AppString.suggestionHeading,
              maxLine: 10,
              fontSize: AppFontSize.titleLarge,
            ),
            const Gap(70),
            Expanded(
              child: Wrap(
                spacing: 10,
                runSpacing: 20,
                children: SuggestionModel.suggestionList
                    .map(
                      (suggestion) => AppTextButton(
                          showBorder: true,
                          
                          text: suggestion.suggestion,
                          onPressed: () {}),
                    )
                    .toList(),
              ),
            ),
            
            PrimaryButton(text: AppString.continues, onPressed: () {}),
          ],
        ),
      ),
    );
  }
}
