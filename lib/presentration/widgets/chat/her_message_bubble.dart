import 'package:flutter/material.dart';
import 'package:yes_no_app/domain/entities/message.dart';
class HerMessageBubble extends StatelessWidget {

  final Message message; 

  const HerMessageBubble({super.key, required this.message});

  @override
  Widget build(BuildContext context) {

    final colors = Theme.of(context).colorScheme; //Me sirve para extraer el color del tema (que configuramos en app_theme.dart) y aplicarlo al color de fondo de los mensajes

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start, //Cambio esto respecto a my_message_bubble.dart, ya que estos mensajes deben mostrarse en el lado izquierdo
      children: [
        Container( //Los contenedores en general me sirven para contener Widgets pero aplicandoles estilos, como colores de fondo, espacios, padding etc (en si me sirvne para personalizar)
          decoration: BoxDecoration( //Propiedad del contenedor para aplicar radio y color de fondo
            color: colors.secondary, //Cambio el color por eso uso .secondary
            borderRadius: BorderRadius.circular(30), 
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric( horizontal: 20, vertical: 10),
            child: Text(message.text, style: const TextStyle(color: Colors.white),),
          ),
        ),
        const SizedBox(height: 5), //Como es una columna uso este Widget para separar los elementos
        _ImageBubble(imageUrl: message.imageUrl!,), //Llamamos el Widget privado creado abajo
        const SizedBox(height: 5)
      ],
    );
  }
}

  class _ImageBubble extends StatelessWidget { //Al ser un Widget privado eliminamos el super.key del constructor ya que no usaremos la key

    final String imageUrl;

    const _ImageBubble({required this.imageUrl});

    @override
    Widget build(BuildContext context) {
      final size = MediaQuery.of(context).size; //IMPORTANTE: Con esta línea determino el tamaño de la pantalla, lo uso en la línea 41

      return ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Image.network(imageUrl,
        width: size.width * 0.7, //Con la medida de la pantralla que tome en la línea 36 uso acá la variable par determinar el ancho como el 70% de la pantalla
        height: 150,
        fit: BoxFit.cover,
        loadingBuilder: (context, child, loadingProgress) {
          if(loadingProgress == null) return child;

          return Container(
            width: size.width * 0.7,
            height: 150,
            padding: const EdgeInsets.symmetric(horizontal: 10 ,vertical: 5),
            child: const Text('Se está cargando la imágen'),
          );
        },), //Esta propiedad sirve para que la imagen se ajuste exactamente al ancho y alto definido.
      );
    }
  }