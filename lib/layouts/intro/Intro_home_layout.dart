import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/shared/cubits/cubit_login/login_cubit.dart';
import 'package:shop_app/shared/cubits/cubit_login/login_states.dart';
import 'package:shop_app/shared/other/components.dart';
import 'package:shop_app/shared/setting/vars.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class IntroHomeLayout extends StatelessWidget {
  IntroHomeLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginCubit, LoginStates>(
      listener: (BuildContext context, state) {},
      builder: (BuildContext context, state) {
        cubit = LoginCubit.get(context);
        return myScaffold(context);
      },
    );
  }

  // vars
  late LoginCubit cubit;
  List<bordingModel> bords = [
    bordingModel('${Vars.imagesPath}/logo/logo.png', 'title 1', 'body 1'),
    bordingModel('${Vars.imagesPath}/logo/gaming.png', 'title 2', 'body 2'),
    bordingModel('${Vars.imagesPath}/logo/tiger.png', 'title 3', 'body 3'),
  ];

  Scaffold myScaffold(BuildContext context) => Scaffold(
        appBar: myAppBar(context),
        body: mainContainer(context),
        // floatingActionButton: fltb(cubit),
      );

  AppBar myAppBar(context) => AppBar(
        title: const Text('titlse'),
        actions: [
          TextButton(
              onPressed: () => cubit.skipIntro(context),
              child: const Text('SKIP',style: TextStyle( fontSize: 20),))
        ],
      );

  FloatingActionButton fltb() => FloatingActionButton(
        onPressed: () {

        },
        child: const Icon(Icons.dark_mode),
      );

  // my container
  Widget mainContainer(BuildContext context) => Container(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Expanded(child: pageViewer(context)),
              forwardButton(context)
            ],
          ),
        ),
      );

  // page viewer
  Widget pageViewer(BuildContext context) => PageView.builder(
        controller: cubit.pageIntroConrol,
        physics: const BouncingScrollPhysics(),
        itemBuilder: (context, index) => oneCard(bords[index]),
        itemCount: bords.length,
        onPageChanged: (index) {
          cubit.isThislast(index, bords.length, context);
        },
      );

  // button next page
  Widget forwardButton(BuildContext context) => Row(children: [
        SmoothPageIndicator(
          controller: cubit.pageIntroConrol,
          count: bords.length,
          effect: ExpandingDotsEffect(spacing: 10, activeDotColor: Vars.pryClr,),
        ),
        const Spacer(),
        FloatingActionButton(
          onPressed: cubit.nextPageControl(context),
          child: const Icon(Icons.arrow_forward_ios),
        )
      ]);

  Widget oneCard( bordingModel model) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Expanded(
        child: Center(
          child: Image.asset(
            model.image,
            height: 300,
            fit: BoxFit.scaleDown,
          ),
        ),
      ),
      Components.box(h: 20),
      Components.simpleText(model.title, size: 30),
      Components.box(h: 40),
      Components.simpleText(model.body, size: 20),
      Components.box(h: 40)
    ],
  );
}

class bordingModel {
  String image;
  String title;
  String body;

  bordingModel(this.image, this.title, this.body);
}
