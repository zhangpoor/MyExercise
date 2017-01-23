//
//  YZTBaiduMapHelper.h
//  BaiduExs
//
//  Created by zhangpoor on 17/1/20.
//  Copyright © 2017年 zhangpoor. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>




typedef NS_ENUM(NSInteger, LaunchOptionsDirectionsMode) {
    LaunchOptionsDirectionsModeDriving = 0,
    LaunchOptionsDirectionsModeTransit = 1,
    LaunchOptionsDirectionsModeWalking = 2,
};

typedef NS_ENUM(NSInteger, YZTBMpoiType){
    YZTBMpoiTypeComposite = 0,//综合排序
    YZTBMpoiTypeDistiance,//距离由近到远排序
};

typedef NS_ENUM(NSInteger, YZTRouteType){
    YZTRouteTpWalking = 0,  //步行
    YZTRouteTpDriving,      //驾车
    YZTRouteTpTransit,      //公交
    YZTRouteTpRiding        //骑行
};



typedef NS_ENUM(NSInteger, YZTRoutePolicyType)
{
    RPTP_NONE                   = -999,     //无设置
    RPTP_DRIVING_BLK_FIRST      = -1,       //躲避拥堵(自驾)
    RPTP_DRIVING_TIME_FIRST     = 0,        //最短时间(自驾)
    RPTP_DRIVING_DIS_FIRST      = 1,        //最短路程(自驾)
    RPTP_DRIVING_FEE_FIRST      = 2,        //少走高速(自驾)
    RPTP_TRANSIT_TIME_FIRST     = 3,		//较快捷(公交)
    RPTP_TRANSIT_TRANSFER_FIRST = 4,        //少换乘(公交)
    RPTP_TRANSIT_WALK_FIRST     = 5,		//少步行(公交)
    RPTP_TRANSIT_NO_SUBWAY      = 6,        //不坐地铁
    
};

@interface YZTBaiduLocModel : NSObject


@property(nonatomic,strong)CLLocation *location;


@end


@interface YZTBaiduGeoModel : NSObject

@property(nonatomic,copy)NSString *city;
@property(nonatomic,copy)NSString *district;
@property(nonatomic,copy)NSString *province;
@property(nonatomic,copy)NSString *address;

@property(nonatomic)CLLocationCoordinate2D geoLocation;

@end

@interface YZTBaiduPOIInfoModel : NSObject

///POI名称
@property (nonatomic, copy) NSString* name;
///POIuid
@property (nonatomic, copy) NSString* uid;
///POI地址
@property (nonatomic, copy) NSString* address;
///POI所在城市
@property (nonatomic, copy) NSString* city;
///POI电话号码
@property (nonatomic, copy) NSString* phone;
///POI邮编
@property (nonatomic, copy) NSString* postcode;
///POI类型，0:普通点 1:公交站 2:公交线路 3:地铁站 4:地铁线路
@property (nonatomic) int epoitype;
///POI坐标
@property (nonatomic) CLLocationCoordinate2D pt;
///是否有全景
@property (nonatomic, assign) BOOL panoFlag;


@end

@interface YZTBaiduPOIModel : NSObject


///本次POI搜索的总结果数
@property (nonatomic) int totalPoiNum;
///当前页的POI结果数
@property (nonatomic) int currPoiNum;
///本次POI搜索的总页数
@property (nonatomic) int pageNum;
///当前页的索引
@property (nonatomic) int pageIndex;
///POI列表，成员是YZTBaiduPOIInfoModel
@property (nonatomic, strong) NSArray* poiInfoList;


@end



/**
 百度授权回调

 @param isSuccess 是否成功
 @param errorStr  失败信息
 */
typedef void (^YZTBaiduAuthorizeCallback)(BOOL isSuccess,NSString *errorStr);


/**
 百度定位回调

 @param isSuccess   是否成功
 @param param       成功后返回信息 YZTBaiduParamModel类型对象
 @param errorStr    失败信息
 */
typedef void (^YZTBaiduLocateCallback)(BOOL isSuccess,YZTBaiduLocModel *param,NSString *errorStr);


/**
 百度地理编码/反地理编码回调

 @param isSuccess   是否成功
 @param geoParam    成功后返回信息 YZTBaiduParamModel类型对象
 @param geoErrorMsg 失败信息
 */
typedef void (^YZTBaiduGeoCodeCallback)(BOOL isSuccess,YZTBaiduGeoModel *geoParam,NSString *geoErrorMsg);



/**
 百度 周边查询回调

 @param isSuccess   是否成功
 @param poiParam    成功后返回信息
 @param poiErrorMsg 失败信息
 */
typedef void (^YZTBaiduNearByCallback)(BOOL isSuccess,YZTBaiduPOIModel *poiParam,NSString *poiErrorMsg);





@interface YZTBaiduMapHelper : NSObject

//@property (nonatomic, weak) id<YZTBaiduMapHelperDelegate> delegate;

#pragma mark- <基础类>
+ (YZTBaiduMapHelper *)shareMapHelper;


/**
 百度sdk授权

 @param callback YZTBaiduAuthorizeCallback类型回调
 */
- (void)yztBaiduAuthorize:(YZTBaiduAuthorizeCallback)callback;

#pragma mark- <功能类>
/**
 定位

 @param callback YZTBaiduLocateCallback类型回调
 */
- (void)yztBaiduLocate:(YZTBaiduLocateCallback)callback;



/**
 反地理编码

 @param coordinate  经纬度结构体
 @param callback    YZTBaiduLocateCallback类型回调
 */
- (void)yztBadiduReverseGeoCodeWithPoint:(CLLocationCoordinate2D)coordinate
                                callback:(YZTBaiduGeoCodeCallback)callback;





/**
 周边检索

 @param location 中心点经纬度
 @param index 分页索引,从0开始
 @param pageCapacity 分页容量，最大50
 @param radius 搜索范围,单位(米)
 @param keyword 搜索关键字
 @param sortType 排序类型 @see YZTBMpoiType
 @param callback YZTBaiduNearByCallback类型回调
 */
- (void)yztBaiduNearByWithLocation:(CLLocationCoordinate2D)location
                         pageIndex:(int)index
                      pageCapacity:(int)pageCapacity
                            radius:(int)radius
                           keyword:(NSString *)keyword
                          sortType:(YZTBMpoiType)sortType
                          callback:(YZTBaiduNearByCallback)callback;


/**
 周边检索 业务简化方法  (每页容量50条，搜索半径50km)

 @param location    中心点经纬度
 @param index       分页索引,从0开始
 @param keyword     搜索关键字
 @param callback    YZTBaiduNearByCallback类型回调
 */
-(void)yztBizNearByWithLocation:(CLLocationCoordinate2D)location
                      pageIndex:(int)index
                        keyword:(NSString *)keyword
                       callback:(YZTBaiduNearByCallback)callback;



/**
 获取百度map

 @return 返回BMKMapView
 */
- (UIView *)getBaiduMapView;
- (void)mapWillAppear;
- (void)mapWillDisappear;
- (void)clearMap;

- (void)mapMoveToLocation:(CLLocationCoordinate2D)point;


/**
 *  公交路线检索
 *
 *  @param startNode     起点节点信息
 *  @param endNode       终点节点信息
 *  @param city          所在城市
 *  @param transitPolicy 公交方案 @see BMKTransitPolicy
 */

/*
- (void)baiduMapTransitRouteSearchFrom:(BMKPlanNode *)startNode
                                    to:(BMKPlanNode *)endNode
                                  city:(NSString *)city
                         transitPolicy:(BMKTransitPolicy)transitPolicy;
*/
/**
 *  驾车路线检索
 *
 *  @param startNode   起点节点信息
 *  @param endNode     终点节点信息
 *  @param drivePolicy 驾车方案 @see BMKDrivingPolicy
 */
/*
- (void)baiduMapDriveRouteSearchFrom:(BMKPlanNode *)startNode
                                  to:(BMKPlanNode *)endNode
                         drivePolicy:(BMKDrivingPolicy)drivePolicy;
*/
/**
 *  步行路线检索
 *
 *  @param startNode  起点节点信息
 *  @param endNode    终点节点信息
 *  @param completion 路线结果
 */

/*
- (void)baiduMapWalkRouteSearchFrom:(BMKPlanNode *)startNode
                                 to:(BMKPlanNode *)endNode;

- (void)yztBaiduRouteSearch:(YZTRouteType)tp
                      start:(CLLocationCoordinate2D)startPoint
                        end:(CLLocationCoordinate2D)endPoint
                       city:(NSString *)city
                routePolicy:(YZTRoutePolicyType)rpTp
                   callback:(YZTBaiduRouteSearchCallback)callback;

*/


#pragma mark- <工具类>

/**
 判断定位服务是否开启

 @return YES开启，NO为开启
 */
- (BOOL)yztCheckLocationService;



/**
 *  计算两点距离
 *
 *  @param startPoint 起点坐标
 *  @param endPoint   终点坐标
 *
 *  @return 距离
 */
- (CLLocationDistance)baiduMapDistanceWithStartPoint:(CLLocationCoordinate2D)startPoint
                                            endPoint:(CLLocationCoordinate2D)endPoint;

/**
 *  根据距离计算缩放比
 *
 *  @param startPoint 起点坐标
 *  @param endPoint   终点坐标
 *
 *  @return 地图缩放比
 */
- (float)baiduMapAutoZoomLevelWithStartPoint:(CLLocationCoordinate2D)startPoint
                                    endPoint:(CLLocationCoordinate2D)endPoint;

/**
 *  跳转苹果地图客户端
 *
 *  @param endPoint       终点坐标
 *  @param directionsMode 导航模式 @see LaunchOptionsDirectionsMode
 */
- (void)baiduMapOpenAppleMapClientWithEndPoint:(CLLocationCoordinate2D)endPoint
                                directionsMode:(LaunchOptionsDirectionsMode)directionsMode;

/**
 *  判断是否安装百度地图客户端
 *
 *  @return 是否安装百度地图客户端
 */
- (BOOL)baiduMapCanOpenBaiduMapClient;

/**
 *  跳转百度地图客户端
 *
 *  @param endPoint       终点坐标
 *  @param directionsMode 导航模式 @see LaunchOptionsDirectionsMode
 */
- (void)baiduMapOpenBaiduMapClientWithEndPoint:(CLLocationCoordinate2D)endPoint
                                directionsMode:(LaunchOptionsDirectionsMode)directionsMode;

/**
 *  判断是否安装高德地图客户端
 *
 *  @return 是否安装高德地图客户端
 */
- (BOOL)baiduMapCanOpenGaodeMapClient;

/**
 *  跳转高德地图客户端(路径规划)
 *
 *  @param endPoint       终点坐标
 *  @param directionsMode 导航模式
 */
- (void)baiduMapOpenGaodeMapClientWithEndPoint:(CLLocationCoordinate2D)endPoint
                                directionsMode:(LaunchOptionsDirectionsMode)directionsMode;

/**
 *  跳转高德地图客户端(直接导航)
 *
 *  @param endPoint 终点坐标
 */
- (void)baiduMapOpenGaodeMapNavClientWithEndPoint:(CLLocationCoordinate2D)endPoint;

@end
