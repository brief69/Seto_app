

import 'dart:async';
import 'package:flutter_webrtc/flutter_webrtc.dart';
import 'package:websocket/websocket.dart';

class LiveStreamManager {
  RTCPeerConnection? _peerConnection;
  MediaStream? _localStream;
  WebSocket? _signalingSocket;

  // WebRTC設定
  final Map<String, dynamic> _config = {
    'iceServers': [
      {'url': 'stun:stun.l.google.com:19302'},
    ]
  };

  // メディアの制約
  final Map<String, dynamic> _constraints = {
    'audio': true,
    'video': {
      'facingMode': 'user', // フロントカメラを使用
    },
  };

  // シグナリングサーバーに接続
  Future<void> connectToSignalingServer(String url) async {
    _signalingSocket = await WebSocket.connect(url);
    _signalingSocket!.listen((data) {
      // 受信したシグナリングデータの処理
      _onSignalingDataReceived(data);
    });
  }

  // シグナリングデータ受信時の処理
  void _onSignalingDataReceived(dynamic data) {
    // ここでオファー、アンサー、ICE候補の処理を行う
  }

  // オファーを生成して送信
  Future<void> createAndSendOffer() async {
    var offer = await _peerConnection!.createOffer({});
    _peerConnection!.setLocalDescription(offer);
    _sendSignalingData(offer); // シグナリングサーバーにオファーを送信
  }

  // シグナリングデータを送信
  void _sendSignalingData(dynamic data) {
    _signalingSocket!.add(data);
  }

  // WebRTC接続の初期化
  Future<void> initializeConnection() async {
    _peerConnection = await createPeerConnection(_config, {});

    // ローカルメディアストリームの取得
    _localStream = await navigator.mediaDevices.getUserMedia(_constraints);

    // ストリームをピア接続に追加
    _peerConnection!.addStream(_localStream!);

    // シグナリングに関する追加のロジックがここに必要です。
  }

  // ライブ配信の開始
  Future<void> startLiveStreaming() async {
    await initializeConnection();

    // ここで、シグナリングサーバーへのオファーを作成し、送信します。
  }

  // リソースの解放
  void dispose() {
    _localStream?.dispose();
    _peerConnection?.close();
  }
}
