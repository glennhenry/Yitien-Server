package com.yiTian.view.modules.kuafujingjichang
{
   import com.ui.constants.ScrollAutoType;
   import com.ui.containers.list.List;
   import com.ui.controls.MyTextField;
   import com.utils.ComponentUtil;
   import com.yiTian.net.handler.DRKFHandler;
   import flash.display.Sprite;
   
   public class DRKFChild_List extends Sprite
   {
      
      private var listVec:Array;
      
      public var list:List;
      
      private var timeTF:MyTextField;
      
      private var type:int = -1;
      
      public function DRKFChild_List()
      {
         super();
         this.init();
      }
      
      private function init() : void
      {
         this.list = ComponentUtil.getList(395,300,DRKFItem,this,null,null,-1);
         this.list.scrollAutoType = ScrollAutoType.TO_TOP;
         addChild(this.list);
         ComponentUtil.setPropertie(this.list,{
            "x":0,
            "y":20
         });
         this.listVec = [];
      }
      
      private function selListFun(value:int) : void
      {
         this.type = value;
         this.showList();
      }
      
      public function showList() : void
      {
         this.list.reset();
         this.list.source = DRKFHandler.getListSource(this.type);
      }
   }
}

