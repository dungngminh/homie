import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:models/models.dart';
import 'package:pbl6_mobile/edit_post/edit_post.dart';
import 'package:widgets/widgets.dart';

class EditingGeneralInformation extends StatelessWidget {
  const EditingGeneralInformation({
    super.key,
    required this.post,
  });

  final Post post;

  @override
  Widget build(BuildContext context) {
    const box16 = SizedBox(
      height: 16,
    );
    const box24 = SizedBox(
      height: 24,
    );
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          'Thông tin chung',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        box16,
        AppTextField(
          labelText: 'Tiêu đề ',
          hintText: 'Tiêu đề cho bài viết',
          initialValue: post.title,
          onChanged: (title) =>
              context.read<EditPostBloc>().add(TitleChanged(title)),
        ),
        box24,
        AppTextField(
          labelText: 'Mô tả chung',
          hintText: 'Mô tả chung của bài viết',
          initialValue: post.description,
          onChanged: (description) => context
              .read<EditPostBloc>()
              .add(SummaryDescriptionChanged(description)),
        ),
      ],
    );
  }
}