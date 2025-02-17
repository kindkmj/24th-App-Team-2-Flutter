import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:x_pr/app/pages/home/home_page_model.dart';
import 'package:x_pr/app/pages/home/home_page_state.dart';
import 'package:x_pr/app/pages/home/onboarding/onboarding_page_view.dart';
import 'package:x_pr/app/pages/home/widgets/home_layout.dart';
import 'package:x_pr/app/routes/routes.dart';
import 'package:x_pr/core/localization/generated/l10n.dart';
import 'package:x_pr/core/theme/components/buttons/button/button.dart';
import 'package:x_pr/core/theme/components/lifecycle/lifecycle_listener.dart';
import 'package:x_pr/core/theme/components/loader/loader.dart';
import 'package:x_pr/core/theme/foundations/app_theme.dart';
import 'package:x_pr/core/view/base_view.dart';
import 'package:x_pr/features/config/domain/services/config_service.dart';
import 'package:x_pr/features/game/domain/entities/game_state/game_state.dart';
import 'package:x_pr/features/game/domain/service/game_service.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    super.key,
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final controller = PageController(viewportFraction: 1.0, keepPage: true);

  @override
  Widget build(BuildContext context) {
    return BaseView(
      viewModel: HomePageModel.new,
      state: (ref, HomePageState? prevState) {
        return HomePageState(
          playingRoomId: switch (ref.watch(GameService.$)) {
            GameDisconnectedState(playingRoomId: final roomId) => roomId,
            _ => prevState?.playingRoomId,
          },
          nickname: ref.watch(ConfigService.$).nickname,
        );
      },
      initState: (ref, viewModel) => viewModel.init(),
      onStateChanged: (ref, viewModel, state, oldState) {
        final (noticeData, oldNoticeData) = (
          state.noticeDialogData,
          oldState?.noticeDialogData,
        );
        if (noticeData != null && noticeData != oldNoticeData) {
          context.pushNamed(Routes.noticeDialog.name, extra: noticeData);
        }
      },
      builder: (ref, viewModel, state) {
        return LifecycleListener(
          listen: viewModel.didChangeAppLifecycleState,
          child: Loader(
            isBusy: state.isBusy,
            child: HomeLayout(
              isShowRejoinButton: state.isPlayingRoom,

              /// Onboarding
              onboarding: OnboardingPageView(
                nickname: state.nickname,
              ),

              /// Create button
              createButton: Button(
                text: S.current.homeCreateRoom,
                size: ButtonSize.large,
                onPressed: () async {
                  final isSuccess = await viewModel.enter();
                  if (isSuccess && context.mounted) {
                    context.pushNamed(Routes.gamePage.name);
                  }
                },
              ),

              /// Join button
              joinButton: Button(
                type: ButtonType.flat,
                color: context.color.text,
                text: S.current.homeJoinRoom,
                size: ButtonSize.large,
                onPressed: viewModel.joinPressed,
              ),

              /// Rejoin button
              rejoinButton: Button(
                width: double.infinity,
                text: S.current.homeRejoinRoom,
                size: ButtonSize.large,
                color: context.color.primary,
                backgroundColor: context.color.hintContainer,
                onPressed: viewModel.rejoinPressed,
              ),

              /// Setting button
              settingButton: Button(
                icon: 'setting',
                onPressed: viewModel.settingPressed,
              ),

              /// Random matching button
              randomMatchingButton: Button(
                text: S.current.homeRandomQuickStart,
                size: ButtonSize.large,
                onPressed: () async {
                  final isSuccess = await viewModel.quickStart();
                  if (isSuccess && context.mounted) {
                    context.pushNamed(Routes.gamePage.name);
                  }
                },
              ),
            ),
          ),
        );
      },
    );
  }
}
