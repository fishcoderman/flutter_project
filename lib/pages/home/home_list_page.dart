import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_swiper_view/flutter_swiper_view.dart';
import 'package:project/pages/home/web_view_page.dart';

class HomeListPage extends StatefulWidget {
  const HomeListPage({super.key});

  @override
  State<HomeListPage> createState() => _HomeListPageState();
}

class _HomeListPageState extends State<HomeListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(title: const Text("home")),
        body: SafeArea(
            child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 150.h,
                width: double.infinity,
                child: Swiper(
                  itemBuilder: (context, index) {
                    return Container(
                      height: 150.h,
                      color: Colors.deepOrangeAccent,
                    );
                  },
                  indicatorLayout: PageIndicatorLayout.NONE,
                  pagination: const SwiperPagination(),
                  autoplay: true,
                  itemCount: 5,
                  control: const SwiperControl(),
                ),
              ),
              ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return GestureDetector(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) {
                          return WebViewPage(title: "hello world ${index + 1}");
                        }));
                      },
                      child: _listItemView(index));
                },
                itemCount: 16,
              )
            ],
          ),
        )));
  }

  Widget _listItemView(int index) {
    return Container(
        padding: EdgeInsets.only(top: 8.h, bottom: 8.h, left: 10.w, right: 10.w),
        margin: EdgeInsets.only(top: 8.h, bottom: 8.h, left: 10.w, right: 10.w),
        decoration: BoxDecoration(
            border: Border.all(color: Colors.black12, width: 0.5.r),
            borderRadius: BorderRadius.circular(12.0)),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center, // 水平方向居中（可选）
              // crossAxisAlignment: CrossAxisAlignment.center, // 竖直方向居中
              children: [
                Image.asset(
                  "assets/images/ic_launcher.png",
                  width: 20.r,
                  height: 20.r,
                ),
                Padding(
                    padding: EdgeInsets.symmetric(vertical: 0, horizontal: 6.w), child: Text("作者")),
                const Expanded(child: SizedBox()),
                const Text("2025-12-25 20:55:56"),
                SizedBox(width: 8.w),
                const Text(
                  "顶置",
                  style: TextStyle(color: Colors.blueAccent, fontWeight: FontWeight.w600),
                ),
              ],
            ),
            Container(
                margin: EdgeInsets.symmetric(vertical: 6.h),
                child: const Text("标题的内容为阿克苏电话费啊看到回复杰卡斯东方红看见啊好的复活卡健身房等哈看到回复卡收到回复")),
            Row(
              children: [
                Text("干货资源",
                    style: TextStyle(
                        color: Colors.green, fontSize: 13.sp, fontWeight: FontWeight.w600)),
                const Expanded(child: SizedBox()),
                Image.asset(
                  "assets/images/img_collect_grey.png",
                  width: 20.r,
                  height: 20.r,
                ),
              ],
            )
          ],
        ));
    // return Text(
    //   'item-${index}',
    //   style: TextStyle(color: Colors.indigoAccent, fontSize: 24.sp),
    // );
  }
}
