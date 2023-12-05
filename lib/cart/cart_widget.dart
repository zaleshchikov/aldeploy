import 'dart:async';
import 'dart:math';

import 'package:flutter/scheduler.dart';

import '../auth/auth_util.dart';
import '../backend/backend.dart';
import '../components/empty_cart_widget.dart';
import '../components/success_order_widget.dart';
import '../flutter_flow/flutter_flow_count_controller.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import '../flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

import '../support_files/service.dart';

class CartWidget extends StatefulWidget {
  const CartWidget({Key? key}) : super(key: key);

  @override
  _CartWidgetState createState() => _CartWidgetState();
}

class _CartWidgetState extends State<CartWidget> {
  double? ratingBarValue;
  int? countControllerValue;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  TextEditingController? textController;
  Timer? timer;

  @override
  void dispose() {
    super.dispose();
    timer!.cancel();
  }

  @override
  void initState() {
    super.initState();

    textController = TextEditingController();
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      timer = Timer.periodic(
          Duration(seconds: 15), (Timer t) => notif(context, timer!));
    });

    WidgetsBinding.instance.addPostFrameCallback((_) => setState(() {}));
  }

  @override
  Widget build(BuildContext context) {
    return Title(
        title: 'Cart',
        color: FlutterFlowTheme.of(context).primaryColor,
        child: Scaffold(
          key: scaffoldKey,
          appBar: AppBar(
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
              'Корзина',
              style: FlutterFlowTheme.of(context).title2.override(
                    fontFamily: 'Inter',
                    color: FlutterFlowTheme.of(context).primaryText,
                    fontSize: 20,
                  ),
            ),
            actions: [],
            centerTitle: true,
            elevation: 2,
          ),
          backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
          body: SafeArea(
            child: GestureDetector(
              onTap: () => FocusScope.of(context).unfocus(),
              child: StreamBuilder<List<CartRecord>>(
                  stream: queryCartRecord(
                    parent: currentUserReference,
                  ),
                  builder: (context, snapshot) {
                    // Customize what your widget looks like when it's loading.
                    if (!snapshot.hasData) {
                      return Center(
                        child: SizedBox(
                          width: 50,
                          height: 50,
                          child: CircularProgressIndicator(
                            color: FlutterFlowTheme.of(context).primaryColor,
                          ),
                        ),
                      );
                    }
                    List<CartRecord> listViewCartRecordList = snapshot.data!;

                    if (listViewCartRecordList.length == 0) {
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            child: EmptyCartWidget(),
                          ),
                        ],
                      );
                    }
                    return Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Expanded(
                              child: Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    16, 16, 16, 0),
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
                                        padding: EdgeInsetsDirectional.fromSTEB(
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
                                            style: FlutterFlowTheme.of(context)
                                                .bodyText1
                                                .override(
                                                  fontFamily: 'Inter',
                                                  fontSize: 12,
                                                ),
                                          ),
                                          Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    0, 4, 0, 0),
                                            child: Text(
                                              FFAppState().currentShopName == ''
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
                          ],
                        ),
                        if (currentUserDisplayName == '')
                          Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(16, 12, 16, 0),
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Text(
                                      'Данные для оформления заказа',
                                      style: FlutterFlowTheme.of(context)
                                          .bodyText1
                                          .override(
                                            fontFamily: 'Inter',
                                            fontSize: 12,
                                          ),
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      0, 4, 0, 0),
                                  child: TextFormField(
                                    controller: textController,
                                    autofocus: false,
                                    obscureText: false,
                                    decoration: InputDecoration(
                                      hintText: 'Напишите имя и фамилию',
                                      hintStyle: FlutterFlowTheme.of(context)
                                          .bodyText2
                                          .override(
                                            fontFamily: 'Inter',
                                            fontSize: 12,
                                          ),
                                      enabledBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Color(0x00000000),
                                          width: 1,
                                        ),
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      focusedBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Color(0x00000000),
                                          width: 1,
                                        ),
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      filled: true,
                                      fillColor: Colors.white,
                                    ),
                                    style: FlutterFlowTheme.of(context)
                                        .bodyText1
                                        .override(
                                          fontFamily: 'Inter',
                                          fontSize: 12,
                                        ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        Expanded(
                          child: Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(0, 16, 0, 0),
                            child: ListView.builder(
                              padding: EdgeInsets.zero,
                              shrinkWrap: true,
                              scrollDirection: Axis.vertical,
                              itemCount: listViewCartRecordList.length,
                              itemBuilder: (context, listViewIndex) {
                                final listViewCartRecord =
                                    listViewCartRecordList[listViewIndex];
                                return Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      16, 0, 16, 16),
                                  child: Container(
                                    width: 100,
                                    height: 154,
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
                                    child: Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          16, 10, 16, 10),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          // Image.asset(
                                          //   'assets/images/1D2EEB92-B58E-452F-A1F8-303C4EE7377C_1.png',
                                          //   width: 86,
                                          //   height: MediaQuery.of(context)
                                          //           .size
                                          //           .height *
                                          //       1,
                                          //   fit: BoxFit.contain,

                                          // ),
                                          if (listViewCartRecord.image ==
                                                  null ||
                                              listViewCartRecord.image == '')
                                            Image.asset(
                                              'assets/images/no-pictures.png',
                                              width: 86,
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  1,
                                              fit: BoxFit.contain,
                                            ),
                                          if (listViewCartRecord.image !=
                                                  null &&
                                              listViewCartRecord.image != '')
                                            Image.network(
                                              listViewCartRecord.image!,
                                              width: 86,
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  1,
                                              fit: BoxFit.contain,
                                            ),
                                          Expanded(
                                            child: Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(16, 0, 0, 0),
                                              child: Column(
                                                mainAxisSize: MainAxisSize.max,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Expanded(
                                                    child: Column(
                                                      mainAxisSize:
                                                          MainAxisSize.max,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Row(
                                                          mainAxisSize:
                                                              MainAxisSize.max,
                                                          children: [
                                                            Expanded(
                                                              child: Text(
                                                                listViewCartRecord
                                                                    .name!,
                                                                style: FlutterFlowTheme.of(
                                                                        context)
                                                                    .subtitle2,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                        // Padding(
                                                        //   padding:
                                                        //       EdgeInsetsDirectional
                                                        //           .fromSTEB(
                                                        //               0, 4, 0, 0),
                                                        //   child:
                                                        //       RatingBar.builder(
                                                        //     onRatingUpdate:
                                                        //         (newValue) =>
                                                        //             setState(() =>
                                                        //                 newValue),
                                                        //     itemBuilder: (context,
                                                        //             index) =>
                                                        //         Icon(
                                                        //       Icons.star_rounded,
                                                        //       color: FlutterFlowTheme
                                                        //               .of(context)
                                                        //           .secondaryColor,
                                                        //     ),
                                                        //     direction:
                                                        //         Axis.horizontal,
                                                        //     initialRating:
                                                        //         ratingBarValue ??=
                                                        //             3,
                                                        //     unratedColor:
                                                        //         Color(0xFF9E9E9E),
                                                        //     itemCount: 5,
                                                        //     itemSize: 19,
                                                        //     glowColor:
                                                        //         FlutterFlowTheme.of(
                                                        //                 context)
                                                        //             .secondaryColor,
                                                        //   ),
                                                        // ),
                                                        // Row(
                                                        //   mainAxisSize:
                                                        //       MainAxisSize.max,
                                                        //   children: [
                                                        //     Expanded(
                                                        //       child: Padding(
                                                        //         padding:
                                                        //             EdgeInsetsDirectional
                                                        //                 .fromSTEB(
                                                        //                     0,
                                                        //                     4,
                                                        //                     0,
                                                        //                     0),
                                                        //         child: Text(
                                                        //           'брют, Италия, 0.75 л',
                                                        //           style: FlutterFlowTheme.of(
                                                        //                   context)
                                                        //               .bodyText2,
                                                        //         ),
                                                        //       ),
                                                        //     ),
                                                        //   ],
                                                        // ),
                                                      ],
                                                    ),
                                                  ),
                                                  Expanded(
                                                    flex: 1,
                                                    child: Column(
                                                      mainAxisSize:
                                                          MainAxisSize.max,
                                                      children: [
                                                        Row(
                                                          mainAxisSize:
                                                              MainAxisSize.max,
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .end,
                                                          children: [
                                                            Container(
                                                              width: 70,
                                                              height: 30,
                                                              decoration:
                                                                  BoxDecoration(
                                                                color: Color(
                                                                    0xFFFF007A),
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            25),
                                                                shape: BoxShape
                                                                    .rectangle,
                                                                border:
                                                                    Border.all(
                                                                  color: Colors
                                                                      .white,
                                                                  width: 0,
                                                                ),
                                                              ),
                                                              child:
                                                                  FlutterFlowCountController(
                                                                decrementIconBuilder:
                                                                    (enabled) =>
                                                                        FaIcon(
                                                                  FontAwesomeIcons
                                                                      .minus,
                                                                  color: enabled
                                                                      ? Color(
                                                                          0xDD000000)
                                                                      : Color(
                                                                          0xFFEEEEEE),
                                                                  size: 14,
                                                                ),
                                                                incrementIconBuilder:
                                                                    (enabled) =>
                                                                        FaIcon(
                                                                  FontAwesomeIcons
                                                                      .plus,
                                                                  color: enabled
                                                                      ? Colors
                                                                          .black
                                                                      : Color(
                                                                          0xFFEEEEEE),
                                                                  size: 14,
                                                                ),
                                                                countBuilder:
                                                                    (count) =>
                                                                        Text(
                                                                  count
                                                                      .toString(),
                                                                  style: GoogleFonts
                                                                      .getFont(
                                                                    'Roboto',
                                                                    color: Colors
                                                                        .black,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600,
                                                                    fontSize:
                                                                        12,
                                                                  ),
                                                                ),
                                                                minimum: 0,
                                                                count:
                                                                    listViewCartRecord
                                                                        .count!,
                                                                updateCount:
                                                                    (count) async {
                                                                  setState(
                                                                      () async {
                                                                    if (count ==
                                                                        0) {
                                                                      listViewCartRecord
                                                                        ..reference
                                                                            .delete();
                                                                    } else {
                                                                      final cartUpdateData =
                                                                          createCartRecordData(
                                                                        count:
                                                                            count,
                                                                      );
                                                                      await listViewCartRecord
                                                                          .reference
                                                                          .update(
                                                                              cartUpdateData);
                                                                    }
                                                                  });
                                                                },
                                                                stepSize: 1,
                                                                contentPadding:
                                                                    EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                            10,
                                                                            0,
                                                                            10,
                                                                            0),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                        Row(
                                                          mainAxisSize:
                                                              MainAxisSize.max,
                                                          children: [
                                                            Text(
                                                              '${listViewCartRecord.price! * listViewCartRecord.count!} ₽',
                                                              style: FlutterFlowTheme
                                                                      .of(context)
                                                                  .subtitle2
                                                                  .override(
                                                                    fontFamily:
                                                                        'Inter',
                                                                    fontSize:
                                                                        14,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600,
                                                                  ),
                                                            ),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                        Padding(
                          padding:
                              EdgeInsetsDirectional.fromSTEB(16, 16, 16, 16),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Expanded(
                                child: StreamBuilder<List<CartRecord>>(
                                  stream: queryCartRecord(
                                    parent: currentUserReference,
                                  ),
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
                                    List<CartRecord> containerCartRecordList =
                                        snapshot.data!;

                                    if (containerCartRecordList.length == 0) {
                                      return Container();
                                    }

                                    int summa = 0;
                                    int count = 0;
                                    for (var i in containerCartRecordList) {
                                      summa += i.price! * i.count!;
                                      count += i.count!;
                                    }
                                    return Container(
                                      width: 100,
                                      height: 68,
                                      decoration: BoxDecoration(
                                        color: Color(0xFFFF0011),
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          Expanded(
                                            child: Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(12, 12, 0, 12),
                                              child: Column(
                                                mainAxisSize: MainAxisSize.max,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    '$summa ₽',
                                                    style: FlutterFlowTheme.of(
                                                            context)
                                                        .title3
                                                        .override(
                                                          fontFamily: 'Inter',
                                                          color: Colors.white,
                                                        ),
                                                  ),
                                                  Text(
                                                    '$count шт.',
                                                    style: FlutterFlowTheme.of(
                                                            context)
                                                        .subtitle1
                                                        .override(
                                                          fontFamily: 'Inter',
                                                          color: Colors.white,
                                                        ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    12, 0, 12, 0),
                                            child: FFButtonWidget(
                                              onPressed: () async {
                                                if (currentUserDisplayName ==
                                                    '') {
                                                  if (textController!.text ==
                                                      '') {
                                                    ScaffoldMessenger.of(
                                                            context)
                                                        .showSnackBar(
                                                      SnackBar(
                                                        content: Text(
                                                            'Введите имя и фамилию'),
                                                      ),
                                                    );
                                                    return;
                                                  } else {
                                                    final usersUpdateData =
                                                        createUsersRecordData(
                                                      displayName:
                                                          textController!.text,
                                                    );
                                                    await currentUserReference!
                                                        .update(
                                                            usersUpdateData);
                                                  }
                                                }
                                                showModalBottomSheet(
                                                  isScrollControlled: true,
                                                  backgroundColor: Colors.white,
                                                  context: context,
                                                  builder: (context) {
                                                    return Padding(
                                                      padding:
                                                          MediaQuery.of(context)
                                                              .viewInsets,
                                                      child:
                                                          SuccessOrderWidget(),
                                                    );
                                                  },
                                                );
                                                var random = new Random();
                                                var id =
                                                    random.nextInt(999999999);

                                                List<CartStruct> listProducts =
                                                    [];
                                                for (var product
                                                    in containerCartRecordList) {
                                                  var newProduct =
                                                      createCartStruct(
                                                    code: product.code,
                                                    name: product.name,
                                                    price: product.price,
                                                    image: product.image,
                                                    count: product.count,
                                                    clearUnsetFields: false,
                                                    create: true,
                                                  );

                                                  listProducts.add(newProduct);

                                                  var res2 =
                                                      await addProductForOrder(
                                                          id, product);
                                                  print(res2);
                                                  await product.reference
                                                      .delete();
                                                }
                                                var res1 = await addNewOrder(
                                                    id,
                                                    currentUserDocument!
                                                        .phoneNumber,
                                                    getCurrentTimestamp
                                                        .toIso8601String(),
                                                    'Новый',
                                                    FFAppState().currentShopId,
                                                    summa,
                                                    currentUserDocument!
                                                        .displayName,
                                                    currentUserDocument!
                                                        .serialNumber);
                                                print(res1);

                                                final ordersCreateData = {
                                                  ...createOrdersRecordData(
                                                    id: id,
                                                    status: 'Новый',
                                                    datetime:
                                                        getCurrentTimestamp,
                                                    user: currentUserReference,
                                                    summa: summa.toDouble(),
                                                    count: count,
                                                    shop: nameShop[FFAppState()
                                                        .currentShopId],
                                                    push: false,
                                                    typed: 'Самовывоз',
                                                  ),
                                                  'Products':
                                                      getCartListFirestoreData(
                                                    listProducts,
                                                  )
                                                };

                                                await OrdersRecord.collection
                                                    .doc()
                                                    .set(ordersCreateData);
                                                // for (var product
                                                //     in containerCartRecordList) {
                                                //   await product.reference.delete();
                                                // }
                                              },
                                              text: 'Оформить заказ',
                                              options: FFButtonOptions(
                                                width: 140,
                                                height: 40,
                                                color: Colors.white,
                                                textStyle:
                                                    FlutterFlowTheme.of(context)
                                                        .subtitle2
                                                        .override(
                                                          fontFamily: 'Inter',
                                                          color: Colors.black,
                                                        ),
                                                borderSide: BorderSide(
                                                  color: Colors.transparent,
                                                  width: 1,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(15),
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
                      ],
                    );
                  }),
            ),
          ),
        ));
  }
}
