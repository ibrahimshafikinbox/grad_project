import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ChatScreen extends StatefulWidget {
  final String userId;
  final String userName;
  final String userJob;
  final String userImage;

  const ChatScreen({
    Key? key,
    required this.userId,
    required this.userName,
    required this.userJob,
    required this.userImage,
  }) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _controller = TextEditingController();

  // الرسائل الستاتيك
  List<Map<String, dynamic>> messages = [
    {
      "isSender": false,
      "text": "Are we still good for tomorrow at 10 AM?",
      "time": "18:29"
    },
    {"isSender": true, "text": "Of course sir", "time": null},
    {
      "isSender": true,
      "text": "Tomorrow at 10 AM works perfectly.",
      "time": "18:30"
    },
    {
      "isSender": true,
      "text": "Could you confirm the address where we’ll be meeting?",
      "time": "14:40"
    },
    {
      "isSender": false,
      "text":
          "Sure! It’s Al–Gomhoria Street, Al–Noor Tower,\n3rd floor, Mansoura.",
      "time": "14:30"
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(),
            Expanded(child: _buildMessages()),
            _buildInputArea(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 4)],
      ),
      child: Row(
        children: [
          const Icon(Icons.arrow_back),
          const SizedBox(width: 12),
          CircleAvatar(
            radius: 24,
            backgroundImage: AssetImage(widget.userImage),
          ),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(widget.userName,
                  style: GoogleFonts.poppins(
                      fontSize: 16, fontWeight: FontWeight.w600)),
              Text(widget.userJob,
                  style: GoogleFonts.poppins(fontSize: 14, color: Colors.blue)),
            ],
          ),
          const Spacer(),
          const Icon(Icons.phone, color: Colors.grey),
        ],
      ),
    );
  }

  Widget _buildMessages() {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      itemCount: messages.length,
      itemBuilder: (context, index) {
        final message = messages[index];
        return message['isSender']
            ? _buildSenderMessage(message['text'], message['time'])
            : _buildReceiverMessage(message['text'], message['time']);
      },
    );
  }

  Widget _buildReceiverMessage(String text, String? time) {
    return Align(
      alignment: Alignment.centerRight,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Container(
            margin: const EdgeInsets.only(top: 8),
            padding: const EdgeInsets.all(12),
            constraints: const BoxConstraints(maxWidth: 260),
            decoration: BoxDecoration(
              color: const Color(0xFF0B63F8),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              text,
              style: GoogleFonts.poppins(color: Colors.white, fontSize: 14),
            ),
          ),
          if (time != null)
            Padding(
              padding: const EdgeInsets.only(top: 4, right: 4),
              child: Text(time,
                  style: GoogleFonts.poppins(fontSize: 11, color: Colors.grey)),
            ),
        ],
      ),
    );
  }

  Widget _buildSenderMessage(String text, String? time) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.only(top: 8),
            padding: const EdgeInsets.all(12),
            constraints: const BoxConstraints(maxWidth: 260),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: Colors.blue),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              text,
              style: GoogleFonts.poppins(fontSize: 14),
            ),
          ),
          if (time != null)
            Padding(
              padding: const EdgeInsets.only(top: 4, left: 4),
              child: Text(time,
                  style: GoogleFonts.poppins(fontSize: 11, color: Colors.grey)),
            ),
        ],
      ),
    );
  }

  Widget _buildInputArea() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: const BoxDecoration(
        color: Colors.white,
        boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 4)],
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _controller,
              style: GoogleFonts.poppins(fontSize: 14),
              decoration: InputDecoration(
                hintText: 'Type here...',
                hintStyle: GoogleFonts.poppins(),
                border: InputBorder.none,
              ),
            ),
          ),
          const Icon(Icons.mic, color: Colors.grey),
          const SizedBox(width: 12),
          GestureDetector(
            onTap: _sendMessage,
            child: CircleAvatar(
              backgroundColor: const Color(0xFF0B63F8),
              radius: 20,
              child: const Icon(Icons.send, color: Colors.white, size: 18),
            ),
          ),
        ],
      ),
    );
  }

  void _sendMessage() {
    final text = _controller.text.trim();
    if (text.isNotEmpty) {
      setState(() {
        messages.add({"isSender": true, "text": text, "time": "now"});
      });
      _controller.clear();
    }
  }
}

// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';

// class ChatScreen extends StatefulWidget {
//   final String userId;

//   const ChatScreen({
//     Key? key,
//     required this.userId,
//   }) : super(key: key);

//   @override
//   State<ChatScreen> createState() => _ChatScreenState();
// }

// class _ChatScreenState extends State<ChatScreen> {
//   @override
//   void initState() {
//     super.initState();
//     print(widget.userId);
//     // Fetch chat messages when the screen loads
//     // context.read<ChatCubit>().fetchChatMessages(widget.userId);
//   }

//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xFFF5F5F5),
//       body: SafeArea(
//         child: Column(
//           children: [
//             _buildHeader(),
//             Expanded(child: _buildMessages()),
//             _buildInputArea(),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildHeader() {
//     return Container(
//       padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 4)],
//       ),
//       child: Row(
//         children: [
//           const Icon(Icons.arrow_back),
//           const SizedBox(width: 12),
//           const CircleAvatar(
//             radius: 24,
//             backgroundImage:
//                 AssetImage('assets/img/person.png'), // Replace with your image
//           ),
//           const SizedBox(width: 12),
//           Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text('Mahmoud Talat',
//                   style: GoogleFonts.poppins(
//                       fontSize: 16, fontWeight: FontWeight.w600)),
//               Text('Carpenter',
//                   style: GoogleFonts.poppins(fontSize: 14, color: Colors.blue)),
//             ],
//           ),
//           const Spacer(),
//           const Icon(Icons.phone, color: Colors.grey),
//         ],
//       ),
//     );
//   }

//   Widget _buildMessages() {
//     return ListView(
//       padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
//       children: [
//         _buildDateLabel("22 July"),
//         _buildReceiverMessage(
//             "Are we still good for tomorrow at 10 AM?", "18:29"),
//         _buildSenderMessage("Of course sir", null),
//         _buildSenderMessage("Tomorrow at 10 AM works perfectly.", "18:30"),
//         _buildDateLabel("Today"),
//         _buildSenderMessage(
//             "Could you confirm the address where we’ll be meeting?", "14:40"),
//         _buildReceiverMessage(
//           "Sure! It’s Al–Gomhoria Street, Al–Noor Tower,\n3rd floor, Mansoura.",
//           "14:30",
//         ),
//       ],
//     );
//   }

//   Widget _buildDateLabel(String text) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 12),
//       child: Row(
//         children: [
//           const Expanded(child: Divider(thickness: 1)),
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 8),
//             child: Text(text,
//                 style: GoogleFonts.poppins(fontSize: 12, color: Colors.grey)),
//           ),
//           const Expanded(child: Divider(thickness: 1)),
//         ],
//       ),
//     );
//   }

//   Widget _buildReceiverMessage(String text, String? time) {
//     return Align(
//       alignment: Alignment.centerRight,
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.end,
//         children: [
//           Container(
//             margin: const EdgeInsets.only(top: 8),
//             padding: const EdgeInsets.all(12),
//             constraints: const BoxConstraints(maxWidth: 260),
//             decoration: BoxDecoration(
//               color: const Color(0xFF0B63F8),
//               borderRadius: BorderRadius.circular(12),
//             ),
//             child: Text(
//               text,
//               style: GoogleFonts.poppins(color: Colors.white, fontSize: 14),
//             ),
//           ),
//           if (time != null)
//             Padding(
//               padding: const EdgeInsets.only(top: 4, right: 4),
//               child: Text(time,
//                   style: GoogleFonts.poppins(fontSize: 11, color: Colors.grey)),
//             ),
//         ],
//       ),
//     );
//   }

//   Widget _buildSenderMessage(String text, String? time) {
//     return Align(
//       alignment: Alignment.centerLeft,
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Container(
//             margin: const EdgeInsets.only(top: 8),
//             padding: const EdgeInsets.all(12),
//             constraints: const BoxConstraints(maxWidth: 260),
//             decoration: BoxDecoration(
//               color: Colors.white,
//               border: Border.all(color: Colors.blue),
//               borderRadius: BorderRadius.circular(12),
//             ),
//             child: Text(
//               text,
//               style: GoogleFonts.poppins(fontSize: 14),
//             ),
//           ),
//           if (time != null)
//             Padding(
//               padding: const EdgeInsets.only(top: 4, left: 4),
//               child: Text(time,
//                   style: GoogleFonts.poppins(fontSize: 11, color: Colors.grey)),
//             ),
//         ],
//       ),
//     );
//   }

//   Widget _buildInputArea() {
//     return Container(
//       padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
//       decoration: const BoxDecoration(
//         color: Colors.white,
//         boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 4)],
//       ),
//       child: Row(
//         children: [
//           Expanded(
//             child: TextField(
//               style: GoogleFonts.poppins(fontSize: 14),
//               decoration: InputDecoration(
//                 hintText: 'Type here...',
//                 hintStyle: GoogleFonts.poppins(),
//                 border: InputBorder.none,
//               ),
//             ),
//           ),
//           const Icon(Icons.mic, color: Colors.grey),
//           const SizedBox(width: 12),
//           CircleAvatar(
//             backgroundColor: const Color(0xFF0B63F8),
//             radius: 20,
//             child: const Icon(Icons.send, color: Colors.white, size: 18),
//           ),
//         ],
//       ),
//     );
//   }
// }
// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:http/http.dart' as http;
// import 'package:image_picker/image_picker.dart';
// import 'dart:convert';
// import 'package:intl/intl.dart';

// class ChatScreen extends StatefulWidget {
//   final String currentUserId;
//   final String otherUserId;

//   const ChatScreen({
//     Key? key,
//     required this.currentUserId,
//     required this.otherUserId,
//   }) : super(key: key);

//   @override
//   State<ChatScreen> createState() => _ChatScreenState();
// }

// class _ChatScreenState extends State<ChatScreen> {
//   int? conversationId;
//   List<Map<String, dynamic>> messages = [];
//   final TextEditingController messageController = TextEditingController();
//   File? selectedImage;
//   final ScrollController _scrollController = ScrollController();

//   @override
//   void initState() {
//     super.initState();
//     initChat();
//   }

//   Future<void> initChat() async {
//     try {
//       conversationId = await getOrCreateConversation();
//       if (conversationId != null) {
//         await fetchMessages();
//         print('Chat initialized successfully.');
//       } else {
//         print('Failed to get or create conversation.');
//       }
//     } catch (e) {
//       print('Error in initChat: $e');
//     }
//   }

//   Future<int?> getOrCreateConversation() async {
//     try {
//       final uri = Uri.parse(
//           'https://1f15-156-221-49-37.ngrok-free.app/api/conversation');
//       final response = await http.post(uri, body: {
//         'user_id': widget.currentUserId,
//         'provider_id': widget.otherUserId,
//       });

//       if (response.statusCode == 200) {
//         final data = jsonDecode(response.body);
//         print('Conversation fetched/created successfully.');
//         return data['conversation']['id'];
//       } else {
//         print(
//             'Failed to get or create conversation. Status: ${response.statusCode}');
//       }
//     } catch (e) {
//       print('Error in getOrCreateConversation: $e');
//     }
//     return null;
//   }

//   Future<void> fetchMessages() async {
//     if (conversationId == null) {
//       print('Cannot fetch messages: conversationId is null');
//       return;
//     }

//     try {
//       final uri = Uri.parse(
//         'https://1f15-156-221-49-37.ngrok-free.app/api/messages?conversation_id=$conversationId',
//       );
//       final response = await http.get(uri);

//       if (response.statusCode == 200) {
//         print('Messages fetched successfully');
//         final List data = jsonDecode(response.body);
//         setState(() {
//           messages = List<Map<String, dynamic>>.from(data.reversed);
//         });
//         WidgetsBinding.instance.addPostFrameCallback((_) {
//           _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
//         });
//       } else {
//         print('Failed to fetch messages. Status: ${response.statusCode}');
//       }
//     } catch (e) {
//       print('Error in fetchMessages: $e');
//     }
//   }

//   Future<void> sendMessage() async {
//     if (messageController.text.trim().isEmpty && selectedImage == null) return;

//     try {
//       final uri =
//           Uri.parse('https://1f15-156-221-49-37.ngrok-free.app/api/message');
//       final request = http.MultipartRequest('POST', uri);

//       request.fields['sender_id'] = widget.currentUserId;
//       request.fields['receiver_id'] = widget.otherUserId;
//       request.fields['message'] = messageController.text;
//       request.fields['sent_at'] = DateTime.now().toString();
//       request.fields['is_read'] = 'false';

//       if (selectedImage != null) {
//         request.files.add(
//             await http.MultipartFile.fromPath('image', selectedImage!.path));
//       }

//       final response = await request.send();

//       if (response.statusCode == 200) {
//         print('Message sent successfully');
//         messageController.clear();
//         selectedImage = null;
//         await fetchMessages();
//       } else {
//         print('Failed to send message. Status: ${response.statusCode}');
//       }
//     } catch (e) {
//       print('Error in sendMessage: $e');
//     }
//   }

//   Future<void> pickImage() async {
//     final picker = ImagePicker();
//     final pickedFile = await picker.pickImage(source: ImageSource.gallery);

//     if (pickedFile != null) {
//       setState(() {
//         selectedImage = File(pickedFile.path);
//       });
//     }
//   }

//   String _formatDate(DateTime date) {
//     final now = DateTime.now();
//     if (date.year == now.year &&
//         date.month == now.month &&
//         date.day == now.day) {
//       return 'Today';
//     }
//     return DateFormat('d MMMM').format(date);
//   }

//   String _formatTime(DateTime date) {
//     return DateFormat('HH:mm').format(date);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xFFF5F5F5),
//       body: SafeArea(
//         child: Column(
//           children: [
//             _buildHeader(),
//             Expanded(
//               child: ListView(
//                 controller: _scrollController,
//                 padding:
//                     const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
//                 children: _buildMessageList(),
//               ),
//             ),
//             if (selectedImage != null) _buildImagePreview(),
//             _buildInputArea(),
//           ],
//         ),
//       ),
//     );
//   }

//   List<Widget> _buildMessageList() {
//     List<Widget> widgets = [];
//     DateTime? previousDate;

//     for (var message in messages) {
//       final sentAt = DateTime.parse(message['sent_at']);
//       final currentDate = _formatDate(sentAt);

//       if (previousDate != currentDate) {
//         widgets.add(_buildDateLabel(currentDate));
//         previousDate = currentDate as DateTime?;
//       }

//       widgets.add(
//         message['sender_id'].toString() == widget.currentUserId
//             ? _buildSenderMessage(
//                 message['message'],
//                 _formatTime(sentAt),
//                 message['image'],
//               )
//             : _buildReceiverMessage(
//                 message['message'],
//                 _formatTime(sentAt),
//                 message['image'],
//               ),
//       );
//     }

//     return widgets;
//   }

//   Widget _buildHeader() {
//     return Container(
//       padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 4)],
//       ),
//       child: Row(
//         children: [
//           const Icon(Icons.arrow_back),
//           const SizedBox(width: 12),
//           const CircleAvatar(
//             radius: 24,
//             backgroundImage: AssetImage('assets/img/person.png'),
//           ),
//           const SizedBox(width: 12),
//           Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text('Mahmoud Talat',
//                   style: GoogleFonts.poppins(
//                       fontSize: 16, fontWeight: FontWeight.w600)),
//               Text('Carpenter',
//                   style: GoogleFonts.poppins(fontSize: 14, color: Colors.blue)),
//             ],
//           ),
//           const Spacer(),
//           const Icon(Icons.phone, color: Colors.grey),
//         ],
//       ),
//     );
//   }

//   Widget _buildDateLabel(String text) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 12),
//       child: Row(
//         children: [
//           const Expanded(child: Divider(thickness: 1)),
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 8),
//             child: Text(text,
//                 style: GoogleFonts.poppins(fontSize: 12, color: Colors.grey)),
//           ),
//           const Expanded(child: Divider(thickness: 1)),
//         ],
//       ),
//     );
//   }

//   Widget _buildReceiverMessage(String? text, String? time, String? imageUrl) {
//     return Align(
//       alignment: Alignment.centerRight,
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.end,
//         children: [
//           if (imageUrl != null)
//             Container(
//               margin: const EdgeInsets.only(top: 8),
//               child: ClipRRect(
//                 borderRadius: BorderRadius.circular(12),
//                 child: Image.network(imageUrl, height: 150),
//               ),
//             ),
//           if (text != null && text.isNotEmpty)
//             Container(
//               margin: const EdgeInsets.only(top: 8),
//               padding: const EdgeInsets.all(12),
//               constraints: const BoxConstraints(maxWidth: 260),
//               decoration: BoxDecoration(
//                 color: const Color(0xFF0B63F8),
//                 borderRadius: BorderRadius.circular(12),
//               ),
//               child: Text(
//                 text,
//                 style: GoogleFonts.poppins(color: Colors.white, fontSize: 14),
//               ),
//             ),
//           if (time != null)
//             Padding(
//               padding: const EdgeInsets.only(top: 4, right: 4),
//               child: Text(time,
//                   style: GoogleFonts.poppins(fontSize: 11, color: Colors.grey)),
//             ),
//         ],
//       ),
//     );
//   }

//   Widget _buildSenderMessage(String? text, String? time, String? imageUrl) {
//     return Align(
//       alignment: Alignment.centerLeft,
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           if (imageUrl != null)
//             Container(
//               margin: const EdgeInsets.only(top: 8),
//               child: ClipRRect(
//                 borderRadius: BorderRadius.circular(12),
//                 child: Image.network(imageUrl, height: 150),
//               ),
//             ),
//           if (text != null && text.isNotEmpty)
//             Container(
//               margin: const EdgeInsets.only(top: 8),
//               padding: const EdgeInsets.all(12),
//               constraints: const BoxConstraints(maxWidth: 260),
//               decoration: BoxDecoration(
//                 color: Colors.white,
//                 border: Border.all(color: Colors.blue),
//                 borderRadius: BorderRadius.circular(12),
//               ),
//               child: Text(
//                 text,
//                 style: GoogleFonts.poppins(fontSize: 14),
//               ),
//             ),
//           if (time != null)
//             Padding(
//               padding: const EdgeInsets.only(top: 4, left: 4),
//               child: Text(time,
//                   style: GoogleFonts.poppins(fontSize: 11, color: Colors.grey)),
//             ),
//         ],
//       ),
//     );
//   }

//   Widget _buildImagePreview() {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//       child: Stack(
//         alignment: Alignment.topRight,
//         children: [
//           ClipRRect(
//             borderRadius: BorderRadius.circular(12),
//             child: Image.file(selectedImage!, height: 100),
//           ),
//           IconButton(
//             icon: const Icon(Icons.close, color: Colors.white),
//             onPressed: () => setState(() => selectedImage = null),
//           )
//         ],
//       ),
//     );
//   }

//   Widget _buildInputArea() {
//     return Container(
//       padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
//       decoration: const BoxDecoration(
//         color: Colors.white,
//         boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 4)],
//       ),
//       child: Row(
//         children: [
//           IconButton(
//             icon: const Icon(Icons.image, color: Colors.grey),
//             onPressed: pickImage,
//           ),
//           Expanded(
//             child: TextField(
//               controller: messageController,
//               style: GoogleFonts.poppins(fontSize: 14),
//               decoration: InputDecoration(
//                 hintText: 'Type here...',
//                 hintStyle: GoogleFonts.poppins(),
//                 border: InputBorder.none,
//               ),
//             ),
//           ),
//           CircleAvatar(
//             backgroundColor: const Color(0xFF0B63F8),
//             radius: 20,
//             child: IconButton(
//               icon: const Icon(Icons.send, color: Colors.white, size: 18),
//               onPressed: sendMessage,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
