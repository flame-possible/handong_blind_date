import 'package:final_project/providers/profileProvider.dart';
import 'package:final_project/screens/navigator/home_page.dart';
import 'package:final_project/screens/navigator/setting_page.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:sendbird_sdk/sendbird_sdk.dart';

import '../../login_page.dart';
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
      automaticallyImplyLeading: false,
      title: const Text(
        '??????',
      ),
      actions: [
        IconButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Setting()),
            );
          },
          icon: Icon(Icons.settings),
          color: Colors.black,
        )
        /*
        Container(
          width: 60,
          padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
          child: TextButton(
              onPressed: () {
                Navigator.pushNamed(context, '/create_chat');
              },
              child: const Icon(Icons.add)),
        ),
        */
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
            children: [
              const Text("Start matching and find a partner to chat!"),
              startChat(),
            ],
          );
        }

        List<GroupChannel> channels = snapshot.data as List<GroupChannel>;
        return Container(
          child: Column(
            children: [
              Flexible(
                fit: FlexFit.tight,
                flex: 5,
                child: ListView.builder(
                  itemCount: channels.length,
                  itemBuilder: (context, index) {
                    GroupChannel channel = channels[index];
                    Member member = channel.members.firstWhere(
                            (element) => !element.isCurrentUser,
                        orElse: () =>
                            Member(nickname: '', userId: '')); // ?????? ??????
                    bool noMessages =
                    channel.lastMessage == null ? true : false;
                    int? lastMessageTime = channel.lastMessage?.createdAt;
                    return Padding(
                      padding: EdgeInsets.fromLTRB(
                          MediaQuery.of(context).size.width * (2 / 100),
                          MediaQuery.of(context).size.width * (2 / 100),
                          MediaQuery.of(context).size.width * (2 / 100),
                          MediaQuery.of(context).size.width * (2 / 100)),
                      child: Material(
                        elevation: 8,
                        color: Colors.transparent,
                        child: ListTile(
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 5, horizontal: 15),
                          tileColor: Color(0xFFF5F5F5),
                          leading: const CircleAvatar(
                            //???????????? ???????????? ???
                            //foregroundImage: NetworkImage(member.profileUrl!),
                            //backgroundColor: Colors.grey,
                            child: Text(
                              "?",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                          // Display all channel members as the title
                          title: Text(
                            //TODO ????????? nickname??? ???????????????, ???????????? ???????????? ????????? ???
                              member.nickname.isNotEmpty
                                  ? member.nickname
                                  : "Welcome",
                              style: const TextStyle(fontSize: 20)),
                          trailing: noMessages
                              ? Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Text(""),
                              Text("Start chatting!"),
                            ],
                          )
                              : Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              isYesterday(
                                  DateTime.fromMillisecondsSinceEpoch(
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
                  },
                ),
              ),
              Flexible(
                fit: FlexFit.loose,
                flex: 2,
                child: startChat(),
              ),
            ],
          ),
        );
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

  /**TODO ?????? ????????? ???????????? user ID??? ?????? ???????????? ????????? ?????? ?????????.
   * ## UserID??? ????????? ???????????? ???????????? ????????? ???????????? ????????? ?????? ???????????? User_id??? ???????????? ?????????????????? ????????? ??? ????????????.
   * ????????? ????????? ??? ?????? ????????? ????????????(??????????????? ????????????) ???????????? ??????????????????,
   * ????????? ???????????? Firebase??? ?????? update ??????????????????.
   */
  List<String> matchedList = ["y5jRmEftFCgNPvn9vu3rAzt2t3H3", "193895"];

  Container startChat() {
    return Container(
      child: ListView.builder(
          itemCount: can_chat.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: EdgeInsets.fromLTRB(
                MediaQuery.of(context).size.width * (2 / 100),
                MediaQuery.of(context).size.width * (2 / 100),
                MediaQuery.of(context).size.width * (2 / 100),
                MediaQuery.of(context).size.width * (2 / 100),
              ),
              child: Material(
                elevation: 8,
                color: Colors.transparent,
                child: InkWell(
                  child: ListTile(
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    contentPadding:
                    const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                    tileColor: Colors.grey[400],
                    title: Text(
                      "????????? ????????? \n${can_chat_nick[index]}\n?????? ????????? ???????????????",
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                  onTap: () {
                    List<String> temp = [
                      //?????? UserId
                      can_chat[index],
                      //??? UserId ?????????. ????????? ????????? ?????? ?????? ?????????????????????.
                      uid
                    ];
                    can_chat.removeAt(index);
                    createChannel(temp);
                  },
                ),
              ),
            );
          }),
    );
  }

  Future<GroupChannel> createChannel(List<String> userIds) async {
    try {
      final params = GroupChannelParams()..userIds = userIds;
      final channel = await GroupChannel.createChannel(params);
      print(userIds);
      return channel;
    } catch (e) {
      print('createChannel: ERROR: $e');
      throw e;
    }
  }
}
