import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store_small_bloc/app/utils/app_variable.dart';
import 'package:store_small_bloc/models/messages.dart';
import 'package:store_small_bloc/models/notification.dart';
import 'package:store_small_bloc/views/notification/notification.dart';

import '../../widget/big_text.dart';
import '../../widget/small_text.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({Key? key}) : super(key: key);

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {

  late NotificationCubit notificationCubit;

  @override
  void dispose() {
    notificationCubit.setStatusNotification();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    notificationCubit = BlocProvider.of<NotificationCubit>(context);
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
        elevation: 0,
        backgroundColor: Colors.blue,
        title: BigText(
          text: "Notifications",
          fontSize: size.height * 0.025,
          color: Colors.white,
        ),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {
                context.read<NotificationCubit>().getListNoti();
              },
              icon: const Icon(
                Icons.settings,
                color: Colors.white,
              )),
        ],
      ),
      body: Column(
        children: [
          Expanded(
              child: BlocBuilder<NotificationCubit, NotificationState>(
                  buildWhen: (previous, current) => previous.status != current.status,
                builder: (context, state) {
                  return ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      itemCount: state.listNotification.length,
                      itemBuilder: (context, index) {
                        return Container(
                          decoration: BoxDecoration(
                              border: Border(
                            bottom: BorderSide(
                                width: 1.0, color: Colors.grey.withOpacity(0.5)),
                          )),
                          child: Row(
                            children: [
                              Container(
                                height: size.height * 0.07,
                                width: size.width * 0.12,
                                margin: EdgeInsets.symmetric(
                                    horizontal: size.height * 0.01),
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    image: state.listNotification[index].image!.isNotEmpty
                                        ? DecorationImage(
                                            image: NetworkImage(
                                                state.listNotification[index].image!),
                                            fit: BoxFit.cover)
                                        : const DecorationImage(
                                            image: AssetImage(
                                                "assets/images/no_image.png"),
                                            fit: BoxFit.cover,
                                          )),
                              ),
                              Expanded(
                                  child: Padding(
                                padding: EdgeInsets.only(right: size.height * 0.01),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        BigText(
                                          text: state.listNotification[index].name ?? "",
                                          fontWeight: FontWeight.bold,
                                        ),
                                        SmallText(
                                            text: AppVariable.timeAgoFormat(
                                                state.listNotification[index].updatedAt ??
                                                    ""),color: int.parse(state.listNotification[index].status??"-1") == 0?Colors.black:Colors.grey),
                                      ],
                                    ),
                                    SmallText(
                                        text: state.listNotification[index].title ?? ""),
                                    BigText(
                                      text: state.listNotification[index].body ?? "",
                                      color: int.parse(state.listNotification[index].status??"-1") == 0
                                          ? Colors.black
                                          : Colors.grey,
                                      maxLines: 2,
                                    ),
                                  ],
                                ),
                              ))
                            ],
                          ),
                        );
                      });
                }
              ))
        ],
      ),
    );
  }
}
