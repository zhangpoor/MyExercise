//require('UIAlertController','UIAlertController/UIAlertAction');
require('UIAlertView');
require('UIView');
require("JSPHManager");
require("UIImageView");
require("UIImage");
require("UIAlertController");
require("UIAlertAction");

var _abc;
var _jsphStr = "_jsph";


defineClass('MyTableController : UITableViewController <UIAlertViewDelegate>', {
    createWithTitle:function(titleName)
    {
        var _myTBVC = MyTableController.alloc().init();
        if(titleName)
        {
            _myTBVC.setTitle(titleName);
        }
        return _myTBVC;
    },
    dataSource: function()
    {
            var data = self.getProp('data')
            if (data) return data;
            var data = [];
            for (var i = 0; i < 20; i ++) {
            data.push("cell from js " + i);
            }
            self.setProp_forKey(data, 'data')
            return data;
    },
    
    tableView_numberOfRowsInSection: function(tableView, section)
    {
            return self.dataSource().count();
    },
    tableView_cellForRowAtIndexPath: function(tableView, indexPath)
    {
            var cell = tableView.dequeueReusableCellWithIdentifier("MyCell")
            if (!cell) {
            cell = require('UITableViewCell').alloc().initWithStyle_reuseIdentifier(0, "MyCell")
            }
            cell.textLabel().setText(self.dataSource().objectAtIndex(indexPath.row()))
            return cell
    },
    tableView_heightForRowAtIndexPath: function(tableView, indexPath)
    {
            return 60
    },
    tableView_didSelectRowAtIndexPath: function(tableView, indexPath)
    {
           self.navigationController().popViewControllerAnimated(true);
    },

})


defineClass('MainController',
{
    // 重写属性
    /*
    setUrl:function(str) {
            _abc = str;
            console.log(str);
    },
            
    url:function() {
            
            var data = _abc.stringByAppendingString(_jsphStr);
            
            return data;
    },
     */
        
    // 重写函数
    changeStr:function(str)
    {
        var _strs = "aaaa";
            //console.log("changeStr"+_jsphStr);
        return str.stringByAppendingString(_strs);
    },
    cell000Action:function(str)
    {
        var data = str.stringByAppendingString(_jsphStr);
        console.log(data);
    },
    cell001Action:function(str)
    {
        /*
        // 原始写法
            var tStr = "title"+_jsphStr;
            var tableViewCtrl = UIAlertView.alloc().init();
            
            tableViewCtrl.setTitle(tStr);
            tableViewCtrl.setMessage(str.stringByAppendingString(_jsphStr));
            tableViewCtrl.addButtonWithTitle("ok");
            
            tableViewCtrl.show();
            
        // 其他写法
        
            var alertView = UIAlertView.alloc();
            alertView.initWithTitle_message_delegate_cancelButtonTitle_otherButtonTitles(
                    tStr,
                    str.stringByAppendingString(_jsphStr),
                    null, "OK", null);
            alertView.show();
        */
        // 正规写法
        
        var _alterVc =
            UIAlertController.alertControllerWithTitle_message_preferredStyle(
                                                "JSPH Title",
                                                str.stringByAppendingString(_jsphStr),
                                                1
            );
            
        var _alterAc =
            UIAlertAction.actionWithTitle_style_handler(
                "取 消",
                1,
                block("UIAlertAction *",function(action) {
                    var _str = "jsph_alter_cancelAction:" + _jsphStr;

                                                        
                    console.log(_str);
                })
            );
            
            
        _alterVc.addAction(_alterAc);
        self.presentViewController_animated_completion(
                _alterVc,
                true,
                block( null,function() {
                    var _str = "jsph_alter_presentViewController:" + _jsphStr;

                                                           
                    console.log(_str);
                } )
            
            );

    },
    cell002Action:function(str)
    {
            var data    = "http://www.qq.com";
            var _webVC  = require("WebController").createWebVC(data);
            self.navigationController().pushViewController_animated(_webVC,true);
            //WebController *_webVC = [WebController createWebVC:self.url];
            //[self.navigationController pushViewController:_webVC animated:YES];
    },
    cell003Action:function(str)
    {
            var _img        = UIImage.imageNamed("pic");
            var _imgView    = UIImageView.alloc().initWithImage(_img);
            var _rect       = {x:0,y:0,width:100,height:100};
            _imgView.setFrame(_rect);
            

            self.view().addSubview(_imgView);
            /*
            self.callBlock(
                           block(
                                "id", function(p) {
                                 console.log(p);
                                 }
                                )
            );
             */
            
            UIView.animateWithDuration_animations_completion(
                2.5,
                block( null,function(){
                      var _cp = _imgView.center();
                      _cp.y += self.view().frame().height;
                      _cp.x += self.view().frame().width;
                      _imgView.setCenter(_cp);
                } ),
                block( "BOOL",function(finished){
                    _imgView.removeFromSuperview();
                } )
            );
          
    },
    cell004Action:function(str)
    {
            var _myTBVC = MyTableController.alloc().init();
            //.createWithTitle("jsphVC");
            self.navigationController().pushViewController_animated(_myTBVC, YES);
    }
})





