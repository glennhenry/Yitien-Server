package com.yiTian.view.modules.chargeGuide
{
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.data.config.Enum_job;
   import com.yiTian.manager.GameUnitManager;
   import com.yiTian.scene.GameScene;
   import com.yiTian.utils.Tween;
   import com.yiTian.utils.Utils;
   import com.yiTian.view.Panel;
   import flash.display.Bitmap;
   import flash.geom.Rectangle;
   import flash.utils.clearTimeout;
   import flash.utils.setTimeout;
   
   public class View_FashionGude extends Panel
   {
      
      public static var isInit:Boolean = false;
      
      private const DATA:Array = [[99101,99113],[99102,99114]];
      
      private var _itemVec:Vector.<Fashion_Item> = new Vector.<Fashion_Item>();
      
      private var bmp:Bitmap = new Bitmap();
      
      private var type_eff:int;
      
      private var timeOut:int;
      
      public function View_FashionGude()
      {
         super();
      }
      
      public static function getIdArr(_job:int, _sex:int, _index:int) : String
      {
         return "20" + Enum_job.getBaseJob(_job) + _index + _sex;
      }
      
      override protected function initStaticView() : void
      {
         ComponentUtil.getScaleBitmap("Back1",[149,41,2,5],this,{
            "x":0,
            "y":0,
            "width":565,
            "height":385
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back2",[5,5,10,10],this,{
            "x":24,
            "y":40,
            "width":517,
            "height":332
         },Global.Img_Cdm);
         ComponentUtil.getBitmap("Title_WXPrompt",this,{
            "x":565 / 2 - 80,
            "y":6
         },Global.Img_Cdm);
         move = new Rectangle(0,0,565,38);
         CloseButton = ComponentUtil.getButton("","Button_Close",this,{
            "x":530,
            "y":5
         },Global.Img_Cdm);
         CloseButton.callBack = function():void
         {
            visible = false;
         };
         GameScene.upUILayer.addChild(this.bmp);
      }
      
      override protected function initDynamicView() : void
      {
         var item:Fashion_Item = null;
         var i:int = 0;
         while(i < 2)
         {
            item = new Fashion_Item();
            addChild(item);
            item.x = 31 + i * 255;
            item.y = 46;
            this._itemVec.push(item);
            i++;
         }
      }
      
      override public function set visible(value:Boolean) : void
      {
         var i:int = 0;
         var item:Fashion_Item = null;
         super.visible = value;
         if(value)
         {
            if(!isInit)
            {
               i = 0;
               while(i < 2)
               {
                  this._itemVec[i].init(getIdArr(Enum_job.getBaseJob(GameUnitManager.hero.job),GameUnitManager.hero.sex,i + 1),GameUnitManager.hero.job,i);
                  i++;
               }
            }
         }
         else
         {
            for each(item in this._itemVec)
            {
               item.visible = false;
            }
         }
      }
      
      public function callEff(_type:int) : void
      {
         this.type_eff = _type;
         this.bmp.bitmapData = null;
         this.bmp.alpha = 1;
         this.bmp.scaleX = 1;
         this.bmp.scaleY = 1;
         this.bmp.x = Global.stage.stageWidth / 2 - 150;
         this.bmp.y = Global.stage.stageHeight / 2 - 350;
         var st:String = _type == 1 ? "resource/image/shouchong/fashion.png" : "resource/image/shouchong/wuhun.png";
         Utils.getLoadBitmap(st,this.bmp,null,this.comp);
      }
      
      private function comp() : void
      {
         Tween.to(this.bmp,1500,{"y":[this.bmp.y,this.bmp.y + 200]},this.cmp);
      }
      
      private function cmp() : void
      {
         this.timeOut = setTimeout(this._clear,1000);
      }
      
      private function _clear() : void
      {
         clearTimeout(this.timeOut);
         Tween.to(this.bmp,800,{
            "y":[this.bmp.y,this.bmp.y - this.bmp.width / 8],
            "x":[this.bmp.x,this.bmp.x - 6 * this.bmp.height],
            "scaleX":[1,2],
            "scaleY":[1,2],
            "alpha":[1,0]
         },function():void
         {
            bmp.bitmapData = null;
         });
      }
      
      override public function resetPosition() : void
      {
         x = (Global.stage.stageWidth - width) / 2;
         y = (Global.stage.stageHeight - height) / 2;
      }
   }
}

