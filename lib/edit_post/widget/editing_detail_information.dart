import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:models/models.dart';
import 'package:pbl6_mobile/edit_post/edit_post.dart';
import 'package:widgets/widgets.dart';

class EditingDetailInformation extends StatelessWidget {
  const EditingDetailInformation({
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
    final editPostBloc = context.read<EditPostBloc>();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          'Thông tin chi tiết',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        box16,
        BlocBuilder<EditPostBloc, EditPostState>(
          builder: (context, state) {
            return AppDropDownField<String>(
              value: state.selectedHouseType == 0
                  ? null
                  : state.selectedHouseType.toString(),
              labelText: 'Loại phòng',
              items: state.houseTypesData
                  .map<DropdownMenuItem<String>>(
                    (type) => DropdownMenuItem<String>(
                      value: type.id.toString(),
                      child: Text(type.name),
                    ),
                  )
                  .toList(),
              onChanged: (houseType) {
                if (houseType != null) {
                  editPostBloc.add(HouseTypeSelected(houseType));
                }
              },
            );
          },
        ),
        box24,
        Builder(
          builder: (context) {
            final formatter = CurrencyTextInputFormatter(
              locale: 'vi',
              symbol: 'VND',
              decimalDigits: 0,
            );
            return AppTextField(
              initialValue: formatter.format(post.price.toString()),
              labelText: 'Giá',
              inputFormatters: [formatter],
              keyboardType: TextInputType.number,
              onChanged: (_) => editPostBloc
                  .add(RoomPriceChanged(formatter.getUnformattedValue())),
            );
          },
        ),
        box24,
        AppTextField(
          labelText: 'Diện tích',
          initialValue: post.area.toString(),
          onChanged: (area) => editPostBloc.add(RoomAreaChanged(area)),
          keyboardType: TextInputType.number,
        )
      ],
    );
  }
}