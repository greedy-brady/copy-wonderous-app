import 'package:flutter/widgets.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get_it_mixin/get_it_mixin.dart';
import 'package:go_router/go_router.dart';
import 'package:midas_coffee_app/logic/data/wonder_data.dart';
import 'package:midas_coffee_app/logic/data/wonder_type.dart';
import 'package:midas_coffee_app/main.dart';
import 'package:midas_coffee_app/router.dart';
import 'package:midas_coffee_app/ui/screens/home_menu/home_menu.dart';
import 'package:midas_coffee_app/ui/utils/app_haptics.dart';
import 'package:midas_coffee_app/ui/wonder_illustrations/common/animated_clouds.dart';
import 'package:midas_coffee_app/ui/wonder_illustrations/common/wonder_illustration.dart';
import 'package:midas_coffee_app/ui/wonder_illustrations/common/wonder_illustration_config.dart';

part '_vertical_swipe_controller.dart';

class HomeScreen extends StatefulWidget with GetItStatefulWidgetMixin {
  HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late final PageController _pageController;

  List<WonderData> get _wonders => wondersLogic.all;
  bool _isMenuOpen = false;

  late int _wonderIndex = 0;

  int get _numWonders => _wonders.length;

  double? _swipeOverride;

  bool _fadeInOnNextBuild = false;

  final _fadeAnims = <AnimationController>[];

  WonderData get currentWonder => _wonders[_wonderIndex];

  late final _VerticalSwipeController _swipeController =
      _VerticalSwipeController(this, _showDetailsPage);

  bool _isSelected(WonderType t) => t == currentWonder.type;

  @override
  void initState() {
    super.initState();
    // Create page controller,
    // allow 'infinite' scrolling by starting at a very high page, or remember the previous value
    final initialPage = _numWonders * 9999;

    print(_wonders);
    print(_numWonders);
    print(initialPage);
    print(_numWonders);

    _pageController =
        PageController(viewportFraction: 1, initialPage: initialPage);

    _wonderIndex = initialPage % _numWonders;
  }

  void _handlePageChanged(value) {
    setState(() {
      _wonderIndex = value % _numWonders;
    });
    AppHaptics.lightImpact();
  }

  void _handleOpenMenuPressed() async {
    setState(() => _isMenuOpen = true);
    WonderType? pickedWonder =
        await appLogic.showFullscreenDialogRoute<WonderType>(
      context,
      HomeMenu(data: currentWonder),
      transparent: true,
    );
    setState(() => _isMenuOpen = false);
    if (pickedWonder != null) {
      _setPageIndex(_wonders.indexWhere((w) => w.type == pickedWonder));
    }
  }

  void _handleFadeAnimInit(AnimationController controller) {
    _fadeAnims.add(controller);
    controller.value = 1;
  }

  void _handlePageIndicatorDotPressed(int index) => _setPageIndex(index);

  void _setPageIndex(int index) {
    if (index == _wonderIndex) return;
    // To support infinite scrolling, we can't jump directly to the pressed index. Instead, make it relative to our current position.
    final pos =
        ((_pageController.page ?? 0) / _numWonders).floor() * _numWonders;
    _pageController.jumpToPage(pos + index);
  }

  void _showDetailsPage() async {
    _swipeOverride = _swipeController.swipeAmt.value;
    context.push(ScreenPaths.wonderDetails(currentWonder.type));
    await Future.delayed(100.ms);
    _swipeOverride = null;
    _fadeInOnNextBuild = true;
  }

  void _startDelayedFgFade() async {
    try {
      for (var a in _fadeAnims) {
        a.value = 0;
      }
      await Future.delayed(300.ms);
      for (var a in _fadeAnims) {
        a.forward();
      }
    } on Exception catch (e) {
      debugPrint(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_fadeInOnNextBuild == true) {
      _startDelayedFgFade();
      _fadeInOnNextBuild = false;
    }

    return _swipeController.wrapGestureDetector(Container(
      color: $styles.colors.black,
      child: Stack(
        children: [
          Stack(
            children: [
              /// Background
              ..._buildBgAndClouds(),

              /// Wonders Illustrations (main content)
              // _buildMgPageView(),

              /// Foreground illustrations and gradients
              // _buildFgAndGradients(),

              /// Controls that float on top of the various illustrations
              // _buildFloatingUi(),
            ],
          ).animate().fadeIn(),
        ],
      ),
    ));
  }

  List<Widget> _buildBgAndClouds() {
    return [
      // Background
      ..._wonders.map((e) {
        final config =
            WonderIllustrationConfig.bg(isShowing: _isSelected(e.type));
        return WonderIllustration(e.type, config: config);
      }).toList(),
      // Clouds
      FractionallySizedBox(
        widthFactor: 1,
        heightFactor: .5,
        child: AnimatedClouds(wonderType: currentWonder.type, opacity: 1),
      )
    ];
  }
}
