import 'package:dio/dio.dart';
import 'package:yes_no_app/domain/entities/message.dart';
import 'package:yes_no_app/infraestructure/models/yes_no_model.dart';

final _dio = Dio();

class GetYesNoAnswer {
  Future<Message> getAnswer() async {
    final response = await _dio.get('https://yesno.wtf/api');

    final yesNoModel = YesNoModel.fromJsonMap(response.data);

    // return Message(
    //   text: yesNoModel.answer,
    //   fromWho: FromWho.hers,
    //   imageUrl: yesNoModel.image);

    return yesNoModel.toMessageEntity();
  }
}