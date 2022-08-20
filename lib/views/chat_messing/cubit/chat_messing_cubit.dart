import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../models/messages.dart';


part 'chat_messing_state.dart';

class ChatMessingCubit extends Cubit<ChatMessingState> {
  ChatMessingCubit() : super(ChatMessingState(listMess: demo_messages));


}
