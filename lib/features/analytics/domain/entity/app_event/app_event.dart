import 'package:flutter/material.dart';
import 'package:x_pr/app/routes/routes.dart';
import 'package:x_pr/features/config/domain/entities/language.dart';
import 'package:x_pr/features/game/domain/entities/game_reaction.dart';
import 'package:x_pr/features/game/domain/entities/game_state/game_state.dart';
import 'package:x_pr/features/game/domain/entities/game_step.dart';

part 'app_event_screen.dart';
part 'screens/edit_nickname/edit_nickname_page_event.dart';
part 'screens/game/drawing_page_event.dart';
part 'screens/game/game_exit_dialog_event.dart';
part 'screens/game/guess_page_event.dart';
part 'screens/game/quick_start_waiting_page_event.dart';
part 'screens/game/ready_page_event.dart';
part 'screens/game/result_page_event.dart';
part 'screens/game/voting_event.dart';
part 'screens/game/waiting_page_event.dart';
part 'screens/home/home_page_event.dart';
part 'screens/home/notice_dialog_event.dart';
part 'screens/join/join_page_event.dart';
part 'screens/license/license_detail_page_event.dart';
part 'screens/license/license_page_event.dart';
part 'screens/nickname/nickname_page_event.dart';
part 'screens/setting/language_bottom_sheet_event.dart';
part 'screens/setting/setting_page_event.dart';
part 'screens/splash/maintenance_dialog_event.dart';
part 'screens/splash/splash_page_event.dart';
part 'screens/splash/update_dialog_event.dart';

sealed class AppEvent {
  const AppEvent(this.screen);

  final AppEventScreen screen;

  Map<String, Object> toJson() => {};
}
