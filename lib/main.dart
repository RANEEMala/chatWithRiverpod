
import 'package:chat_riverpod/model/model.dart';
import 'package:chat_riverpod/provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';


void main() async {
  await Supabase.initialize(
    url: 'https://iyidecmdyhivdqjjdczx.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Iml5aWRlY21keWhpdmRxampkY3p4Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3MDAxNjIyMDIsImV4cCI6MjAxNTczODIwMn0.-SSo8FqwiGpWdaQ0TdCikiQY374vE0BT1EzYk90pYRg',
  );
  runApp(ProviderScope(
    child: const MyApp()));
}



class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ChatPage(),
    );
  }
}

class ChatPage extends ConsumerWidget {
   TextEditingController message=TextEditingController();


  @override
  Widget build(BuildContext context,ref) {
    final watch=ref.watch(getData);
    return Scaffold(
      body: Center(
        child:  Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Expanded(
                      child: watch.when(
                        data:(data){
                          return  ListView.builder(
                              itemCount: data.length,
                              itemBuilder: (context, index) {
                                return data[index].is_me as bool
                                ?SizedBox(
                                  width: 100,
                                  height: 60,
                                  child: Align(
                                    alignment: Alignment.topRight,
                                    child: Card(
                                      child: Container(
                                        decoration: BoxDecoration(
                                            color: Colors.blue,
                                            borderRadius: BorderRadius.only(
                                                bottomLeft: Radius.circular(20),
                                                topLeft: Radius.circular(20),
                                                topRight: Radius.circular(20))),
                                        width: 300,
                                        height: 100,
                                        child: Center(
                                          child: Text(data[index].message.toString()),
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                                    : SizedBox(
                                  width: 100,
                                  height: 60,
                                  child: Align(
                                    alignment: Alignment.topLeft,
                                    child: Card(
                                      child: Container(
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.only(
                                                bottomRight:
                                                Radius.circular(20),
                                                topLeft: Radius.circular(20),
                                                topRight: Radius.circular(20))),
                                        width: 300,
                                        height: 100,
                                        child: Center(
                                          child: Text(data[index].message
                                              .toString()),
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              });

                        },
                        error: (error, stackTrace) {
                          return Text("errors",style: TextStyle(color: Colors.red),);
                        },
                        loading: () {
                          return Center(child: CircularProgressIndicator());
                        },
                      )
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SizedBox(
                            width: MediaQuery.sizeOf(context).width * 0.8,
                            child: TextField(
                              controller: message,
                              decoration:
                              InputDecoration(border: OutlineInputBorder()),
                            )),
                      ),
                      IconButton(
                          onPressed: () async {
                            ChatModel chatModel=ChatModel(message: message.text);
                            ref.read(chat).addMessage(chatModel);
                            message.clear();
                          },
                          icon: Icon(Icons.send))
                    ],
                  )
                ],

        ),
      ),
    );
  }
}


