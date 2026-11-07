package com.yiTian.view.modules.bianqiangzhiyin
{
   import com.ui.containers.list.IListItem;
   import com.ui.controls.MyTextField;
   import com.utils.ComponentUtil;
   import flash.display.Sprite;
   
   public class Child_bqItem extends IListItem
   {
      
      private static var instance:Child_bqItem;
      
      private var title:MyTextField;
      
      private var tt:MyTextField;
      
      private var txtCon:Sprite;
      
      public function Child_bqItem()
      {
         super();
         this.initUI();
      }
      
      public static function getInstance() : Child_bqItem
      {
         if(!instance)
         {
            instance = new Child_bqItem();
         }
         return instance;
      }
      
      private function initUI() : void
      {
         this.title = ComponentUtil.getTextField("找个妹纸一起养狗",this,{
            "x":10,
            "y":3,
            "size":12,
            "leading":2
         });
         this.tt = ComponentUtil.getTextField("找个妹纸一起养狗",this,{
            "x":47,
            "y":3,
            "size":12,
            "leading":2
         });
      }
      
      override public function set data(value:Object) : void
      {
         super.data = value.flag;
         this.title.htmlText = "<font color=\'#f9ff00\'>[" + value.flag + "]</font> ";
         this.tt.htmlText = "<u>" + value.title + "</u>";
      }
      
      override public function dispose() : void
      {
         this.tt.htmlText = "";
      }
      
      override public function updataFunc() : void
      {
      }
   }
}

