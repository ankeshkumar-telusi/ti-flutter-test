import 'dart:async';
import 'package:chrconnecthpdraft/feature/app/extension/context.dart';
import 'package:flutter/material.dart';
import '../home/components/welcoming.dart';

class OnboardingScreen extends StatefulWidget {
  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen>
    with TickerProviderStateMixin {
  final StreamController<int> _controller = StreamController<int>();

  late AnimationController _animecontroller;
  late Animation<double> _animation;

  late AnimationController _bottomAnimecontroller;
  late Animation<Offset> offset;

  @override
  void initState() {
    super.initState();
    _animecontroller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
    );
    _animation = Tween<double>(begin: 0.0, end: 1.0).animate(_animecontroller);


    _bottomAnimecontroller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
    );
    offset = Tween<Offset>(begin: Offset(0.0, 1.0), end: Offset.zero)
        .animate(_bottomAnimecontroller);
  }

  @override
  void dispose() {
    _animecontroller.dispose();
    _bottomAnimecontroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Align(
              alignment: Alignment.topRight,
              child: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.close),
                color: Colors.black,
              ),
            ),
          ),
          StreamBuilder<int>(
            stream: _controller.stream,
            builder: (context, snapshot) {
              return _buildContainer(snapshot.data ?? 0);
            },
          ),
        ],
      ),
    );
  }

  Widget onBoardFirstScreen() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          height: 40,
          color: Colors.white,
          padding: const EdgeInsets.only(left: 16, right: 16, top: 8, bottom: 8),
          child: const Welcoming(
            state: WelcomingStates.evening,
            name: "Linda",
            onboard: true,
          ),
        ),
        const SizedBox(
          height: 16,
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(context.localizations.quick_tour,
              style: Theme.of(context).textTheme.bodyMedium),
        ),
        const SizedBox(
          height: 16,
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: InkWell(
            onTap: () {
              _controller.sink.add(1);
              _animecontroller.forward();
            },
            child: Row(
              children: [
                Text(context.localizations.letgo,
                    style: Theme.of(context).textTheme.displaySmall),
                const SizedBox(
                  width: 12,
                ),
                const Icon(
                  Icons.arrow_forward,
                  color: Colors.black,
                  size: 16,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget onBoardSecondScreen() {
    return AnimatedBuilder(
      animation: _animecontroller,
      builder: (context, child) {
        return Transform.scale(
          scale: _animation.value,
          child: GestureDetector(
            onVerticalDragUpdate: (details) {
              if (details.delta.dy.abs() > 5) {
                _controller.sink.add(2);
              }
            },
            onHorizontalDragUpdate: (details) {
              if (details.delta.dx.abs() > 5) {
                _controller.sink.add(2);
              }
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  height: 250,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(16)),
                  ),
                  child: Image.asset('images/onboard_reminder.png',
                      fit: BoxFit.contain),
                ),
                const SizedBox(
                  height: 16,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(context.localizations.onboard_reminder,
                      style: Theme.of(context).textTheme.bodyMedium),
                ),
                const SizedBox(
                  height: 16,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: InkWell(
                    onTap: () {
                      _controller.sink.add(2);
                    },
                    child: Row(
                      children: [
                        Text(context.localizations.scroll_next_section,
                            style: Theme.of(context).textTheme.displaySmall),
                        const SizedBox(
                          width: 12,
                        ),
                        const Icon(
                          Icons.arrow_forward,
                          color: Colors.black,
                          size: 16,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }


  Widget onBoardThirdScreen() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
                height: 250,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(16)),
                ),
                child:Image.asset(
                  'images/onboard_appoint.png',
                  fit: BoxFit.contain,
                )
        ),
        const SizedBox(
          height: 16,
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(context.localizations.onboard_appointment,
              style: Theme.of(context).textTheme.bodyMedium),
        ),
        const SizedBox(
          height: 16,
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: InkWell(
            onTap: () {
              _controller.sink.add(3);
            },
            child: Row(
              children: [
                Text(context.localizations.continue_text,
                    style: Theme.of(context).textTheme.displaySmall),
                const SizedBox(
                  width: 12,
                ),
                const Icon(
                  Icons.arrow_forward,
                  color: Colors.black,
                  size: 16,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget onBoardForthScreen() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          height: 250,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.all(Radius.circular(16)),
          ),
          child: Align(
            alignment: Alignment.bottomRight,
            child: Image.asset(
              'images/onboard_virtual_meet.png',
              fit: BoxFit.fitHeight,
              height: 40,
            ),
          ),
        ),
        const SizedBox(
          height: 16,
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(context.localizations.virtual_appointment,
              style: Theme.of(context).textTheme.bodyMedium),
        ),
        const SizedBox(
          height: 16,
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: InkWell(
            onTap: () {
              _controller.sink.add(4);
            },
            child: Row(
              children: [
                Text(context.localizations.continue_text,
                    style: Theme.of(context).textTheme.displaySmall),
                const SizedBox(
                  width: 12,
                ),
                const Icon(
                  Icons.arrow_forward,
                  color: Colors.black,
                  size: 16,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget onBoardFifthScreen() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const SizedBox(
          height: 16,
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Expanded(
                child: Text(context.localizations.schedule_appointment,
                    style: Theme.of(context).textTheme.bodyMedium),
              ),
              Container(
                height: 40,
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.all(Radius.circular(16)),
                ),
                child: Image.asset('images/onboard_viewall.png',
                    fit: BoxFit.contain),
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 16,
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: InkWell(
            onTap: () {
              _controller.sink.add(5);
              _bottomAnimecontroller.forward();
            },
            child: Row(
              children: [
                Text(context.localizations.continue_text,
                    style: Theme.of(context).textTheme.displaySmall),
                const SizedBox(
                  width: 12,
                ),
                const Icon(
                  Icons.arrow_forward,
                  color: Colors.black,
                  size: 16,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget onBoardSixthScreen() {
    return Column(
      children: [
        const SizedBox(
          height: 16,
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(context.localizations.bottom_resources,
              style: Theme.of(context).textTheme.bodyMedium),
        ),
        const SizedBox(
          height: 16,
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: InkWell(
            onTap: () {
              _controller.sink.add(6);
            },
            child: Row(
              children: [
                Text(context.localizations.continue_text,
                    style: Theme.of(context).textTheme.displaySmall),
                const SizedBox(
                  width: 12,
                ),
                const Icon(
                  Icons.arrow_forward,
                  color: Colors.black,
                  size: 16,
                ),
              ],
            ),
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: SlideTransition(
            position: offset,
            child: Container(
              width: MediaQuery.of(context).size.width,
              decoration: const BoxDecoration(
                color: Colors.transparent,
                borderRadius: BorderRadius.all(Radius.circular(16)),
              ),
              child: Image.asset('images/onboard_inbox_bottom.png',
                  fit: BoxFit.contain),
            ),
          ),
        ),
      ],
    );
  }

  Widget onBoardFinishScreen() {
    return Stack(
      children: [
        Container(
          height: MediaQuery.of(context).size.height * 0.9,
          width: MediaQuery.of(context).size.width,
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(16)),
          ),
          child: ColorFiltered(
            colorFilter: ColorFilter.mode(
                Colors.white.withOpacity(0.6), BlendMode.srcOver),
            child: Image.asset(
              'images/onboard_final_screen.png',
              fit: BoxFit.contain,
            ),
          ),
        ),
        Positioned(
            top: 10, // Adjust as needed
            right: 10,
            child: Container(
              width: MediaQuery.of(context).size.width * 0.6,
              padding: const EdgeInsets.symmetric(vertical: 8),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.secondaryContainer,
                borderRadius: const BorderRadius.all(Radius.circular(16)),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(context.localizations.return_home,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ),
            )),
      ],
    );
  }

  Widget _buildContainer(int index) {
    List<Widget> containers = [
      onBoardFirstScreen(),
      onBoardSecondScreen(),
      onBoardThirdScreen(),
      onBoardForthScreen(),
      onBoardFifthScreen(),
      onBoardSixthScreen(),
      onBoardFinishScreen(),
    ];

    return containers[index];
  }
/**
 * create common onBoarding screen
 * which will be used for all the onboarding screen
 */
}
