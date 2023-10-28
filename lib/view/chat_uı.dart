import 'dart:convert';

import 'package:chatgpt_demo/model/response_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class ChatUIView extends StatefulWidget {
  final String typeText;

  const ChatUIView({super.key, required this.typeText});

  @override
  State<ChatUIView> createState() => _ChatUIViewState();
}

class _ChatUIViewState extends State<ChatUIView> {
  TextEditingController _promptController = TextEditingController();

  String responseText = '';

  late ChatCompletion _responseModel;

  @override
  void initState() {
    _promptController = TextEditingController(text: widget.typeText);
    super.initState();
  }

  @override
  void dispose() {
    _promptController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff343541),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text('Chat Gpt Demo'),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            PromptBldr(responseText: responseText),
            TextFormFieldBldr(
                promptController: _promptController, btnFun: completionFun),
          ],
        ),
      ),
    );
  }

  completionFun() async {
    setState(() => responseText = '...');

    final response = await http.post(
      Uri.parse('https://api.openai.com/v1/chat/completions'),
      headers: {
        'Content-Type': 'application/json; charset=utf-8',
        'Authorization': 'Bearer ${dotenv.env['OPENAI_API_KEY']}'
      },
      body: jsonEncode(
        {
          "model": "gpt-3.5-turbo",
          "messages": [
            {"role": "user", "content": _promptController.text},
          ]
        },
      ),
    );

    _promptController.clear();

    if (response.statusCode != 200) {
      final errorData = jsonDecode(response.body);
      setState(() {
        responseText = "Error: ${errorData['error']['message']}";
      });
    } else {
      setState(() {
        final jsonData = json.decode(utf8.decode(response.bodyBytes));
        final chatCompletion = ChatCompletion.fromJson(jsonData);

        responseText = chatCompletion.choices[0].message.content;

        debugPrint(responseText);
        debugPrint(response.body);
      });
    }
  }
}

class PromptBldr extends StatelessWidget {
  final String responseText;

  const PromptBldr({super.key, required this.responseText});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height / 1.35,
      color: Color(0xff434654),
      child: Align(
        alignment: Alignment.bottomLeft,
        child: Padding(
          padding: EdgeInsets.all(20),
          child: SingleChildScrollView(
            child: Text(
              responseText,
              textAlign: TextAlign.start,
              style: TextStyle(
                fontSize: 25,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class TextFormFieldBldr extends StatelessWidget {
  final TextEditingController promptController;
  final void Function()? btnFun;

  const TextFormFieldBldr(
      {super.key, required this.promptController, required this.btnFun});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Padding(
        padding: EdgeInsets.only(left: 10, right: 10, bottom: 30, top: 10),
        child: Row(
          children: [
            Flexible(
              child: TextFormField(
                controller: promptController,
                cursorColor: Colors.white,
                autofocus: false,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  overflow: TextOverflow.ellipsis,
                ),
                decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0xff444653)),
                    borderRadius: BorderRadius.circular(5.5),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0xff444653)),
                  ),
                  filled: true,
                  fillColor: Color(0xff444653),
                  hintText: 'Type',
                  hintStyle: TextStyle(color: Colors.grey),
                ),
              ),
            ),
            SizedBox(width: 5),
            Container(
              height: 63,
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 17, 173, 176),
                borderRadius: BorderRadius.circular(5.5),
              ),
              child: Padding(
                padding: EdgeInsets.all(10),
                child: IconButton(onPressed: btnFun, icon: Icon(Icons.send)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
