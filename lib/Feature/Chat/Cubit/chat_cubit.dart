// Cubit
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grad_project/Core/constants/api_consts.dart';
import 'package:grad_project/Feature/Chat/Cubit/chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  ChatCubit() : super(ChatInitial());

  Future<void> fetchConversations() async {
    emit(ChatLoading());
    try {
      final response = await Dio().get(
        '${ApiConsts.baseUrl}/conversation',
      );

      if (response.statusCode == 200) {
        final List<dynamic> conversations = response.data;
        print('Conversations loaded: $conversations');
        emit(ChatLoaded(conversations));
      } else {
        emit(ChatError('Failed to load conversations: ${response.statusCode}'));
      }
    } on DioException catch (e) {
      emit(ChatError('Error: ${e.message}'));
    } catch (e) {
      emit(ChatError('Unexpected error: $e'));
    }
  }

  // Method to get user details from a conversation
  Map<String, dynamic> getUserDetails(Map<String, dynamic> conversation) {
    return conversation['user'] ?? {};
  }

  // Method to get provider details from a conversation
  Map<String, dynamic> getProviderDetails(Map<String, dynamic> conversation) {
    return conversation['provider'] ?? {};
  }

  // Method to get conversation ID
  int getConversationId(Map<String, dynamic> conversation) {
    return conversation['id'] ?? 0;
  }
}
