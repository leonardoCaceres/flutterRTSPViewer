import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ConfigPage extends ConsumerStatefulWidget {
  const ConfigPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ConfigPage();
}

class _ConfigPage extends ConsumerState<ConfigPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Align(
            alignment: Alignment.topLeft,
            child: IconButton(
              onPressed: () {
                setState(
                  () {
                    Navigator.pop(context);
                  },
                );
              },
              icon: const Icon(Icons.close),
            ),
          ),
          Expanded(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      child: TextFormField(
                        decoration: const InputDecoration(
                          icon: Icon(Icons.person_2_rounded),
                          hintText: "RTSP:",
                        ),
                        controller: TextEditingController(
                          text: ref.read(rtspStateProvider),
                        ),
                        onChanged: (value) {
                          ref
                              .read(rtspStateProvider.notifier)
                              .update((state) => value);
                        },
                      ),
                    ),
                    SizedBox(
                      child: TextFormField(
                        decoration: const InputDecoration(
                          icon: Icon(Icons.person_2_rounded),
                          hintText: "MQTT:",
                        ),
                        controller: TextEditingController(
                          text: ref.read(mqttBrokerStateProvider),
                        ),
                        onChanged: (value) {
                          ref
                              .read(mqttBrokerStateProvider.notifier)
                              .update((state) => value);
                        },
                      ),
                    ),
                    SizedBox(
                      child: TextFormField(
                        decoration: const InputDecoration(
                          icon: Icon(Icons.person_2_rounded),
                          hintText: "PORT:",
                        ),
                        controller: TextEditingController(
                          text: ref.read(mqttPortStateProvider),
                        ),
                        onChanged: (value) {
                          ref
                              .read(mqttPortStateProvider.notifier)
                              .update((state) => value);
                        },
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {},
                      child: const Row(
                        children: [
                          Icon(Icons.settings),
                          Text(" salvar"),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

final rtspStateProvider =
    StateProvider<String>((ref) => 'rtsp://10.7.129.102:8554/ds-test');
final mqttBrokerStateProvider = StateProvider<String>((ref) => "10.7.129.102");
final mqttPortStateProvider = StateProvider<String>((ref) => "1883");
