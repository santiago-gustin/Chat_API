import 'package:flutter/material.dart';
import 'package:yes_no_app/domain/entities/message.dart';

class MyMessageBubble extends StatelessWidget {
  
  final Message message; 
  
  const MyMessageBubble({super.key, required this.message});

  @override
  Widget build(BuildContext context) {

    final colors = Theme.of(context).colorScheme; //Me sirve para extraer el color del tema (que configuramos en app_theme.dart) y aplicarlo al color de fondo de los mensajes
    

    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Container( //Los contenedores en general me sirven para contener Widgets pero aplicandoles estilos, como colores de fondo, espacios, padding etc (en si me sirvne para personalizar)
          decoration: BoxDecoration( //Propiedad del contenedor para aplicar radio y color de fondo
            color: colors.primary,
            borderRadius: BorderRadius.circular(30), 
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric( horizontal: 20, vertical: 10),
            child: Text(message.text, style: const TextStyle(color: Colors.white),),
          ),
        ),
        const SizedBox(height: 10), //Como es una columna uso este Widget para separar los elementos
      ],
    );
  }
}