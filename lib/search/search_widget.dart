import 'dart:io';

import 'package:easy_debounce/easy_debounce.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../auth/auth_util.dart';
import '../auth/firebase_user_provider.dart';
import '../backend/backend.dart';
import '../choice_age/choice_age_widget.dart';
import '../flutter_flow/flutter_flow_count_controller.dart';
import '../flutter_flow/flutter_flow_icon_button.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_toggle_icon.dart';
import '../flutter_flow/flutter_flow_util.dart';
import '../flutter_flow/flutter_flow_widgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:text_search/text_search.dart';

import '../support_files/service.dart';

class SearchWidget extends StatefulWidget {
  const SearchWidget({Key? key}) : super(key: key);

  @override
  _SearchWidgetState createState() => _SearchWidgetState();
}

class _SearchWidgetState extends State<SearchWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  List<ProductRecord> simpleSearchResults = [];
  TextEditingController? textController;

  late Future<List<Product>> futureProducts;

  List<Product> _found = [];
  List<Product> _all = [];

  @override
  void initState() {
    super.initState();

    textController = TextEditingController();
    WidgetsBinding.instance.addPostFrameCallback((_) => setState(() {}));
    futureProducts = fetchProductsAll(FFAppState().currentShopId);
  }

  void _runFilter(String enteredKeyword) {
    List<Product> results = [];
    if (enteredKeyword == '') {
      results = _all;
    } else {
      results = _all
          .where((product) => product.name!
              .toLowerCase()
              .contains(enteredKeyword.toLowerCase()))
          .toList();
    }
    setState(() {
      _found = results;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      // appBar: AppBar(
      //   backgroundColor: Color(0xFFFFBA52),
      //   automaticallyImplyLeading: false,
      //   leading: Padding(
      //     padding: const EdgeInsets.all(8.0),
      //     child: Image.asset(
      //       'assets/images/logo1.png',
      //       width: 180,
      //       height: 180,
      //       fit: BoxFit.cover,
      //     ),
      //   ),
      //   title: Text(
      //     'Поиск',
      //     style: FlutterFlowTheme.of(context).title2.override(
      //           fontFamily: 'Inter',
      //           color: FlutterFlowTheme.of(context).primaryText,
      //           fontSize: 20,
      //         ),
      //   ),
      //   actions: [],
      //   centerTitle: true,
      //   elevation: 2,
      // ),
      backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
      body: SafeArea(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: FutureBuilder<List<Product>>(
              future: futureProducts,
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Center(
                    child: SizedBox(
                      width: 50,
                      height: 50,
                      child: CircularProgressIndicator(
                        color: Color(0xFFFF000D),
                      ),
                    ),
                  );
                }

                if (textController!.text == '') {
                  _found = _all;
                }

                _all = snapshot.data!;

                //_all = gridViewUsersRecordList;
                if (textController!.text == '') {
                  _found = _all;
                }

                _found = _found
                  ..where((product) => product.sellPricePerUnit != null)
                      .toList();

                _found.sort((product1, product2) {
                  int? productRest1 =
                      product1.productRest == null ? 0 : product1.productRest;
                  int? productRest2 =
                      product2.productRest == null ? 0 : product2.productRest;
                  if (productRest1! > productRest2!) {
                    return -1;
                  } else if (productRest1 < productRest2) {
                    return 1;
                  } else {
                    return 0;
                  }
                });

                return Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Expanded(
                              child: Container(
                                width: 100,
                                height: 160,
                                decoration: BoxDecoration(
                                  color: FlutterFlowTheme.of(context)
                                      .secondaryBackground,
                                ),
                                child: Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      0, 20, 0, 0),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Stack(
                                        alignment: AlignmentDirectional(-1, 0),
                                        children: [
                                          Row(
                                            mainAxisSize: MainAxisSize.max,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                'Каталог',
                                                style:
                                                    FlutterFlowTheme.of(context)
                                                        .bodyText1
                                                        .override(
                                                          fontFamily: 'Inter',
                                                          fontSize: 20,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                              ),
                                            ],
                                          ),
                                          Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    16, 0, 0, 0),
                                            child: FlutterFlowIconButton(
                                              borderColor: Colors.transparent,
                                              borderRadius: 30,
                                              borderWidth: 1,
                                              buttonSize: 40,
                                              icon: FaIcon(
                                                FontAwesomeIcons.angleLeft,
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .primaryText,
                                                size: 20,
                                              ),
                                              onPressed: () async {
                                                Navigator.pop(context);
                                              },
                                            ),
                                          ),
                                        ],
                                      ),
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            16, 10, 16, 0),
                                        child: TextFormField(
                                          controller: textController,
                                          autofocus: true,
                                          obscureText: false,
                                          onChanged: (_) =>
                                              EasyDebounce.debounce(
                                            'textController',
                                            Duration(milliseconds: 1000),
                                            () => setState(() {
                                              _runFilter(textController!.text);
                                              ;
                                            }),
                                          ),
                                          decoration: InputDecoration(
                                            hintText: 'Поиск',
                                            hintStyle:
                                                FlutterFlowTheme.of(context)
                                                    .bodyText2
                                                    .override(
                                                      fontFamily: 'Inter',
                                                      fontSize: 15,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
                                            enabledBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                color: Color(0x00000000),
                                                width: 1,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                            ),
                                            focusedBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                color: Color(0x00000000),
                                                width: 1,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                            ),
                                            errorBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                color: Color(0x00000000),
                                                width: 1,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                            ),
                                            focusedErrorBorder:
                                                UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                color: Color(0x00000000),
                                                width: 1,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                            ),
                                            filled: true,
                                            fillColor: Color(0xFFE9E9E9),
                                            prefixIcon: Icon(
                                              Icons.search,
                                              size: 20,
                                            ),
                                          ),
                                          style: FlutterFlowTheme.of(context)
                                              .bodyText1
                                              .override(
                                                fontFamily: 'Inter',
                                                fontSize: 15,
                                                fontWeight: FontWeight.w500,
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
                    Expanded(
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Expanded(
                            child: Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(0, 16, 0, 0),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Visibility(
                                    visible: _found.length == 0 &&
                                        snapshot.connectionState !=
                                            ConnectionState.waiting,
                                    child: SizedBox(
                                      width: MediaQuery.of(context).size.width,
                                      height:
                                          MediaQuery.of(context).size.height,
                                      child: Text('Товар не найден'),
                                    ),
                                  ),
                                  if (_found.length != 0 &&
                                      snapshot.connectionState !=
                                          ConnectionState.waiting)
                                    Expanded(
                                      child: Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            16, 0, 16, 16),
                                        child: GridView.builder(
                                          padding: EdgeInsets.zero,
                                          gridDelegate:
                                              SliverGridDelegateWithFixedCrossAxisCount(
                                            crossAxisCount: 2,
                                            crossAxisSpacing: 9,
                                            mainAxisSpacing: 0,
                                            childAspectRatio: 0.53,
                                          ),
                                          shrinkWrap: true,
                                          scrollDirection: Axis.vertical,
                                          itemCount: _found.length,
                                          itemBuilder:
                                              (context, gridViewIndex) {
                                            Product product =
                                                _found[gridViewIndex];

                                            if (product.sellPricePerUnit ==
                                                null) {
                                              Container();
                                            }

                                            return Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(0, 0, 0, 9),
                                              child: Container(
                                                width: 100,
                                                height: 100,
                                                decoration: BoxDecoration(
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .secondaryBackground,
                                                  boxShadow: [
                                                    BoxShadow(
                                                      blurRadius: 4,
                                                      color: Color(0x3F000000),
                                                      offset: Offset(0, 4),
                                                    )
                                                  ],
                                                ),
                                                child: Stack(
                                                  alignment:
                                                      AlignmentDirectional(
                                                          0, -1),
                                                  children: [
                                                    Padding(
                                                      padding:
                                                          EdgeInsetsDirectional
                                                              .fromSTEB(
                                                                  8, 6, 8, 0),
                                                      child: Row(
                                                        mainAxisSize:
                                                            MainAxisSize.max,
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          // Row(
                                                          //   mainAxisSize:
                                                          //       MainAxisSize.max,
                                                          //   children: [
                                                          //     if (product.image ==
                                                          //         null)
                                                          //       Image.asset(
                                                          //         'assets/images/2EB60678-184F-4B20-B747-4E74D37068B9_3.png',
                                                          //         width: 16,
                                                          //         height: 15,
                                                          //         fit: BoxFit
                                                          //             .cover,
                                                          //       ),
                                                          //     Padding(
                                                          //       padding:
                                                          //           EdgeInsetsDirectional
                                                          //               .fromSTEB(
                                                          //                   3,
                                                          //                   0,
                                                          //                   0,
                                                          //                   0),
                                                          //       child: Text(
                                                          //         '5',
                                                          //         style: FlutterFlowTheme.of(
                                                          //                 context)
                                                          //             .bodyText1
                                                          //             .override(
                                                          //               fontFamily:
                                                          //                   'Inter',
                                                          //               fontSize:
                                                          //                   8,
                                                          //               fontWeight:
                                                          //                   FontWeight
                                                          //                       .normal,
                                                          //             ),
                                                          //       ),
                                                          //     ),
                                                          //   ],
                                                          // ),
                                                          // ToggleIcon(
                                                          //   onPressed: () async {
                                                          //     setState(
                                                          //       () => FFAppState()
                                                          //               .favoriteProduct
                                                          //               .contains(
                                                          //                   product
                                                          //                       .name)
                                                          //           ? FFAppState()
                                                          //               .favoriteProduct
                                                          //               .remove(product
                                                          //                   .name)
                                                          //           : FFAppState()
                                                          //               .favoriteProduct
                                                          //               .add(product
                                                          //                   .name!),
                                                          //     );
                                                          //   },
                                                          //   value: FFAppState()
                                                          //       .favoriteProduct
                                                          //       .contains(
                                                          //           product.name),
                                                          //   onIcon: Icon(
                                                          //     Icons.favorite,
                                                          //     color: Colors.black,
                                                          //     size: 20,
                                                          //   ),
                                                          //   offIcon: Icon(
                                                          //     Icons
                                                          //         .favorite_border,
                                                          //     color: Colors.black,
                                                          //     size: 20,
                                                          //   ),
                                                          // ),
                                                        ],
                                                      ),
                                                    ),
                                                    Column(
                                                      mainAxisSize:
                                                          MainAxisSize.max,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceAround,
                                                      children: [
                                                        Column(
                                                          mainAxisSize:
                                                              MainAxisSize.max,
                                                          children: [
                                                            if (product.image ==
                                                                null)
                                                              Image.asset(
                                                                'assets/images/no-pictures.png',
                                                                width: 60,
                                                                height: 140,
                                                                fit: BoxFit
                                                                    .contain,
                                                              ),
                                                            if (product.image !=
                                                                null)
                                                              Image.network(
                                                                product.image!,
                                                                width: 60,
                                                                height: 140,
                                                                fit: BoxFit
                                                                    .contain,
                                                              ),
                                                            Padding(
                                                              padding:
                                                                  EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          10,
                                                                          10,
                                                                          10,
                                                                          0),
                                                              child: Row(
                                                                mainAxisSize:
                                                                    MainAxisSize
                                                                        .max,
                                                                children: [
                                                                  Expanded(
                                                                    child: Text(
                                                                      product
                                                                          .name!,
                                                                      textAlign:
                                                                          TextAlign
                                                                              .center,
                                                                      style: FlutterFlowTheme.of(
                                                                              context)
                                                                          .bodyText1
                                                                          .override(
                                                                            fontFamily:
                                                                                'Inter',
                                                                            fontSize:
                                                                                12,
                                                                            color:
                                                                                FlutterFlowTheme.of(context).primaryText,
                                                                          ),
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                        // Padding(
                                                        //   padding:
                                                        //       EdgeInsetsDirectional
                                                        //           .fromSTEB(16, 0,
                                                        //               16, 0),
                                                        //   child: Row(
                                                        //     mainAxisSize:
                                                        //         MainAxisSize.max,
                                                        //     mainAxisAlignment:
                                                        //         MainAxisAlignment
                                                        //             .center,
                                                        //     children: [
                                                        //       Expanded(
                                                        //         child: Text(
                                                        //           'Вино красное полусухое, Италия, 0.75 л.',
                                                        //           textAlign:
                                                        //               TextAlign
                                                        //                   .center,
                                                        //           style: FlutterFlowTheme.of(
                                                        //                   context)
                                                        //               .bodyText2,
                                                        //         ),
                                                        //       ),
                                                        //     ],
                                                        //   ),
                                                        // ),
                                                        Column(
                                                          mainAxisSize:
                                                              MainAxisSize.max,
                                                          children: [
                                                            Padding(
                                                              padding:
                                                                  EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          0,
                                                                          0,
                                                                          0,
                                                                          10),
                                                              child: Text(
                                                                product.sellPricePerUnit ==
                                                                        null
                                                                    ? '?'
                                                                    : product
                                                                            .sellPricePerUnit! +
                                                                        ' ₽',
                                                                style: FlutterFlowTheme.of(
                                                                        context)
                                                                    .subtitle2
                                                                    .override(
                                                                      fontFamily:
                                                                          'Inter',
                                                                      color: FlutterFlowTheme.of(
                                                                              context)
                                                                          .primaryText,
                                                                      fontSize:
                                                                          14,
                                                                    ),
                                                              ),
                                                            ),
                                                            StreamBuilder<
                                                                List<
                                                                    CartRecord>>(
                                                              stream:
                                                                  queryCartRecord(
                                                                parent:
                                                                    currentUserReference,
                                                                queryBuilder: (cartRecord) =>
                                                                    cartRecord.where(
                                                                        'name',
                                                                        isEqualTo:
                                                                            product.name),
                                                                singleRecord:
                                                                    true,
                                                              ),
                                                              builder: (context,
                                                                  snapshot) {
                                                                // Customize what your widget looks like when it's loading.
                                                                if (!currentUser!
                                                                    .loggedIn) {
                                                                  return FFButtonWidget(
                                                                    onPressed:
                                                                        () async {
                                                                      await Navigator
                                                                          .push(
                                                                        context,
                                                                        MaterialPageRoute(
                                                                          builder: (context) =>
                                                                              ChoiceAgeWidget(),
                                                                        ),
                                                                      );
                                                                    },
                                                                    text:
                                                                        'В корзину',
                                                                    options:
                                                                        FFButtonOptions(
                                                                      width: 90,
                                                                      height:
                                                                          30,
                                                                      color: Color(
                                                                          0xFFFF007A),
                                                                      textStyle: FlutterFlowTheme.of(
                                                                              context)
                                                                          .bodyText2
                                                                          .override(
                                                                            fontFamily:
                                                                                'Inter',
                                                                            color:
                                                                                FlutterFlowTheme.of(context).primaryText,
                                                                          ),
                                                                      borderSide:
                                                                          BorderSide(
                                                                        color: Colors
                                                                            .transparent,
                                                                        width:
                                                                            1,
                                                                      ),
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              8),
                                                                    ),
                                                                  );
                                                                }
                                                                if (!snapshot
                                                                    .hasData) {
                                                                  return Center(
                                                                    child:
                                                                        SizedBox(
                                                                      width: 50,
                                                                      height:
                                                                          50,
                                                                      child:
                                                                          CircularProgressIndicator(
                                                                        color: FlutterFlowTheme.of(context)
                                                                            .primaryColor,
                                                                      ),
                                                                    ),
                                                                  );
                                                                }
                                                                List<CartRecord>
                                                                    columnCartRecordList =
                                                                    snapshot
                                                                        .data!;
                                                                final columnCartRecord =
                                                                    columnCartRecordList
                                                                            .isNotEmpty
                                                                        ? columnCartRecordList
                                                                            .first
                                                                        : null;

                                                                return Column(
                                                                  mainAxisSize:
                                                                      MainAxisSize
                                                                          .max,
                                                                  children: [
                                                                    if (product
                                                                            .productRest ==
                                                                        0)
                                                                      FFButtonWidget(
                                                                        onPressed:
                                                                            () async {},
                                                                        text:
                                                                            'Нет в наличии',
                                                                        options:
                                                                            FFButtonOptions(
                                                                          height:
                                                                              30,
                                                                          color: Color.fromARGB(
                                                                              255,
                                                                              224,
                                                                              224,
                                                                              224),
                                                                          textStyle: FlutterFlowTheme.of(context)
                                                                              .bodyText2
                                                                              .override(
                                                                                fontFamily: 'Inter',
                                                                                color: FlutterFlowTheme.of(context).primaryText,
                                                                              ),
                                                                          borderSide:
                                                                              BorderSide(
                                                                            color:
                                                                                Colors.transparent,
                                                                            width:
                                                                                1,
                                                                          ),
                                                                          borderRadius:
                                                                              BorderRadius.circular(8),
                                                                        ),
                                                                      ),
                                                                    if (columnCartRecord ==
                                                                            null &&
                                                                        product.productRest !=
                                                                            0)
                                                                      FFButtonWidget(
                                                                        onPressed:
                                                                            () async {
                                                                          final cartCreateData =
                                                                              createCartRecordData(
                                                                            productId:
                                                                                product.id,
                                                                            code:
                                                                                product.code,
                                                                            name:
                                                                                product.name,
                                                                            price:
                                                                                int.parse(product.sellPricePerUnit!),
                                                                            image:
                                                                                product.image,
                                                                            count:
                                                                                1,
                                                                          );

                                                                          await CartRecord.createDoc(currentUserReference!)
                                                                              .set(cartCreateData);
                                                                          FFAppState()
                                                                              .addToCart(currentUserReference!);
                                                                        },
                                                                        text:
                                                                            'В корзину',
                                                                        options:
                                                                            FFButtonOptions(
                                                                          width:
                                                                              90,
                                                                          height:
                                                                              30,
                                                                          color:
                                                                              Color(
                                                                                  0xFFFF0011),
                                                                          textStyle: FlutterFlowTheme.of(context)
                                                                              .bodyText2
                                                                              .override(
                                                                                fontFamily: 'Inter',
                                                                                color: FlutterFlowTheme.of(context).primaryText,
                                                                              ),
                                                                          borderSide:
                                                                              BorderSide(
                                                                            color:
                                                                                Colors.transparent,
                                                                            width:
                                                                                1,
                                                                          ),
                                                                          borderRadius:
                                                                              BorderRadius.circular(8),
                                                                        ),
                                                                      ),
                                                                    if (columnCartRecord !=
                                                                            null &&
                                                                        product.productRest !=
                                                                            0)
                                                                      Container(
                                                                        width:
                                                                            70,
                                                                        height:
                                                                            30,
                                                                        decoration:
                                                                            BoxDecoration(
                                                                          color:
                                                                              Color(
                                                                                  0xFFFF000D),
                                                                          borderRadius:
                                                                              BorderRadius.circular(25),
                                                                          shape:
                                                                              BoxShape.rectangle,
                                                                          border:
                                                                              Border.all(
                                                                            color:
                                                                                Colors.white,
                                                                            width:
                                                                                0,
                                                                          ),
                                                                        ),
                                                                        child:
                                                                            FlutterFlowCountController(
                                                                          decrementIconBuilder: (enabled) =>
                                                                              FaIcon(
                                                                            FontAwesomeIcons.minus,
                                                                            color: enabled
                                                                                ? Color(0xDD000000)
                                                                                : Color(0xFFEEEEEE),
                                                                            size:
                                                                                14,
                                                                          ),
                                                                          incrementIconBuilder: (enabled) =>
                                                                              FaIcon(
                                                                            FontAwesomeIcons.plus,
                                                                            color: enabled
                                                                                ? Colors.black
                                                                                : Color(0xFFEEEEEE),
                                                                            size:
                                                                                14,
                                                                          ),
                                                                          countBuilder: (count) =>
                                                                              Text(
                                                                            count.toString(),
                                                                            style:
                                                                                GoogleFonts.getFont(
                                                                              'Roboto',
                                                                              color: Colors.black,
                                                                              fontWeight: FontWeight.w600,
                                                                              fontSize: 12,
                                                                            ),
                                                                          ),
                                                                          minimum:
                                                                              0,
                                                                          maximum:
                                                                              product.productRest,
                                                                          count:
                                                                              columnCartRecord.count!,
                                                                          updateCount:
                                                                              (count) async {
                                                                            setState(() async {
                                                                              if (count == 0) {
                                                                                columnCartRecord..reference.delete();
                                                                              } else {
                                                                                final cartUpdateData = createCartRecordData(
                                                                                  count: count,
                                                                                );
                                                                                await columnCartRecord.reference.update(cartUpdateData);
                                                                              }
                                                                            });
                                                                          },
                                                                          stepSize:
                                                                              1,
                                                                          contentPadding: EdgeInsetsDirectional.fromSTEB(
                                                                              10,
                                                                              0,
                                                                              10,
                                                                              0),
                                                                        ),
                                                                      ),
                                                                  ],
                                                                );
                                                              },
                                                            ),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                                    ),
                                ],
                              ),
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
    );
  }
}
