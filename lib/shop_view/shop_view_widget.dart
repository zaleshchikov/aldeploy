import 'dart:async';

import 'package:flutter/scheduler.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';

import '../backend/backend.dart';
import '../components/info_shop_widget.dart';
import '../flutter_flow/flutter_flow_google_map.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:alcoapp_main/yandex_map/yandex_map_widget.dart';
import '../support_files/service.dart';

class ShopViewWidget extends StatefulWidget {
  const ShopViewWidget({Key? key}) : super(key: key);

  @override
  _ShopViewWidgetState createState() => _ShopViewWidgetState();
}

class _ShopViewWidgetState extends State<ShopViewWidget> {
  LatLng? googleMapsCenter;
  final googleMapsController = Completer<GoogleMapController>();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  TabController? tabcontroler;
  LatLng? currentUserLocationValue;
  Timer? timer;

  @override
  void dispose() {
    super.dispose();
    timer!.cancel();
  }

  @override
  void initState() {
    super.initState();
    // getCurrentUserLocation(defaultLocation: LatLng(0.0, 0.0), cached: true)
    //     .then((loc) => setState(() => currentUserLocationValue = loc));
    //
    // SchedulerBinding.instance.addPostFrameCallback((_) async {
    //   timer = Timer.periodic(
    //       Duration(seconds: 15), (Timer t) => notif(context, timer!));
    // });

    //WidgetsBinding.instance.addPostFrameCallback((_) => setState(() {}));
  }

  @override
  Widget build(BuildContext context) {
    return Title(
        title: 'shopView',
        color: FlutterFlowTheme.of(context).primaryColor,
        child: Scaffold(
          key: scaffoldKey,
          resizeToAvoidBottomInset: false,
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
              'Маркет-бары',
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
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Expanded(
                        child: Padding(
                          padding:
                              EdgeInsetsDirectional.fromSTEB(10, 19, 10, 0),
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
                                Text(
                                  'Адреса маркет-баров по близости',
                                  style: FlutterFlowTheme.of(context)
                                      .bodyText1
                                      .override(
                                        fontFamily: 'Inter',
                                        fontSize: 12,
                                      ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(16, 19, 16, 19),
                      child: DefaultTabController(
                        length: 2,
                        initialIndex: 0,
                        child: Column(
                          children: [
                            TabBar(
                              labelColor: Colors.black,
                              unselectedLabelColor: Color(0x3F000000),
                              labelStyle: FlutterFlowTheme.of(context)
                                  .bodyText1
                                  .override(
                                    fontFamily: 'Inter',
                                    fontSize: 14,
                                  ),
                              indicatorColor: Colors.black,
                              tabs: [
                                Tab(
                                  text: 'Карта',
                                ),
                                Tab(
                                  text: 'Список',
                                ),
                              ],
                            ),

                            /*Container(
                              height:
                              MediaQuery.of(context).size.height / 50,
                            ),
                            Expanded(
                              child: TabBarView(
                                children: [Center(
                                  child: Container(
                                      height:
                                          MediaQuery.of(context).size.height / 1.8,
                                      width: MediaQuery.of(context).size.width/1.2,
                                      child: MapScreen(
                                        [PlacemarkMapObject(
                                          mapId: MapObjectId('MapObject'),
                                          point: Point(latitude: 55, longitude: 37),
                                          opacity: 1,

                                        ),]
                                      )),
                                ),
                                  Center(
                                    child: Container(
                                        height:
                                        MediaQuery.of(context).size.height / 1.8,
                                        width: MediaQuery.of(context).size.width/1.2,
                                        child: MapScreen(
                                          []
                                        )),
                                  ),
                   ]
                              ),
                            )*/
                            Expanded(
                              child: TabBarView(
                                physics: NeverScrollableScrollPhysics(),
                                children: [
                                  StreamBuilder<List<ShopsRecord>>(
                                    stream: queryShopsRecord(),
                                    builder: (context, snapshot) {
                                      // Customize what your widget looks like when it's loading.
                                      if (!snapshot.hasData) {
                                        return Center(
                                          child: SizedBox(
                                            width: 50,
                                            height: 50,
                                            child: CircularProgressIndicator(
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .primaryColor,
                                            ),
                                          ),
                                        );
                                      }
                                      List<ShopsRecord>
                                          googleMapShopsRecordList =
                                          snapshot.data!;
                                      return MapScreen(
                                        snapshot.data,
                                          55.066545,
                                          82.936869
                                      );
                                        //MapScreen(
                                          // PlacemarkMapObject(
                                          //   mapId: MapObjectId('MapObject'),
                                          //   point: Point(latitude: 55.755864, longitude: 37.617698),
                                          //   opacity: 1,
                                          //   onTap: (_, __) => print(1)
                                          // ),
                                        //MapPoint(name: 'Москва', latitude: 55.755864, longitude: 37.617698),
                                      //);
                                      // return FlutterFlowGoogleMap(
                                      //   controller: googleMapsController,
                                      //   onCameraIdle: (latLng) =>
                                      //       googleMapsCenter = latLng,
                                      //   initialLocation: googleMapsCenter ??=
                                      //       LatLng(55.066545, 82.936869),
                                      //   markers: googleMapShopsRecordList
                                      //       .map(
                                      //         (googleMapShopsRecord) =>
                                      //             FlutterFlowMarker(
                                      //           googleMapShopsRecord
                                      //               .reference.path,
                                      //           googleMapShopsRecord.locaion!,
                                      //           () async {
                                      //             await showModalBottomSheet(
                                      //               isScrollControlled: true,
                                      //               backgroundColor:
                                      //                   Colors.transparent,
                                      //               context: context,
                                      //               builder: (context) {
                                      //                 return Padding(
                                      //                   padding: MediaQuery.of(
                                      //                           context)
                                      //                       .viewInsets,
                                      //                   child: InfoShopWidget(
                                      //                     shop:
                                      //                         googleMapShopsRecord,
                                      //                   ),
                                      //                 );
                                      //               },
                                      //             );
                                      //           },
                                      //         ),
                                      //       )
                                      //       .toList(),
                                      //   markerColor: GoogleMarkerColor.red,
                                      //   mapType: MapType.normal,
                                      //   style: GoogleMapStyle.standard,
                                      //   initialZoom: 14,
                                      //   allowInteraction: true,
                                      //   allowZoom: true,
                                      //   showZoomControls: true,
                                      //   showLocation: true,
                                      //   showCompass: false,
                                      //   showMapToolbar: false,
                                      //   showTraffic: false,
                                      //   centerMapOnMarkerTap: true,
                                      // );
                                    },
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 12),
                                    child: StreamBuilder<List<ShopsRecord>>(
                                      stream: queryShopsRecord(),
                                      builder: (context, snapshot) {
                                        // Customize what your widget looks like when it's loading.
                                        if (!snapshot.hasData) {
                                          return Center(
                                            child: SizedBox(
                                              width: 50,
                                              height: 50,
                                              child: CircularProgressIndicator(
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .primaryColor,
                                              ),
                                            ),
                                          );
                                        }
                                        List<ShopsRecord>
                                            listViewShopsRecordList =
                                            snapshot.data!;
                                        return ListView.builder(
                                          padding: EdgeInsets.zero,
                                          shrinkWrap: true,
                                          scrollDirection: Axis.vertical,
                                          itemCount:
                                              listViewShopsRecordList.length,
                                          itemBuilder:
                                              (context, listViewIndex) {
                                            final listViewShopsRecord =
                                                listViewShopsRecordList[
                                                    listViewIndex];
                                            return Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(16, 0, 16, 12),
                                              child: InkWell(
                                                onTap: () async {
                                                  await showModalBottomSheet(
                                                    isScrollControlled: true,
                                                    backgroundColor:
                                                        Colors.transparent,
                                                    context: context,
                                                    builder: (context) {
                                                      return Padding(
                                                        padding: MediaQuery.of(
                                                                context)
                                                            .viewInsets,
                                                        child: InfoShopWidget(
                                                          shop:
                                                              listViewShopsRecord,
                                                        ),
                                                      );
                                                    },
                                                  );
                                                },
                                                child: Container(
                                                  width: 100,
                                                  height: 60,
                                                  decoration: BoxDecoration(
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .secondaryBackground,
                                                    boxShadow: [
                                                      BoxShadow(
                                                        blurRadius: 4,
                                                        color:
                                                            Color(0x40000000),
                                                        offset: Offset(0, 4),
                                                      )
                                                    ],
                                                  ),
                                                  child: Row(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            EdgeInsetsDirectional
                                                                .fromSTEB(22, 0,
                                                                    16, 0),
                                                        child: FaIcon(
                                                          FontAwesomeIcons
                                                              .mapMarkerAlt,
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
                                                        mainAxisSize:
                                                            MainAxisSize.max,
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Padding(
                                                            padding:
                                                                EdgeInsetsDirectional
                                                                    .fromSTEB(
                                                                        0,
                                                                        4,
                                                                        0,
                                                                        0),
                                                            child: Text(
                                                              listViewShopsRecord
                                                                  .shopName!,
                                                              style: FlutterFlowTheme
                                                                      .of(context)
                                                                  .bodyText1
                                                                  .override(
                                                                    fontFamily:
                                                                        'Inter',
                                                                    fontSize:
                                                                        12,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500,
                                                                  ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            );
                                          },
                                        );
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
