
import 'package:chat_riverpod/model/model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final supabase = Supabase.instance.client;


abstract class CoreSrvice{
  Stream<List<ChatModel>>getMessages();
  Future<bool>addMessage(chatModel);
}


class ServicesImp extends CoreSrvice{
  @override
  Stream<List<ChatModel>> getMessages() {
   var messages= supabase.from("Chat").select('*').then((data) => data.map((map) => ChatModel.fromMap(map)).toList());
    return messages.asStream();
  }

  Future<bool>addMessage(chatModel) async{
     await supabase.from('Chat').insert({
      "message": chatModel.message,
      "is_me": false
    }).select();
    return true;
  }
}
