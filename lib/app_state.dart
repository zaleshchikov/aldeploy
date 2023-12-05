import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'flutter_flow/flutter_flow_util.dart';
import 'flutter_flow/lat_lng.dart';

class FFAppState {
  static final FFAppState _instance = FFAppState._internal();

  factory FFAppState() {
    return _instance;
  }

  FFAppState._internal() {
    initializePersistedState();
  }

  Future initializePersistedState() async {
    prefs = await SharedPreferences.getInstance();
    _favoriteProduct =
        prefs.getStringList('ff_favoriteProduct') ?? _favoriteProduct;
    _currentShopId = prefs.getString('ff_currentShopId') ?? _currentShopId;
    _currentShopName =
        prefs.getString('ff_currentShopName') ?? _currentShopName;
    _cart = prefs.getStringList('ff_cart')?.map((path) => path.ref).toList() ??
        _cart;
  }

  late SharedPreferences prefs;

  List<String> _favoriteProduct = [];
  List<String> get favoriteProduct => _favoriteProduct;
  set favoriteProduct(List<String> _value) {
    _favoriteProduct = _value;
    prefs.setStringList('ff_favoriteProduct', _value);
  }

  void addToFavoriteProduct(String _value) {
    _favoriteProduct.add(_value);
    prefs.setStringList('ff_favoriteProduct', _favoriteProduct);
  }

  void removeFromFavoriteProduct(String _value) {
    _favoriteProduct.remove(_value);
    prefs.setStringList('ff_favoriteProduct', _favoriteProduct);
  }

  String _currentShopId = '0863e510-e401-423d-b4b5-ac0fab700726';
  String get currentShopId => _currentShopId;
  set currentShopId(String _value) {
    _currentShopId = _value;
    prefs.setString('ff_currentShopId', _value);
  }

  String _currentShopName = 'Б. Хмельницкого, 6';
  String get currentShopName => _currentShopName;
  set currentShopName(String _value) {
    _currentShopName = _value;
    prefs.setString('ff_currentShopName', _value);
  }

  List<DocumentReference> _cart = [];
  List<DocumentReference> get cart => _cart;
  set cart(List<DocumentReference> _value) {
    _cart = _value;
    prefs.setStringList('ff_cart', _value.map((x) => x.path).toList());
  }

  void addToCart(DocumentReference _value) {
    _cart.add(_value);
    prefs.setStringList('ff_cart', _cart.map((x) => x.path).toList());
  }

  void removeFromCart(DocumentReference _value) {
    _cart.remove(_value);
    prefs.setStringList('ff_cart', _cart.map((x) => x.path).toList());
  }
}

LatLng? _latLngFromString(String? val) {
  if (val == null) {
    return null;
  }
  final split = val.split(',');
  final lat = double.parse(split.first);
  final lng = double.parse(split.last);
  return LatLng(lat, lng);
}
