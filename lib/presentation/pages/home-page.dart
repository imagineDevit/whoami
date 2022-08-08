import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:henri_sedjame/misc/colors.dart';
import 'package:henri_sedjame/misc/constants.dart';
import 'package:henri_sedjame/misc/images.dart';
import 'package:henri_sedjame/misc/logo-properties.dart';
import 'package:henri_sedjame/models/data.dart';
import 'package:henri_sedjame/models/value.dart';
import 'package:henri_sedjame/presentation/notifiers/data-notifier.dart';
import 'package:henri_sedjame/presentation/pages/common-page.dart';
import 'package:henri_sedjame/presentation/pages/first-page.dart';
import 'package:henri_sedjame/presentation/widgets/wai-button.dart';
import 'package:henri_sedjame/utils/logo-utils.dart';
import 'package:henri_sedjame/utils/screen-utils.dart';

class HomePage extends StatefulWidget {
  final Value<Data> data;

  const HomePage({Key? key, required this.data}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late ScrollController _scrollController;
  late DataNotifier _dataNotifier;

  double logoPositionTop = 0.0;
  double menuPositionTop = 0.0;
  double? logoPositionLeft;
  double logoSize = 1000.0;
  double menuOpacity = 0.0;
  double translateGap = logoMoveScrollGap;
  bool showMenuBar = false;
  bool showEn = false;

  @override
  void initState() {
    super.initState();

    _dataNotifier = GetIt.I<DataNotifier>();

    _scrollController = ScrollController()
      ..addListener(() {
        var screenSize = MediaQuery.of(context).size;
        var offset = _scrollController.offset;

        logoPositionTop = offset;
        menuPositionTop = offset;

        var initialPositionLeft = (screenSize.width / 2) -
            (LogoUtils.logoSize(maxLogoSize, screenSize.width) / 2);

        if (offset < translateGap) {
          showMenuBar = false;
          logoSize = maxLogoSize -
              (((maxLogoSize - minLogoSize) / translateGap) * offset);

          logoPositionLeft = offset == 0
              ? null
              : (initialPositionLeft -
                  ((initialPositionLeft / translateGap) * offset));

          menuOpacity = 0.0;
        } else {
          showMenuBar = true;
          logoSize = minLogoSize;
          logoPositionLeft = 0;
          menuOpacity = 1.0;
        }

        setState(() => {});
      });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (ctx, constraints) => SingleChildScrollView(
          controller: _scrollController,
          child: Stack(
            alignment: Alignment.center,
            children: [
              Column(
                children: [
                  FirstPage(
                    offset: logoPositionTop,
                    logoSize:
                        LogoUtils.logoSize(maxLogoSize, constraints.maxWidth),
                  ),
                  const CommonPage()
                ],
              ),
              if (showMenuBar) ...[menuBarView(context, constraints.maxWidth)],
              logoView(constraints.maxWidth),
              langSwitchView(constraints.maxWidth)
            ],
          ),
        ),
      ),
    );
  }

  Positioned langSwitchView(double screenWidth) {
    var w = 50.0;
    var h = 25.0;
    var top =((ScreenUtils.isLarge(screenWidth) ? largeMenuBarHeight : mediumMenuBarHeight) - h)/ 2 ;

    return Positioned(
        top: menuPositionTop + top,
        right: 15,
        child: MouseRegion(
          cursor: SystemMouseCursors.click,
          child: GestureDetector(
            onTap: () {
              setState(() => showEn = !showEn);
              _dataNotifier.setData(showEn ? widget.data.en : widget.data.fr);
            },
            child: Container(
              width: w,
              height: h,
              decoration: BoxDecoration(
                  color: showEn ? dark : Colors.white,
                  borderRadius: BorderRadius.circular(25)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  if (showEn) ...[langView("EN", true)],
                  Container(
                    width: 20,
                    height: 20,
                    decoration: BoxDecoration(
                        color: green,
                        borderRadius: BorderRadius.circular(25),
                        boxShadow: const [
                          BoxShadow(
                              offset: Offset(0.1, 0.4), color: Colors.grey)
                        ]),
                  ),
                  if (!showEn) ...[langView("FR", false)],
                ],
              ),
            ),
          ),
        ));
  }

  Widget langView(String lang, bool en) {
    return Padding(
      padding: EdgeInsets.only(left: en ? 4.0 : 0, right: en ? 0 : 4.0),
      child: Text(
        lang,
        style: GoogleFonts.lato(
            color: en ? Colors.white : dark, fontWeight: FontWeight.bold),
      ),
    );
  }

  Positioned menuBarView(BuildContext context, double screenWidth) {
    return Positioned(
        top: menuPositionTop,
        child: Opacity(
          opacity: ScreenUtils.isSmall(screenWidth) ? 0 : menuOpacity,
          child: Container(
            height: ScreenUtils.isLarge(screenWidth)
                ? largeMenuBarHeight
                : mediumMenuBarHeight,
            width: MediaQuery.of(context).size.width,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [dark, darkPurple, blackPurple],
              ),
              boxShadow: [
                BoxShadow(
                    offset: Offset(0.0, 0.8),
                    color: brightGreen,
                    blurRadius: 0.5)
              ],
            ),
            child: Align(
              alignment: Alignment.centerRight,
              child: Padding(
                padding: const EdgeInsets.only(right: 90),
                child: WAIButton(text: "CONTACT", onPressed: () {}),
              ),
            ),
          ),
        ));
  }

  Positioned logoView(double screenWidth) {
    var imgSize = LogoUtils.logoSize(logoSize, screenWidth);
    var imgPositionLeft =
        LogoUtils.logoLeftPosition(logoPositionLeft, screenWidth);

    return Positioned(
        top: logoPositionTop + (ScreenUtils.isSmall(screenWidth) ? 5.0 : 0.0),
        left: imgPositionLeft,
        child: Image(
          image: const AssetImage(logoImg),
          width: imgSize,
        ));
  }
}
