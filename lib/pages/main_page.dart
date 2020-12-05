import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:progress_dialog/progress_dialog.dart';

import '../blocs/app_navigator/app_navigator_bloc.dart';
import '../models/main_repository.dart';
import '../pages/home_page.dart';
import '../shared/app_defaults.dart';
import '../widgets/common_dialogs.dart';

class MainPage extends StatefulWidget {
  MainPage({Key key, this.title = "MainPage"}) : super(key: key);
  final String title;

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  AppNavigatorPage _currentPage;
  ProgressDialog _progressDialog;

  @override
  void initState() {
    _currentPage = appNavigatorPages.reversed.first;

    BlocProvider.of<AppNavigatorBloc>(context).add(AnonymousSigninEvent());

    /*BlocProvider.of<AppNavigatorBloc>(context).add(WarnUserEvent(
        List<String>()..add("progress_start"),
        message: "in progress.."));*/

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext buildContext) {
    if (_progressDialog == null) {
      _progressDialog = buildProgressDialog(buildContext, '...in progress...',
          isDismissible: true, autoHide: Duration(seconds: 3));
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: MultiBlocListener(
        listeners: [
          BlocListener<AppNavigatorBloc, AppNavigatorState>(
            listener: (context, state) {
              if (state is AppPageState) {
                setState(() {
                  _currentPage = state.tab;
                });
              } else if (state is WarnUserState) {
                // progress dialog
                if (state.actions.contains("progress_start")) {
                  _progressDialog.show();
                } else if (state.actions.contains("progress_stop")) {
                  _progressDialog.hide();
                } else if (state.actions.contains("alert_message")) {
                  String _alertType = "WARNING"; // default
                  if (state.actions.contains("SUCCESS")) {
                    _alertType = "SUCCESS";
                  } else if (state.actions.contains("INFO")) {
                    _alertType = "INFO";
                  } else if (state.actions.contains("ERROR")) {
                    _alertType = "ERROR";
                  }
                  showAlertDialog(buildContext, state.message,
                      type: _alertType, autoHide: state.duration);
                }
              }
            },
          ),
        ],
        child: Center(
          child: _pageContainer(),
        ),
      ),
    );
  }

  Widget _pageContainer() {
    // TODO: revisit and simplify browsing logic, avoid recreating components!!!
    /*Widget _widget;
    if (_currentPage.id == "TRADING") {
      _widget = TradingPage();
    } else {
      _widget = HomePage();
    }*/
    Widget _widget = HomePage();

    return RepositoryProvider(
      create: (context) => MainRepository(),
      child: _widget,
    );
  }
}
