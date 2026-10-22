import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/utils/app_colors.dart';
import '../../../core/utils/app_constants.dart';
import '../../../core/utils/app_enums.dart';
import '../../../core/utils/app_extensions.dart';
import '../../../core/utils/app_styles.dart';
import '../../../core/widgets/animated_background.dart';
import '../../../data/portfolio_data.dart';
import '../../blocs/home_bloc/home_bloc.dart';
import '../app_bar/vertical_headers_builder.dart';
import 'about_me/about_me_section.dart';
import 'contact/contact_section.dart';
import 'intro/intro_section.dart';
import 'projects/projects_section.dart';

class HomeBody extends StatefulWidget {
  const HomeBody({super.key});

  @override
  State<HomeBody> createState() => _HomeBodyState();
}

class _HomeBodyState extends State<HomeBody> {
  static const double _maxContentWidth = 1200;

  final ScrollController _controller = ScrollController();
  final ValueNotifier<Offset?> _pointer = ValueNotifier(null);
  final introKey = GlobalKey();
  final aboutKey = GlobalKey();
  final projectKey = GlobalKey();
  final contactKey = GlobalKey();

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _initListenerForInteractWithHeaderIndex();
    });
  }

  void _initListenerForInteractWithHeaderIndex() {
    _controller.addListener(() {
      if (!mounted) return;
      // Measured on every scroll: the projects section changes height when
      // its category filter changes.
      double introHeight = introKey.currentContext!.size!.height;
      double aboutHeight = aboutKey.currentContext!.size!.height;
      double projectHeight = projectKey.currentContext!.size!.height;
      // Switch the active nav item a little before a section reaches the top.
      double controllerHeight = _controller.offset + context.height * .3;
      if (_controller.position.extentAfter == 0.0) {
        context.read<HomeBloc>().add(ChangeAppBarHeadersColorByColor(3));
      } else if (controllerHeight < introHeight) {
        context.read<HomeBloc>().add(ChangeAppBarHeadersColorByColor(0));
      } else if (controllerHeight < (introHeight + aboutHeight)) {
        context.read<HomeBloc>().add(ChangeAppBarHeadersColorByColor(1));
      } else if (controllerHeight <
          (introHeight + aboutHeight + projectHeight)) {
        context.read<HomeBloc>().add(ChangeAppBarHeadersColorByColor(2));
      } else {
        context.read<HomeBloc>().add(ChangeAppBarHeadersColorByColor(3));
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _pointer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = context.width < DeviceType.ipad.getMaxWidth();
    return BlocListener<HomeBloc, HomeState>(
      listener: (context, state) {
        if (state is AppBarHeadersIndexChanged) {
          if (context.read<HomeBloc>().appBarHeaderAxis ==
              AppBarHeadersAxis.vertical) {
            context
                .read<HomeBloc>()
                .add(ChangeAppBarHeadersAxis(AppBarHeadersAxis.horizontal));
          }
          final target = [introKey, aboutKey, projectKey, contactKey][state.index];
          Scrollable.ensureVisible(
            target.currentContext!,
            duration: const Duration(milliseconds: 700),
            curve: Curves.easeInOutCubic,
          );
        }
      },
      child: MouseRegion(
        onHover: (event) => _pointer.value = event.position,
        onExit: (_) => _pointer.value = null,
        child: Stack(
          children: [
            Positioned.fill(child: AnimatedBackground(pointer: _pointer)),
            SingleChildScrollView(
              controller: _controller,
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: _maxContentWidth),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: isMobile ? 20 : 40),
                    child: Column(
                      children: [
                        IntroSection(key: introKey),
                        AboutMeSection(key: aboutKey),
                        ProjectsSection(key: projectKey),
                        ContactSection(key: contactKey),
                        const _Footer(),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              top: AppConstants.appBarHeight,
              left: 0,
              right: 0,
              child: _ScrollProgress(controller: _controller),
            ),
            const VerticalHeadersBuilder(),
          ],
        ),
      ),
    );
  }
}

class _ScrollProgress extends StatelessWidget {
  const _ScrollProgress({required this.controller});

  final ScrollController controller;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: (context, _) {
        double progress = 0;
        if (controller.hasClients &&
            controller.position.hasContentDimensions &&
            controller.position.maxScrollExtent > 0) {
          progress = (controller.offset / controller.position.maxScrollExtent)
              .clamp(0, 1);
        }
        return Align(
          alignment: Alignment.centerLeft,
          child: FractionallySizedBox(
            widthFactor: progress,
            child: Container(
              height: 2,
              decoration: BoxDecoration(
                gradient: AppColors.primaryGradient,
                boxShadow: [
                  BoxShadow(
                    color: AppColors.secondaryColor.withValues(alpha: .6),
                    blurRadius: 8,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class _Footer extends StatelessWidget {
  const _Footer();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 32),
      decoration: BoxDecoration(
        border: Border(top: BorderSide(color: AppColors.glassBorder)),
      ),
      child: Text(
        '© ${DateTime.now().year} ${PortfolioData.profile.name}  ·  Designed & built with Flutter',
        textAlign: TextAlign.center,
        style: AppStyles.s14.copyWith(color: AppColors.lowPriority),
      ),
    );
  }
}
