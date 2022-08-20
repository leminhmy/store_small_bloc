import 'package:flutter/material.dart';
import 'package:store_small_bloc/views/widget/test_screen/bottomnav.dart';

class TestHomeScreen extends StatelessWidget {
  const TestHomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<String> listimg = ['assets/images/f.png', 'assets/images/g.png', 'assets/images/t.png', 'assets/images/no_image.png',];
    int indexPage = 0;
    PageController pageController = PageController(initialPage: 0, keepPage: true,);
    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      appBar: AppBar(
        title: Text("TestHome"),
        centerTitle: true,
      ),
      body: PageView.builder(
          controller: pageController,
          onPageChanged: (int page){
            indexPage = page;
          },
          itemCount: listimg.length,
          itemBuilder: (context, index) => Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(listimg[index]), fit: BoxFit.contain),
                ),
              )),
      bottomNavigationBar: StatefulBuilder(builder: (context,StateSetter setStateBottom) {
        pageController.addListener(() {
          setStateBottom((){});
        });

        return BuildBottomWidgetTest(
          changePage: (int value) {
            // pageController.jumpToPage(value);
            pageController.animateToPage(value, duration: const Duration(milliseconds: 300), curve: Curves.linear);
            setStateBottom((){});
          },
          indexPage: indexPage,
        );
      }),
    );
  }
}
