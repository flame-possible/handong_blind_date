import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sendbird_sdk/sendbird_sdk.dart';
import 'package:dash_chat/dash_chat.dart';

class ChatroomPage extends StatefulWidget {
  final GroupChannel channel;
  const ChatroomPage({Key? key, required this.channel}) : super(key: key);

  @override
  State<ChatroomPage> createState() => _ChatroomPageState();
}

class _ChatroomPageState extends State<ChatroomPage> with ChannelEventHandler {
  List<BaseMessage> _messages = [];
  @override
  void initState() {
    super.initState();
    getMessages(widget.channel);
    SendbirdSdk().addChannelEventHandler(widget.channel.channelUrl, this);
  }

  @override
  void dispose() {
    SendbirdSdk().removeChannelEventHandler(widget.channel.channelUrl);
    super.dispose();
  }

  @override
  onMessageReceived(channel, message) {
    setState(() {
      _messages.add(message);
    });
  }

  Future<void> getMessages(GroupChannel channel) async {
    try {
      List<BaseMessage> messages = await channel.getMessagesByTimestamp(
          DateTime.now().millisecondsSinceEpoch * 1000, MessageListParams());
      setState(() {
        _messages = messages;
      });
    } catch (e) {
      print('ChatroomPage.dart: getMessages: ERROR: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: navigationBar(widget.channel),
      body: body(context),
    );
  }

  AppBar navigationBar(GroupChannel channel) {
    Member member = channel.members.firstWhere(
        (element) => element.userId != SendbirdSdk().currentUser?.userId);

    return AppBar(
      automaticallyImplyLeading: true,
      centerTitle: false,
      leading: const BackButton(),
      title: Text(member.nickname),
      titleTextStyle: const TextStyle(
        color: Colors.black,
        fontSize: 20,
        fontWeight: FontWeight.normal,
      ),
      iconTheme: Theme.of(context).iconTheme,
      actions: [
        // 질문 리스트 버튼
        SizedBox(
          width: 40,
          child: PopupMenuButton(
            itemBuilder: (context) => [
              PopupMenuItem(
                child: Column(
                  children: const [
                    Text("Question suggestions"),
                    Text("1. ..."),
                    Text("2. ..."),
                  ],
                ),
              ),
            ],
            child: const Icon(Icons.sticky_note_2_outlined),
          ),
        ),
        // 알림 설정 버튼
        SizedBox(
          width: 40,
          child: TextButton(
            onPressed: () {
              print("clicked");
            },
            child: Icon(Icons.notifications, color: Colors.black),
          ),
        ),
        // 나가기 버튼
        SizedBox(
          width: 40,
          child: TextButton(
            onPressed: () {
              showExitDialog();
            },
            child: const Icon(Icons.exit_to_app, color: Colors.black),
          ),
        ),
      ],
    );
  }

  Widget body(BuildContext context) {
    ChatUser user = asDashChatUser(SendbirdSdk().currentUser!);
    return Padding(
      // A little breathing room for devices with no home button.
      padding: const EdgeInsets.fromLTRB(8, 8, 8, 8),
      child: DashChat(
        dateFormat: DateFormat("E, MMM d"),
        timeFormat: DateFormat.jm(),
        showUserAvatar: false,
        key: Key(widget.channel.channelUrl),
        onSend: (ChatMessage message) async {
          var sentMessage =
              widget.channel.sendUserMessageWithText(message.text!);
          setState(() {
            _messages.add(sentMessage);
          });
        },
        sendOnEnter: true,
        textInputAction: TextInputAction.send,
        user: user,
        messages: asDashChatMessages(_messages),
        inputDecoration: const InputDecoration(
            hintText: "Enter a message",
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(15)),
            ),
            contentPadding: EdgeInsets.all(10.0),
            isDense: true),
        messageDecorationBuilder: (ChatMessage msg, isUser) {
          return const BoxDecoration(
            color: Colors.grey,
            borderRadius: BorderRadius.all(Radius.circular(10)),
          );
        },
      ),
    );
  }

  List<ChatMessage> asDashChatMessages(List<BaseMessage> messages) {
    // BaseMessage is a Sendbird class
    // ChatMessage is a DashChat class
    List<ChatMessage> result = [];
    for (var message in messages) {
      User user = message.sender!;
      if (user == null) {
        continue;
      }
      result.add(
        ChatMessage(
          createdAt: DateTime.fromMillisecondsSinceEpoch(message.createdAt),
          text: message.message,
          user: asDashChatUser(user),
        ),
      );
    }
    return result;
  }

  ChatUser asDashChatUser(User user) {
    return ChatUser(
      name: user.nickname,
      uid: user.userId,
      avatar: user.profileUrl,
    );
  }

  void showExitDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: const [
              Text("All records will be deleted if you leave the chat."),
              Text("Do you want to leave the chat?"),
            ],
          ),
          actions: [
            TextButton(
                onPressed: () {
                  widget.channel.leave();
                  Navigator.pop(context);
                  Navigator.pop(context);
                },
                child: const Text("Exit")),
            TextButton(onPressed: () {}, child: const Text("Report and exit")),
            TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text("Cancel")),
          ],
        );
      },
    );
  }
}
