import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:media_kit/media_kit.dart'; // Provides [Player], [Media], [Playlist] etc.
import 'package:spici/presentation/config_page.dart';
//import 'package:media_kit_video/media_kit_video.dart';
import 'package:spici/presentation/video_view.dart'; // Provides [VideoController] & [Video] etc.

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  MediaKit.ensureInitialized();
  runApp(
    const ProviderScope(
      child: MyScreen(),
    ),
  );
}

class MyScreen extends ConsumerStatefulWidget {
  const MyScreen({Key? key}) : super(key: key);
  @override
  ConsumerState<MyScreen> createState() => MyScreenState();
}

class MyScreenState extends ConsumerState<MyScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    //player.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Stream Viewer',
      onGenerateRoute: (settings) {
        return MaterialPageRoute(
          builder: (context) {
            return Scaffold(
              appBar: AppBar(
                backgroundColor: Colors.white,
              ),
              body: Center(
                child: Row(
                  children: [
                    const Expanded(
                      child: SizedBox(),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) {
                                  return const VideoView();
                                },
                              ),
                            );
                          },
                          child: const Row(
                            children: [
                              Icon(
                                Icons.play_arrow,
                              ),
                              Text(
                                " Abrir Stream",
                              ),
                            ],
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (BuildContext context) {
                                  return const ConfigPage();
                                },
                              ),
                            );
                          },
                          child: const Row(
                            children: [
                              Icon(Icons.settings),
                              Text(" Configurações"),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const Expanded(
                      child: SizedBox(),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
