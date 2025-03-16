import 'package:flutter/cupertino.dart';

import '../../repository/api/wan_api.dart';
import '../../repository/model/home_banner_model.dart';

class BannerModel with ChangeNotifier {
  List<HomeBannerModel> ? bannerList;
  ///获取Banner列表
  Future getBannerList() async {
    List<HomeBannerModel?>? banner = await WanApi.instance().bannerList();
    return banner;
  }
}
