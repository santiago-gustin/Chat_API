import 'package:flutter/material.dart';
import 'package:yes_no_app/config/helpers/get_yes_no_answer.dart';
import 'package:yes_no_app/domain/entities/message.dart';

class ChatProvider extends ChangeNotifier {
  
  final ScrollController chatScrollController = ScrollController(); //Creo una instrancia ScrollController que será el controlador mediante el cual puedo ejecutar el scroll. Además esta es la forma de conectar el provider con chat_screen, como se explica en el archivo chat_screen
  final GetYesNoAnswer getYesNoAnswer = GetYesNoAnswer();

  List<Message> messageList = [
    Message(text: 'Hola', fromWho: FromWho.me),
    Message(text: 'Ya saliste del trabajo?', fromWho: FromWho.me),
  ];

  Future<void> sendMessage (String text) async {
    if(text.isEmpty)  return; //Aseguro que no se envien textos vacios, si se envian no se hace nada en la app
    final newMessage = Message(text: text, fromWho: FromWho.me);
    messageList.add(newMessage);

    if(text.endsWith('?')){
      herReply();
    }

    notifyListeners();
    moveScrollToBottom(); //LLamo a la animacion que cree en la funcion abajo para que cada que reenderize la pantalla luegro se ejcute la animacion
  }

  Future<void> herReply() async{
    final herMessage = await getYesNoAnswer.getAnswer();
    messageList.add(herMessage);

    notifyListeners();
    moveScrollToBottom();
  }

  void moveScrollToBottom() { //Conn esta funcion creo la animacion o ejecuto el scroll
    chatScrollController.animateTo(
      chatScrollController.position.maxScrollExtent, //La primera propiedad sirve para declarar la medida desde donde arranca el scroll, en este caso definimos que desde donde se encuentre el scroll arrancamos 
      duration: const Duration(microseconds: 300), //La propiedad duration: sirve para definir el tiempo que toma en ejectuarse la animacion del scroll
      curve: Curves.easeOut); //La propiedad curve me permite definir la animacion que quieor que se muestra cada que se haga scroll
  }

}