import 'package:crypto_font_icons/crypto_font_icons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../blocs/app_navigator/app_navigator_bloc.dart';
import '../models/coin.dart';
import '../models/main_repository.dart';
import '../shared/common_utils.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  MainRepository _mainRepository;
  List<Coin> _coins = List();

  @override
  void initState() {
    //BlocProvider.of<AppNavigatorBloc>(context).add(LoadCoinsEvent(limit: "8"));

    /*
    BlocProvider.of<AppNavigatorBloc>(context).add(WarnUserEvent(
        List<String>()..add("progress_start"),
        message: "in progress.."));
    */

    super.initState();
  }

  RefreshController _refreshController =
      RefreshController(initialRefresh: true);

  @override
  Widget build(BuildContext buildContext) {
    if (_mainRepository == null) {
      _mainRepository = RepositoryProvider.of<MainRepository>(context);
      CommonUtils.logger.d("repository isReady: ${_mainRepository != null}");
    }

    return BlocListener<AppNavigatorBloc, AppNavigatorState>(
        listener: (context, state) {
          BlocProvider.of<AppNavigatorBloc>(context)
              .add(WarnUserEvent(List<String>()..add("progress_stop")));
          if (state is CoinsLoaded) {
            setState(() {
              _coins = state.coins;
              _refreshController.refreshCompleted();
            });
          }
        },
        child: Container(
          child: SmartRefresher(
            controller: _refreshController,
            enablePullDown: true,
            header: WaterDropMaterialHeader(),
            onRefresh: () {
              BlocProvider.of<AppNavigatorBloc>(context).add(WarnUserEvent(
                  List<String>()..add("progress_start"),
                  message: "in progress.."));
              BlocProvider.of<AppNavigatorBloc>(context)
                  .add(LoadCoinsEvent(limit: "44"));
            },
            /*onLoading: () {
              BlocProvider.of<AppNavigatorBloc>(context)
                  .add(LoadCoinsEvent(limit: "8"));
            },*/
            child: ListView.builder(
              itemCount: _coins.length,
              physics: ClampingScrollPhysics(),
              itemBuilder: (context, index) {
                final Coin coin = _coins[index];
                if (index == 0) {
                  return Column(
                    children: [
                      ListTile(
                        onTap: null,
                        /*leading: CircleAvatar(
                          backgroundColor: Colors.transparent,
                        ),*/
                        title: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              /*Expanded(
                                  child: Text(
                                "Rank",
                                style:
                                    TextStyle(fontSize: 14, color: Colors.grey),
                              )),*/
                              Expanded(
                                  child: Text(
                                "Name",
                                style:
                                    TextStyle(fontSize: 14, color: Colors.grey),
                              )),
                              Expanded(
                                child: Text(
                                  "Symbol",
                                  style: TextStyle(
                                      fontSize: 14, color: Colors.grey),
                                ),
                              ),
                              Expanded(
                                  child: Text(
                                "Price (US\$)",
                                style:
                                    TextStyle(fontSize: 14, color: Colors.grey),
                              )),
                              Expanded(
                                  child: Text(
                                "Change (7d)",
                                style:
                                    TextStyle(fontSize: 14, color: Colors.grey),
                              )),
                            ]),
                      ),
                      _coinCard(coin)
                    ],
                  );
                }
                return _coinCard(coin);
              },
            ),
          ),
        ));
  }

  _coinCard(Coin coin) {
    return Card(
      elevation: 4.0,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(4.0))),
      margin: EdgeInsets.all(4.0),
      child: ListTile(
          contentPadding: EdgeInsets.all(16.0),
          onTap: null,
          title: Container(
            alignment: Alignment.center,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                /*Expanded(
                  child: Text(
                    "#${coin.rank}",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),*/
                Expanded(
                  child: Text(
                    "${coin.name}",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Expanded(
                  child: Text(
                    "${coin.symbol}",
                    style: TextStyle(fontSize: 18),
                  ),
                ),
                Expanded(
                  child: Text(
                    "\$${coin.priceUsd}",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Expanded(
                  child: Text(
                    "${coin.percentChange7d}%",
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ],
            ),
          )),
    );
  }

  _coinIcon(String symbol) {
    // TODO: map symbol to relevant icons!!!
    return Icon(
      CryptoFontIcons.BTC,
      size: 22,
    );
    /*return Icon(
      MaterialCommunityIcons.bitcoin,
      size: 22,
    );*/
  }
}
