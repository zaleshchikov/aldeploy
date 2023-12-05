import 'dart:async';

import 'package:alcoapp_main/auth/auth_util.dart';
import 'package:flutter/scheduler.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../backend/backend.dart';
import '../components/add_card_widget.dart';
import '../components/choice_shop_widget.dart';
import '../flutter_flow/flutter_flow_icon_button.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import '../page_catalog/page_catalog_widget.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../search/search_widget.dart';
import '../subcategory_page/subcategory_page_widget.dart';
import '../support_files/service.dart';

class CatalogWidget extends StatefulWidget {
  const CatalogWidget({Key? key}) : super(key: key);

  @override
  _CatalogWidgetState createState() => _CatalogWidgetState();
}

class _CatalogWidgetState extends State<CatalogWidget> {
  PageController? pageViewController;
  TextEditingController? textController;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  late Future<List<Category>> futureCategories;
  int colorIndex = 0;
  Timer? timer;
  @override
  void dispose() {
    super.dispose();
    timer!.cancel();
  }

  @override
  void initState() {
    super.initState();

    futureCategories = fetchCategories(FFAppState().currentShopId);
    textController = TextEditingController();
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      timer = Timer.periodic(
          Duration(seconds: 15), (Timer t) => notif(context, timer!));

      if (currentUserDocument!.isInstalCard == false) {
        await showModalBottomSheet(
          isScrollControlled: true,
          backgroundColor: Colors.transparent,
          context: context,
          builder: (context) {
            return Padding(
              padding: MediaQuery.of(context).viewInsets,
              child: AddCartWidget(),
            );
          },
        ).then((value) => setState(() {}));
      }
    });

    WidgetsBinding.instance.addPostFrameCallback((_) => setState(() {}));
  }

  @override
  Widget build(BuildContext context) {
    return Title(
        title: 'Catalog',
        color: FlutterFlowTheme.of(context).primaryColor,
        child: Scaffold(
          key: scaffoldKey,
          appBar: AppBar(
            // actions: [
            //   IconButton(
            //     icon: Icon(
            //       Icons.search,
            //       color: Colors.black,
            //     ),
            //     onPressed: () async {
            //       await Navigator.push(
            //         context,
            //         MaterialPageRoute(
            //           builder: (context) => SearchWidget(),
            //         ),
            //       );
            //     },
            //   )
            // ],
            backgroundColor: Colors.white,
            automaticallyImplyLeading: false,
            leading: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.asset(
                'assets/images/logo1.png',
                width: 180,
                height: 180,
                fit: BoxFit.cover,
              ),
            ),
            title: Text(
              'Каталог',
              style: FlutterFlowTheme.of(context).title2.override(
                    fontFamily: 'Inter',
                    color: FlutterFlowTheme.of(context).primaryText,
                    fontSize: 20,
                  ),
            ),
            // actions: [],
            centerTitle: true,
            elevation: 2,
          ),
          backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
          body: GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Expanded(
                                child: StreamBuilder<List<PromotionsRecord>>(
                                  stream: queryPromotionsRecord(),
                                  builder: (context, snapshot) {
                                    // Customize what your widget looks like when it's loading.
                                    if (!snapshot.hasData) {
                                      return Center(
                                        child: SizedBox(
                                          width: 50,
                                          height: 50,
                                          child: CircularProgressIndicator(
                                            color: FlutterFlowTheme.of(context)
                                                .primaryColor,
                                          ),
                                        ),
                                      );
                                    }
                                    List<PromotionsRecord>
                                        pageViewPromotionsRecordList =
                                        snapshot.data!;
                                    return Container(
                                      width: double.infinity,
                                      height: 200,
                                      child: Stack(
                                        children: [
                                          Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    4, 4, 4, 20),
                                            child: PageView.builder(
                                              controller: pageViewController ??=
                                                  PageController(
                                                      initialPage: min(
                                                          0,
                                                          pageViewPromotionsRecordList
                                                                  .length -
                                                              1)),
                                              scrollDirection: Axis.horizontal,
                                              itemCount:
                                                  pageViewPromotionsRecordList
                                                      .length,
                                              itemBuilder:
                                                  (context, pageViewIndex) {
                                                final pageViewPromotionsRecord =
                                                    pageViewPromotionsRecordList[
                                                        pageViewIndex];
                                                return Image.network(
                                                  pageViewPromotionsRecord
                                                      .cover!,
                                                  fit: BoxFit.fitWidth,
                                                );
                                              },
                                            ),
                                          ),
                                          Align(
                                            alignment:
                                                AlignmentDirectional(0, 1),
                                            child: SmoothPageIndicator(
                                              controller: pageViewController ??=
                                                  PageController(
                                                      initialPage: min(
                                                          0,
                                                          pageViewPromotionsRecordList
                                                                  .length -
                                                              1)),
                                              count:
                                                  pageViewPromotionsRecordList
                                                      .length,
                                              axisDirection: Axis.horizontal,
                                              onDotClicked: (i) {
                                                pageViewController!
                                                    .animateToPage(
                                                  i,
                                                  duration: Duration(
                                                      milliseconds: 500),
                                                  curve: Curves.ease,
                                                );
                                              },
                                              effect: ExpandingDotsEffect(
                                                expansionFactor: 2,
                                                spacing: 0,
                                                radius: 16,
                                                dotWidth: 40,
                                                dotHeight: 1,
                                                dotColor: Color(0xFFB1C1DA),
                                                activeDotColor: Colors.black,
                                                paintStyle: PaintingStyle.fill,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                        Column(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Expanded(
                                  child: Container(
                                    width: 100,
                                    // height: 60,
                                    decoration: BoxDecoration(
                                      color: Colors.transparent,
                                    ),
                                    child: Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          0, 10, 0, 0),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    16, 10, 16, 0),
                                            child: TextFormField(
                                              controller: textController,
                                              autofocus: false,
                                              obscureText: false,
                                              readOnly: true,
                                              onTap: () async {
                                                await Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        SearchWidget(),
                                                  ),
                                                );
                                              },
                                              decoration: InputDecoration(
                                                hintText: 'Поиск товаров',
                                                hintStyle:
                                                    FlutterFlowTheme.of(context)
                                                        .bodyText2
                                                        .override(
                                                          fontFamily: 'Inter',
                                                          fontSize: 15,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                        ),
                                                enabledBorder:
                                                    UnderlineInputBorder(
                                                  borderSide: BorderSide(
                                                    color: Colors.white,
                                                    width: 1,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(15),
                                                ),
                                                focusedBorder:
                                                    UnderlineInputBorder(
                                                  borderSide: BorderSide(
                                                    color: Colors.white,
                                                    width: 1,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(15),
                                                ),
                                                errorBorder:
                                                    UnderlineInputBorder(
                                                  borderSide: BorderSide(
                                                    color: Colors.white,
                                                    width: 1,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(15),
                                                ),
                                                focusedErrorBorder:
                                                    UnderlineInputBorder(
                                                  borderSide: BorderSide(
                                                    color: Colors.white,
                                                    width: 1,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(15),
                                                ),
                                                filled: true,
                                                fillColor: Colors.white,
                                                prefixIcon: Icon(
                                                  Icons.search,
                                                  size: 20,
                                                  color: Color(0xFFE9E9E9),
                                                ),
                                              ),
                                              style:
                                                  FlutterFlowTheme.of(context)
                                                      .bodyText1
                                                      .override(
                                                        fontFamily: 'Inter',
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                      ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Expanded(
                              child: Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    16, 16, 16, 0),
                                child: InkWell(
                                  onTap: () async {
                                    await showModalBottomSheet(
                                      isScrollControlled: true,
                                      backgroundColor: Colors.transparent,
                                      context: context,
                                      builder: (context) {
                                        return Padding(
                                          padding:
                                              MediaQuery.of(context).viewInsets,
                                          child: ChoiceShopWidget(),
                                        );
                                      },
                                    );
                                  },
                                  child: Container(
                                    width: 100,
                                    height: 75,
                                    decoration: BoxDecoration(
                                      color: FlutterFlowTheme.of(context)
                                          .secondaryBackground,
                                      boxShadow: [
                                        BoxShadow(
                                          blurRadius: 4,
                                          color: Color(0x40000000),
                                          offset: Offset(0, 4),
                                        )
                                      ],
                                    ),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  22, 0, 16, 0),
                                          child: FaIcon(
                                            FontAwesomeIcons.mapMarkerAlt,
                                            color: Colors.black,
                                            size: 24,
                                          ),
                                          // Image.asset(
                                          //   'assets/images/81B92F39-6F0F-4E51-9161-26820E32D231_1.png',
                                          //   width: 22,
                                          //   height: 41,
                                          //   fit: BoxFit.contain,
                                          // ),
                                        ),
                                        Column(
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              'Каталог магазина',
                                              style:
                                                  FlutterFlowTheme.of(context)
                                                      .bodyText1
                                                      .override(
                                                        fontFamily: 'Inter',
                                                        fontSize: 12,
                                                      ),
                                            ),
                                            Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(0, 4, 0, 0),
                                              child: Text(
                                                FFAppState().currentShopName ==
                                                        ''
                                                    ? 'Выберите магазин'
                                                    : FFAppState()
                                                        .currentShopName,
                                                style:
                                                    FlutterFlowTheme.of(context)
                                                        .bodyText1
                                                        .override(
                                                          fontFamily: 'Inter',
                                                          fontSize: 12,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                        ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0, 16, 0, 16),
                          child: FutureBuilder<List<Category>>(
                            future: futureCategories,
                            builder: (context, snapshot) {
                              // Customize what your widget looks like when it's loading.
                              if (!snapshot.hasData) {
                                return Center(
                                  child: SizedBox(
                                    width: 50,
                                    height: 50,
                                    child: CircularProgressIndicator(
                                      color: FlutterFlowTheme.of(context)
                                          .primaryColor,
                                    ),
                                  ),
                                );
                              }
                              List<Category> categoriesNoFilter =
                                  snapshot.data!;
                              List<Category> categories = categoriesNoFilter
                                  .where((element) => element.hide == false)
                                  .toList();
                              List<Color> listColor = [
                                Color.fromARGB(255, 172, 237, 237),
                                Color.fromARGB(255, 255, 105, 177),
                                Color.fromARGB(255, 177, 193, 218),
                                Color.fromARGB(255, 217, 174, 237),
                                Color.fromARGB(255, 255, 186, 82),
                              ];

                              return Column(
                                mainAxisSize: MainAxisSize.max,
                                children: List.generate(categories.length,
                                    (columnIndex) {
                                  final category = categories[columnIndex];
                                  // Color colorButton = listColor[colorIndex];
                                  // colorIndex += 1;
                                  // if (colorIndex > 4) {
                                  //   colorIndex = 0;
                                  // }
                                  Color colorButton = Colors.white;
                                  return Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        0, 0, 0, 12),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        Expanded(
                                          child: Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    16, 0, 16, 0),
                                            child: InkWell(
                                              onTap: () async {
                                                if (category.isRelative!) {
                                                  await Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) =>
                                                          SubcategoryPageWidget(
                                                        category: category,
                                                      ),
                                                    ),
                                                  );
                                                } else {
                                                  await Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) =>
                                                          PageCatalogWidget(
                                                        categoryId: category.id,
                                                      ),
                                                    ),
                                                  );
                                                }
                                              },
                                              child: Container(
                                                width: 100,
                                                height: 130,
                                                decoration: BoxDecoration(
                                                  color: colorButton,
                                                  boxShadow: [
                                                    BoxShadow(
                                                      blurRadius: 4,
                                                      color: Color(0x3F000000),
                                                      offset: Offset(0, 4),
                                                    )
                                                  ],
                                                ),
                                                child: Padding(
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(24, 0, 24, 0),
                                                  child: Row(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    children: [
                                                      Expanded(
                                                        child: Text(
                                                          category.name!,
                                                          style: FlutterFlowTheme
                                                                  .of(context)
                                                              .bodyText1
                                                              .override(
                                                                fontFamily:
                                                                    'Inter',
                                                                fontSize: 15,
                                                              ),
                                                        ),
                                                      ),
                                                      if (category.image !=
                                                          null)
                                                        Padding(
                                                          padding:
                                                              EdgeInsetsDirectional
                                                                  .fromSTEB(10,
                                                                      0, 0, 0),
                                                          child: Image.network(
                                                            category.image!,
                                                            width: 64,
                                                            height: 64,
                                                            fit: BoxFit.contain,
                                                          ),
                                                        ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                }),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
