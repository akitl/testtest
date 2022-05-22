
import 'package:flame/game.dart';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:tinder_nft/TinderBeats.dart';
import 'package:window_size/window_size.dart';

void main() {
  //  WidgetsFlutterBinding.ensureInitialized();
  // if (Platform.isWindows) {
  //   setWindowMaxSize(const Size(600, 850));
  //   setWindowMinSize(const Size(350, 750));
  // }
  runApp(
    GameWidget(
      game: TinderBeats2(),
    ),
  );
}
