import 'dart:io';
import 'dart:typed_data';

import 'package:bluetooth_print_plus/bluetooth_print_model.dart';
import 'package:bluetooth_print_plus/cpcl_command.dart';
import 'package:bluetooth_print_plus/esc_command.dart';
import 'package:bluetooth_print_plus/tsp_command.dart';
import 'package:flutter/material.dart';
import 'dart:async';

import 'package:bluetooth_print_plus/bluetooth_print_plus.dart';
import 'package:flutter/services.dart';

class PostTestPage2 extends StatefulWidget {
  final Uint8List pdfBytes;

  const PostTestPage2({super.key, required this.pdfBytes});

  @override
  State<PostTestPage2> createState() => _PostTestPage2State();
}

class _PostTestPage2State extends State<PostTestPage2>
    with WidgetsBindingObserver {
  final _bluetoothPrintPlus = BluetoothPrintPlus.instance;
  bool _connected = false;
  BluetoothDevice? _device;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => initBluetooth());
  }

  Future<void> initBluetooth() async {
    bool isConnected = await _bluetoothPrintPlus.isConnected ?? false;
    _bluetoothPrintPlus.state.listen((state) {
      print('******************* cur device status: $state');
      switch (state) {
        case BluetoothPrintPlus.CONNECTED:
          setState(() {
            _connected = true;
            if (_device == null) return;
            Navigator.of(context).push(MaterialPageRoute(builder: (ctx) {
              return FunctionPage(
                _device!,
                pdfFile: widget.pdfBytes,
              );
            }));
          });
          break;
        case BluetoothPrintPlus.DISCONNECTED:
          setState(() {
            _connected = false;
          });
          break;
        default:
          break;
      }
    });

    if (!mounted) return;

    if (isConnected) {
      setState(() {
        _connected = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Plugin example app'),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
                child: StreamBuilder<List<BluetoothDevice>>(
              stream: _bluetoothPrintPlus.scanResults,
              initialData: [],
              builder: (c, snapshot) => ListView(
                children: snapshot.data!
                    .map((d) => Container(
                          padding: const EdgeInsets.only(
                              left: 10, right: 10, bottom: 5),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                  child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(d.name ?? ''),
                                  Text(
                                    d.address ?? 'null',
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                        fontSize: 12, color: Colors.grey),
                                  ),
                                  const Divider(),
                                ],
                              )),
                              const SizedBox(
                                width: 10,
                              ),
                              ElevatedButton(
                                onPressed: () async {
                                  _bluetoothPrintPlus.stopScan();
                                  _bluetoothPrintPlus.connect(d);
                                  _device = d;
                                },
                                child: const Text("connect"),
                              )
                            ],
                          ),
                        ))
                    .toList(),
              ),
            )),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              width: double.infinity,
              height: 60,
              child: ElevatedButton(
                child: const Text("Search", style: TextStyle(fontSize: 16)),
                onPressed: () {
                  _bluetoothPrintPlus.isAvailable;
                  _bluetoothPrintPlus.startScan(
                      timeout: const Duration(seconds: 30));
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}

enum CmdType { Tsc, Cpcl, Esc }

class FunctionPage extends StatefulWidget {
  final BluetoothDevice device;
  final Uint8List pdfFile;

  const FunctionPage(this.device, {super.key, required this.pdfFile});

  @override
  State<FunctionPage> createState() => _FunctionPageState();
}

class _FunctionPageState extends State<FunctionPage> {
  CmdType cmdType = CmdType.Tsc;

  @override
  void dispose() {
    super.dispose();

    BluetoothPrintPlus.instance.disconnect();
    print("FunctionPage dispose");
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.device.name ?? ""),
      ),
      body: Column(
        children: [
          buildRadioGroupRowWidget(),
          const SizedBox(
            height: 20,
          ),
          if (cmdType == CmdType.Tsc)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                    onPressed: () async {
                      final cmd = await CommandTool.tscSelfTestCmd();
                      BluetoothPrintPlus.instance.write(cmd);
                    },
                    child: const Text("selfTest")),
              ],
            ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ElevatedButton(
                  onPressed: () async {
                    final Uint8List image = widget.pdfFile;
                    Uint8List? cmd;
                    switch (cmdType) {
                      case CmdType.Tsc:
                        cmd = await CommandTool.tscImageCmd(image);
                        break;
                      case CmdType.Cpcl:
                        cmd = await CommandTool.cpclImageCmd(image);
                        break;
                      case CmdType.Esc:
                        cmd = await CommandTool.escImageCmd(image);
                        break;
                    }
                    BluetoothPrintPlus.instance.write(cmd);
                  },
                  child: const Text("image")),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ElevatedButton(
                  onPressed: () async {
                    Uint8List? cmd;
                    switch (cmdType) {
                      case CmdType.Tsc:
                        cmd = await CommandTool.tscTemplateCmd();
                        break;
                      case CmdType.Cpcl:
                        cmd = await CommandTool.cpclTemplateCmd();
                        break;
                      case CmdType.Esc:
                        break;
                    }

                    BluetoothPrintPlus.instance.write(cmd);
                    print("getCommand $cmd");
                  },
                  child: const Text("text/QR_code/barcode")),
            ],
          )
        ],
      ),
    );
  }

  Row buildRadioGroupRowWidget() {
    return Row(children: [
      const Text("command type"),
      ...CmdType.values
          .map((e) => Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Radio(
                    value: e,
                    groupValue: cmdType,
                    onChanged: (v) {
                      setState(() {
                        cmdType = e;
                      });
                    },
                  ),
                  Text(e.toString().split(".").last)
                ],
              ))
          .toList()
    ]);
  }
}

/// CommandTool
class CommandTool {
  static final tscCommand = TscCommand();
  static final cpclCommand = CpclCommand();
  static final escCommand = EscCommand();

  /// tscSelfTestCmd
  static Future<Uint8List?> tscSelfTestCmd() async {
    await tscCommand.cleanCommand();
    await tscCommand.selfTest();
    final cmd = await tscCommand.getCommand();
    return cmd;
  }

  /// tscImageCmd
  static Future<Uint8List?> tscImageCmd(Uint8List image) async {
    await tscCommand.cleanCommand();
    await tscCommand.cls();
    await tscCommand.size(width: 76, height: 130);
    await tscCommand.image(image: image, x: 50, y: 60);
    await tscCommand.print(1);
    final cmd = await tscCommand.getCommand();
    return cmd;
  }

  /// tscTemplateCmd
  static Future<Uint8List?> tscTemplateCmd() async {
    await tscCommand.cleanCommand();
    await tscCommand.size(width: 76, height: 130);
    await tscCommand.cls();
    await tscCommand.speed(8);
    await tscCommand.density(8);
    await tscCommand.text(
      content: "莫听穿林打叶声，何妨吟啸且徐行。",
      x: 10,
      y: 10,
    );
    await tscCommand.text(
        content: "竹杖芒鞋轻胜马，谁怕？", x: 10, y: 60, xMulti: 2, yMulti: 2);
    await tscCommand.text(
        content: "一蓑烟雨任平生。", x: 10, y: 170, xMulti: 3, yMulti: 3);
    await tscCommand.qrCode(
        // content: "料峭春风吹酒醒，微冷，山头斜照却相迎。",
        content: "28938928",
        x: 50,
        y: 350,
        cellWidth: 3);
    await tscCommand.qrCode(
      // content: "回首向来萧瑟处，归去，也无风雨也无晴。",
      content: "28938928",
      x: 50,
      y: 500,
    );
    await tscCommand.barCode(
      content: "123456789",
      x: 200,
      y: 350,
    );
    await tscCommand.print(1);
    final cmd = await tscCommand.getCommand();
    return cmd;
  }

  /// cpclImageCmd
  static Future<Uint8List?> cpclImageCmd(Uint8List image) async {
    await cpclCommand.cleanCommand();
    await cpclCommand.size(width: 76 * 8, height: 76 * 8);
    await cpclCommand.image(image: image, x: 10, y: 10);
    await cpclCommand.print();
    final cmd = await cpclCommand.getCommand();
    return cmd;
  }

  /// cpclTemplateCmd
  static Future<Uint8List?> cpclTemplateCmd() async {
    await cpclCommand.cleanCommand();
    await cpclCommand.size(width: 76 * 8, height: 76 * 8);
    await cpclCommand.qrCode(content: "12345678", x: 10, y: 10, width: 10);
    await cpclCommand.text(content: "日啖荔枝三百颗", x: 10, y: 150);
    await cpclCommand.text(
        content: "不辞长作岭南人", x: 10, y: 180, bold: true, xMulti: 2, yMulti: 2);
    await cpclCommand.barCode(content: "12345678", x: 10, y: 220);
    await cpclCommand.line(x: 150, y: 100, endX: 300, endY: 500);
    await cpclCommand.print();
    final cmd = await cpclCommand.getCommand();
    return cmd;
  }

  /// escImageCmd
  static Future<Uint8List?> escImageCmd(Uint8List image) async {
    await escCommand.cleanCommand();
    await escCommand.print();
    await escCommand.image(image: image);
    await escCommand.print();
    final cmd = await escCommand.getCommand();
    return cmd;
  }
}
