import 'dart:async';
import 'package:yandex_mapkit/yandex_mapkit.dart';

import 'package:alcoapp_main/support_files/service.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:firebase_core/firebase_core.dart';
import 'auth/firebase_user_provider.dart';
import 'auth/auth_util.dart';

import 'backend/backend.dart';
import 'flutter_flow/flutter_flow_theme.dart';
import 'flutter_flow/flutter_flow_util.dart';
import 'flutter_flow/internationalization.dart';
import 'package:google_fonts/google_fonts.dart';
import 'index.dart';

import 'package:flutter/material.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';


class MapScreen extends StatefulWidget {


  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  late final YandexMapController _mapController;


  @override
  void dispose() {
    _mapController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
          appBar: AppBar(title: const Text('Yandex Mapkit Demo')),
          body: YandexMap(
            onMapCreated: (controller) async {
              _mapController = controller;
              await _mapController.moveCamera(
                CameraUpdate.newCameraPosition(
                  const CameraPosition(
                    target: Point(
                      latitude: 50,
                      longitude: 20,
                    ),
                    zoom: 3,
                  ),
                ),
              );
            },
          ),
        ));
  }
}




void main() async {
   WidgetsFlutterBinding.ensureInitialized();
   await Firebase.initializeApp();
   await FlutterFlowTheme.initialize();

   FFAppState(); // Initialize FFAppState
   runApp(MyApp());

  AndroidYandexMap.useAndroidViewSurface = false;

}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  State<MyApp> createState() => _MyAppState();

  static _MyAppState of(BuildContext context) =>
      context.findAncestorStateOfType<_MyAppState>()!;
}

class _MyAppState extends State<MyApp> {
  Locale? _locale;
  ThemeMode _themeMode = ThemeMode.light;

  late Stream<AlcoappMainFirebaseUser> userStream;
  AlcoappMainFirebaseUser? initialUser;
  bool displaySplashImage = true;

  final authUserSub = authenticatedUserStream.listen((_) {});

  @override
  void initState() {
    super.initState();

    userStream = alcoappMainFirebaseUserStream()
      ..listen((user) => initialUser ?? setState(() => initialUser = user));
    Future.delayed(
      Duration(seconds: 1),
      () => setState(() => displaySplashImage = false),
    );
  }

  @override
  void dispose() {
    authUserSub.cancel();

    super.dispose();
  }

  void setLocale(String language) =>
      setState(() => _locale = createLocale(language));
  void setThemeMode(ThemeMode mode) => setState(() {
        _themeMode = ThemeMode.light;
        FlutterFlowTheme.saveThemeMode(_themeMode);
      });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ёмкость',
      localizationsDelegates: [
        FFLocalizationsDelegate(),
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      locale: _locale,
      supportedLocales: const [Locale('en', '')],
      theme: ThemeData(brightness: Brightness.light),
      darkTheme: ThemeData(brightness: Brightness.dark),
      themeMode: _themeMode,
      home: initialUser == null || displaySplashImage
          ? Container(
              color: Colors.transparent,
              child: Builder(
                builder: (context) => Image.asset(
                  'assets/images/splash_screen.jpg',
                  fit: BoxFit.cover,
                ),
              ),
            )
          : currentUser!.loggedIn
              ? NavBarPage()
              : NavBarPage(),
    );
  }
}

class NavBarPage extends StatefulWidget {
  NavBarPage({Key? key, this.initialPage}) : super(key: key);

  final String? initialPage;

  @override
  _NavBarPageState createState() => _NavBarPageState();
}

/// This is the private State class that goes with NavBarPage.
class _NavBarPageState extends State<NavBarPage> {
  String _currentPage = 'Profile';

  @override
  void initState() {
    super.initState();
    _currentPage = widget.initialPage ?? _currentPage;
  }

  @override
  Widget build(BuildContext context) {
    final tabs = {
      'shopView': ShopViewWidget(),
      //'Catalog': CatalogWidget(),
      //'Cart': CartWidget(),
      'Profile': ProfileWidget(),
    };
    final currentIndex = tabs.keys.toList().indexOf(_currentPage);
    return Scaffold(
      body: tabs[_currentPage],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (i) => setState(() => _currentPage = tabs.keys.toList()[i]),
        backgroundColor: FlutterFlowTheme.of(context).primaryBtnText,
        selectedItemColor: FlutterFlowTheme.of(context).primaryText,
        unselectedItemColor: Color(0xFFCCCCCC),
        showSelectedLabels: true,
        showUnselectedLabels: true,
        type: BottomNavigationBarType.fixed,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(
              Icons.location_pin,
              size: 24,
            ),
            label: 'Маркет-бары',
            tooltip: '',
          ),
          /*BottomNavigationBarItem(
            icon: Icon(
              Icons.menu_rounded,
              size: 24,
            ),
            label: 'Каталог',
            tooltip: '',
          ),*/
          /*BottomNavigationBarItem(
            icon: new Stack(
              children: <Widget>[
                new Icon(
                  Icons.shopping_cart_rounded,
                  size: 24,
                ),
                new Positioned(
                  // draw a red marble
                  top: 0.0,
                  right: 0.0,
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
                                color:
                                    FlutterFlowTheme.of(context).primaryColor,
                              ),
                            ),
                          );
                        }
                        List<CartRecord> listViewCartRecordList =
                            snapshot.data!;

                        if (listViewCartRecordList.length == 0) {
                          return Container();
                        }
                        return new Container(
                          width: 12,
                          height: 12,
                          child: Text(
                            listViewCartRecordList.length.toString(),
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 8,
                            ),
                          ),
                          alignment: AlignmentDirectional(0, 0),
                          decoration: BoxDecoration(
                            color: Colors.redAccent,
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(30),
                              bottomRight: Radius.circular(30),
                              topLeft: Radius.circular(30),
                              topRight: Radius.circular(30),
                            ),
                          ),
                        );
                      }),
                )
              ],
            ),
            // Icon(
            //   Icons.shopping_cart_rounded,
            //   size: 24,
            // ),
            label: 'Корзина',
            tooltip: '',
          ),*/
          BottomNavigationBarItem(
            icon: Icon(
              Icons.person,
              size: 24,
            ),
            label: 'Профиль',
            tooltip: '',
          )
        ],
      ),
    );
  }
}
