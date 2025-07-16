import 'dart:async';
import 'package:examproject1/api/ChatbotService.dart';
import 'package:examproject1/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';

class ChatbotScreen extends StatefulWidget {
  BuildContext context;

  ChatbotScreen(
    this.context,
  );

  @override
  _ChatbotScreenState createState() => _ChatbotScreenState();
}

class _ChatbotScreenState extends State<ChatbotScreen> {
  late ChatbotService? chatbotService = null;
  String developContentWelcome = "";
  String developContent = "";
  String model = "gpt-4o";

  late StateSetter myState;

  FocusNode AIFocusNode = FocusNode();
  late double sheetHeight;

  final String textFieldHint = "찾는 영화가 있으신가요?";
  final bool hasBackButton = true;
  final BoxDecoration userBubbleDecoration = const BoxDecoration(
    color: Colors.green, // Default user bubble decoration
    borderRadius: BorderRadius.all(Radius.circular(16)),
  );
  final BoxDecoration botBubbleDecoration = const BoxDecoration(
    color: Colors.white, // Default bot bubble decoration
    borderRadius: BorderRadius.all(Radius.circular(16)),
  );

  final TextEditingController messageController = TextEditingController();
  final List<ChatMessage> chattMessage = [];
  final ScrollController scrollController = ScrollController();

  bool firstFunction = true;
  bool isDone = true;

  @override
  void initState() {
    super.initState();
    setPrompt();

    sheetHeight = MediaQueryHeight - 150;

    AIFocusNode.addListener(() {
      if (AIFocusNode.hasFocus) {
        _scrollToBottom();
        sheetHeight = 300;
      } else {
        sheetHeight = MediaQueryHeight - 150;
      }
    });
  }

  setPrompt() async {
    developContentWelcome = "답변을 html로 줘. 무조건 <!DOCTYPE html>로 시작하며, 헤더는 주지마! 너의 답변(String)을 html로 찍을거야!)";

    //동적인 예비 프롬프트
    developContent = "답변을 html로 줘. 무조건 <!DOCTYPE html>로 시작하며, 헤더는 주지마! 너의 답변(String)을 html로 찍을거야!)";
    model = "gpt-4o";

    chatbotService = ChatbotService(
      apiKey: "API key를 넣어주세요",
      temperature: 0.5,
      firstPrompt: developContentWelcome,
      systemPrompt: developContent,
      model: 'gpt-4o',
    );
    try {
      myState(() {});
    } catch (e) {}
    handleSendMessage();
  }

  void handleSendMessage() async {
    final message = messageController.text.trim();
    messageController.clear();
    try {
      myState(() {
        chattMessage.add(ChatMessage(
          message: message,
          isUser: true,
          decoration: userBubbleDecoration,
        ));
      });
    } catch (e) {}
    _scrollToBottom();

    chattMessage.add(ChatMessage(
      message: '',
      isUser: false,
      decoration: botBubbleDecoration,
    ));

    _scrollToBottom();

    try {
      final Stream<String> stream = chatbotService!.streamMessages(message);
      isDone = false;
      stream.listen(
        (content) {
          try {
            myState(() {
              final index = chattMessage.length - 1;
              final currentMessage = chattMessage[index];

              // Append the new content to the existing message
              chattMessage[index] = ChatMessage(
                message: currentMessage.message + content,
                isUser: false,
                decoration: botBubbleDecoration,
              );
            });

            _scrollToBottom();
          } catch (e) {}
        },
        onError: (error) {
        },
        onDone: () {
          isDone = true;
        },
      );
    } catch (e) {}
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      try {
        scrollController.jumpTo(scrollController.position.maxScrollExtent);
      } catch (e) {}
    });
  }

  @override
  void dispose() {
    messageController.dispose();
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Visibility(
        visible: chatbotService != null,
        child: Align(
            alignment: Alignment.bottomLeft,
            child: GestureDetector(
                onTap: () async {
                  FocusManager.instance.primaryFocus?.unfocus();

                  showModalBottomSheet(
                      backgroundColor: Colors.white,
                      barrierColor: const Color.fromRGBO(0, 0, 0, 0.45),
                      context: context,
                      isScrollControlled: true,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
                      ),
                      builder: (BuildContext context) {
                        return ScrollConfiguration(
                            behavior: const ScrollBehavior().copyWith(overscroll: false),
                            child: GestureDetector(onTap: () {
                              FocusManager.instance.primaryFocus?.unfocus();
                            }, child: StatefulBuilder(builder: (BuildContext context, StateSetter mystate) {
                              myState = mystate;
                              return SafeArea(
                                child: Padding(
                                  padding: MediaQuery.of(context).viewInsets,
                                  child: Container(
                                    color: Colors.white,
                                    height: sheetHeight,
                                    margin: const EdgeInsets.only(top: 33, bottom: 5),
                                    child: Stack(
                                      children: [
                                        Container(
                                            height: sheetHeight - 76,
                                            color: Colors.white,
                                            child: ListView.builder(
                                              controller: scrollController,
                                              itemCount: chattMessage.length,
                                              itemBuilder: (context, index) {
                                                final message = chattMessage[index];
                                                return ChatBubble(message: message);
                                              },
                                            )),
                                        Align(
                                            alignment: Alignment.bottomCenter,
                                            child: Container(
                                              height: 76,
                                              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                                              child: Row(
                                                children: [
                                                  Expanded(
                                                    child: TextField(
                                                      focusNode: AIFocusNode,
                                                      controller: messageController,
                                                      decoration: InputDecoration(
                                                        hintText: textFieldHint,
                                                        border: const OutlineInputBorder(),
                                                      ),
                                                    ),
                                                  ),
                                                  GestureDetector(
                                                      onTap: () {
                                                        if (isDone == false) {
                                                        } else if (messageController.text == "") {
                                                        } else {
                                                          FocusManager.instance.primaryFocus?.unfocus();
                                                          handleSendMessage();
                                                        }
                                                      },
                                                      child: Container(
                                                          margin: const EdgeInsets.only(left: 10),
                                                          child: Image.asset(
                                                            "asset/ploatingBack.png",
                                                            width: 60,
                                                            height: 60,
                                                          )))
                                                ],
                                              ),
                                            )),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            })));
                      });

                  _scrollToBottom();
                },
                child: Container(
                    margin: const EdgeInsets.only(left: 10, bottom: 130),
                    child: Image.asset(
                      'assets/fire.png',
                      width: 48,
                      height: 48,
                    )))));
  }
}

class ChatMessage {
  final String message;
  final bool isUser;
  final BoxDecoration decoration;

  const ChatMessage({
    required this.message,
    required this.isUser,
    required this.decoration,
  });
}

class ChatBubble extends StatelessWidget {
  final ChatMessage message;

  const ChatBubble({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    if (message.isUser) {
      return Align(
        alignment: Alignment.bottomRight,
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          padding: const EdgeInsets.all(16),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                message.message,
                textAlign: TextAlign.end,
              ),
              Container(
                width: 15,
              ),
              CircleAvatar(child: Image.asset("assets/controller.png"))
            ],
          ),
        ),
      );
    } else {
      return Align(
        alignment: Alignment.bottomLeft,
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          padding: const EdgeInsets.all(16),
          decoration: message.decoration,
          child: HtmlWidget(message.message.toString().replaceAll('```html', '').replaceAll('```', '')),
        ),
      );
    }
  }
}
