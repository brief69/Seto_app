

import 'package:flutter/material.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';

class LiveStreamPage extends StatelessWidget {
  const LiveStreamPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          // ビデオ表示部分
          RTCVideoView(/* ビデオストリームを表示するWidget */),
          // ライトバーとボタン
          Align(
            alignment: Alignment.topRight,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                IconButton(
                  icon: const Icon(Icons.thumb_up),
                  onPressed: () => print('いいね！'),
                ),
                IconButton(
                  icon: const Icon(Icons.comment),
                  onPressed: () => print('コメント'),
                ),
                IconButton(
                  icon: Icon(Icons.share),
                  onPressed: () => print('シェア'),
                ),
              ],
            ),
          ),
          // キャプション
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              padding: const EdgeInsets.all(8.0),
              color: Colors.black54,
              child: const Text(
                'ここにキャプションが表示されます',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
