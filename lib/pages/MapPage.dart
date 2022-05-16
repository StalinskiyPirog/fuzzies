import 'package:flutter/material.dart';
import 'package:fuzzies/layout/drawer.dart';
import 'package:fuzzies/layout/appbar.dart';

import 'dart:ui';
import 'dart:typed_data';
import 'dart:math';

import 'package:yandex_mapkit/yandex_mapkit.dart';

class MapPage extends StatefulWidget {
  const MapPage({Key? key}) : super(key: key);

  @override
  _MapPageState createState() => _MapPageState();
}

Future<Uint8List> _buildClusterAppearance(Cluster cluster) async {
  final recorder = PictureRecorder();
  final canvas = Canvas(recorder);
  final size = Size(200, 200);
  final fillPaint = Paint()
    ..color = Colors.white
    ..style = PaintingStyle.fill;
  final strokePaint = Paint()
    ..color = Colors.black
    ..style = PaintingStyle.stroke
    ..strokeWidth = 10;
  final radius = 60.0;

  final textPainter = TextPainter(
      text: TextSpan(
          text: cluster.size.toString(),
          style: TextStyle(color: Colors.black, fontSize: 50)),
      textDirection: TextDirection.ltr);

  textPainter.layout(minWidth: 0, maxWidth: size.width);

  final textOffset = Offset((size.width - textPainter.width) / 2,
      (size.height - textPainter.height) / 2);
  final circleOffset = Offset(size.height / 2, size.width / 2);

  canvas.drawCircle(circleOffset, radius, fillPaint);
  canvas.drawCircle(circleOffset, radius, strokePaint);
  textPainter.paint(canvas, textOffset);

  final image = await recorder
      .endRecording()
      .toImage(size.width.toInt(), size.height.toInt());
  final pngBytes = await image.toByteData(format: ImageByteFormat.png);

  return pngBytes!.buffer.asUint8List();
}

class _MapPageState extends State<MapPage> with RestorationMixin {
  final List<MapObject> mapObjects = [];

  final int kPlacemarkCount = 500;
  final Random seed = Random();
  final MapObjectId clusterizedPlacemarkCollectionId =
      MapObjectId('clusterized_placemark_collection');
  final MapObjectId largeClusterizedPlacemarkCollectionId =
      MapObjectId('large_clusterized_placemark_collection');

  late YandexMapController controller;
  final RestorableBool isSelectedCat = RestorableBool(false);
  final RestorableBool isSelectedDog = RestorableBool(false);
  final RestorableBool isSelectedRodent = RestorableBool(false);
  final RestorableBool isSelectedBird = RestorableBool(false);
  final RestorableBool isSelectedRabbit = RestorableBool(false);
  final RestorableBool isSelectedHedgehog = RestorableBool(false);
  final RestorableBool isSelectedExotic = RestorableBool(false);

  @override
  String get restorationId => "map_page";

  @override
  void restoreState(RestorationBucket? oldBucket, bool initialRestore) {
    registerForRestoration(isSelectedCat, "selected_cat");
    registerForRestoration(isSelectedDog, "selected_dog");
    registerForRestoration(isSelectedRodent, "selected_rodent");
    registerForRestoration(isSelectedBird, "selected_bird");
    registerForRestoration(isSelectedRabbit, "is_selected_rabbit");
    registerForRestoration(isSelectedHedgehog, "is_selected_hedgehog");
    registerForRestoration(isSelectedExotic, "selected_exotic");
  }

  @override
  void dispose() {
    isSelectedCat.dispose();
    isSelectedDog.dispose();
    isSelectedRodent.dispose();
    isSelectedBird.dispose();
    isSelectedRabbit.dispose();
    isSelectedExotic.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final List<MapObject> mapObjects = [];
    final filterChips = [
      FilterChip(
          label: const Text("Кошки"),
          backgroundColor: Colors.white,
          selected: isSelectedCat.value,
          onSelected: (value) {
            setState(() {
              isSelectedCat.value = !isSelectedCat.value;
            });
          }),
      FilterChip(
          label: const Text("Собаки"),
          backgroundColor: Colors.white,
          selected: isSelectedDog.value,
          onSelected: (value) {
            setState(() {
              isSelectedDog.value = !isSelectedDog.value;
            });
          }),
      FilterChip(
          label: const Text("Грызуны"),
          backgroundColor: Colors.white,
          selected: isSelectedRodent.value,
          onSelected: (value) {
            setState(() {
              isSelectedRodent.value = !isSelectedRodent.value;
            });
          }),
      FilterChip(
          label: const Text("Птицы"),
          backgroundColor: Colors.white,
          selected: isSelectedBird.value,
          onSelected: (value) {
            setState(() {
              isSelectedBird.value = !isSelectedBird.value;
            });
          }),
      FilterChip(
          label: const Text("Кролики"),
          backgroundColor: Colors.white,
          selected: isSelectedRabbit.value,
          onSelected: (value) {
            setState(() {
              isSelectedRabbit.value = !isSelectedRabbit.value;
            });
          }),
      FilterChip(
          label: const Text("Ежи"),
          backgroundColor: Colors.white,
          selected: isSelectedHedgehog.value,
          onSelected: (value) {
            setState(() {
              isSelectedHedgehog.value = !isSelectedHedgehog.value;
            });
          }),
      FilterChip(
          label: const Text("Экзотические животные"),
          backgroundColor: Colors.white,
          selected: isSelectedExotic.value,
          onSelected: (value) {
            setState(() {
              isSelectedExotic.value = !isSelectedExotic.value;
            });
          }),
    ];
    return Scaffold(
      extendBodyBehindAppBar: true,
      extendBody: true,
      resizeToAvoidBottomInset: false,
      drawer: leftDrawer(),
      appBar: AppBar(
        elevation: 0,
      ),
      body: Center(
        child: Stack(
          children: [
            YandexMap(
              mapObjects: mapObjects,
              tiltGesturesEnabled: false,
              onMapCreated: (YandexMapController YMController) async {
                controller = YMController;
                final cameraPosition = await controller.getCameraPosition();
              },
              logoAlignment: const MapAlignment(
                  horizontal: HorizontalAlignment.center,
                  vertical: VerticalAlignment.top),
            ),
            Align(
              child: ElevatedButton(
                child: Icon(Icons.ac_unit_sharp),
                onPressed: () async {
                  if (mapObjects.any(
                      (el) => el.mapId == clusterizedPlacemarkCollectionId)) {
                    return;
                  }
                  final clusterizedPlacemarkCollection =
                      ClusterizedPlacemarkCollection(
                    mapId: clusterizedPlacemarkCollectionId,
                    radius: 30,
                    minZoom: 15,
                    onClusterAdded: (ClusterizedPlacemarkCollection self,
                        Cluster cluster) async {
                      return cluster.copyWith(
                          appearance: cluster.appearance.copyWith(
                              icon: PlacemarkIcon.single(PlacemarkIconStyle(
                                  image: BitmapDescriptor.fromAssetImage(
                                      'lib/assets/cluster.png'),
                                  scale: 1))));
                    },
                    onClusterTap:
                        (ClusterizedPlacemarkCollection self, Cluster cluster) {
                      print('Tapped cluster');
                    },
                    placemarks: [
                      Placemark(
                          mapId: MapObjectId('placemark_1'),
                          point: Point(latitude: 55.756, longitude: 37.618),
                          consumeTapEvents: true,
                          onTap: (Placemark self, Point point) =>
                              print('Tapped placemark at $point'),
                          icon: PlacemarkIcon.single(PlacemarkIconStyle(
                              image: BitmapDescriptor.fromAssetImage(
                                  'lib/assets/place.png'),
                              scale: 1))),
                      Placemark(
                          mapId: MapObjectId('placemark_2'),
                          point: Point(latitude: 59.956, longitude: 30.313),
                          icon: PlacemarkIcon.single(PlacemarkIconStyle(
                              image: BitmapDescriptor.fromAssetImage(
                                  'lib/assets/place.png'),
                              scale: 1))),
                      Placemark(
                          mapId: MapObjectId('placemark_3'),
                          point: Point(latitude: 39.956, longitude: 30.313),
                          icon: PlacemarkIcon.single(PlacemarkIconStyle(
                              image: BitmapDescriptor.fromAssetImage(
                                  'lib/assets/place.png'),
                              scale: 1))),
                    ],
                    onTap: (ClusterizedPlacemarkCollection self, Point point) =>
                        print('Tapped me at $point'),
                  );

                  setState(() {
                    mapObjects.add(clusterizedPlacemarkCollection);
                  });
                },
              ),
              alignment: Alignment.centerRight,
            ),
            SafeArea(
              child: Column(
                children: [
                  Align(
                    child: Wrap(
                      verticalDirection: VerticalDirection.down,
                      runAlignment: WrapAlignment.spaceEvenly,
                      crossAxisAlignment: WrapCrossAlignment.center,
                      alignment: WrapAlignment.center,
                      children: [
                        for (final chip in filterChips)
                          Transform(
                            child: chip,
                            transform: Matrix4.identity()..scale(0.8),
                          ),
                      ],
                    ),
                    alignment: Alignment.topCenter,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
