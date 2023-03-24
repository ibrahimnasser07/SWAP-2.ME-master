import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:swap_me/model/arg_model.dart';
import 'package:swap_me/shared/components/sized_box.dart';
import 'package:swap_me/shared/styles/theme.dart';

class ImageDetails extends StatelessWidget {
  const ImageDetails({Key? key}) : super(key: key);
  static const String routeName = 'ImageDetails';

  @override
  Widget build(BuildContext context) {
    ScreenArgs screenArgs =
        ModalRoute.of(context)!.settings.arguments as ScreenArgs;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back_ios_new,
              color: ThemeApp.primaryColor,
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Image.network(
              screenArgs.adsModel.image,
              width: double.infinity,
              height: 400,
              fit: BoxFit.fill,
            ),
            DSize(height: 50, width: 0),
            Text(
              '1/2',
              style: GoogleFonts.cairo(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: ThemeApp.primaryColor,
              ),
            ),
            DSize(height: 20, width: 0),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(40),
                      child: Image.network(
                        screenArgs.adsModel.image,
                        height: 200,
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                  const DSize(height: 0, width: 10),
                  Expanded(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(40),
                      child: Image.network(
                        screenArgs.adsModel.image,
                        height: 200,
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
