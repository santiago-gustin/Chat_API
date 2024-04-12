import 'package:flutter/material.dart';

class MessageFieldBox extends StatelessWidget {

  final ValueChanged<String> onValue;
  const MessageFieldBox({super.key, required this.onValue});
 
  @override
  Widget build(BuildContext context) {

    final textController = TextEditingController(); //Creamos estas dos variables para poder usarlas en diferentes partes del codigo ya que con ellas controlo que cuando se envie un mensaje se mantenga activo el teclado, se mantenga focus la caja de texto, capturo el texto que este escrito en la caja cuando se de click al boton enviar y que cuando de click afuera de la caja de texto el focus se quite. En chat_screen mediante el chatProvider accedo a ||||||||||||

    final focusNode = FocusNode();
 
    final outlineInputBorder = OutlineInputBorder( //Creamos una variable con los estilos para reutilizarlos en la linea 15 y 16 y no tener que estan volviendo a escribir todo
          borderSide: const BorderSide( color: Colors.transparent),
          borderRadius:  BorderRadius.circular(40));
 
    return TextFormField( //En general este es el Widget para captar texto
      controller: textController, //Uso la propiedad controller y asigno la clase que guarde en la variable textController, si no hago esto no puedo usar sus metodos para limpiar, seleccionar texto etc
      focusNode: focusNode, //Uso la propiedad focusNode para asignar la clase que guarde en la var, al igual que con textController
      onTapOutside: (event) {
        focusNode.unfocus(); //La propiedad onTapOutside se usa cuando se da click fuera de los campos input, recibe una funcion en la cual con la clase guardad en la var focudNode quito el focus de la caja de texto
      },
      decoration: InputDecoration( //Con la propiedad decoration aplico estilos
        hintText: 'End your message with "?"', //Con esta linea muestro un mensaje en la caja de texto
        enabledBorder: outlineInputBorder, //Uso dos propiedades dentro de InputDecoration. enableBorder es cuando el input no esta seleccionado y el focus es cuando le doy click para escribir y el input ya queda seleccionado, Tenemos que asegurarnque ambos tengan los mismos estilos por eso creamos una varaible donde guardamos los estilos y asi aqui solo llamar esa variable y no tenr que reptir el codigo
        focusedBorder: outlineInputBorder,
        filled: true, //Para mostrar como un relleno en el input
        suffixIcon: IconButton( //Creo el boton de envio
          icon: const Icon(Icons.send_outlined),
          onPressed: () { 
            final textValue = textController.value.text; //Con textController y los metodos value.text extraigo lo que haya en el campo de texto
            //print('button: $textValue');
            onValue(textValue);
            textController.clear(); //Cuando se da click al icono de enviar mensaje se imprime en consola el textod e la caja de texto
           },)
        ),
      onFieldSubmitted: (value) {
        // print('Submit value $value'); //Cada que damos entener se imprime todo lo que haya en la caja de texto
        onValue(value);
        textController.clear(); //Limpio la caja de texto con el metodo .clear()
        focusNode.requestFocus(); //Con .requestFocus() mantengo el focus en el campo de texto y activo el teclado
      },
      // onChanged: (value) { No es muy usada esra propiedad, la usamos para demostrar su funcionamiento no más
      //   print('Changed: $value'); //Cada que haya un cambio en la caja de texto se imprime lo que haya en la caja de texto, o sea que cada que se agrege una letra se imprime
      // },
      );
  }
}