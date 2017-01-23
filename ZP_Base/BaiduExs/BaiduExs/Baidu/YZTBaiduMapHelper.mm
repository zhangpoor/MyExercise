//
//  YZTBaiduMapHelper.m
//  BaiduExs
//
//  Created by zhangpoor on 17/1/20.
//  Copyright © 2017年 zhangpoor. All rights reserved.
//

#import "YZTBaiduMapHelper.h"

//目前定位全部功能依赖
#import <BaiduMapKit/BaiduMapAPI_Location/BMKLocationComponent.h>
//目前反地理编码、 Poi功能（周边查询） 等全部功能依赖
#import <BaiduMapKit/BaiduMapAPI_Search/BMKSearchComponent.h>

//线路检索_地图
#import <BaiduMapKit/BaiduMapAPI_Map/BMKMapComponent.h>



//根据不同的bundle id 去 百度开放平台去注册个。。这个对应的是 com.pingan.yztDept
static NSString * const kAppKeyForDev_dept  = @"Powa2XFyxxZ287ErsGcpgxEnSUeEhAww";


typedef void (^YZTBaiduRouteSearchCallback)(BOOL isSuccess,BMKPolyline *line,NSString *routeSearchErrorMsg);




@implementation YZTBaiduLocModel


@end




@interface YZTBaiduGeoModel()

@property (nonatomic,strong)BMKReverseGeoCodeOption *rGeoOption;
@property (nonatomic,copy)YZTBaiduGeoCodeCallback aCallback;


+(YZTBaiduGeoModel *)createGeoTaskObj:(BMKReverseGeoCodeOption *)opt callback:(YZTBaiduGeoCodeCallback)callback;

@end


@implementation YZTBaiduGeoModel


+(YZTBaiduGeoModel *)createGeoTaskObj:(BMKReverseGeoCodeOption *)opt
                             callback:(YZTBaiduGeoCodeCallback)callback
{
    YZTBaiduGeoModel *geoObj    = [[YZTBaiduGeoModel alloc]init];
    geoObj.rGeoOption           = opt;
    geoObj.aCallback            = callback;
    
    return geoObj;
}


@end






@implementation YZTBaiduPOIInfoModel

+(YZTBaiduPOIInfoModel *)createModelBy:(BMKPoiInfo *)bmkModel
{
    YZTBaiduPOIInfoModel *_model = [[YZTBaiduPOIInfoModel alloc]init];
    
    if (bmkModel) {
        _model.name     = bmkModel.name;
        _model.uid      = bmkModel.uid;
        _model.address  = bmkModel.address;
        _model.city     = bmkModel.city;
        _model.phone    = bmkModel.phone;
        _model.postcode = bmkModel.postcode;
        _model.epoitype = bmkModel.epoitype;
        _model.pt       = bmkModel.pt;
        _model.panoFlag = bmkModel.panoFlag;
    }
    
    return _model;
}


@end

@implementation YZTBaiduPOIModel

@end


@interface YZTBaiduMapHelper ()
<
BMKGeneralDelegate,
BMKLocationServiceDelegate,
BMKGeoCodeSearchDelegate,
BMKPoiSearchDelegate,
BMKRouteSearchDelegate
>


@property (nonatomic, strong) BMKMapManager         *mapManager;
@property (nonatomic, strong) BMKLocationService    *locationService;
@property (nonatomic, strong) BMKGeoCodeSearch      *geoCodeSearch;

@property (nonatomic, strong) BMKMapView            *mapView;
//@property (nonatomic, strong) BMKRouteSearch *routeSearch;



@property (nonatomic, assign) BOOL isPermission;
@property (nonatomic,strong)NSMutableArray *authorizeQueue;

@property (nonatomic,strong)NSMutableArray *locateQueue;

@property (nonatomic,strong)NSMutableArray *geoQueue;
@property (nonatomic) BOOL isOnGeo;


@property (nonatomic,strong)NSMutableDictionary *nearbyQueue;
@property (nonatomic,strong)NSMutableDictionary *nearbyMap;


@property (nonatomic,strong)NSMutableDictionary *routeQueue;
@property (nonatomic,strong)NSMutableDictionary *routeMap;


//@property (nonatomic,copy) void(^searchErrorCodeFunc)(CGFloat height, CGFloat margin);


@end

@implementation YZTBaiduMapHelper

#pragma mark - public
+ (YZTBaiduMapHelper *)shareMapHelper
{
    static YZTBaiduMapHelper *baiduMapHelper = nil;
    static dispatch_once_t onceToken = 0;
    dispatch_once(&onceToken, ^{
        baiduMapHelper = [[self alloc] init];
        
        baiduMapHelper.authorizeQueue   = [NSMutableArray array];
        baiduMapHelper.locateQueue      = [NSMutableArray array];
        baiduMapHelper.geoQueue         = [NSMutableArray array];

        baiduMapHelper.nearbyQueue      = [NSMutableDictionary dictionary];
        baiduMapHelper.nearbyMap        = [NSMutableDictionary dictionary];
        baiduMapHelper.routeQueue       = [NSMutableDictionary dictionary];
        baiduMapHelper.routeMap         = [NSMutableDictionary dictionary];
        baiduMapHelper.isPermission     = NO;
        baiduMapHelper.isOnGeo          = NO;
    });
    return baiduMapHelper;
}


#pragma mark- <授权模块>
- (void)yztBaiduAuthorize:(YZTBaiduAuthorizeCallback)callback
{

    if (self.isPermission) {
        if (callback) {
            callback(YES,nil);
        }
        return;
    }
    
    
    
    if (callback) {
        [self.authorizeQueue addObject:callback];
    }
    if (self.authorizeQueue.count > 1)
    {
        return;
    }
    
    
    
    NSString *_baiduAppKey = kAppKeyForDev_dept;
    
    
    BOOL flag = [self.mapManager start:_baiduAppKey generalDelegate:self];
    
    if (!flag) {
        [self authorizeResultAction:NO info:@"初始化鉴权失败"];
    }
}

- (void)authorizeResultAction:(BOOL)isSuccess
                         info:(NSString *)info
{
    while (self.authorizeQueue.count > 0) {
        
        YZTBaiduAuthorizeCallback _callback = self.authorizeQueue[0];
        [self.authorizeQueue removeObjectAtIndex:0];
        if (_callback) {
            _callback(isSuccess,info);
        }
        
        
        
    }
}

#pragma mark <== BMKGeneralDelegate ==>
- (void)onGetPermissionState:(int)iError
{
    if (0 == iError) {
        NSLog(@"yzt_baidu_百度地图授权成功");
        self.isPermission =YES;
        [self yztBaiduLocate:
         ^(BOOL isSuccess, YZTBaiduLocModel *param, NSString *errorStr) {
            NSLog(@"yzt_baidu_首次定位:%@",isSuccess?@"ok":@"not");
        }];
        [self authorizeResultAction:YES info:nil];
        
    }
    else {
        NSLog(@"yzt_baidu_百度地图授权失败");
        self.isPermission = NO;
        [self authorizeResultAction:NO info:@"鉴权失败"];
    }
}

- (void)onGetNetworkState:(int)iError
{
    if (0 == iError) {
        NSLog(@"yzt_baidu_网络连接");
    }
    else {
        NSLog(@"yzt_baidu_网络未连接");
    }
}





#pragma mark- <定位模块>
- (void)yztBaiduLocate:(YZTBaiduLocateCallback)callback
{
    if (callback) {
        [self.locateQueue addObject:callback];
    }
    if (self.locateQueue.count > 1) {
        
        return;
    }
    __weak typeof(self) _weakSelf = self;

    
    [self yztBaiduAuthorize:^(BOOL isSuccess, NSString *errorStr) {
        if (isSuccess) {
            [_weakSelf.locationService startUserLocationService];
        }
        else
        {
            [_weakSelf locateResultAction:NO
                                    param:nil
                                     info:@"请在[系统设置]中打开定位开关"];
             NSLog(@"yzt_baidu_百度地图yztBaiduLocate定位失败: %@",errorStr);
             

        }
    }];
}

- (void)locateResultAction:(BOOL)isSuccess
                     param:(YZTBaiduLocModel *)param
                      info:(NSString *)info
{
    if (self.isPermission) {
        [self.locationService stopUserLocationService];
    }
    while (self.locateQueue.count > 0) {
        
        YZTBaiduLocateCallback _callback = self.locateQueue[0];
        
        [self.locateQueue removeObjectAtIndex:0];
        
        if (_callback) {
            _callback(isSuccess,param,info);
        }
    }
}

#pragma mark <== BMKLocationServiceDelegate ==>
- (void)didFailToLocateUserWithError:(NSError *)error
{
    NSLog(@"yzt_baidu_百度地图定位失败: %@",error);
    [self locateResultAction:NO
                       param:nil
                        info:@"请在[系统设置]中打开定位开关"];
}

- (void)didUpdateBMKUserLocation:(BMKUserLocation *)userLocation
{
    NSLog(@"yzt_baidu_百度地图定位成功: %@",userLocation);
    
    YZTBaiduLocModel *param   = [[YZTBaiduLocModel alloc]init];
    param.location              = userLocation.location;
    
    [self locateResultAction:YES
                       param:param
                        info:nil];
}

/* 暂未使用的回调
 - (void)willStartLocatingUser
 {
 
 }
 
 - (void)didStopLocatingUser
 {
 
 }
 
 
 - (void)didUpdateUserHeading:(BMKUserLocation *)userLocation
 {
 
 }
 */


#pragma mark- <地理编码/反地理编码模块>
- (void)yztBadiduReverseGeoCodeWithPoint:(CLLocationCoordinate2D)coordinate
                                callback:(YZTBaiduGeoCodeCallback)callback
{
    BMKReverseGeoCodeOption *option = [[BMKReverseGeoCodeOption alloc] init];
    option.reverseGeoPoint          = coordinate;
    
    [self.geoQueue addObject:[YZTBaiduGeoModel createGeoTaskObj:option callback:callback]];
    
    if (!self.isOnGeo) {
        [self yztBadiduReverseGeoCodeWithOption:option
                                       callback:callback];
    }

}


- (void)yztBadiduReverseGeoCodeWithOption:(BMKReverseGeoCodeOption *)option
                                 callback:(YZTBaiduGeoCodeCallback)callback
{
    self.isOnGeo = YES;
    
    __weak typeof(self) _weakSelf = self;
    
    [self yztBaiduAuthorize:^(BOOL isSuccess, NSString *errorStr) {
        if (isSuccess) {


            BOOL flag = [self.geoCodeSearch reverseGeoCode:option];
            if (!flag) {
                [_weakSelf geoResultAction:NO
                                    result:nil
                                 errorInfo:@"反地理编码操作失败"];
            }
            
            
        }
        else
        {
            
            NSString *_eMsg = @"反地理编码失败";
            NSLog(@"yzt_baidu_ReverseGeo_%@",_eMsg);

            [_weakSelf geoResultAction:NO
                                result:nil
                             errorInfo:_eMsg];
            
        }
    }];
}

-(void)geoResultAction:(BOOL)isSuccess
                result:(BMKReverseGeoCodeResult *)result
             errorInfo:(NSString *)info
{
    if (self.geoQueue.count > 0) {
        YZTBaiduGeoModel *_geoModel = self.geoQueue[0];
        YZTBaiduGeoCodeCallback _callback = _geoModel.aCallback;
        
        
        if (_callback) {
            YZTBaiduGeoModel *param = nil;
            if (isSuccess) {
                param   = [[YZTBaiduGeoModel alloc]init];
                param.geoLocation = result.location;
                param.city      = result.addressDetail.city;
                param.district  = result.addressDetail.district;
                param.province  = result.addressDetail.province;
                param.address   = result.address;
                
            }
            
            _callback(isSuccess,param,info);
        }
        
        [self.geoQueue removeObjectAtIndex:0];
    }
    

    
    if (self.geoQueue.count > 0) {
        YZTBaiduGeoModel *_geoModel = self.geoQueue[0];
        [self yztBadiduReverseGeoCodeWithOption:_geoModel.rGeoOption
                                       callback:_geoModel.aCallback];
    }
    else
    {
        self.isOnGeo = NO;
    }

    
    
}


#pragma mark <== BMKGeoCodeSearchDelegate ==>
- (void)onGetReverseGeoCodeResult:(BMKGeoCodeSearch *)searcher
                           result:(BMKReverseGeoCodeResult *)result
                        errorCode:(BMKSearchErrorCode)error
{
    NSLog(@"yzt_baidu_onGetReverseGeoCodeResult:%@",result.address);
    
    BOOL _flag = NO;
    NSString *_errorMsg = nil;
    
    if (error == BMK_SEARCH_NO_ERROR) {
        _flag = YES;
    }
    else
    {
        _errorMsg = [self searchErrorInfo:error];
    }

    [self geoResultAction:_flag
                   result:result
                errorInfo:_errorMsg];
    
}





#pragma mark- <周边查询>
-(void)yztBizNearByWithLocation:(CLLocationCoordinate2D)location
                      pageIndex:(int)index
                        keyword:(NSString *)keyword
                       callback:(YZTBaiduNearByCallback)callback
{
    [self yztBaiduNearByWithLocation:location
                           pageIndex:index
                        pageCapacity:50
                              radius:50000
                             keyword:keyword
                            sortType:YZTBMpoiTypeDistiance callback:callback];
}


- (void)yztBaiduNearByWithLocation:(CLLocationCoordinate2D)location
                         pageIndex:(int)index
                      pageCapacity:(int)pageCapacity
                            radius:(int)radius
                           keyword:(NSString *)keyword
                          sortType:(YZTBMpoiType)sortType
                          callback:(YZTBaiduNearByCallback)callback
{
     __weak typeof(self) _weakSelf = self;
    [self yztBaiduAuthorize:^(BOOL isSuccess, NSString *errorStr) {

        if (isSuccess) {
            BMKNearbySearchOption *option   = [[BMKNearbySearchOption alloc] init];
            option.location                 = location;
            option.pageIndex                = index;
            option.pageCapacity             = pageCapacity;
            option.radius                   = radius;
            option.keyword                  = keyword;
            option.sortType                 = (BMKPoiSortType)sortType;

            
            BMKPoiSearch *poiSearch = [[BMKPoiSearch alloc]init];
            poiSearch.delegate      = _weakSelf;
            
            if (callback) {
                
                NSNumber *_key = [NSNumber numberWithDouble:[[NSDate date] timeIntervalSince1970]];
                
                
                [_weakSelf.nearbyQueue setObject:callback forKey:_key];
                [_weakSelf.nearbyMap setObject:poiSearch forKey:_key];
                
            }
            
            BOOL _flag = [poiSearch poiSearchNearBy:option];
            if (!_flag) {
                
                [_weakSelf nearbyResultAction:_flag
                                     searcher:poiSearch
                                       result:nil
                                    errorInfo:@"执行搜索失败"];
                
            }
        }
        else
        {
            NSString *_eMsg =[NSString stringWithFormat:@"搜索失败: %@",errorStr];
            NSLog(@"yzt_baidu_yztNearBy_%@",_eMsg);
            
            if (callback) {
                callback(NO,nil,_eMsg);
            }
            
            
        }
    }];

}

-(void)nearbyResultAction:(BOOL)isSuccess
                 searcher:(BMKPoiSearch *)searcher
                   result:(BMKPoiResult *)result
                errorInfo:(NSString *)info
{
    NSLog(@"yzt_baidu_nearbyResult:%@",
           isSuccess?[NSString stringWithFormat:@"成功搜索到:%d条信息",result.totalPoiNum]:info);
    
    
    id _key = nil;
    
    for (NSNumber *key in self.nearbyMap.allKeys) {
        if ([searcher isEqual:self.nearbyMap[key]]) {
            _key = key;
            break;
        }
    }
    
    if (_key) {
        YZTBaiduNearByCallback _callback = self.nearbyQueue[_key];
        
        
        if (_callback) {
            
            YZTBaiduPOIModel *param = nil;
            
            if (isSuccess) {
                param               = [[YZTBaiduPOIModel alloc]init];
                param.totalPoiNum   = result.totalPoiNum;
                param.currPoiNum    = result.currPoiNum;
                param.pageNum       = result.pageNum;
                param.pageIndex     = result.pageIndex;
                
                NSMutableArray *_ary = [NSMutableArray array];
                if (result.poiInfoList) {
                    for (BMKPoiInfo *poiInfo in result.poiInfoList) {
                        [_ary addObject:[YZTBaiduPOIInfoModel createModelBy:poiInfo]];
                    }
                }
                
                
                param.poiInfoList   = _ary;

            }
            
            _callback(isSuccess,param,info);
        }
        
        
        [self.nearbyQueue removeObjectForKey:_key];
        [self.nearbyMap removeObjectForKey:_key];
    }
    
    
    searcher.delegate                 = nil;
    searcher                          = nil;
    
}


#pragma mark <== BMKPoiSearchDelegate ==>

- (void)onGetPoiResult:(BMKPoiSearch *)searcher
                result:(BMKPoiResult *)poiResult
             errorCode:(BMKSearchErrorCode)errorCode
{
    BOOL flag = NO;
    NSString *_errorMsg = nil;
    
    if (errorCode == BMK_SEARCH_NO_ERROR) {
        flag = YES;
    }
    else
    {
        _errorMsg = [self searchErrorInfo:errorCode];
    }


    [self nearbyResultAction:flag
                    searcher:searcher
                      result:poiResult
                   errorInfo:_errorMsg];
    
}


/**
 *返回POI详情搜索结果
 *@param searcher 搜索对象
 *@param poiDetailResult 详情搜索结果
 *@param errorCode 错误号，@see BMKSearchErrorCode

- (void)onGetPoiDetailResult:(BMKPoiSearch*)searcher result:(BMKPoiDetailResult*)poiDetailResult errorCode:(BMKSearchErrorCode)errorCode;
 

 *返回POI室内搜索结果
 *@param searcher 搜索对象
 *@param poiIndoorResult 搜索结果列表
 *@param errorCode 错误号，@see BMKSearchErrorCode
 
- (void)onGetPoiIndoorResult:(BMKPoiSearch*)searcher result:(BMKPoiIndoorResult*)poiIndoorResult errorCode:(BMKSearchErrorCode)errorCode;
*/


#pragma mark- <地图>
- (UIView *)getBaiduMapView
{
    if (!_mapView) {
        _mapView                    = [[BMKMapView alloc] init];
        //_mapView.delegate = self;
        _mapView.mapType            = BMKMapTypeStandard;
        _mapView.showsUserLocation  = YES;
        
        BMKLocationViewDisplayParam *param  = [[BMKLocationViewDisplayParam alloc]init];
        param.isRotateAngleValid            = true;//跟随态旋转角度是否生效
        param.isAccuracyCircleShow          = true;//精度圈是否显示
        param.locationViewOffsetX           = 0;//定位偏移量(经度)
        param.locationViewOffsetY           = 0;//定位偏移量（纬度）
        [_mapView updateLocationViewWithParam:param];
    }
    return self.mapView;
}

- (void)mapWillAppear
{
    if (_mapView) {
        [self.mapView viewWillAppear];
    }
    
}

- (void)mapWillDisappear
{
    if (_mapView) {
        [self.mapView viewWillDisappear];
    }
}

- (void)clearMap
{
    if (_mapView) {
        _mapView.delegate = nil;
        _mapView = nil;
        
        
        NSLog(@"yzt_baidu_clearMap");
    }

}

#pragma mark 地图操作^
- (void)mapMoveToLocation:(CLLocationCoordinate2D)point
{
    if (_mapView) {
        [self.mapView setCenterCoordinate:point];
        self.mapView.showsUserLocation = YES;
    }
}


#pragma mark- <线路检索>

- (void)yztBaiduRouteSearch:(YZTRouteType)tp
                      start:(CLLocationCoordinate2D)startPoint
                        end:(CLLocationCoordinate2D)endPoint
                       city:(NSString *)city
                routePolicy:(YZTRoutePolicyType)rpTp
                   callback:(YZTBaiduRouteSearchCallback)callback

{
    
    
    __block BMKBaseRoutePlanOption *option = nil;
    switch (tp) {
        case YZTRouteTpWalking:
        {
            option = [[BMKWalkingRoutePlanOption alloc] init];
        }
            break;
        case YZTRouteTpTransit:
        {
            BMKTransitRoutePlanOption *_option  = [[BMKTransitRoutePlanOption alloc] init];
            _option.transitPolicy               = (BMKTransitPolicy)rpTp;
            _option.city                        = city;
            option                              = _option;
        }
            break;
        case YZTRouteTpDriving:
        {
            BMKDrivingRoutePlanOption *_option  = [[BMKDrivingRoutePlanOption alloc] init];
            _option.drivingPolicy               = (BMKDrivingPolicy)rpTp;

            option                              = _option;
        }
            break;
        case YZTRouteTpRiding:
        {
            option  = [[BMKRidingRoutePlanOption alloc] init];
        }
            break;
        default:
        {
            NSLog(@"yzt_baidu_RouteSearch:未确定搜索类型");
            if (callback) {
                callback(NO,nil,@"未确定搜索类型");
            }
            
            return;
        }
            break;
    }
    
    BMKPlanNode *_stNode    = [[BMKPlanNode alloc]init];
    _stNode.pt              = startPoint;
    BMKPlanNode *_endNode   = [[BMKPlanNode alloc]init];
    _endNode.pt             = endPoint;
    option.from             = _stNode;
    option.to               = _endNode;
    
    __weak typeof(self) _weakSelf = self;
    [self yztBaiduAuthorize:^(BOOL isSuccess, NSString *errorStr) {
        
        if (isSuccess) {

            
            BMKRouteSearch *routeSearch     = [[BMKRouteSearch alloc]init];
            routeSearch.delegate            = _weakSelf;
            
            
            
            BOOL _flag = NO;
            NSString *_str = @"线路搜索执行失败";
            switch (tp) {
                case YZTRouteTpWalking:
                {
                    _flag = [routeSearch walkingSearch:(BMKWalkingRoutePlanOption *)option];
                    _str = @"步行线路搜索执行失败";
                }
                    break;
                case YZTRouteTpTransit:
                {
                    _flag = [routeSearch transitSearch:(BMKTransitRoutePlanOption *)option];
                    _str = @"公交线路搜索执行失败";
                }
                    break;
                case YZTRouteTpDriving:
                {
                    _flag = [routeSearch drivingSearch:(BMKDrivingRoutePlanOption *)option];
                    _str = @"驾车线路搜索执行失败";
                }
                    break;
                case YZTRouteTpRiding:
                {
                    _flag = [routeSearch ridingSearch:(BMKRidingRoutePlanOption *)option];
                    _str = @"骑行线路搜索执行失败";
                }
                    break;
                default:
                {
                }
                    break;
            }
            
            if (_flag) {
                
                if (callback) {
                    
                    NSNumber *_key = [NSNumber numberWithDouble:[[NSDate date] timeIntervalSince1970]];
                    
                    
                    [_weakSelf.routeQueue setObject:callback forKey:_key];
                    [_weakSelf.routeMap setObject:routeSearch forKey:_key];
                    
                }
                
            }
            else{
                NSString *_eMsg =[NSString stringWithFormat:@"搜索失败: %@",_str];
                NSLog(@"yzt_baidu_RouteSearch_%@",_eMsg);
                
                if (callback) {
                    callback(NO,nil,_eMsg);
                }
            }
        }
        else
        {
            NSString *_eMsg =[NSString stringWithFormat:@"搜索失败: %@",errorStr];
            NSLog(@"yzt_baidu_RouteSearch_%@",_eMsg);
            
            if (callback) {
                callback(NO,nil,_eMsg);
            }
        }
    }];
    
    
    
    
}


-(void)routeSearchResultAction:(BOOL)isSuccess
                      searcher:(BMKRouteSearch *)searcher
                        result:(BMKPolyline *)result
                     errorInfo:(NSString *)info
{
    NSLog(@"yzt_baidu_routeSearchResult_errorInfo:%@",info);
    
    id _key = nil;
    
    for (NSNumber *key in self.routeMap.allKeys) {
        if ([searcher isEqual:self.routeMap[key]]) {
            _key = key;
            break;
        }
    }
    
    if (_key) {
        YZTBaiduRouteSearchCallback _callback = self.routeQueue[_key];
        
        if (_callback) {
            _callback(isSuccess,result,info);
        }
        
        [self.routeQueue removeObjectForKey:_key];
        [self.routeMap removeObjectForKey:_key];
    }
    
    searcher.delegate                 = nil;
    searcher                          = nil;
}

/*
- (void)baiduMapTransitRouteSearchFrom:(BMKPlanNode *)startNode
                                    to:(BMKPlanNode *)endNode
                                  city:(NSString *)city
                         transitPolicy:(BMKTransitPolicy)transitPolicy
{
    if (self.isPermission) {
        BMKTransitRoutePlanOption *option = [[BMKTransitRoutePlanOption alloc] init];
        option.from = startNode;
        option.to = endNode;
        option.city = city;
        option.transitPolicy = transitPolicy;
        BOOL flag = [self.routeSearch transitSearch:option];
        
        if (flag) {
            NSLog(@"公交路线检索成功");
        } else {
            NSLog(@"公交路线检索失败");
        }
    }
}

- (void)baiduMapWalkRouteSearchFrom:(BMKPlanNode *)startNode
                                 to:(BMKPlanNode *)endNode
{
    if (self.isPermission) {
        BMKWalkingRoutePlanOption *option = [[BMKWalkingRoutePlanOption alloc] init];
        option.from = startNode;
        option.to = endNode;
        BOOL flag = [self.routeSearch walkingSearch:option];
        if (flag) {
            NSLog(@"步行路线检索成功");
        } else {
            NSLog(@"步行路线检索失败");
        }
    }
}

- (void)baiduMapDriveRouteSearchFrom:(BMKPlanNode *)startNode
                                  to:(BMKPlanNode *)endNode
                         drivePolicy:(BMKDrivingPolicy)drivePolicy
{
    if (self.isPermission) {
        BMKDrivingRoutePlanOption *option = [[BMKDrivingRoutePlanOption alloc] init];
        option.from = startNode;
        option.to = endNode;
        option.drivingPolicy = drivePolicy;
        BOOL flag = [self.routeSearch drivingSearch:option];
        if (flag) {
            NSLog(@"驾车路线检索成功");
        } else {
            NSLog(@"驾车路线检索失败");
        }
    }
}
*/

#pragma mark <== BMKRouteSearchDelegate ==>
- (void)onGetWalkingRouteResult:(BMKRouteSearch *)searcher
                         result:(BMKWalkingRouteResult *)result
                      errorCode:(BMKSearchErrorCode)error
{
    BOOL flag = NO;
    NSString *_errorMsg = nil;
    BMKPolyline *polyline = nil;
    if (error == BMK_SEARCH_NO_ERROR) {
        
        flag = YES;
        
        BMKWalkingRouteLine *plan = (BMKWalkingRouteLine *)[result.routes objectAtIndex:0];
        NSUInteger size = [plan.steps count];
        int planPointCounts = 0;
        for (int i = 0; i < size; i++) {
            BMKWalkingStep *walkingStep = [plan.steps objectAtIndex:i];
            planPointCounts += walkingStep.pointsCount;
        }
        
        BMKMapPoint *tempPoints = new BMKMapPoint[planPointCounts];
        int i = 0;
        for (int j = 0; j < size; j++) {
            BMKWalkingStep *walkingStep = [plan.steps objectAtIndex:j];
            int k = 0;
            for(k = 0;k < walkingStep.pointsCount;k++) {
                tempPoints[i].x = walkingStep.points[k].x;
                tempPoints[i].y = walkingStep.points[k].y;
                i++;
            }
        }
        polyline = [BMKPolyline polylineWithPoints:tempPoints count:planPointCounts];
        delete [] tempPoints;
    }
    else
    {
        _errorMsg = [self searchErrorInfo:error];
    }
    [self routeSearchResultAction:flag
                         searcher:searcher
                           result:polyline
                        errorInfo:_errorMsg];
    
}


- (void)onGetDrivingRouteResult:(BMKRouteSearch *)searcher
                         result:(BMKDrivingRouteResult *)result
                      errorCode:(BMKSearchErrorCode)error
{
    BOOL flag = NO;
    NSString *_errorMsg = nil;
    BMKPolyline *polyline = nil;
    
    if (BMK_SEARCH_NO_ERROR == error) {
        
        flag = YES;
        
        BMKDrivingRouteLine *plan = (BMKDrivingRouteLine *)[result.routes objectAtIndex:0];
        NSInteger size = [plan.steps count];
        int planPointCounts = 0;
        for (int i = 0; i < size; i++) {
            BMKDrivingStep *drivingStep = [plan.steps objectAtIndex:i];
            planPointCounts += drivingStep.pointsCount;
        }
        
        BMKMapPoint * tempPoints = new BMKMapPoint[planPointCounts];
        int i = 0;
        for (int j = 0; j < size; j++) {
            BMKDrivingStep *drivingStep = [plan.steps objectAtIndex:j];
            int k = 0;
            for(k = 0;k < drivingStep.pointsCount;k++) {
                tempPoints[i].x = drivingStep.points[k].x;
                tempPoints[i].y = drivingStep.points[k].y;
                i++;
            }
        }
        polyline = [BMKPolyline polylineWithPoints:tempPoints count:planPointCounts];
        delete [] tempPoints;

    }
    else {
        _errorMsg = [self searchErrorInfo:error];
    }
    
    [self routeSearchResultAction:flag
                         searcher:searcher
                           result:polyline
                        errorInfo:_errorMsg];
}

- (void)onGetTransitRouteResult:(BMKRouteSearch *)searcher
                         result:(BMKTransitRouteResult *)result
                      errorCode:(BMKSearchErrorCode)error
{
    BOOL flag = NO;
    NSString *_errorMsg = nil;
    BMKPolyline *polyline = nil;
    
    if (BMK_SEARCH_NO_ERROR == error) {
        flag = YES;
        
        
        BMKTransitRouteLine *plan = (BMKTransitRouteLine *)[result.routes objectAtIndex:0];
        // 计算路线方案中的路段数目
        NSUInteger size = [plan.steps count];
        int planPointCounts = 0;
        for (int i = 0; i < size; i++) {
            BMKTransitStep *transitStep = [plan.steps objectAtIndex:i];
            //轨迹点总数累计
            planPointCounts += transitStep.pointsCount;
        }
        //轨迹点
        BMKMapPoint *tempPoints = new BMKMapPoint[planPointCounts];
        int i = 0;
        for (int j = 0; j < size; j++) {
            BMKTransitStep *transitStep = [plan.steps objectAtIndex:j];
            int k = 0;
            for(k = 0;k < transitStep.pointsCount;k++) {
                tempPoints[i].x = transitStep.points[k].x;
                tempPoints[i].y = transitStep.points[k].y;
                i++;
            }
        }
        // 通过points构建BMKPolyline
        polyline = [BMKPolyline polylineWithPoints:tempPoints count:planPointCounts];
        delete []tempPoints;

    }
    else {
        _errorMsg = [self searchErrorInfo:error];
    }
    
    
    [self routeSearchResultAction:flag
                         searcher:searcher
                           result:polyline
                        errorInfo:_errorMsg];
}


/** 赞未使用
 *返回骑行搜索结果
 *@param searcher 搜索对象
 *@param result 搜索结果，类型为BMKRidingRouteResult
 *@param error 错误号，@see BMKSearchErrorCode
 *
- (void)onGetRidingRouteResult:(BMKRouteSearch*)searcher result:(BMKRidingRouteResult*)result errorCode:(BMKSearchErrorCode)error;
 */




#pragma mark- <pravite>
- (NSString *)searchErrorInfo:(BMKSearchErrorCode)code
{
    NSString *_eStr = nil;
    switch (code) {
        case BMK_SEARCH_NO_ERROR:
        {
            _eStr = nil;
        }
            break;
        case BMK_SEARCH_AMBIGUOUS_KEYWORD:
        {
            _eStr = @"检索词有岐义";
        }
            break;
        case BMK_SEARCH_AMBIGUOUS_ROURE_ADDR:
        {
            _eStr = @"检索地址有岐义";
        }
            break;
        case BMK_SEARCH_NOT_SUPPORT_BUS:
        {
            _eStr = @"该城市不支持公交搜索";
        }
            break;
        case BMK_SEARCH_NOT_SUPPORT_BUS_2CITY:
        {
            _eStr = @"不支持跨城市公交";
        }
            break;
        case BMK_SEARCH_RESULT_NOT_FOUND:
        {
            _eStr = @"抱歉，无更多结果";//@"没有找到检索结果";
        }
            break;
        case BMK_SEARCH_ST_EN_TOO_NEAR:
        {
            _eStr = @"起终点太近";
        }
            break;
        case BMK_SEARCH_KEY_ERROR:
        {
            _eStr = @"关键字错误";
        }
            break;
        case BMK_SEARCH_NETWOKR_ERROR:
        {
            _eStr = @"网络连接错误";
        }
            break;
        case BMK_SEARCH_NETWOKR_TIMEOUT:
        {
            _eStr = @"网络连接超时";
        }
            break;
        case BMK_SEARCH_PERMISSION_UNFINISHED:
        {
            _eStr = @"还未完成鉴权，请在鉴权通过后重试";
        }
            break;
        case BMK_SEARCH_INDOOR_ID_ERROR:
        {
            _eStr = @"室内图ID错误";
        }
            break;
        case BMK_SEARCH_FLOOR_ERROR:
        {
            _eStr = @"室内图检索楼层错误";
        }
            break;
        default:
        {
            _eStr = @"未知错误";
        }
            break;
    }
    
    return _eStr;
}

/*
- (void)searchErrorCodeFunc:(BMKSearchErrorCode)code
                   callback:(void(^)(BMKSearchErrorCode,NSString *))callback
{
    NSString *_eStr = nil;
    switch (code) {
        case BMK_SEARCH_NO_ERROR:
        {
            _eStr = nil;
        }
            break;
        case BMK_SEARCH_AMBIGUOUS_KEYWORD:
        {
            _eStr = @"检索词有岐义";
        }
            break;
        case BMK_SEARCH_AMBIGUOUS_ROURE_ADDR:
        {
            _eStr = @"检索地址有岐义";
        }
            break;
        case BMK_SEARCH_NOT_SUPPORT_BUS:
        {
            _eStr = @"该城市不支持公交搜索";
        }
            break;
        case BMK_SEARCH_NOT_SUPPORT_BUS_2CITY:
        {
            _eStr = @"不支持跨城市公交";
        }
            break;
        case BMK_SEARCH_RESULT_NOT_FOUND:
        {
            _eStr = @"抱歉，无更多结果";//@"没有找到检索结果";
        }
            break;
        case BMK_SEARCH_ST_EN_TOO_NEAR:
        {
            _eStr = @"起终点太近";
        }
            break;
        case BMK_SEARCH_KEY_ERROR:
        {
            _eStr = @"关键字错误";
        }
            break;
        case BMK_SEARCH_NETWOKR_ERROR:
        {
            _eStr = @"网络连接错误";
        }
            break;
        case BMK_SEARCH_NETWOKR_TIMEOUT:
        {
            _eStr = @"网络连接超时";
        }
            break;
        case BMK_SEARCH_PERMISSION_UNFINISHED:
        {
            _eStr = @"还未完成鉴权，请在鉴权通过后重试";
        }
            break;
        case BMK_SEARCH_INDOOR_ID_ERROR:
        {
            _eStr = @"室内图ID错误";
        }
            break;
        case BMK_SEARCH_FLOOR_ERROR:
        {
            _eStr = @"室内图检索楼层错误";
        }
            break;
        default:
        {
            _eStr = @"未知错误";
        }
            break;
    }
    
    
    if (callback) {
        callback(code,_eStr);
    }
}


- (void(^)(BMKSearchErrorCode code,NSString *eStr))searchErrorCodeFunc:(BMKSearchErrorCode)code
{
 
 
    void(^block)(BMKSearchErrorCode, NSString *) = ^(BMKSearchErrorCode aCode,NSString *aEStr){
 
        aCode = code;
 
        switch (aCode) {
            case BMK_SEARCH_NO_ERROR:
            {
                aEStr = nil;
            }
                break;
            case BMK_SEARCH_AMBIGUOUS_KEYWORD:
            {
                aEStr = @"检索词有岐义";
            }
                break;
            case BMK_SEARCH_AMBIGUOUS_ROURE_ADDR:
            {
                aEStr = @"检索地址有岐义";
            }
                break;
            case BMK_SEARCH_NOT_SUPPORT_BUS:
            {
                aEStr = @"该城市不支持公交搜索";
            }
                break;
            case BMK_SEARCH_NOT_SUPPORT_BUS_2CITY:
            {
                aEStr = @"不支持跨城市公交";
            }
                break;
            case BMK_SEARCH_RESULT_NOT_FOUND:
            {
                aEStr = @"抱歉，无更多结果";//@"没有找到检索结果";
            }
                break;
            case BMK_SEARCH_ST_EN_TOO_NEAR:
            {
                aEStr = @"起终点太近";
            }
                break;
            case BMK_SEARCH_KEY_ERROR:
            {
                aEStr = @"关键字错误";
            }
                break;
            case BMK_SEARCH_NETWOKR_ERROR:
            {
                aEStr = @"网络连接错误";
            }
                break;
            case BMK_SEARCH_NETWOKR_TIMEOUT:
            {
                aEStr = @"网络连接超时";
            }
                break;
            case BMK_SEARCH_PERMISSION_UNFINISHED:
            {
                aEStr = @"还未完成鉴权，请在鉴权通过后重试";
            }
                break;
            case BMK_SEARCH_INDOOR_ID_ERROR:
            {
                aEStr = @"室内图ID错误";
            }
                break;
            case BMK_SEARCH_FLOOR_ERROR:
            {
                aEStr = @"室内图检索楼层错误";
            }
                break;
            default:
            {
                aEStr = @"未知错误";
            }
                break;
        }
        
        
    };
    
    
    return block;
}
*/

#pragma mark- <工具类>
-(BOOL)yztCheckLocationService{
    BOOL _flag = NO;
    CLAuthorizationStatus status = [CLLocationManager authorizationStatus];
    switch (status) {
        case kCLAuthorizationStatusDenied://永不
        {
            NSLog(@"yzt_baidu_CheckLoc_Denied");
        }
            break;
        case kCLAuthorizationStatusNotDetermined:
        {
            NSLog(@"yzt_baidu_CheckLoc_NotDetermined");
            /* 
             未设置以下字段会进入此回调
             Privacy - Location Usage Description
             Privacy - Location Always Usage Description
             
             未设置 Bundle Display Name 也会进入此回调
             
             */
        }
            break;
        case kCLAuthorizationStatusRestricted:
        {
            NSLog(@"yzt_baidu_CheckLoc_Restricted");
        }
            break;
        case kCLAuthorizationStatusAuthorizedAlways://定位开启，始终
        {
            NSLog(@"yzt_baidu_CheckLoc_AuthorizedAlways");
            _flag = YES;
        }
            break;
        case kCLAuthorizationStatusAuthorizedWhenInUse://定位开启，在使用时
        {
            NSLog(@"yzt_baidu_CheckLoc_AuthorizedWhenInUse");
            _flag = YES;
        }
            break;
       
        default:
        {
            NSLog(@"yzt_baidu_CheckLoc_default");
        }
            break;
    }
    

    
    return _flag;
}

#pragma mark- <未整理>
/*
- (CLLocationDistance)baiduMapDistanceWithStartPoint:(CLLocationCoordinate2D)startPoint
                                            endPoint:(CLLocationCoordinate2D)endPoint
{
    BMKMapPoint start = BMKMapPointForCoordinate(startPoint);
    BMKMapPoint end = BMKMapPointForCoordinate(endPoint);
    CLLocationDistance distance = BMKMetersBetweenMapPoints(start, end);
    return distance;
}


- (float)baiduMapAutoZoomLevelWithStartPoint:(CLLocationCoordinate2D)startPoint endPoint:(CLLocationCoordinate2D)endPoint
{
    NSArray *zoom = @[@50, @100, @200, @500, @1000, @2000, @5000, @10000, @20000, @25000, @50000, @100000, @200000, @500000, @1000000, @2000000];
    double distance = [self baiduMapDistanceWithStartPoint:startPoint endPoint:endPoint];
    
    for (int i = 0; i < zoom.count; i++) {
        if ([zoom[i] doubleValue] > distance) {
            return 18 - i + 3;
        }
    }
    return 3;
}



- (void)baiduMapOpenAppleMapClientWithEndPoint:(CLLocationCoordinate2D)endPoint directionsMode:(LaunchOptionsDirectionsMode)directionsMode
{
    MKMapItem *currentLocation = [MKMapItem mapItemForCurrentLocation];
    MKPlacemark *placemark = [[MKPlacemark alloc] initWithCoordinate:endPoint addressDictionary:nil];
    MKMapItem *toLocation = [[MKMapItem alloc] initWithPlacemark:placemark];
    
    NSString *directType = MKLaunchOptionsDirectionsModeDriving;
    switch (directionsMode) {

        case LaunchOptionsDirectionsModeTransit:
        {
            directType = MKLaunchOptionsDirectionsModeTransit;
        }
            break;
        case LaunchOptionsDirectionsModeWalking:
        {
            directType = MKLaunchOptionsDirectionsModeWalking;
        }
            break;
        case LaunchOptionsDirectionsModeDriving:
        default:
            break;
    }
    
    [MKMapItem openMapsWithItems:@[currentLocation, toLocation]
                   launchOptions:@{MKLaunchOptionsDirectionsModeKey:directType, MKLaunchOptionsShowsTrafficKey:[NSNumber numberWithBool:YES]}];
}

- (BOOL)baiduMapCanOpenBaiduMapClient
{
    return [[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"baidumap://map/"]];
}

- (void)baiduMapOpenBaiduMapClientWithEndPoint:(CLLocationCoordinate2D)endPoint directionsMode:(LaunchOptionsDirectionsMode)directionsMode
{
    NSString *directType = nil;
    switch (directionsMode) {
        case LaunchOptionsDirectionsModeDriving:
        {
            directType = @"driving";
        }
            break;
        case LaunchOptionsDirectionsModeTransit:
        {
            directType = @"transit";
        }
            break;
        case LaunchOptionsDirectionsModeWalking:
        {
            directType = @"walking";
        }
            break;
        default:
            break;
    }
    
    NSString *urlString = [[NSString stringWithFormat:@"baidumap://map/direction?origin={{我的位置}}&destination=latlng:%f,%f|name=目的地&mode=%@&coord_type=bd09ll&src=%@", endPoint.latitude, endPoint.longitude, directType, @"一账通"] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:urlString]]) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlString]];
    }
}

- (BOOL)baiduMapCanOpenGaodeMapClient
{
    return [[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"iosamap://"]];
}

- (void)baiduMapOpenGaodeMapClientWithEndPoint:(CLLocationCoordinate2D)endPoint directionsMode:(LaunchOptionsDirectionsMode)directionsMode
{
    NSString *directType = nil;
    switch (directionsMode) {
        case LaunchOptionsDirectionsModeDriving:
        {
            directType = @"0";
        }
            break;
        case LaunchOptionsDirectionsModeTransit:
        {
            directType = @"1";
        }
            break;
        case LaunchOptionsDirectionsModeWalking:
        {
            directType = @"2";
        }
            break;
        default:
            break;
    }
    
    NSString *urlString = [[NSString stringWithFormat:@"iosamap://path?sourceApplication=%@&sid=BGVIS1&did=BGVIS2&dlat=%f&dlon=%f&dev=0&m=0&t=%@",@"一账通", endPoint.latitude, endPoint.longitude, directType] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:urlString]]) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlString]];
    }
}

- (void)baiduMapOpenGaodeMapNavClientWithEndPoint:(CLLocationCoordinate2D)endPoint
{
    NSString *urlString = [[NSString stringWithFormat:@"iosamap://navi?sourceApplication=%@&backScheme=%@&lat=%f&lon=%f&dev=0&style=2",@"一账通",@"patoa", endPoint.latitude, endPoint.longitude] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:urlString]]) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlString]];
    }
}








*/

#pragma mark - getter and setter

- (BMKMapManager *)mapManager
{
    if (!_mapManager) {
        _mapManager = [[BMKMapManager alloc] init];
    }
    return _mapManager;
}

- (BMKLocationService *)locationService
{
    if (!_locationService) {
        _locationService = [[BMKLocationService alloc] init];
        _locationService.delegate = self;
    }
    return _locationService;
}

- (BMKGeoCodeSearch *)geoCodeSearch
{
    if (!_geoCodeSearch) {
        _geoCodeSearch = [[BMKGeoCodeSearch alloc] init];
        _geoCodeSearch.delegate = self;
    }
    return _geoCodeSearch;
}

/*
- (BMKRouteSearch *)routeSearch
{
    if (!_routeSearch) {
        _routeSearch = [[BMKRouteSearch alloc] init];
        _routeSearch.delegate = self;
    }
    return _routeSearch;
}

*/

@end
