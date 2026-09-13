
import 'package:avora/features/chats/data/data_source/mark_pending_messages_as_delivered_use_case.dart';
import 'package:avora/features/chats/data/data_source/message_delivery_realtime_data_source.dart';
import 'package:avora/features/chats/domain/use_case/mark_conversation_as_delivered.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MessageDeliveryCubit extends Cubit<void> {
  MessageDeliveryCubit({
    required this.messageDeliveryRealtimeDataSource,
    required this.markConversationAsDeliveredUseCase,
    required this.currentUserId, required this.markPendingMessagesAsDeliveredUseCase,
  }) : super(null);

  final MessageDeliveryRealtimeDataSource messageDeliveryRealtimeDataSource;

  final MarkConversationAsDeliveredUseCase markConversationAsDeliveredUseCase;
final MarkPendingMessagesAsDeliveredUseCase
    markPendingMessagesAsDeliveredUseCase;
  final String currentUserId;

  void startListening() {
    messageDeliveryRealtimeDataSource.subscribe(
      onMessageReceived: ({required conversationId, required senderId}) {
        _handleIncomingMessage(
          conversationId: conversationId,
          senderId: senderId,
        );
      },
    );
      _markPendingMessagesAsDelivered();

  }
  Future<void> _markPendingMessagesAsDelivered() async {
    await markPendingMessagesAsDeliveredUseCase();
  }

  Future<void> _handleIncomingMessage({
    required String conversationId,
    required String senderId,
  }) async {
    // Ignore messages sent by the current user.
    if (senderId == currentUserId) return;

    await markConversationAsDeliveredUseCase(conversationId: conversationId);
  }

  @override
  Future<void> close() async {
    await messageDeliveryRealtimeDataSource.unsubscribe();

    return super.close();
  }
}
