import 'package:avora/features/chats/presentation/cubits/presence_cubit/presence_state.dart';
import 'package:avora/features/profile/domain/use_cases/get_profile.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:avora/features/chats/data/data_source/presence_realtime_data_source.dart';

class PresenceCubit extends Cubit<PresenceState> {
  PresenceCubit({
    required this.presenceRealtimeDataSource,
    required this.getProfileUseCase,
  }) : super(const PresenceState());

  final PresenceRealtimeDataSource presenceRealtimeDataSource;
  final GetProfileUseCase getProfileUseCase;
  late String _currentUserId;

  Future<void> startListening({required String currentUserId}) async {
    _currentUserId = currentUserId;

    await presenceRealtimeDataSource.subscribe(
      userId: currentUserId,
      onUserOnline: _handleUserOnline,
      onUserOffline: _handleUserOffline,
    );
  }

  void _handleUserOnline(String userId) {
    // Ignore our own presence.
    if (userId == _currentUserId) {
      return;
    }

    // Ignore duplicate online events.
    if (state.onlineUserIds.contains(userId)) {
      return;
    }

    final updatedOnlineUsers = {...state.onlineUserIds, userId};

    emit(PresenceState(onlineUserIds: updatedOnlineUsers));
  }

  void _handleUserOffline(String userId) {
    if (userId == _currentUserId) {
      return;
    }

    if (!state.onlineUserIds.contains(userId)) {
      return;
    }

    final updatedOnlineUsers = {...state.onlineUserIds}..remove(userId);

    emit(
      PresenceState(
        onlineUserIds: updatedOnlineUsers,
        lastSeenAtByUserId: state.lastSeenAtByUserId,
      ),
    );

    _loadLastSeen(userId);
  }

  Future<void> _loadLastSeen(String userId) async {
    final profile = await getProfileUseCase(userId: userId);

    final currentProfile = profile.fold((l) => null, (r) => r!);

    if (currentProfile == null) return;
    final updatedLastSeen = {
      ...state.lastSeenAtByUserId,
      userId: currentProfile.lastSeenAt,
    };

    emit(
      PresenceState(
        onlineUserIds: state.onlineUserIds,
        lastSeenAtByUserId: updatedLastSeen,
      ),
    );
  }

  @override
  Future<void> close() async {
    await presenceRealtimeDataSource.unsubscribe();
    return super.close();
  }
}
