class ChatCompletion {
  final String id;
  final String object;
  final int created;
  final String model;
  final List<Choice> choices;
  final Usage usage;

  ChatCompletion({
    required this.id,
    required this.object,
    required this.created,
    required this.model,
    required this.choices,
    required this.usage,
  });

  factory ChatCompletion.fromJson(Map<String, dynamic> json) => ChatCompletion(
        id: json['id'],
        object: json['object'],
        created: json['created'],
        model: json['model'],
        choices: (json['choices'] as List)
            .map((choiceJson) => Choice.fromJson(choiceJson))
            .toList(),
        usage: Usage.fromJson(json['usage']),
      );
}

class Choice {
  final int index;
  final Message message;
  final String finishReason;

  Choice({
    required this.index,
    required this.message,
    required this.finishReason,
  });

  factory Choice.fromJson(Map<String, dynamic> json) => Choice(
        index: json['index'],
        message: Message.fromJson(json['message']),
        finishReason: json['finish_reason'],
      );
}

class Message {
  final String role;
  final String content;

  Message({
    required this.role,
    required this.content,
  });

  factory Message.fromJson(Map<String, dynamic> json) => Message(
        role: json['role'],
        content: json['content'],
      );
}

class Usage {
  final int promptTokens;
  final int completionTokens;
  final int totalTokens;

  Usage({
    required this.promptTokens,
    required this.completionTokens,
    required this.totalTokens,
  });

  factory Usage.fromJson(Map<String, dynamic> json) => Usage(
        promptTokens: json['prompt_tokens'],
        completionTokens: json['completion_tokens'],
        totalTokens: json['total_tokens'],
      );
}
