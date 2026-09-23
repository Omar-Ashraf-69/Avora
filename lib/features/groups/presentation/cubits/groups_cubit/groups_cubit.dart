import 'package:avora/core/di/dependecny_injection.dart';
import 'package:avora/features/auth/domain/repos/auth_repo.dart';
import 'package:avora/features/chats/data/data_source/message_realtime_data_source.dart';
import 'package:avora/features/chats/data/models/message_model.dart';
import 'package:avora/features/chats/domain/entities/message_entity.dart';
import 'package:avora/features/groups/data/data_sources/user_real_time_data_source.dart';
import 'package:avora/features/groups/domain/entities/group_list_entity.dart';
import 'package:avora/features/groups/domain/use_case/get_groups_use_case.dart';
import 'package:avora/features/groups/presentation/cubits/groups_cubit/groups_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class GroupsCubit extends Cubit<GroupsState> {
  GroupsCubit({
    required this.getGroupsUseCase,
    required this.messageRealtimeDataSource,
    required this.userRealtimeDataSource,
  }) : super(const GroupsInitial());

  final GetGroupsUseCase getGroupsUseCase;
  final MessageRealtimeDataSource messageRealtimeDataSource;
  final UserRealtimeDataSource userRealtimeDataSource;

  // ------------------------------------------------------------------
  // INITIALIZE
  // ------------------------------------------------------------------

  Future<void> initialize() async {
    await loadGroups();

    if (isClosed) return;

    subscribeToGroups();

    final currentUser = getIt<AuthRepository>().getCurrentUser();

    if (currentUser == null || isClosed) return;

    await userRealtimeDataSource.subscribe(
      userId: currentUser.id,
      onGroupAdded: _onGroupAdded,
    );
  }

  void _onGroupAdded(String conversationId) {
    print('🆕 GroupsCubit: New group received: $conversationId');

    loadGroups();
  }

  Future<void> testNewGroupMessages() async {
    final supabaseClient = getIt<SupabaseClient>();

    final response = await supabaseClient
        .from('messages')
        .select()
        .eq('conversation_id', '98ddd3c1-5f17-46f8-9075-ca49594dfe4f')
        .order('created_at');

    print('🔍 NEW GROUP MESSAGE TEST: $response');
  }
  // ------------------------------------------------------------------
  // LOAD GROUPS
  // ------------------------------------------------------------------

  Future<void> loadGroups() async {
    print('🔄 GroupsCubit: loadGroups()');

    emit(const GroupsLoading());

    final result = await getGroupsUseCase();

    if (isClosed) {
      return;
    }

    result.fold(
      (failure) {
        print('❌ getGroups failed: ${failure.message}');

        emit(GroupsFailure(message: failure.message));
      },
      (groups) {
        print('✅ getGroups returned ${groups.length} groups');

        for (final group in groups) {
          print(
            '👥 GROUP: ${group.name} | '
            'conversationId: ${group.conversationId} | '
            'avatar: ${group.avatarUrl}',
          );
        }

        messageRealtimeDataSource.updateConversationIds(
          groups.map((group) => group.conversationId).toList(),
        );

        emit(GroupsLoaded(groups: groups));
      },
    );
  }

  // ------------------------------------------------------------------
  // SUBSCRIBE TO GROUP REALTIME
  // ------------------------------------------------------------------

  void subscribeToGroups() {
    print('🟢 GroupsCubit: subscribeToGroups()');

    final currentState = state;

    final conversationIds = currentState is GroupsLoaded
        ? currentState.groups.map((group) => group.conversationId).toList()
        : <String>[];

    messageRealtimeDataSource.subscribeToConversations(
      conversationIds: conversationIds,
      onMessageInserted: _onMessageInserted,
      onMessageUpdated: _onMessageUpdated,
      onMessageDeleted: _onMessageDeleted,
    );
  }

  // ------------------------------------------------------------------
  // MESSAGE INSERTED
  // ------------------------------------------------------------------
  void _onMessageInserted(MessageModel message) {
    final currentState = state;

    if (currentState is! GroupsLoaded) {
      return;
    }

    final groups = [...currentState.groups];

    final index = groups.indexWhere(
      (group) => group.conversationId == message.conversationId,
    );

    // Unknown conversation.
    //
    // A system message can mean that the current user
    // has just been added to a new group.
    if (index == -1) {
      if (message.type == MessageType.system) {
        print('🆕 GroupsCubit: System message from unknown conversation');

        loadGroups();
      }

      return;
    }

    // Existing group conversation.
    final currentGroup = groups[index];

    final updatedGroup = GroupListItemEntity(
      conversationId: currentGroup.conversationId,
      groupId: currentGroup.groupId,
      name: currentGroup.name,
      avatarUrl: currentGroup.avatarUrl,
      lastMessage: message.content,
      lastMessageAt: message.createdAt,
      lastMessageSenderId: message.senderId,
      lastMessageType: message.type,
      unreadCount: currentGroup.unreadCount,
    );

    groups.removeAt(index);
    groups.insert(0, updatedGroup);

    emit(GroupsLoaded(groups: groups));
  }

  // ------------------------------------------------------------------
  // MESSAGE UPDATED
  // ------------------------------------------------------------------

  void _onMessageUpdated(MessageModel message) {
    // Handle later if your application needs
    // message-update handling in the groups list.
  }

  // ------------------------------------------------------------------
  // MESSAGE DELETED
  // ------------------------------------------------------------------

  void _onMessageDeleted(String messageId) {
    // Handle later if your application needs
    // message-delete handling in the groups list.
  }

  // ------------------------------------------------------------------
  // CLOSE
  // ------------------------------------------------------------------

  @override
  Future<void> close() async {
    await messageRealtimeDataSource.unsubscribeFromConversations();
    await userRealtimeDataSource.unsubscribe();

    return super.close();
  }
}
