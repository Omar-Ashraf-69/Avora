  import 'package:avora/core/funcs/phone_formater.dart';
import 'package:avora/features/profile/domain/entities/user_identifier.dart';
import 'package:flutter/material.dart';

UserIdentifier buildIdentifier({required bool isPhone, required TextEditingController identifierController}) {
    final value = identifierController.text.trim();

    if (isPhone) {
      return UserIdentifier(
        type: UserIdentifierType.phone,
        value: PhoneNumberFormatter.normalizeEgyptianPhone(value),
      );
    }

    return UserIdentifier(
      type: UserIdentifierType.username,
      value: value.replaceFirst('@', '').toLowerCase(),
    );
  }
