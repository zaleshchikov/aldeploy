import '../flutter_flow/flutter_flow_icon_button.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ConditionLoyaltyWidget extends StatefulWidget {
  const ConditionLoyaltyWidget({Key? key}) : super(key: key);

  @override
  _ConditionLoyaltyWidgetState createState() => _ConditionLoyaltyWidgetState();
}

class _ConditionLoyaltyWidgetState extends State<ConditionLoyaltyWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) => setState(() {}));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
      appBar: AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        leading: FlutterFlowIconButton(
          borderColor: Colors.transparent,
          borderRadius: 30,
          borderWidth: 1,
          buttonSize: 60,
          icon: Icon(
            Icons.arrow_back_rounded,
            color: FlutterFlowTheme.of(context).primaryText,
            size: 30,
          ),
          onPressed: () async {
            Navigator.pop(context);
          },
        ),
        title: Text(
          'Карта лояльности',
          style: FlutterFlowTheme.of(context).title2.override(
                fontFamily: 'Inter',
                color: FlutterFlowTheme.of(context).primaryText,
                fontSize: 20,
              ),
        ),
        actions: [],
        centerTitle: false,
        elevation: 2,
      ),
      body: SafeArea(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Padding(
            padding: EdgeInsetsDirectional.fromSTEB(12, 12, 12, 0),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Text(
                    'Уважаемые покупатели!\n\nУстановите наше мобильное приложение и внесите  в него ваши данные для получения вашей дисконтной карты. \n\nБольше не нужно носить пластиковую дисконтную карту с собой.\n\nОна всегда будет с вами в вашем мобильном устройстве.\n\nИтак, для того чтобы привязать свою дисконтную карту к номеру телефона, зайдите в мобильное приложение «Ёмкость» в раздел «Дисконтная карта». \n\nДисконтная карта выдается физическому лицу старше 18 лет в любом маркет-баре Ёмкость.\n\nПластиковая дисконтная карта\n  •      Вы можете привязать пластиковую ДК к мобильному устройству в официальном мобильном приложении «Ёмкость». Приложение «Ёмкость» должно быть действующим.\n  •      К одному мобильному устройству и номеру телефона может быть привязана только одна пластиковая ДК;\n  •      К одному мобильному устройству и номеру телефона может быть привязана только одна виртуальная ДК;\n  •      Виртуальная ДК изымается, если по ней не совершаются покупки в течение 30 дней с момента её получения. Если в течение этого времени была совершена покупка, то карта остаётся.\n\nК сканированию не принимаются различные копии (фотографии, скриншоты и т.п.) штрих-кода (QR-кода) карты.\nКарта будет активна в течении 3х дней после ее регистрации.',
                    style: FlutterFlowTheme.of(context).bodyText1.override(
                          fontFamily: 'Inter',
                          fontSize: 14,
                          fontWeight: FontWeight.normal,
                        ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
