import 'package:entrenai/ui/app_router.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:video_player/video_player.dart';

class VideoIntroPage extends StatefulWidget {
  const VideoIntroPage({super.key});

  @override
  State<VideoIntroPage> createState() => _VideoIntroPageState();
}

class _VideoIntroPageState extends State<VideoIntroPage> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.asset('assets/intro.mp4')
      ..initialize().then((_) {
        _controller.setVolume(0);
        _controller.play();
        _controller.setLooping(true);
        setState(() {});
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _controller.value.isInitialized
          ? Stack(
              children: [
                VideoPlayer(_controller),
                Align(
                  alignment: Alignment.center,
                  child: SizedBox(
                    width: 200,
                    height: 50,
                    child: MaterialButton(
                      onPressed: () {
                        Navigator.of(context).pushNamed(RoutesNames.onboarding);
                      },
                      color: Theme.of(context).colorScheme.primary,
                      shape: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: BorderSide.none,
                      ),
                      elevation: 32,
                      child: Text('LET\'S GO!', style: GoogleFonts.lilitaOne(
                        fontSize: 24,
                        fontWeight: FontWeight.w400,
                      ),),
                    ),
                  ),
                ),
              ],
            )
          : Container(),
    );
  }
}
