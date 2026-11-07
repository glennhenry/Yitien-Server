package com.yiTian.view.modules.broadcast
{
   import com.ui.constants.ScrollAutoType;
   import com.ui.containers.list.List;
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.utils.Utils;
   import com.yiTian.view.Panel;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.geom.Rectangle;
   
   public class CheckAllTip extends Panel
   {
      
      private var list:List;
      
      private var _data:Array;
      
      private var _bg:Sprite;
      
      private const MIN:int = 15;
      
      private var b:Boolean = true;
      
      public function CheckAllTip()
      {
         super();
      }
      
      override protected function initStaticView() : void
      {
         this._bg = new Sprite();
         this.addChild(this._bg);
         this._bg.addChild(ComponentUtil.getScaleBitmap("Back1",[149,41,2,5],this,{
            "x":0,
            "y":0,
            "width":306,
            "height":390
         },Global.Img_Cdm));
         this._bg.addChild(ComponentUtil.getScaleBitmap("Back2",[5,5,10,10],this,{
            "x":24,
            "y":40,
            "width":258,
            "height":340
         },Global.Img_Cdm));
         move = new Rectangle(0,0,278,35);
         CloseButton = ComponentUtil.getButton("","Button_Close",this,{
            "x":272,
            "y":6,
            "textColor":16184781
         },Global.Img_Cdm);
         this.list = ComponentUtil.getList(247,338,CheckAllListItem,this,null,null,-1);
         this.list.scrollAutoType = ScrollAutoType.TO_TOP;
         addChild(this.list);
         this.list.x = 32;
         this.list.y = 41.5;
         this._data = [];
         var i:uint = 0;
         while(i < this.MIN)
         {
            this._data.push({"htmlText":""});
            i++;
         }
      }
      
      public function updata(data:Array) : void
      {
         var i:uint = 0;
         while(i < data.length)
         {
            this._data[i] = {"htmlText":data[i]};
            i++;
         }
         this.list.source = this._data;
      }
      
      override public function resetPosition() : void
      {
         x = (Global.stage.stageWidth - width) / 2;
         y = (Global.stage.stageHeight - height) / 2;
      }
      
      override public function set visible(value:Boolean) : void
      {
         super.visible = value;
         if(value)
         {
            if(this.b)
            {
               this.b = false;
               Utils.loadTitle("lang/ch/XiTongXinXi_Imgs.swf","Title_EventInformat",new Bitmap(),{
                  "x":73,
                  "y":5
               },this._bg);
            }
         }
      }
   }
}

