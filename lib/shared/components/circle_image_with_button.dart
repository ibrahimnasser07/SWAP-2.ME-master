import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../cubit/swapCubit/swap_cubit.dart';

class ProfileCircleImageWithButton extends StatelessWidget {
  final String imageUrl;
  final IconData iconData;
  final Function() onPressed;
  final Color buttonColor;

  const ProfileCircleImageWithButton({
    Key? key,
    required this.imageUrl,
    required this.iconData,
    required this.onPressed,
    this.buttonColor = Colors.blue,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final profileImage = SwapCubit.get(context).profileImagePicked;
    final adsImagePicked = SwapCubit.get(context).adsImagePicked;
    Widget imageWidget;

    if (profileImage != null) {
      imageWidget = Image.file(
        profileImage,
        fit: BoxFit.cover,
        width: 180,
        height: 180,
      );
    } else if (adsImagePicked != null) {
      imageWidget = Image.file(
        adsImagePicked,
        fit: BoxFit.cover,
        width: 180,
        height: 180,
      );
    } else {
      imageWidget = CachedNetworkImage(
        imageUrl: imageUrl,
        fit: BoxFit.cover,
        width: 180,
        height: 180,
      );
    }

    return Stack(
      children: [
        Container(
          width: 180,
          height: 180,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: Colors.black, width: 1),
          ),
          child: ClipOval(child: imageWidget),
        ),
        Positioned(
          left: 12,
          bottom: 12,
          child: Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: buttonColor,
            ),
            child: IconButton(
              icon: Icon(iconData),
              onPressed: onPressed,
              color: Colors.white,
              iconSize: 20,
            ),
          ),
        ),
      ],
    );
  }
}
