import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grad_project/Core/Helper/naviagation_helper.dart';
import 'package:grad_project/Feature/Chat/Cubit/chat_cubit.dart';
import 'package:grad_project/Feature/Chat/Cubit/chat_state.dart';
import 'package:grad_project/Feature/Chat/View/chat_view.dart';

class ChatListView extends StatefulWidget {
  const ChatListView({super.key});

  @override
  State<ChatListView> createState() => _ChatListViewState();
}

class _ChatListViewState extends State<ChatListView> {
  @override
  void initState() {
    super.initState();
    context.read<ChatCubit>().fetchConversations();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: BlocBuilder<ChatCubit, ChatState>(
          builder: (context, state) {
            if (state is ChatLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is ChatError) {
              return Center(child: Text(state.message));
            } else if (state is ChatLoaded) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                    child: Text(
                      'Messages',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Color(0xff00296B),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'Search Chats',
                        prefixIcon: const Icon(Icons.search),
                        filled: true,
                        fillColor: Colors.grey[200],
                        contentPadding: const EdgeInsets.all(12),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Expanded(
                    child: ListView.separated(
                      itemCount: state.conversations.length,
                      separatorBuilder: (_, __) =>
                          const Divider(indent: 80, height: 0),
                      itemBuilder: (context, index) {
                        final conversation = state.conversations[index];
                        final user = conversation['user'];
                        final provider = conversation['provider'];

                        return ListTile(
                          leading: CircleAvatar(
                            radius: 28,
                            backgroundImage: NetworkImage(
                                user['profile_picture'] ??
                                    'https://via.placeholder.com/150'),
                          ),
                          title: Text(
                            '${user['firstname']} ${user['lastname']}',
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                provider['bio'] ?? 'Service Provider',
                                style: const TextStyle(
                                  color: Colors.blue,
                                  fontSize: 12,
                                ),
                              ),
                              const SizedBox(height: 4),
                              const Text(
                                'Tap to start chatting',
                                style: TextStyle(color: Colors.grey),
                              ),
                            ],
                          ),
                          onTap: () {
                            final userId = user['provider_id'] ?? '';
                            print(userId);
                            navigateTo(
                              context,
                              ChatScreen(
                                  userId: userId,
                                  userName:
                                      '${user['firstname']} ${user['lastname']}',
                                  userJob: '',
                                  userImage: user['profile_picture'] ??
                                      'https://via.placeholder.com/150'),
                            );
                          },
                        );
                      },
                    ),
                  ),
                ],
              );
            }
            return const Center(child: Text('No conversations found'));
          },
        ),
      ),
    );
  }
}
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:grad_project/Core/Helper/naviagation_helper.dart';
// import 'package:grad_project/Feature/Chat/Cubit/chat_cubit.dart';
// import 'package:grad_project/Feature/Chat/Cubit/chat_state.dart';
// import 'package:grad_project/Feature/Chat/View/chat_view.dart';

// class ChatListView extends StatefulWidget {
//   const ChatListView({super.key});

//   @override
//   State<ChatListView> createState() => _ChatListViewState();
// }

// class _ChatListViewState extends State<ChatListView> {
//   @override
//   void initState() {
//     super.initState();
//     context.read<ChatCubit>().fetchConversations();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: SafeArea(
//         child: BlocBuilder<ChatCubit, ChatState>(
//           builder: (context, state) {
//             if (state is ChatLoading) {
//               return const Center(child: CircularProgressIndicator());
//             } else if (state is ChatError) {
//               return Center(child: Text(state.message));
//             } else if (state is ChatLoaded) {
//               return Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   const Padding(
//                     padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
//                     child: Text(
//                       'Messages',
//                       style: TextStyle(
//                         fontSize: 24,
//                         fontWeight: FontWeight.bold,
//                         color: Color(0xff00296B),
//                       ),
//                     ),
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.symmetric(horizontal: 16),
//                     child: TextField(
//                       decoration: InputDecoration(
//                         hintText: 'Search Chats',
//                         prefixIcon: const Icon(Icons.search),
//                         filled: true,
//                         fillColor: Colors.grey[200],
//                         contentPadding: const EdgeInsets.all(12),
//                         border: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(16),
//                           borderSide: BorderSide.none,
//                         ),
//                       ),
//                     ),
//                   ),
//                   const SizedBox(height: 12),
//                   Expanded(
//                     child: ListView.separated(
//                       itemCount: state.conversations.length,
//                       separatorBuilder: (_, __) =>
//                           const Divider(indent: 80, height: 0),
//                       itemBuilder: (context, index) {
//                         final conversation = state.conversations[index];
//                         final user = conversation['user'];
//                         final provider = conversation['provider'];

//                         // Safely get the user ID (check both user and provider)
//                         final userId = user['user_id'];

//                         return ListTile(
//                             leading: CircleAvatar(
//                               radius: 28,
//                               backgroundImage: NetworkImage(
//                                 user['profile_picture'] ??
//                                     'https://via.placeholder.com/150',
//                               ),
//                             ),
//                             title: Text(
//                               '${user['firstname']} ${user['lastname']}',
//                               style: const TextStyle(
//                                 fontWeight: FontWeight.bold,
//                               ),
//                             ),
//                             subtitle: Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Text(
//                                   provider['bio'] ?? 'Service Provider',
//                                   style: const TextStyle(
//                                     color: Colors.blue,
//                                     fontSize: 12,
//                                   ),
//                                 ),
//                                 const SizedBox(height: 4),
//                                 const Text(
//                                   'Tap to start chatting',
//                                   style: TextStyle(color: Colors.grey),
//                                 ),
//                               ],
//                             ),
//                             onTap: () {
//                               final userId = user[
//                                   'user_id']; // make sure this is correct for your app logic
//                               if (userId != null) {
//                                 print(userId);
//                                 navigateTo(
//                                     context,
//                                     ChatScreen(
//                                       currentUserId: '2',
//                                       otherUserId: '1',
//                                     ));
//                               } else {
//                                 print('! Error: userId is null');
//                               }
//                             });
//                       },
//                     ),
//                   ),
//                 ],
//               );
//             }
//             return const Center(child: Text('No conversations found'));
//           },
//         ),
//       ),
//     );
//   }
// }
