import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_swiper_view/flutter_swiper_view.dart';
import 'package:project/pages/home/web_view_page.dart';

import '../../repository/api/wan_api.dart';
import '../../repository/model/home_banner_model.dart';
import '../../repository/model/home_list_model.dart';

class HomeListPage extends StatefulWidget {
  const HomeListPage({super.key});

  @override
  State<HomeListPage> createState() => _HomeListPageState();
}

class _HomeListPageState extends State<HomeListPage> {
  List<HomeBannerModel?>? bannerList;
  List<HomeListItemData?>? articleList;

  @override
  void initState() {
    super.initState();

    // 使用 Future.wait 同时等待两个异步操作
    Future.wait([getBannerData(), getArticleList()]).then((_) {
      setState(() {});
    });
  }

  Future<void> getArticleList() async {
    final value = await WanApi.instance().homeList('1');
    articleList = value?.datas;
  }

  Future<void> getBannerData() async {
    bannerList = await WanApi.instance().bannerList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(title: const Text("Hello Flutter")),
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
                        child: Image.network(
                            bannerList?[index]?.imagePath ?? '',
                            fit: BoxFit.fill));
                  },
                  indicatorLayout: PageIndicatorLayout.NONE,
                  pagination: const SwiperPagination(),
                  autoplay: true,
                  itemCount: bannerList?.length ?? 0,
                  control: const SwiperControl(),
                ),
              ),
              ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return GestureDetector(
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return WebViewPage(title: "hello world ${index + 1}");
                        }));
                      },
                      child: _listItemView(index));
                },
                itemCount: articleList?.length ?? 0,
              )
            ],
          ),
        )));
  }

  Widget _listItemView(int index) {
    var artical = articleList?[index];
    return Container(
        padding:
            EdgeInsets.only(top: 8.h, bottom: 8.h, left: 10.w, right: 10.w),
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
                    padding: EdgeInsets.symmetric(vertical: 0, horizontal: 6.w),
                    child: Text(artical?.author ?? '')),
                const Expanded(child: SizedBox()),
                Text(artical?.niceShareDate ?? ''),
                SizedBox(width: 8.w),
                const Text(
                  "顶置",
                  style: TextStyle(
                      color: Colors.blueAccent, fontWeight: FontWeight.w600),
                ),
              ],
            ),
            Container(
                width: double.infinity,
                margin: EdgeInsets.symmetric(vertical: 10.h),
                child: Text(
                  artical?.title ?? '',
                  textAlign: TextAlign.left,
                )),
            Row(
              children: [
                Text("干货资源",
                    style: TextStyle(
                        color: Colors.green,
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w600)),
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
