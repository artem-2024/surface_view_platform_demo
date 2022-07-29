import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: TestPage(),
    );
  }
}

/// Test Page
class TestPage extends StatefulWidget {
  const TestPage({Key? key}) : super(key: key);

  @override
  State<TestPage> createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
  @override
  Widget build(BuildContext context) {
    final isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Plugin example app'),
        actions: [
          // When i click this button about five times, i got a error：Platform view hasn't been initialized from the platform view channel.
          IconButton(
            tooltip: "full screen platform view",
            onPressed: () async {
              final isLandscape =
                  MediaQuery.of(context).orientation == Orientation.landscape;
              if (isLandscape) {
                await SystemChrome.setPreferredOrientations([
                  DeviceOrientation.portraitUp,
                  DeviceOrientation.portraitDown
                ]);
              } else {
                await SystemChrome.setPreferredOrientations([
                  DeviceOrientation.landscapeLeft,
                  DeviceOrientation.landscapeRight
                ]);
              }
            },
            icon: const Icon(Icons.fullscreen),
          )
        ],
      ),
      body: isLandscape
          ? androidHybridView()
          : Column(
              children: [
                AspectRatio(
                  aspectRatio: 16 / 9,
                  child: androidHybridView(),
                ),
                Expanded(
                  child: DefaultTabController(
                    length: 3,
                    child: Column(
                      children: [
                        TabBar(
                          labelColor: Colors.black,
                          tabs: List.generate(
                            3,
                            (index) => Tab(
                              text: 'tab${index + 1}',
                            ),
                          ),
                        ),
                        const Expanded(
                          child: TabBarView(
                            children: [
                              Center(child: Text('Page 1')),
                              Center(child: Text('Page 2')),
                              Center(child: Text('Page 3')),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
    );
  }

  /// suck as a surface-video-player
  Widget androidHybridView() {
    return PlatformViewLink(
      viewType: 'Test/surface_view_platform',
      surfaceFactory:
          (BuildContext context, PlatformViewController controller) {
        return AndroidViewSurface(
          controller: controller as AndroidViewController,
          gestureRecognizers: const {},
          hitTestBehavior: PlatformViewHitTestBehavior.opaque,
        );
      },
      onCreatePlatformView: (PlatformViewCreationParams params) {
        return PlatformViewsService.initExpensiveAndroidView(
          id: params.id,
          viewType: params.viewType,
          layoutDirection: TextDirection.ltr,
          creationParamsCodec: const StandardMessageCodec(),
        )
          ..addOnPlatformViewCreatedListener(params.onPlatformViewCreated)
          ..create();
      },
    );
  }
}
