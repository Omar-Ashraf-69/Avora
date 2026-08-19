import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/foundation.dart' as foundation;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomEmojiPicker extends StatelessWidget {
  const CustomEmojiPicker({
    super.key,
    required this.controller,
    required this._emojiScrollController,
  });

  final TextEditingController controller;
  final ScrollController _emojiScrollController;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300.h,
      child: EmojiPicker(
        textEditingController: controller,
        scrollController: _emojiScrollController,
        config: Config(
          height: 300.h,
    
          checkPlatformCompatibility: true,
    
          viewOrderConfig: const ViewOrderConfig(),
    
          emojiViewConfig: EmojiViewConfig(
            emojiSizeMax:
                28 *
                (foundation.defaultTargetPlatform == TargetPlatform.iOS
                    ? 1.2
                    : 1.0),
          ),
    
          skinToneConfig: const SkinToneConfig(rememberSkinTone: true),
    
          categoryViewConfig: const CategoryViewConfig(),
    
          bottomActionBarConfig: const BottomActionBarConfig(),
    
          searchViewConfig: const SearchViewConfig(),
        ),
      ),
    );
  }
}
