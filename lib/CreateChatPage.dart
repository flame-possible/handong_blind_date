import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sendbird_sdk/sendbird_sdk.dart';

import 'ChatroomPage.dart';

class CreateChatPage extends StatefulWidget {
  const CreateChatPage({Key? key}) : super(key: key);

  @override
  State<CreateChatPage> createState() => _CreateChatPageState();
}

class _CreateChatPageState extends State<CreateChatPage> {
  final Set<User> _selectedUsers = {};
  final List<User> _availableUsers = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.white,
      appBar: navigationBar(),
      body: body(context),
    );
  }

  Future<List<User>> getUsers() async {
    try {
      final query = ApplicationUserListQuery();
      List<User> users = await query.loadNext();
      return users;
    } catch (e) {
      print('CreateChatPage: getUsers: ERROR: $e');
      return [];
    }
  }

  Future<GroupChannel> createChannel(List<String> userIds) async {
    try {
      final params = GroupChannelParams()..userIds = userIds;
      final channel = await GroupChannel.createChannel(params);
      return channel;
    } catch (e) {
      print('createChannel: ERROR: $e');
      throw e;
    }
  }

  @override
  void initState() {
    super.initState();
    getUsers().then((users) {
      setState(() {
        _availableUsers.clear();
        _availableUsers.addAll(users);
      });
    }).catchError((e) {
      print('initState: ERROR: $e');
    });
  }

  AppBar navigationBar() {
    return AppBar(
      automaticallyImplyLeading: true,
      backgroundColor: Colors.white,
      centerTitle: true,
      leading: BackButton(color: Theme.of(context).buttonColor),
      title: const Text(
        'Select members',
        style: TextStyle(color: Colors.black),
      ),
      actions: [
        TextButton(
          style: ButtonStyle(
              foregroundColor: MaterialStateProperty.all<Color>(
                  Theme.of(context).buttonColor)),
          onPressed: () {
            if (_selectedUsers.toList().length < 1) {
              // Don't create a channel if there isn't another user selected
              return;
            }
            createChannel(
                    [for (final user in _selectedUsers.toList()) user.userId])
                .then((channel) {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => ChatroomPage(channel: channel),
                ),
              );
            }).catchError((error) {
              print(
                  'CreateChatPage: navigationBar: createChannel: ERROR: $error');
            });
          },
          child: Text(
            "Create",
            style: TextStyle(
              fontSize: 20.0,
              color: Theme.of(context).primaryColor,
            ),
          ),
        )
      ],
    );
  }

  Widget body(BuildContext context) {
    return ListView.builder(
        itemCount: _availableUsers.length,
        itemBuilder: (context, index) {
          User user = _availableUsers[index];
          var profUrl = user.profileUrl;
          return CheckboxListTile(
            title: Text(user.nickname.isEmpty ? user.userId : user.nickname,
                style: TextStyle(color: Colors.black)),
            controlAffinity: ListTileControlAffinity.platform,
            value: _selectedUsers.contains(user),
            // value: SendbirdSdk().currentUser.userId == user.userId,
            activeColor: Theme.of(context).primaryColor,
            onChanged: (value) {
              // Using a set to store which users we want to create
              // a channel with.
              setState(() {
                if (value! && value) {
                  _selectedUsers.add(user);
                } else {
                  _selectedUsers.remove(user);
                }
                print(
                    'CreateChatPage: on change for: ${user.nickname} _selectedUsers: $_selectedUsers');
              });
            },
            secondary: (profUrl != null && profUrl.isEmpty)
                ? CircleAvatar(
                    child: Text(
                    (user.nickname.isEmpty ? user.userId : user.nickname)
                        .substring(0, 1)
                        .toUpperCase(),
                  ))
                : CircleAvatar(
                    backgroundImage: NetworkImage(profUrl!),
                  ),
          );
        });
  }
}
