import 'package:chat_riverpod/model/model.dart';
import 'package:chat_riverpod/service/srvice.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final chat = StateProvider<ServicesImp>((ref){
  return ServicesImp();
});

final getData = StreamProvider<List<ChatModel>>((ref) {
  return ref.read(chat).getMessages();
});



