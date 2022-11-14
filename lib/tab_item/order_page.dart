import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class OrderPage extends StatefulWidget {
  const OrderPage({super.key});

  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: orderList.length,
          itemBuilder: (context,index){
            return Card(
              color: Colors.white70,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                 Text("Name: ${orderList[index].user!.name}",style: TextStyle(fontSize: 16,fontWeight: FontWeight.w400,color: Colors.black87),),
                 Text("id: ${orderList[index].id}",), 
                 Text("price: ${orderList[index].price}",), 
                 Text("quantity: ${orderList[index].quantity}",), 
                 Text("discount: ${orderList[index].discount}",), 
                 Text("vat: ${orderList[index].vat}",),  
                 Text("Order ststus: ${orderList[index].orderStatus!.orderStatusCategory!.name}"),
                 Text("date and time: ${orderList[index].orderDateAndTime}",style: TextStyle(fontSize: 14,fontWeight: FontWeight.w400,color: Colors.black54),),
                 SizedBox(
                  height: 5,
                 ),
                ],
              ),
            );
          }
          ),
      ),
    );
  }
}
