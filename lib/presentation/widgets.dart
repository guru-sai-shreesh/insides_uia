import 'package:flutter/material.dart';

import 'package:insides/presentation/resources/asset_manager.dart';
import 'package:insides/presentation/resources/colour_manager.dart';
import 'package:insides/presentation/resources/string_manager.dart';
import 'package:insides/presentation/resources/style_manager.dart';
import 'package:insides/presentation/resources/font_manager.dart';
import 'package:insides/presentation/resources/value_manager.dart';

Expanded kRowDivider = const Expanded(
  child: Divider(
    thickness: AppSizeManager.a0_8,
  ),
);

Padding dividerRow (String text){
  return Padding(
    padding: const EdgeInsets.symmetric(
      vertical: PaddingManager.p_10,
      horizontal: PaddingManager.p_60,
    ),
    child: Row(
      children: <Widget>[
        kRowDivider,

        Padding(
          padding: const EdgeInsets.all(
            PaddingManager.p_10,
          ),
          child: Text(
            text,
          ),
        ),

        kRowDivider
      ],
    ),
  );
}