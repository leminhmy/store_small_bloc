import 'package:flutter/material.dart';


class BuildBottomWidgetTest extends StatelessWidget {
  const BuildBottomWidgetTest({Key? key, required this.indexPage, required this.changePage}) : super(key: key);
  final int indexPage;
  final ValueChanged<int> changePage;

  @override
  Widget build(BuildContext context) {
    List<IconData> listIconData = [
      Icons.home_outlined,
      Icons.messenger,
      Icons.shopping_cart_outlined,
      Icons.person
    ];
    int indexSelected = indexPage;
    return Container(
      height: 70,
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: List.generate(4, (index) => GestureDetector(
            onTap: (){
              changePage(index);
            },
            child: Icon(listIconData[index],color: indexSelected == index?Colors.red:Colors.black,))),
      ),
    );
  }
}
