import '../auth/auth_util.dart';
import '../backend/backend.dart';
import '../flutter_flow/flutter_flow_google_map.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import '../flutter_flow/flutter_flow_widgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import '../support_files/service.dart';
import 'package:alcoapp_main/yandex_map/yandex_map_widget.dart';

class InfoShopWidget extends StatefulWidget {
  const InfoShopWidget({
    Key? key,
    this.shop,
  }) : super(key: key);

  final ShopsRecord? shop;

  @override
  _InfoShopWidgetState createState() => _InfoShopWidgetState();
}

class _InfoShopWidgetState extends State<InfoShopWidget> {
  LatLng? googleMapsCenter;
  final googleMapsController = Completer<GoogleMapController>();

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) => setState(() {}));
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            Expanded(
              child: Container(
                width: 100,
                height: MediaQuery.of(context).size.height * 0.5,
                decoration: BoxDecoration(
                  color: FlutterFlowTheme.of(context).secondaryBackground,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(0),
                    bottomRight: Radius.circular(0),
                    topLeft: Radius.circular(12),
                    topRight: Radius.circular(12),
                  ),
                ),
                child: Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(16, 16, 16, 16),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Text(
                            widget.shop!.shopName!,
                            style:
                                FlutterFlowTheme.of(context).bodyText1.override(
                                      fontFamily: 'Inter',
                                      fontSize: 16,
                                    ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 8, 0, 0),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: (cachedUserLocation == null)
                              ? MainAxisAlignment.end
                              : MainAxisAlignment.spaceBetween,
                          children: [
                            if (cachedUserLocation != null)
                              Text(
                                '${calculateDistance(cachedUserLocation!.latitude, cachedUserLocation!.longitude, widget.shop!.locaion!.latitude, widget.shop!.locaion!.longitude)} км от вас',
                                style: FlutterFlowTheme.of(context)
                                    .bodyText1
                                    .override(
                                      fontFamily: 'Inter',
                                      color: FlutterFlowTheme.of(context)
                                          .secondaryText,
                                      fontSize: 12,
                                    ),
                              ),
                            FFButtonWidget(
                              onPressed: () async {
                                openMap(widget.shop!);
                              },
                              text: 'Маршрут',
                              icon: FaIcon(
                                FontAwesomeIcons.mapMarkerAlt,
                                color: FlutterFlowTheme.of(context).primaryText,
                                size: 16,
                              ),
                              options: FFButtonOptions(
                                height: 30,
                                color: Color(0xFFFF000D),
                                textStyle: FlutterFlowTheme.of(context)
                                    .bodyText2
                                    .override(
                                      fontFamily: 'Inter',
                                      color: FlutterFlowTheme.of(context)
                                          .primaryText,
                                    ),
                                borderSide: BorderSide(
                                  color: Colors.transparent,
                                  width: 1,
                                ),
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0, 24, 0, 0),
                           child: MapScreen(
                             [widget.shop],
                             widget.shop!.locaion!.latitude,
                             widget.shop!.locaion!.longitude,

                           )
                          // FlutterFlowGoogleMap(
                          //   controller: googleMapsController,
                          //   onCameraIdle: (latLng) => googleMapsCenter = latLng,
                          //   initialLocation: googleMapsCenter ??=
                          //       widget.shop!.locaion!,
                          //   markers: [
                          //     if (widget.shop != null)
                          //       FlutterFlowMarker(
                          //         widget.shop!.reference.path,
                          //         widget.shop!.locaion!,
                          //       ),
                          //   ],
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
                          // ),
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
    );
  }
}
