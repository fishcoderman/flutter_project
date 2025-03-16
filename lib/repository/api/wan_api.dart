import 'package:dio/dio.dart';
import 'package:project/http/dio_instance.dart';
import 'package:project/repository/model/home_banner_model.dart';
import 'package:project/repository/model/home_list_model.dart';

class WanApi {
  static WanApi? _instance;

  WanApi._internal();

  static WanApi instance() {
    return _instance ??= WanApi._internal();
  }

  ///获取首页文章列表
  Future<HomeListModel?> homeList(String pageCount) async {
    Response response =
    await DioInstance.instance().get(path: "article/list/$pageCount/json");
    return HomeListModel.fromJson(response.data);
  }

  ///获取置顶文章列表
  Future<HomeTopListModel> topHomeList() async {
    Response response =
    await DioInstance.instance().get(path: "article/top/json");
    return HomeTopListModel.fromJson(response.data);
  }

  ///获取首页banner数据
  Future<List<HomeBannerModel?>?> bannerList() async {
    Response response = await DioInstance.instance().get(path: "banner/json");
    var model = HomeBannerListModel.fromJson(response.data);
    return model.bannerList;
  }

  ///收藏
  Future<bool> collect(String id) async {
    Response response =
    await DioInstance.instance().post(path: "lg/collect/$id/json");
    if (response.data != null && response.data == true) {
      return true;
    }
    return false;
  }

  ///取消收藏文章
  Future<bool> cancelCollect(String id) async {
    Response response = await DioInstance.instance()
        .post(path: "lg/uncollect_originId/$id/json");
    if (response.data != null && response.data == true) {
      return true;
    }
    return false;
  }
}
