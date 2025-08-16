import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class TapToPlayVideoBox extends StatefulWidget {
  final String videoUrl;

  const TapToPlayVideoBox(String video, {Key? key, required this.videoUrl}) : super(key: key);

  @override
  State<TapToPlayVideoBox> createState() => _TapToPlayVideoBoxState();
}

class _TapToPlayVideoBoxState extends State<TapToPlayVideoBox> {
  late VideoPlayerController _controller;
  bool _isPlaying = false;
  bool _isInitialized = false;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network(widget.videoUrl)
      ..addListener(() {
        if (_controller.value.isInitialized && !_isInitialized) {
          setState(() {
            _isInitialized = true;
          });
        }
      });
    _controller.initialize();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _playVideo() {
    setState(() {
      _isPlaying = true;
    });
    _controller.play();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _isPlaying ? null : _playVideo,
      child: Container(
        width: 62,
        height: 62,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.13),
              blurRadius: 6,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        alignment: Alignment.center,
        child: _isPlaying && _isInitialized
            ? ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: AspectRatio(
                  aspectRatio: _controller.value.aspectRatio,
                  child: VideoPlayer(_controller),
                ),
              )
            : const Icon(Icons.play_circle_fill_outlined,
                color: Colors.black54, size: 42),
      ),
    );
  }
}
