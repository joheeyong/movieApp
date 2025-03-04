import 'dart:convert';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

functionJsonDecode(http.Response result, context) async {
  if (result.statusCode == 200) {
    return jsonDecode(utf8.decode(result.bodyBytes));
  } else {
    connectivityCheck(context);

    return null;
  }
}

connectivityCheck(context) async {
  final List<ConnectivityResult> connectivityResult = await Connectivity().checkConnectivity();
  if (!connectivityResult.contains(ConnectivityResult.mobile) && !connectivityResult.contains(ConnectivityResult.wifi)) {
    showToast("가져오지 못한 데이터가 있습니다\n네트워크 연결을 확인해주세요", context);
  } else {
    showToast("가져오지 못한 데이터가 있습니다\n잠시후 다시시도해주세요", context);
  }
}

showToast(String str, context) {
  late FToast fToast;
  fToast = FToast();
  fToast.init(context);

  Widget toast = Container(
    padding: const EdgeInsets.fromLTRB(10, 8, 10, 10),
    decoration: BoxDecoration(borderRadius: BorderRadius.circular(6.0), color: const Color.fromRGBO(51, 51, 51, 1), boxShadow: const [
      BoxShadow(
        offset: Offset(2, 2),
        blurRadius: 4,
        color: Color.fromRGBO(0, 0, 0, 0.25),
      )
    ]),
    child: SizedBox(
        width: double.infinity,
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(flex: 6, child: Text(str, textAlign: TextAlign.start, maxLines: 5, style: TextStyle(fontSize: 14, height: 1.5, overflow: TextOverflow.ellipsis, color: Colors.white, fontStyle: FontStyle.normal))),
            Expanded(
                flex: 1,
                child: Container(
                  margin: const EdgeInsets.only(left: 13),
                  child: GestureDetector(
                    onTap: () {
                      fToast.removeCustomToast();
                    },
                    child: const Text("재시도", textAlign: TextAlign.end, style: TextStyle(fontSize: 14, overflow: TextOverflow.ellipsis, color: Color.fromRGBO(0, 179, 54, 1), fontStyle: FontStyle.normal)),
                  ),
                ))
          ],
        )),
  );

  fToast.showToast(
      child: toast,
      toastDuration: const Duration(seconds: 10),
      positionedToastBuilder: (BuildContext context, Widget child, ToastGravity? gravity) {
        return SafeArea(
            child: Stack(
          children: [
            Positioned(
              right: 10,
              left: 10,
              bottom: 65,
              child: child,
            ),
          ],
        ));
      });
}
