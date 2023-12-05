import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../backend/backend.dart';
import '../components/choice_shop_widget.dart';
import '../flutter_flow/flutter_flow_icon_button.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import '../page_catalog/page_catalog_widget.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../support_files/service.dart';

class SubcategoryPageWidget extends StatefulWidget {
  const SubcategoryPageWidget({Key? key, this.category}) : super(key: key);

  final Category? category;

  @override
  _SubcategoryPageWidgetState createState() => _SubcategoryPageWidgetState();
}

class _SubcategoryPageWidgetState extends State<SubcategoryPageWidget> {
  PageController? pageViewController;
  TextEditingController? textController;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  late Future<List<Category>> futureCategories;
  int colorIndex = 0;

  @override
  void initState() {
    super.initState();

    futureCategories =
        fetchSubCategories(widget.category!.id!, FFAppState().currentShopId);
    textController = TextEditingController();
    print(widget.category!.id);
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
            backgroundColor: Colors.white,
            automaticallyImplyLeading: false,
            leading: Padding(
              padding: EdgeInsetsDirectional.fromSTEB(16, 0, 0, 0),
              child: FlutterFlowIconButton(
                borderColor: Colors.transparent,
                borderRadius: 30,
                borderWidth: 1,
                buttonSize: 40,
                icon: FaIcon(
                  FontAwesomeIcons.angleLeft,
                  color: FlutterFlowTheme.of(context).primaryText,
                  size: 20,
                ),
                onPressed: () async {
                  Navigator.pop(context);
                },
              ),
            ),
            title: Text(
              widget.category!.name!,
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
                              List<Category> categories = snapshot.data!;
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
                                  Color colorButton = Colors.white;
                                  colorIndex += 1;
                                  if (colorIndex > 4) {
                                    colorIndex = 0;
                                  }
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
                                                await Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        PageCatalogWidget(
                                                      categoryId: category.id,
                                                    ),
                                                  ),
                                                );
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
