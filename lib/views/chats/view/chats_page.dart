import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../app/router/route_name.dart';
import '../../../app/utils/time_ago.dart';
import '../../../models/messages.dart';
import '../../../models/user_model.dart';
import '../../widget/big_text.dart';
import '../../widget/search_widget.dart';
import '../../widget/small_text.dart';

class ChatsPage extends StatefulWidget {
  const ChatsPage({Key? key, required this.listUser, required this.listMess}) : super(key: key);

  final List<UserModel> listUser;
  final List<MessagesModel> listMess;

  @override
  State<ChatsPage> createState() => _ChatsPageState();
}

class _ChatsPageState extends State<ChatsPage> {
  String query = '';
  late ValueChanged<String> onChanged;
  List<UserModel>? listUser = [];
  String isYour = '';

  @override
  void initState(){
    super.initState();
    listUser = widget.listUser;
  }
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(

      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.green,
        centerTitle: true,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            BigText(
              text: "Chats",
              color: Colors.white,
              fontSize: size.height * 0.022,
            ),
            SearchWidget(
              widthWidget: size.height * 0.2,
              text: query,
              hintText: 'Search NameUser',
              onChanged: searchBook,
            ),
          ],
        ),
        actions: [
          Stack(
            children: [
              IconButton(
                  onPressed: () {
                    /*Get.to(NotificationPage(),
                        transition: Transition.cupertino);*/
                  },
                  icon: Icon(
                    Icons.notifications_active,
                    color: Colors.white,
                  )),
              Positioned(
                right: 0,
                top: 0,
                child: CircleAvatar(
                  maxRadius: size.height * 0.01,
                  backgroundColor: Colors.red,
                  child: SmallText(
                      text: "1",
                      color: Colors.white),
                ),
              )

            ],
          )
        ],
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: size.height * 0.02,
            vertical: size.height * 0.01),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                  itemCount: listUser!.length,
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (context, index) {
                    if(getLastMessPeople(widget.listMess, 1).idSend == 1){
                      isYour = 'Bạn: ';
                    }else{
                      isYour = '';
                    }
                    return GestureDetector(
                      onTap: () => Navigator.pushNamed(
                          context, RouteName.messaging,
                          arguments: demo_listUser[index]),
                      child: Container(
                        margin: EdgeInsets.only(
                            bottom: size.height * 0.02),
                        child: Row(
                          crossAxisAlignment:
                          CrossAxisAlignment.center,
                          children: [
                            Stack(
                              children: [
                                listUser![index].image == ""
                                    ? CircleAvatar(
                                  backgroundColor:
                                  Colors.black,
                                  minRadius: size.height * 0.025,
                                  backgroundImage:
                                  AssetImage(
                                    "assets/images/a2.png",
                                  ),
                                )
                                    : CircleAvatar(
                                  backgroundColor:
                                  Colors.black,
                                  minRadius: size.height * 0.025,
                                  backgroundImage:
                                  AssetImage(widget.listUser[index].image!),
                                ),
                                Positioned(
                                    right: 0,
                                    bottom: 0,
                                    child: Icon(
                                      Icons.circle,
                                      color: Colors.green,
                                      size:
                                      size.height * 0.016,
                                    )),
                              ],
                            ),
                            SizedBox(
                              width: size.height * 0.01,
                            ),
                            Column(
                              crossAxisAlignment:
                              CrossAxisAlignment.start,
                              mainAxisAlignment:
                              MainAxisAlignment
                                  .spaceBetween,
                              children: [
                                BigText(
                                  text: listUser![index]
                                      .name!,
                                  color: Colors.black,
                                ),
                                SizedBox(
                                  height: size.height * 0.005,
                                ),
                                /*messagesController
                                    .getMissMessaging(
                                    listMessages![
                                    index]
                                        .id!) >
                                    0
                                    ? BigText(
                                  text: isYour+messagesController
                                      .getLastMessPeople(
                                      listMessages![
                                      index]
                                          .id!).messaging!,
                                  color: Colors.black,
                                )
                                    : SmallText(
                                  text: isYour+messagesController
                                      .getLastMessPeople(
                                      listMessages![
                                      index]
                                          .id!).messaging!,
                                  maxLines: 1,
                                ),*/
                              ],
                            ),
                            const Spacer(),
                            Column(
                              crossAxisAlignment:
                              CrossAxisAlignment.end,
                              children: [
                                CircleAvatar(
                                  maxRadius: 10,
                                  backgroundColor:
                                  Colors.red,
                                  child: SmallText(
                                    text: '1',
                                    color: Colors.white,
                                  ),
                                ),
                                timeWidget(index),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  }),
            ),
          ],
        ),
      ),
    );
  }

  void searchBook(String query) {
    final listMessages = widget.listUser.where((user) {
      final nameLower = user.name!.toLowerCase();
      final searchLower = query.toLowerCase();

      return nameLower.contains(searchLower);
    }).toList();

    setState(() {
      this.query = query;
      this.listUser = listMessages;
    });
  }
  MessagesModel getLastMessPeople(List<MessagesModel> listMessFn,int idPeople){
    MessagesModel messagesModel = MessagesModel(messaging: "",);
    int userId = 1;

    for (var element in listMessFn) {
      if(element.idSend == userId && element.idTake == idPeople || element.idSend == idPeople && element.idTake == userId){
        messagesModel = element;
      }
    }

    return messagesModel;
  }
  timeWidget(int index) {
    MessagesModel messagesModel = getLastMessPeople(widget.listMess,2);

    if(messagesModel.updatedAt != null){
      var outputDate = DateTime.now().toString();
      DateTime parseDate =
      DateFormat("yyyy-MM-dd HH:mm:ss").parse(messagesModel.updatedAt!);
      var inputDate = DateTime.parse(parseDate.toString());
      var outputFormat = DateFormat("MM/dd/yyyy hh:mm a");
      outputDate = outputFormat.format(inputDate);

      return SmallText(text: TimeAgo.timeAgoSinceDate(parseDate));
    }
    return SmallText(text: "");

  }
}
