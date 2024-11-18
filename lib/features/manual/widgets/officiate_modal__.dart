import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import '../../../app/theme/app_string.dart';
import '../../../core/presentation/text_field/icon_text_field.dart';

import '../data/models/officiating_category.dart';
import '../data/models/officiating_type.dart';

class OfficiateS extends StatefulWidget {
  const OfficiateS({super.key});

  @override
  State<OfficiateS> createState() => _OfficiateModalState();
}

class _OfficiateModalState extends State<OfficiateS> {
  final categoryController = TextEditingController();
  final typeController = TextEditingController();
  List<OfficiatingType> _typeList = [];
  // final nameController = TextEditingController();
  // final dateController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      shrinkWrap: true,
      children: [
        GestureDetector(
          onTapDown: (details) {
            showMenu(
              context: context,
              position: RelativeRect.fromLTRB(details.globalPosition.dx,
                  details.globalPosition.dy + 10, details.globalPosition.dx, 0),
              items: OfficiatingCategory.categoryList
                  .map(
                    (cat) => PopupMenuItem<String>(
                      onTap: () {
                        categoryController.text = cat.ceremony;
                        if (cat.id == '1') {
                          _typeList = OfficiatingType.namingList;
                        }
                      },
                      value: cat.ceremony,
                      child: Text(cat.ceremony),
                    ),
                  )
                  .toList(),
            );
          },
          child: IconTextField(
            labelText: AppString.ceremony,
            hintText: AppString.ceremonyHint,
            controller: categoryController,
          ),
        ),
        const Gap(10),
        GestureDetector(
          onTapDown: (details) {
            showMenu(
              context: context,
              position: RelativeRect.fromLTRB(details.globalPosition.dx,
                  details.globalPosition.dy + 10, details.globalPosition.dx, 0),
              items: _typeList
                  .map(
                    (type) => PopupMenuItem<String>(
                      onTap: () {
                        typeController.text = type.text;
                      },
                      value: type.text,
                      child: Text(type.text),
                    ),
                  )
                  .toList(),
            );
          },
          child: IconTextField(
            controller: typeController,
            labelText: AppString.ceremonyType,
            hintText: AppString.ceremonyTypeHint,
          ),
        ),
        const Gap(50)
      ],
    );
  }
}
