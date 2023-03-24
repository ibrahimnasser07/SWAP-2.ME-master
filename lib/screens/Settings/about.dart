import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../shared/styles/theme.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({Key? key}) : super(key: key);
  static const String routeName = 'aboutScreen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
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
        title: Text(
          "عن التطبيق",
          style: GoogleFonts.cairo(
            color: ThemeApp.primaryColor,
            fontWeight: FontWeight.bold,
            fontSize: 17,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 50),
        child: NotificationListener<OverscrollIndicatorNotification>(
          onNotification: (overscroll) {
            overscroll.disallowIndicator();
            return false;
          },
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(width: double.infinity),
                SizedBox(
                  height: 250,
                  child: SvgPicture.asset('assets/images/swap_me_ar.svg'),
                ),
                Text(
                  "تطببق  مبادله لتبادل أي شيء لم نعد بحاجه اليه"
                  " من شخص الي اخر ،يمكنك استبدال هاتفك المحمول"
                  " الذي قمت بتجديده بساعه يد او حقيبتك بكتاب كل"
                  " شيء يمكن ان يكون قابلا للتبادل ولكن بشرط ان تكون"
                  " الحالة جيده او ممتازة وليس شرط ان يكون التبادل"
                  " بنفس المنتج ، ادخل بياناتك وتقدم بالمنتج الذي"
                  " تريد تبادله ، ولديك عروض للتبادل ونختار من"
                  " بينها ما يعجبك والذي يناسبك في عالم  المقايضة"
                  " ممنوع استخدام العملة ولا مكان للشراء والبيع",
                  style: GoogleFonts.vazirmatn(fontSize: 16,height: 2),
                ),
                const SizedBox(height: 30),
                Text(
                  "استمتع بتجربتك للتطبيق",
                  style: GoogleFonts.vazirmatn(fontSize: 16),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
