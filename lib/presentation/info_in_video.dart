import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';
import 'package:spici/presentation/config_page.dart';

class InfoInVideo extends ConsumerStatefulWidget {
  const InfoInVideo({Key? key}) : super(key: key);
  @override
  ConsumerState<InfoInVideo> createState() => _InfoInVideo();

  final bool isOpen = false;
}

class _InfoInVideo extends ConsumerState<InfoInVideo> {
  bool _isOpen = false;
  MqttServerClient? client;
  String messages = '';
  @override
  void initState() {
    super.initState();
    _isOpen = widget.isOpen;
    _initializeMqttClient();
  }

  Future<void> _initializeMqttClient() async {
    client = MqttServerClient.withPort(
        ref.read(mqttBrokerStateProvider), 'l2opassandfs', 1883);
    await client!.connect();
    client?.subscribe(ref.read(mqttTopicStateProvider), MqttQos.exactlyOnce);
    client?.updates?.listen(
      _onMessageReceived,
    );
  }

  void _onMessageReceived(List<MqttReceivedMessage<MqttMessage>> event) {
    final MqttPublishMessage recMess = event[0].payload as MqttPublishMessage;
    final String message =
        MqttPublishPayload.bytesToStringAsString(recMess.payload.message);
    setState(() {
      messages = message;
    });
  }

  @override
  Widget build(BuildContext context) {
    String suspects = messages != '' ? messages : "Nenhum suspeito";
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _isOpen
            ? SizedBox(
                width: 200,
                child: Column(
                  children: [
                    const Text(
                      "Suspeitos em cena:",
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                    Text(
                      suspects,
                      style: const TextStyle(
                        fontSize: 20,
                      ),
                    ),
                  ],
                ),
              )
            : const SizedBox(
                width: 0,
              ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              icon: _isOpen
                  ? const Icon(Icons.arrow_forward_ios_outlined)
                  : const Icon(Icons.arrow_back_ios_new_outlined),
              onPressed: () {
                setState(() {
                  _isOpen = !_isOpen;
                });
              },
            ),
          ],
        )
      ],
    );
  }
}
