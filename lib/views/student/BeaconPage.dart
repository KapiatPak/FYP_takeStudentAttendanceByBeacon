import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';

class BeaconPage extends StatefulWidget {
  const BeaconPage({Key? key}) : super(key: key);

  @override
  _BeaconPageState createState() => _BeaconPageState();
}

class _BeaconPageState extends State<BeaconPage> {
  // BluetoothDevice? targetDevice; // 目標設備
  bool canSignIn = false; // 是否可以進行打卡
  bool showLoadingIcon = true; // 是否顯示加載圖標

  @override
  void initState() {
    super.initState();
    _startScan();
  }

  void _startScan() {
    FlutterBluePlus.startScan(timeout: Duration(seconds: 4));
    showLoadingIcon = true;

    FlutterBluePlus.scanResults.listen((results) {
      for (ScanResult r in results) {
        if (_isBeaconDevice(r.device)) {
          print('Found device: ${r.device.advName}, RSSI: ${r.rssi}');
          setState(() {
            canSignIn = true;
            // targetDevice = r.device;
          });
          break;
        } else {
          setState(() {
            canSignIn = false;
          });
        }
      }
    });

    Future.delayed(Duration(seconds: 1), () {
      setState(() {
        showLoadingIcon = false;
      });
    });
  }

  bool _isBeaconDevice(BluetoothDevice device) {
    String targetName = 'MPU_A1';
    if (device.advName == targetName) {
      return true;
    }
    return false;
  }

  void _signIn() {
    // 實現簽到邏輯
    // ...
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('打卡成功'),
          actions: <Widget>[
            TextButton(
              child: Text('確定'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // title: Text('Scan for Devices'),
        automaticallyImplyLeading: false,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              child: Text('Take Attendance'),
              onPressed: canSignIn ? _signIn : null,
            ),
            ElevatedButton(
              child: Text('Refresh'),
              onPressed: _startScan,
            ),
            AnimatedOpacity(
              opacity:
              showLoadingIcon ? 1.0 : 0.0,
              duration: Duration(milliseconds: 500), // 動畫持續時間
              child: CircularProgressIndicator(), // 加載圖標
            ),
          ],
        ),
      ),
    );
  }
}
