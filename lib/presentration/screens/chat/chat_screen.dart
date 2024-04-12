import 'package:provider/provider.dart';

import 'package:flutter/material.dart';
import 'package:yes_no_app/domain/entities/message.dart';
import 'package:yes_no_app/presentration/providers/chat_provider.dart';
import 'package:yes_no_app/presentration/widgets/chat/her_message_bubble.dart';
import 'package:yes_no_app/presentration/widgets/chat/my_message_bubble.dart';
import 'package:yes_no_app/presentration/widgets/shared/message_field_box.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const Padding( //Propiedad que me sirve para dejar un espacio a lado izquierdo del titulo del appBar
          padding: EdgeInsets.all(5.0),
          child: CircleAvatar(
            backgroundImage: NetworkImage('https://cnnespanol.cnn.com/wp-content/uploads/2020/09/Dwayne-22The-Rock22-Johnson.jpg'),
          ),
        ),
        title: const Text('La Roca'),
        // centerTitle: true,
      ),
      body: const _ChatView(),
    );
  }
}

class _ChatView extends StatelessWidget {
  const _ChatView({ //Me sale un warning ya que al ser un Widget privado no podree acceder a el por medio de la key, o sea que podriamos incluso borrar esta key
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    
    final chatProvider = context.watch<ChatProvider>();

    return SafeArea( //Envuelvo todo en un SafeArea que es un widget que me permite acomodar el contenido en el área disponible de la pantralla, que no se baje al menu unferior de navegacion del cel y no se suva en las muescas superiores de la camara
      child: Padding(
        padding: const EdgeInsets.symmetric( horizontal: 10),
        child: Column(
          children: [
            Expanded(child: ListView.builder(
              controller: chatProvider.chatScrollController, //La propiedad controller me permite controlar el scroll. Esta propiedad debe recibir de alguna forma la notificacion cuando hay un nuevo mensaje para que se ejecute el scroll, por ende tenemos que coenctar de alguna forma esta propiedad con el chat_provider, por ende instancio un ScrollController en chat_provider y  acá accedo a el mediante la instancia de chatProvider de la línea 39
              itemCount: chatProvider.messageList.length,
              itemBuilder: (context, index) {
                final message = chatProvider.messageList[index];
                return (message.fromWho == FromWho.hers)?
                HerMessageBubble(message: message,): 
                MyMessageBubble(message: message,);
              })),
            MessageFieldBox(onValue: (String value) { chatProvider.sendMessage(value); })
          ],
        ),
      ),
    );
  }
}