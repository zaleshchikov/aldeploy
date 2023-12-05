import 'package:alcoapp_main/backend/backend.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../auth/auth_util.dart';
import '../backend/schema/users_record.dart';
import '../flutter_flow/flutter_flow_icon_button.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import '../main.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../support_files/service.dart';

class AuthCodeWidget extends StatefulWidget {
  const AuthCodeWidget({
    Key? key,
    this.phone,
    this.verifyID,
  }) : super(key: key);

  final String? phone;
  final String? verifyID;

  @override
  _AuthCodeWidgetState createState() => _AuthCodeWidgetState();
}

class _AuthCodeWidgetState extends State<AuthCodeWidget> {
  TextEditingController? textFieldPhoneController;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  bool? progress = false;

  @override
  void initState() {
    super.initState();
    textFieldPhoneController = TextEditingController();
    WidgetsBinding.instance.addPostFrameCallback((_) => setState(() {}));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        elevation: 0,
        toolbarHeight: 40,
        leading: FlutterFlowIconButton(
          borderColor: Colors.transparent,
          borderRadius: 30,
          borderWidth: 1,
          buttonSize: 60,
          icon: Icon(
            Icons.arrow_back_rounded,
            color: Colors.black,
            size: 30,
          ),
          onPressed: () async {
            Navigator.pop(context);
          },
        ),
      ),
      backgroundColor: FlutterFlowTheme.of(context).secondaryBackground,
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
              flex: 2,
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Expanded(
                    flex: 1,
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0, 160, 0, 0),
                          child: Image.asset(
                            'assets/images/logo1.png',
                            width: 180,
                            height: 180,
                            fit: BoxFit.contain,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 30),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/images/logo_name.png',
                          width: 235,
                          height: 45,
                          fit: BoxFit.cover,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 2,
              child: Container(
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: FlutterFlowTheme.of(context).secondaryBackground,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(0),
                    bottomRight: Radius.circular(0),
                    topLeft: Radius.circular(8),
                    topRight: Radius.circular(8),
                  ),
                  border: Border.all(
                    color: FlutterFlowTheme.of(context).primaryText,
                    width: 1,
                  ),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(0, 14, 0, 0),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: 40,
                            height: 4,
                            decoration: BoxDecoration(
                              color: Colors.black,
                              borderRadius: BorderRadius.circular(100),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(29, 0, 29, 0),
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Column(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Введите последние 4 цифры номера',
                                      style: FlutterFlowTheme.of(context)
                                          .bodyText1
                                          .override(
                                            fontFamily: 'Inter',
                                            fontSize: 20,
                                            fontWeight: FontWeight.w900,
                                          ),
                                    ),
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          0, 6, 0, 0),
                                      child: Text(
                                        'На этот номер телефона +7${widget.phone} вам поступит звонок',
                                        style: FlutterFlowTheme.of(context)
                                            .bodyText1
                                            .override(
                                              fontFamily: 'Inter',
                                              color: Color(0xFFB1C1DA),
                                              fontSize: 10,
                                              fontWeight: FontWeight.normal,
                                            ),
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Expanded(
                                      child: TextFormField(
                                        controller: textFieldPhoneController,
                                        autofocus: true,
                                        obscureText: false,
                                        decoration: InputDecoration(
                                          hintText: '1234',
                                          hintStyle:
                                              FlutterFlowTheme.of(context)
                                                  .bodyText2
                                                  .override(
                                                    fontFamily: 'Inter',
                                                    color: Color(0xFFB1C1DA),
                                                    fontSize: 20,
                                                    fontWeight: FontWeight.w900,
                                                  ),
                                          enabledBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Color(0x00000000),
                                              width: 1,
                                            ),
                                            borderRadius:
                                                const BorderRadius.only(
                                              topLeft: Radius.circular(4.0),
                                              topRight: Radius.circular(4.0),
                                            ),
                                          ),
                                          focusedBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Color(0x00000000),
                                              width: 1,
                                            ),
                                            borderRadius:
                                                const BorderRadius.only(
                                              topLeft: Radius.circular(4.0),
                                              topRight: Radius.circular(4.0),
                                            ),
                                          ),
                                        ),
                                        style: FlutterFlowTheme.of(context)
                                            .bodyText1
                                            .override(
                                              fontFamily: 'Inter',
                                              fontSize: 20,
                                              fontWeight: FontWeight.w900,
                                            ),
                                        keyboardType: TextInputType.phone,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(9, 0, 9, 20),
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Expanded(
                                      child: InkWell(
                                        onTap: () async {
                                          if ('+7' + widget.phone! !=
                                              '+79183325000') {
                                            final smsCodeVal =
                                                textFieldPhoneController!.text;
                                            if (smsCodeVal == null ||
                                                smsCodeVal.isEmpty) {
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(
                                                SnackBar(
                                                  content: Text(
                                                      'Enter SMS verification code.'),
                                                ),
                                              );
                                              return;
                                            }

                                            if (progress == false) {
                                              setState(() {
                                                progress = true;
                                              });

                                              // bool isVerify = await verifyFcall(
                                              //     widget.verifyID!,
                                              //     textFieldPhoneController!
                                              //         .text);

                                              bool isVerify = widget.verifyID ==
                                                  textFieldPhoneController!
                                                      .text;

                                              if (isVerify) {
                                                String token = await getToken(
                                                    '+7' + widget.phone!);
                                                // final user =
                                                //     await signInWithJwtToken(
                                                //         context, token);

                                                final userCredential =
                                                    await FirebaseAuth.instance
                                                        .signInWithCustomToken(
                                                            token);

                                                final user =
                                                    userCredential.user;
                                                await maybeCreateUser(
                                                    userCredential.user!);

                                                if (user == null) {
                                                  setState(() {
                                                    progress = true;
                                                  });
                                                  return;
                                                } else {
                                                  // maybeCreateUser(user);
                                                  print(user);
                                                  await Navigator
                                                      .pushAndRemoveUntil(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) =>
                                                          NavBarPage(
                                                              initialPage:
                                                                  'shopView'),
                                                    ),
                                                    (r) => false,
                                                  );
                                                }
                                              } else {
                                                setState(() {
                                                  progress = false;
                                                });
                                                print("Что-то не так");
                                              }
                                            }

                                            // int phone =
                                            //     int.parse('7' + widget.phone!);

                                            // int phone =
                                            //     int.parse('7' + widget.phone!);
                                            // String serialNumber =
                                            //     await createCard(phone);
                                            // final user = await maybeCreateUser(
                                            //     phoneVerifiedUser);
                                            // print(serialNumber);
                                            // final usersUpdateData =
                                            //     createUsersRecordData(
                                            //   serialNumber: serialNumber,
                                            // );
                                            // await user!.reference
                                            //     .update(usersUpdateData);
                                          } else {
                                            final smsCodeVal =
                                                textFieldPhoneController!.text;
                                            final phoneVerifiedUser =
                                                await verifySmsCode(
                                              context: context,
                                              smsCode: smsCodeVal,
                                            );
                                            if (phoneVerifiedUser == null) {
                                              return;
                                            }

                                            await Navigator.pushAndRemoveUntil(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    NavBarPage(
                                                        initialPage: 'Catalog'),
                                              ),
                                              (r) => false,
                                            );
                                          }
                                        },
                                        child: Container(
                                          width: 100,
                                          height: 48,
                                          decoration: BoxDecoration(
                                            color: Color(0xFFFF0011),
                                            borderRadius:
                                                BorderRadius.circular(12),
                                          ),
                                          alignment: AlignmentDirectional(0, 0),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              if (progress == true)
                                                Center(
                                                  child: SizedBox(
                                                    width: 30,
                                                    height: 30,
                                                    child:
                                                        CircularProgressIndicator(
                                                      color: Colors.black,
                                                    ),
                                                  ),
                                                ),
                                              if (progress == false)
                                                Text(
                                                  'Далее',
                                                  style: FlutterFlowTheme.of(
                                                          context)
                                                      .bodyText1
                                                      .override(
                                                        fontFamily: 'Inter',
                                                        fontSize: 12,
                                                        fontWeight:
                                                            FontWeight.w900,
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
    );
  }
}
