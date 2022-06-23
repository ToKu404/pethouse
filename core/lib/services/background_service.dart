// import 'dart:ui';
// import 'dart:isolate';
// final ReceivePort port = ReceivePort();

// class BackgroundService {
//   static BackgroundService? _backgroundService;
//   static const String _isolateName = 'isolate';
//   static SendPort? _uiSendPort;

//   BackgroundService._instance() {
//     _backgroundService = this;
//   }

//   factory BackgroundService() =>
//       _backgroundService ?? BackgroundService._instance();

//   void initializeIsolate() {
//     IsolateNameServer.registerPortWithName(port.sendPort, _isolateName);
//   }

//   void settingAlarmServer() {

//     _uiSendPort ??= IsolateNameServer.lookupPortByName(_isolateName);
//     _uiSendPort?.send(null);
//   }
// }
