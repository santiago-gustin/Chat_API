// To parse this JSON data, do
//
//     final yesNoModel = yesNoModelFromJson(jsonString);

import 'dart:convert';

import 'package:yes_no_app/domain/entities/message.dart';

YesNoModel yesNoModelFromJson(String str) => YesNoModel.fromJsonMap(json.decode(str));

String yesNoModelToJson(YesNoModel data) => json.encode(data.toJson());

class YesNoModel { //Esta es una clase que me permite recibir mapas o respuesta de una api para convertirlas en instancias que este usando en mi app, en este caso recibo una mapa de una ape que tiene tres atriburos, answer, forced e image y los convierto a Message.
    final String answer; //Debo crear los mismos atributos que me envia mi API
    final bool forced;
    final String image;

    YesNoModel({
        required this.answer,
        required this.forced,
        required this.image,
    });

    factory YesNoModel.fromJsonMap(Map<String, dynamic> json) => YesNoModel(
        answer: json["answer"],
        forced: json["forced"],
        image: json["image"],
    );

    Map<String, dynamic> toJson() => {
        "answer": answer,
        "forced": forced,
        "image": image,
    };

    Message toMessageEntity() => Message(
      text:answer == 'yes' ? 'Si' : 'No',
      fromWho: FromWho.hers,
      imageUrl: image );
}
