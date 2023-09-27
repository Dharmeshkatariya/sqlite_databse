import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sqlite_work_databse_dk/screen/cartitemscreen/maxvaluescreen.dart';
import 'package:sqlite_work_databse_dk/screen/pagination.dart';
import 'package:sqlite_work_databse_dk/screen/paginationdatetimewithsorting.dart';

import 'advance/beforecretedgetdata.dart';
import 'advance/home.dart';
import 'advance/listdata.dart';
import 'advance/pricelist.dart';
import 'bookingscreen.dart';
import 'cartitemscreen/ascendingorder.dart';
import 'cartitemscreen/betchscreen.dart';
import 'cartitemscreen/calculated_avg_vlue.dart';
import 'cartitemscreen/cardbyid.dart';
import 'cartitemscreen/cardlistpage.dart';
import 'cartitemscreen/cardtlistscreen.dart';
import 'cartitemscreen/cartlistforcontion.dart';
import 'cartitemscreen/catergoryscreen.dart';
import 'cartitemscreen/destinetname.dart';
import 'cartitemscreen/discount sorted.dart';
import 'cartitemscreen/discount_grater_than.dart';
import 'cartitemscreen/getnmaesortedbynme.dart';
import 'cartitemscreen/itemcount.dart';
import 'cartitemscreen/latestitem.dart';
import 'cartitemscreen/lessthan discount.dart';
import 'cartitemscreen/lessthanquentcard.dart';
import 'cartitemscreen/paginatedscreen.dart';
import 'cartitemscreen/price sorted.dart';
import 'cartitemscreen/pricerangedata.dart';
import 'cartitemscreen/qty_gratertthan.dart';
import 'cartitemscreen/recentcard.dart';
import 'cartitemscreen/searchdata.dart';

class AllDatabseQeuery extends StatefulWidget {
  const AllDatabseQeuery({super.key});

  @override
  State<AllDatabseQeuery> createState() => _AllDatabseQeueryState();
}

class _AllDatabseQeueryState extends State<AllDatabseQeuery> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            children: [
              ElevatedButton(
                  onPressed: () {
                    Get.to(BookingScreen());
                  },
                  child: Text("booking")),
              ElevatedButton(
                  onPressed: () {
                    Get.to(PaginationScreeenSorting());
                  },
                  child: Text("PaginationScreeenSorting")),
              ElevatedButton(
                  onPressed: () {
                    Get.to(PaginationScreeen());
                  },
                  child: Text("PaginationScreeen")),
              ElevatedButton(
                  onPressed: () {
                    Get.to(RecentCardList());
                  },
                  child: Text("RecentCardList")),
              ElevatedButton(
                  onPressed: () {
                    Get.to(CardFindByIdScreeen());
                  },
                  child: Text("CardFindByIdScreeen")),
              ElevatedButton(
                  onPressed: () {
                    Get.to(CategoryCardsScreen(
                      category: 'hello',
                    ));
                  },
                  child: Text("CategoryCardsScreen")),
              ElevatedButton(
                  onPressed: () {
                    Get.to(CardSearchScreen());
                  },
                  child: Text("CardSearchScreen")),
              ElevatedButton(
                  onPressed: () {
                    Get.to(CardListScreen());
                  },
                  child: Text("CardListScreen")),
              ElevatedButton(
                  onPressed: () {
                    Get.to(FindCardForConitonScreen());
                  },
                  child: Text("FindCardForConitonScreen")),
              ElevatedButton(
                  onPressed: () {
                    Get.to(PaginatedCardListScreen());
                  },
                  child: Text("PaginatedCardListScreen")),
              ElevatedButton(
                  onPressed: () {
                    Get.to(BatchUpdateScreen());
                  },
                  child: Text("BatchUpdateScreen")),
              ElevatedButton(
                  onPressed: () {
                    Get.to(AverageValueScreen());
                  },
                  child: Text("AverageValueScreen")),
              ElevatedButton(
                  onPressed: () {
                    Get.to(MaxValueScreen());
                  },
                  child: Text("MaxValueScreen")),
              ElevatedButton(
                  onPressed: () {
                    Get.to(DistinctNamesScreen());
                  },
                  child: Text("DistinctNamesScreen")),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => LatestItemsScreen()),
                  );
                },
                child: Text('View Latest Items'),
              ), ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ItemCountScreen()),
                  );
                },
                child: Text('ItemCountScreen'),
              ) ,ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => CardsWithQuantityGreaterThanScreen()),
                  );
                },
                child: Text('CardsWithQuantityGreaterThanScreen'),
              ),ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => CardsWithDiscountGreaterThanScreen()),
                  );
                },
                child: Text('CardsWithDiscountGreaterThanScreen'),
              ),ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => CardsInPriceRangeScreen()),
                  );
                },
                child: Text('CardsInPriceRangeScreen'),
              ),ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => CardsSortedByNameScreen()),
                  );
                },
                child: Text('CardsSortedByNameScreen'),
              ),ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => CardsWithQuantityLessThanScreen()),
                  );
                },
                child: Text('CardsWithQuantityLessThanScreen'),
              ),ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => CardsWithDiscountLessThanScreen()),
                  );
                },
                child: Text('CardsWithDiscountLessThanScreen'),
              ),ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => CardsSortedByPriceDescendingScreen()),
                  );
                },
                child: Text('CardsSortedByPriceDescendingScreen'),
              ),ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => CardsSortedByQuantityAscendingScreen()),
                  );
                },
                child: Text('CardsSortedByQuantityAscendingScreen'),
              ),ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => CardItemListPage()),
                  );
                },
                child: Text('CardItemListPage'),
              ),ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Soretdcardlistpagescreeen()),
                  );
                },
                child: Text('Soretdcardlistpagescreeen'),
              ),ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => AllCardAdded()),
                  );
                },
                child: Text('AllCardAdded'),
              ),ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => CardItemListScreen()),
                  );
                },
                child: Text('CardItemListScreen'),
              ),ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => YourPage()),
                  );
                },
                child: Text('getdate beforecretded data'),
              ),ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => PriceRangeCardList()),
                  );
                },
                child: Text('PriceRangeCardList'),
              ),

            ],
          ),
        ),
      ),
    );
  }
}
