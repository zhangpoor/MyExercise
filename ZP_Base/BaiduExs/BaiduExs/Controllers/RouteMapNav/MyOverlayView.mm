//
//  MyOverlayView.m
//  BaiduExs
//
//  Created by zhangpoor on 17/2/14.
//  Copyright © 2017年 zhangpoor. All rights reserved.
//

#import "MyOverlayView.h"
#import <BaiduMapAPI_Utils/BMKGeometry.h>
#import <BaiduMapAPI_Map/BMKCircle.h>


@implementation MyOverlayView




-(void)glRender
{
    
    BMKCircle *_circle = (BMKCircle *)_overlay;
    
    BMKCircle *_center = [BMKCircle circleWithCenterCoordinate:_circle.coordinate
                                                        radius:_circle.radius/6];
    
    
    UIColor *_col = [UIColor colorWithRed:0.1 green:0.9 blue:0.2 alpha:0.2];
    UIColor *_colB = [UIColor colorWithRed:0.3 green:0.3 blue:0.3 alpha:0.9];
    
    
    UIColor *_col001 = [UIColor colorWithRed:0.2 green:0.1 blue:0.9 alpha:0.9];
    UIColor *_col001B = [UIColor colorWithRed:0.9 green:0.3 blue:0.2 alpha:0.9];
    
    
    [self renderRegionWithPoints:_circle.points
                      pointCount:_circle.pointCount
                       fillColor:_col
                usingTriangleFan:YES];
    [self renderLinesWithPoints:_circle.points pointCount:_circle.pointCount
                    strokeColor:_colB
                      lineWidth:2
                         looped:YES];
    
    [self renderRegionWithPoints:_center.points
                      pointCount:_center.pointCount
                       fillColor:_col001
                usingTriangleFan:YES];
    [self renderLinesWithPoints:_center.points pointCount:_center.pointCount
                    strokeColor:_col001B
                      lineWidth:1
                         looped:YES];
 /*
    BMKMapPoint _p = BMKMapPointForCoordinate(_circle.coordinate);
    
    BMKMapPoint * _pList = new BMKMapPoint[4];
    _pList[0].x = _p.x + 50;
    _pList[0].y = _p.y + 50;
    _pList[1].x = _p.x + 50;
    _pList[1].y = _p.y - 50;
    _pList[2].x = _p.x - 50;
    _pList[2].y = _p.y - 50;
    _pList[3].x = _p.x - 50;
    _pList[3].y = _p.y + 50;
    
    
    GLuint testureID = [self loadStrokeTextureImage:[UIImage imageNamed:@"star.jpg"]];
    if (testureID) {
        [self renderTexturedLinesWithPoints:_pList
                                 pointCount:4
                                  lineWidth:50
                                  textureID:testureID
                                     looped:YES];
    }
    
    delete _pList;
 */
    
    
    
}



@end
