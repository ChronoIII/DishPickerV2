import 'package:chat_gpt_sdk/chat_gpt_sdk.dart';
import 'package:chat_gpt_sdk/src/model/complete_text/response/choices.dart';

import '../values/app.values.dart';

class ChatGptUtil {
  final OpenAI _instance = OpenAI.instance.build(
    token: openAiToken,
    baseOption: HttpSetup(receiveTimeout: const Duration(seconds: 5)),
  );

  ChatGptUtil();

  Future<Choices?> request(String prompt) async {
    try {
      final request = CompleteText(
        prompt: prompt,
        model: Model.textDavinci3,
        maxTokens: 200,
      );
      final response = await _instance.onCompletion(request: request);
      return response!.choices.first;
    } catch (e) {
      print(e);
    }
    return null;
  }

  Future<String> askQuestion(String prompt,
      {String result = '', int tries = 0}) async {
    if (tries >= 5) {
      return result;
    }
    Choices? choiceResponse = await request(prompt);
    result += choiceResponse!.text;
    tries += 1;

    if (choiceResponse!.finishReason != 'stop') {
      var tempPrompt = result += '@keep going';
      result += await askQuestion(tempPrompt, result: result, tries: tries);
    }
    return result;
  }
}
