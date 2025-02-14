import 'package:flutter/material.dart';
import 'package:icgc/core/presentation/modals/modal_list_item.dart';

class OptionsModal extends StatelessWidget {
  const OptionsModal({
    super.key,
    required this.onViewTags,
    required this.onAddTag,
    this.onDelete,
    this.onEdit,
  });
  final VoidCallback onViewTags;
  final VoidCallback onAddTag;
  final VoidCallback? onDelete;
  final VoidCallback? onEdit;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          ModalListItem(
            onTap: onViewTags,
            title: 'View tags',
            trailing: Icons.keyboard_arrow_right,
          ),
          ModalListItem(
            onTap: onAddTag,
            title: 'Add tag',
            trailing: Icons.keyboard_arrow_right,
          ),
          if (onEdit != null)
            ModalListItem(
              onTap: onEdit!,
              title: 'Edit sermon',
              trailing: Icons.keyboard_arrow_right,
            ),
          if (onDelete != null)
            ModalListItem(
              onTap: onDelete!,
              title: 'Delete sermon',
              trailing: Icons.delete,
            ),
        ],
      ),
    );
  }
}
