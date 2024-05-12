import 'package:bluetooth_print/bluetooth_print.dart';
import 'package:bluetooth_print/bluetooth_print_model.dart';
import 'package:flutter/material.dart';

class PosPageTemp extends StatefulWidget {
  static const String route = "/pos";

  const PosPageTemp({Key? key}) : super(key: key);

  @override
  State<PosPageTemp> createState() => _PosPageTempState();
}

class _PosPageTempState extends State<PosPageTemp> {
  BluetoothPrint bluetoothPrint = BluetoothPrint.instance;

  bool _connected = false;
  BluetoothDevice _device = BluetoothDevice();
  String tips = 'Không có thiết bị được kết nối';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (_connected)
      tips =
      'Đã kết nối'; // Khi vào trang sẽ check xem đã kết nối trước đó hay chưa
    WidgetsBinding.instance.addPostFrameCallback((_) => initBluetooth());
  }

  Future<void> initBluetooth() async {
    bluetoothPrint.startScan(
        timeout: Duration(seconds: 4)); // scan trong 4s, tìm device

    bool? isConnected = await bluetoothPrint.isConnected;

    bluetoothPrint.state.listen((state) {
      print('cur device status: $state');

      switch (state) {
        case BluetoothPrint.CONNECTED:
          setState(() {
            _connected = true;
            tips = 'Kết nối thành công';
          });
          break;
        case BluetoothPrint.DISCONNECTED:
          setState(() {
            _connected = false;
            tips = 'Ngắt kết nối thành công';
          });
          break;
        default:
          break;
      }
    });

    if (!mounted) return; // nếu chưa kết nối thì không làm gì

    if (isConnected != null && isConnected == true) {
      setState(() {
        _connected = true;
      });
    }
  }

  void _onConnect() async {
    // chỗ này đọc lệnh chắc mọi người cũng hiểu được :v
    try{
      if (_device.address != null) {
        await bluetoothPrint.connect(_device);
      } else {
        setState(() {
          tips = 'Vui lòng chọn thiết bị';
        });
        print('please select device');
      }
    }
    catch(e){
      print(e.toString());
    }

  }

  void _onDisconnect() async {
    await bluetoothPrint.disconnect();
  }

  void _sendData() async {
    Map<String, dynamic> config = Map();
    List<LineText> list = [];
    list.add(LineText(
        type: LineText.TYPE_TEXT,
        content: 'MAY IN EXAMPLE',
        weight: 1,
        align: LineText.ALIGN_CENTER,
        linefeed: 1));
    list.add(LineText(
        type: LineText.TYPE_TEXT,
        content: 'Dia chi: Da Nang',
        weight: 0,
        align: LineText.ALIGN_CENTER,
        linefeed: 1));
    list.add(LineText(linefeed: 1));
    list.add(LineText(
        type: LineText.TYPE_TEXT,
        content: 'HOA DON',
        align: LineText.ALIGN_CENTER,
        weight: 1,
        linefeed: 1));
    final DateTime now = DateTime.now();
    list.add(LineText(
        type: LineText.TYPE_TEXT,
        content: 'Ngay in: ' + now.toString(),
        align: LineText.ALIGN_LEFT,
        linefeed: 1));
    list.add(LineText(linefeed: 1));
    list.add(LineText(type: LineText.TYPE_TEXT, content: 'In cho vui'));

    await bluetoothPrint.printReceipt(config, list);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Máy in')),
      body: RefreshIndicator(
        onRefresh: () =>
            bluetoothPrint.startScan(timeout: Duration(seconds: 4)),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                    child: Text(tips),
                  ),
                ],
              ),
              Divider(),
              StreamBuilder<List<BluetoothDevice>>(
                stream: bluetoothPrint.scanResults,
                initialData: [],
                builder: (c, snapshot) => Column(
                  children: snapshot.data != null
                      ? snapshot.data!
                      .map((d) => ListTile(
                    title: Text(d.name ?? ''),
                    subtitle: Text("${d.address}"),
                    onTap: () async {
                      setState(() {
                        _device = d;
                        bluetoothPrint.connect(_device);
                      });
                    },
                    trailing: _device != null &&
                        _device.address == d.address
                        ? Icon(
                      Icons.check,
                      color: Colors.green,
                    )
                        : null,
                  ))
                      .toList()
                      : [],
                ),
              ),
              Divider(),
              Container(
                padding: EdgeInsets.fromLTRB(20, 5, 20, 10),
                child: Column(
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        ElevatedButton(
                          child: Text('Kết nối'),
                          onPressed: _connected ? null : _onConnect,
                        ),
                        SizedBox(width: 10.0),
                        ElevatedButton(
                          child: Text('Ngắt kết nối'),
                          onPressed: _connected ? _onDisconnect : null,
                        ),
                      ],
                    ),
                    ElevatedButton(
                      child: Text('In hóa đơn'),
                      onPressed: _connected ? _sendData : null,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
      // phần dưới là button scan để tìm kiếm device
      floatingActionButton: StreamBuilder<bool>(
        stream: bluetoothPrint.isScanning,
        initialData: false,
        builder: (c, snapshot) {
          if (snapshot.data != null) {
            return FloatingActionButton(
              child: Icon(Icons.stop),
              onPressed: () => bluetoothPrint.stopScan(),
              backgroundColor: Colors.red,
            );
          } else {
            return FloatingActionButton(
                child: Icon(Icons.search),
                onPressed: () =>
                    bluetoothPrint.startScan(timeout: Duration(seconds: 4)));
          }
        },
      ),
    );
  }
}
