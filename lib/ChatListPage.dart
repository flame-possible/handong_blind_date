import 'package:final_project/providers/profileProvider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:sendbird_sdk/sendbird_sdk.dart';

import 'ChatroomPage.dart';

class ChatListPage extends StatefulWidget {
  const ChatListPage({Key? key}) : super(key: key);

  @override
  State<ChatListPage> createState() => _ChatListPageState();
}

class _ChatListPageState extends State<ChatListPage> with ChannelEventHandler {
  late ProfileProvider _profileProvider;


  @override
  Widget build(BuildContext context) {
    _profileProvider = Provider.of<ProfileProvider>(context);
    SendbirdSdk().updateCurrentUserInfo(
      nickname: _profileProvider.propertyGeneral[0]['answer'],
      fileInfo: FileInfo.fromUrl(url: _profileProvider.profileImage.first),
    );

    return Scaffold(
      appBar: navigationBar(),
      body: body(context),
    );
  }

  Future<List<GroupChannel>> getGroupChannels() async {
    try {
      final query = GroupChannelListQuery()
        ..includeEmptyChannel = true
        ..order = GroupChannelListOrder.latestLastMessage
        ..limit = 15;
      return await query.loadNext();
    } catch (e) {
      print('ChatListPage: getGroupChannel: ERROR: $e');
      return [];
    }
  }

  @override
  void initState() {
    super.initState();
    SendbirdSdk().addChannelEventHandler('channel_list_view', this);
  }

  @override
  void dispose() {
    SendbirdSdk().removeChannelEventHandler("channel_list_view");
    super.dispose();
  }

  @override
  void onChannelChanged(BaseChannel channel) {
    setState(() {
      // Force the list future builder to rebuild.
    });
  }

  @override
  void onChannelDeleted(String channelUrl, ChannelType channelType) {
    setState(() {
      // Force the list future builder to rebuild.
    });
  }

  @override
  void onUserJoined(GroupChannel channel, User user) {
    setState(() {
      // Force the list future builder to rebuild.
    });
  }

  @override
  void onUserLeaved(GroupChannel channel, User user) {
    setState(() {
      // Force the list future builder to rebuild.
    });
    super.onUserLeaved(channel, user);
  }

  AppBar navigationBar() {
    return AppBar(
      automaticallyImplyLeading: true,
      centerTitle: true,
      leading: BackButton(color: Theme.of(context).iconTheme.color),
      title: const Text(
        'Chatrooms',
        style: TextStyle(color: Colors.black),
      ),
      actions: [
        Container(
          width: 60,
          padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
          child: TextButton(
              onPressed: () {
                Navigator.pushNamed(context, '/create_chat');
              },
              child: const Icon(Icons.add)),
        ),
      ],
    );
  }

  Widget body(BuildContext context) {
    return FutureBuilder(
      future: getGroupChannels(),
      builder: (context, snapshot) {
        if (snapshot.hasData == false || snapshot.data == null) {
          // Nothing to display yet - good place for a loading indicator
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: const [
              Text("Start matching and find a partner to chat!")
            ],
          );
        }

        List<GroupChannel> channels = snapshot.data as List<GroupChannel>;
        return ListView.builder(
            itemCount: channels.length,
            itemBuilder: (context, index) {
              GroupChannel channel = channels[index];
              Member member = channel.members.firstWhere(
                  (element) =>
                      !element.isCurrentUser,
                  orElse: () => Member(nickname: '', userId: '')); // 대화 상대
              bool noMessages = channel.lastMessage == null ? true : false;
              int? lastMessageTime = channel.lastMessage?.createdAt;
              return Padding(
                padding: EdgeInsets.all(10),
                child: Material(
                  elevation: 5,
                  color: Colors.transparent,
                  child: ListTile(
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    contentPadding: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                    tileColor: Colors.grey[200],
                    leading: CircleAvatar(
                      foregroundImage: NetworkImage(member.profileUrl!),
                      //backgroundColor: Colors.grey,
                      child: const Text(
                        "?",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    // Display all channel members as the title
                    title: Text(
                        member.nickname.isNotEmpty
                            ? member.nickname
                            : "The member left the chat",
                        style: const TextStyle(fontSize: 20)),
                    trailing: noMessages
                        ? Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: const [
                              Text(""),
                              Text("Start chatting!"),
                            ],
                          )
                        : Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              isYesterday(DateTime.fromMillisecondsSinceEpoch(
                                      lastMessageTime!))
                                  ? Text(DateFormat("MM-dd").format(
                                      DateTime.fromMillisecondsSinceEpoch(
                                          lastMessageTime)))
                                  : Text(DateFormat("h:mm a").format(
                                      DateTime.fromMillisecondsSinceEpoch(
                                          lastMessageTime))),
                              Text(channel.lastMessage?.message ?? ''),
                            ],
                          ),
                    onTap: () {
                      gotoChannel(channel.channelUrl);
                    },
                  ),
                ),
              );
            });
      },
    );
  }

  bool isYesterday(DateTime dt) {
    final yesterday = DateTime.now().subtract(Duration(days: 1));
    return yesterday.day == dt.day &&
        yesterday.month == dt.month &&
        yesterday.year == dt.year;
  }

  void gotoChannel(String channelUrl) {
    GroupChannel.getChannel(channelUrl).then((channel) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ChatroomPage(channel: channel),
        ),
      );
    }).catchError((e) {
      //handle error
      print('ChatListPage: gotoChannel: ERROR: $e');
    });
  }
}
