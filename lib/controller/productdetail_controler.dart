import 'package:get/get.dart';

import '../common.dart';
import '../modal/entity/card.dart';
import '../modal/entity/product.dart';
import '../screen/viewcardpage.dart';

class ProductDetailsController extends GetxController {
  Product? product;
  RxInt productQty = 1.obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

  updateQty(bool isAdd) {
    if (isAdd) {
      productQty.value++;
    } else {
      if (productQty.value > 1) {
        productQty.value--;
      }
    }
  }

  addCard() async {
    DateTime createdAt = DateTime.now();
    CardItem card = CardItem(
        id: Common().getRandomId(),
        name: product!.name,
        desc: product!.desc,
        price: product!.price,
        qty: productQty.value,
        createdAt: createdAt,
        discount: product!.discount);
    await Common().insertCardItem(card);
    Get.to(() => ViewCardPage());
  }
}
