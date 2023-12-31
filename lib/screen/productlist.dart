
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sqlite_work_databse_dk/screen/product_detail.dart';
import 'package:sqlite_work_databse_dk/screen/viewcardpage.dart';

import '../controller/productadd_controller.dart';
import '../modal/entity/product.dart';
import 'all_databse_screen.dart';
import 'bookingscreen.dart';
import 'editproduct.dart';

class ProductList extends GetView {
   ProductList({Key? key}) : super(key: key);
  final _productController = Get.put(ProductController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Colors.black, //change your color here
        ),
        backgroundColor: Colors.white,
        title: const Text(
          "Product List",
          style: TextStyle(
              fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.green,
        onPressed: () {
          Get.to(EditProduct(
            isEdit: false,
          ));
        },
        child: const Icon(Icons.add),
      ),
      body:Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
        child: Obx(
              () => Column(
            children: [
              Expanded(
                child: ListView.builder(
                    padding: const EdgeInsets.all(8),
                    itemCount: _productController.productList.length,
                    itemBuilder: (BuildContext context, int index) {
                      return _listItem(index);
                    }),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      Get.to( ViewCardPage());
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.red.shade200,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 40),
                      margin: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 10),
                      alignment: Alignment.center,
                      child: const Text(
                        "View Card",
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.black),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                ],
              ),
              ElevatedButton(onPressed: (){
                Get.to(AllDatabseQeuery());
              }, child: Text("AllDatabseQeuery")),
            ],
          ),
        ),
      ),
    );
  }
   Widget _listItem(int index) {
     Product product = _productController.productList[index];
     return GestureDetector(
       onTap: () {
         Get.to(
               () => ProductDetail(product: product),
         );
       },
       child: Container(
         decoration: BoxDecoration(
           color: Colors.red.shade50,
           borderRadius: BorderRadius.circular(10),
         ),
         padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
         margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
         child: Column(
           children: [
             Row(
               children: [
                 Expanded(
                   child: Text(
                     "Name :  ${product.name}",
                     style: const TextStyle(
                         fontWeight: FontWeight.w500,
                         fontSize: 15,
                         color: Colors.black),
                   ),
                 ),
                 Text(
                   "QTY :  ${product.qty}",
                   style: const TextStyle(
                       fontWeight: FontWeight.w500,
                       fontSize: 15,
                       color: Colors.black),
                 ),
               ],
             ),
             SizedBox(height: 10,),
             Row(
               children: [
                 Expanded(
                   child: Text(
                     "Price :  ${product.price}",
                     style: const TextStyle(
                         fontWeight: FontWeight.w500,
                         fontSize: 15,
                         color: Colors.black),
                   ),
                 ),
                 Text(
                   "Discount :  ${product.discount}",
                   style: const TextStyle(
                       fontWeight: FontWeight.w500,
                       fontSize: 15,
                       color: Colors.black),
                 ),
               ],
             )
           ],
         ),
       ),
     );
   }
}
