class Openai {
  Openai({
    required this.id,
    required this.object,
    required this.created,
    required this.model,
    required this.choices,
    required this.usage,
    required this.systemFingerprint,
  });

  final String? id;
  final String? object;
  final int? created;
  final String? model;
  final List<Choice> choices;
  final Usage? usage;
  final String? systemFingerprint;

  factory Openai.fromJson(Map<String, dynamic> json){
    return Openai(
      id: json["id"],
      object: json["object"],
      created: json["created"],
      model: json["model"],
      choices: json["choices"] == null ? [] : List<Choice>.from(json["choices"]!.map((x) => Choice.fromJson(x))),
      usage: json["usage"] == null ? null : Usage.fromJson(json["usage"]),
      systemFingerprint: json["system_fingerprint"],
    );
  }

}

class Choice {
  Choice({
    required this.index,
    required this.message,
    required this.logprobs,
    required this.finishReason,
  });

  final int? index;
  final Message? message;
  final dynamic logprobs;
  final String? finishReason;

  factory Choice.fromJson(Map<String, dynamic> json){
    return Choice(
      index: json["index"],
      message: json["message"] == null ? null : Message.fromJson(json["message"]),
      logprobs: json["logprobs"],
      finishReason: json["finish_reason"],
    );
  }

}

class Message {
  Message({
    required this.role,
    required this.content,
    required this.refusal,
  });

  final String? role;
  final String? content;
  final dynamic refusal;

  factory Message.fromJson(Map<String, dynamic> json){
    return Message(
      role: json["role"],
      content: json["content"],
      refusal: json["refusal"],
    );
  }

}

class Usage {
  Usage({
    required this.promptTokens,
    required this.completionTokens,
    required this.totalTokens,
    required this.promptTokensDetails,
    required this.completionTokensDetails,
  });

  final int? promptTokens;
  final int? completionTokens;
  final int? totalTokens;
  final PromptTokensDetails? promptTokensDetails;
  final CompletionTokensDetails? completionTokensDetails;

  factory Usage.fromJson(Map<String, dynamic> json){
    return Usage(
      promptTokens: json["prompt_tokens"],
      completionTokens: json["completion_tokens"],
      totalTokens: json["total_tokens"],
      promptTokensDetails: json["prompt_tokens_details"] == null ? null : PromptTokensDetails.fromJson(json["prompt_tokens_details"]),
      completionTokensDetails: json["completion_tokens_details"] == null ? null : CompletionTokensDetails.fromJson(json["completion_tokens_details"]),
    );
  }

}

class CompletionTokensDetails {
  CompletionTokensDetails({
    required this.reasoningTokens,
  });

  final int? reasoningTokens;

  factory CompletionTokensDetails.fromJson(Map<String, dynamic> json){
    return CompletionTokensDetails(
      reasoningTokens: json["reasoning_tokens"],
    );
  }

}

class PromptTokensDetails {
  PromptTokensDetails({
    required this.cachedTokens,
  });

  final int? cachedTokens;

  factory PromptTokensDetails.fromJson(Map<String, dynamic> json){
    return PromptTokensDetails(
      cachedTokens: json["cached_tokens"],
    );
  }

}
