import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// States
abstract class ChatState {}

class ChatInitial extends ChatState {}

class ChatLoading extends ChatState {}

class ChatLoaded extends ChatState {
  final List<dynamic> conversations;
  ChatLoaded(this.conversations);
}

class ChatError extends ChatState {
  final String message;
  ChatError(this.message);
}
