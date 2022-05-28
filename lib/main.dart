import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      home:  MyHomePage(title: 'Office Food'),
    );
  }
}

class MyHomePage extends StatefulWidget {
   MyHomePage({Key? key, required this.title}) : super(key: key);


  final String title;

  String nombres="";
  String pedido="";
  double precio=0;
  int cantidad=0;
  double total = 0;
  double descuento=0;
  double pagoTotal=0;
  String mensaje="";
  bool validacion=false;
  bool? delivery=false;



  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  final _tfNombres = TextEditingController();
  final _tfPedido = TextEditingController();
  final _tfPrecio = TextEditingController();
  final _tfCantidad = TextEditingController();

  void _calcularPago(){
    setState(() {
      widget.validacion=false;
      if (_tfNombres.text.toString()=="" ||
      _tfPedido.text.toString()=="" ||
      _tfPrecio.text.toString()=="" ||
      _tfCantidad.text.toString()==""
      )
      {
        widget.validacion = true;
        widget.mensaje = "Ingrese los datos";
        return;
      }

      widget.nombres = _tfNombres.text;
      widget.pedido = _tfPedido.text;
      widget.precio = double.parse(_tfPrecio.text);
      widget.cantidad = int.parse(_tfCantidad.text);

      widget.total = widget.precio*widget.cantidad;

      if(widget.total>500){
        widget.descuento = widget.total*0.05;
      }

      widget.pagoTotal = widget.total-widget.descuento;
      if(widget.delivery=true){
        widget.pagoTotal = widget.total+20-widget.descuento;
      }

    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body:
      ListView(
        children: [
          Container(
            padding: EdgeInsets.all(10),
            child: Text(
              "Bienvenido, por favor complete sus datos para completar su pedido."),
          ),
          Container(
            padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
            child: Column(

              children: <Widget>[
                TextField(
                  controller: _tfNombres,
                  decoration: InputDecoration(hintText: "Ingrese Nombres",
                  labelText: "Nombres",errorText: _tfNombres.text.toString()==""?widget.mensaje:null),
                ),
                TextField(
                  controller: _tfPedido,
                  decoration: InputDecoration(hintText: "Ingrese Pedido",
                  labelText: "Pedido",errorText: _tfPedido.text.toString()==""?widget.mensaje:null),
                ),
                TextField(
                  controller: _tfPrecio,
                  keyboardType: TextInputType.numberWithOptions(decimal: true),
                  decoration: InputDecoration(hintText: "Ingrese Precio",
                  labelText: "Precio",errorText: _tfPrecio.text.toString()==""?widget.mensaje:null),
                ),
                TextField(
                  controller: _tfCantidad,
                  keyboardType: TextInputType.numberWithOptions(decimal: false),
                  decoration: InputDecoration(hintText: "Ingrese Cantidad",
                  labelText: "Cantidad",errorText: _tfCantidad.text.toString()==""?widget.mensaje:null),
                ),

                Text(""),
                Text("Total: S/."+widget.total.toString()+"  Descuento S/."+widget.descuento.toString()),
                Text(""),
                

                RaisedButton(
                  color: Colors.orange,
                  child: Text("Calcular",
                  style: TextStyle(fontSize: 18, fontFamily: "rbold"),
                  ),
                  onPressed: _calcularPago,),

                  Text(""),
                  Text("Delivery"),

                  Checkbox(
                          value: widget.delivery,
                          onChanged: (bool? value) {
                            setState(() {
                              widget.delivery = true;
                            });
                          },
                        ), 
                  Text(""),
                  Text("Total a Pagar: S/."+widget.pagoTotal.toString()),
                  

              ],
            ),
          )
        ],

      )
    );
  }
}
