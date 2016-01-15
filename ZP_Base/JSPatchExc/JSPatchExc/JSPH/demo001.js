
defineClass('ViewController', {
    tableView_didSelectRowAtIndexPath:function(tableView,indexPath) {
            
            tableView.deselectRowAtIndexPath_animated(indexPath,YES);
            
            var tableViewCtrl = UIAlertView.alloc().init();
            
            tableViewCtrl.setTitle("title");
            tableViewCtrl.setMessage("message_" + indexPath.row);
            tableViewCtrl.addButtonWithTitle("ok");
            
            tableViewCtrl.show();
            
    }
})