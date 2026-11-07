package com.yiTian.view.modules.chargeGuide
{
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.data.config.Enum_job;
   import com.yiTian.manager.GameUnitManager;
   import com.yiTian.utils.Tween;
   import com.yiTian.utils.Utils;
   import com.yiTian.view.Panel;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   
   public class View_Fashions extends Panel
   {
      
      private static const LEN:int = 3;
      
      public static var isFirstInit:Boolean = true;
      
      private var itemVec:Vector.<fsItem> = new Vector.<fsItem>(LEN,true);
      
      private var containers:Sprite;
      
      private var containersM:Sprite;
      
      private var posArr:Array = [[7,6],[229.5,6],[452,6]];
      
      private var power:Number = 1;
      
      private var rato:int = 6;
      
      private var indexArr:Array = [1,1,2];
      
      public function View_Fashions()
      {
         super();
         this.initB();
      }
      
      public static function getIdArr(_job:int, _sex:int, _index:int) : String
      {
         return "20" + Enum_job.getBaseJob(_job) + _index + _sex;
      }
      
      public function initB() : void
      {
         var i:int;
         var item:fsItem = null;
         ComponentUtil.getScaleBitmap("Back1",[149,41,2,5],this,{
            "x":0,
            "y":0,
            "width":726,
            "height":389
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back2",[5,5,10,10],this,{
            "x":24,
            "y":40,
            "width":678,
            "height":340
         },Global.Img_Cdm);
         Utils.loadTitle("lang/ch/ShiZhuang.swf","Guide_Cloth_top",new Bitmap(),{
            "x":300,
            "y":6
         },this);
         move = new Rectangle(0,0,724,38);
         ComponentUtil.getButton("","Button_Close",this,{
            "x":692,
            "y":6,
            "textColor":16184781,
            "callBack":function(e:MouseEvent):void
            {
               visible = false;
            }
         },Global.Img_Cdm);
         this.containers = new Sprite();
         this.containers.graphics.beginFill(0,0);
         this.containers.graphics.drawRect(0,0,676,338);
         this.containers.graphics.endFill();
         this.containers.x = 24;
         this.containers.y = 40;
         this.containersM = new Sprite();
         this.containersM.graphics.beginFill(0,0);
         this.containersM.graphics.drawRect(0,0,676,338);
         this.containersM.graphics.endFill();
         this.containersM.x = 24;
         this.containersM.y = 40;
         addChild(this.containersM);
         addChild(this.containers);
         this.containers.mask = this.containersM;
         i = 0;
         while(i < LEN)
         {
            item = new fsItem(i);
            this.containers.addChild(item);
            this.itemVec[i] = item;
            i++;
         }
      }
      
      override public function set visible(value:Boolean) : void
      {
         var _item:fsItem = null;
         super.visible = value;
         this.itemVec[0].y = -500;
         this.itemVec[2].y = -500;
         if(value)
         {
            this.inti_item();
            Tween.to(this.itemVec[1],300,{
               "y":[-120,6],
               "x":[229.5,229.5]
            },function():void
            {
               Tween.to(itemVec[0],550,{
                  "x":[229.5,posArr[0][0]],
                  "y":[6,6]
               },null,null,tFun);
               Tween.to(itemVec[2],550,{
                  "x":[229.5,posArr[2][0]],
                  "y":[6,6]
               },null,null,tFun);
            });
         }
         else
         {
            for each(_item in this.itemVec)
            {
               _item.visible = false;
               Tween.stop(_item);
            }
         }
      }
      
      private function tFun(p:Number) : Number
      {
         var rate:Number = p * 3.1416 * this.rato;
         return 1 - Math.sin(rate) / rate;
      }
      
      private function inti_item() : void
      {
         var item:fsItem = null;
         var i:int = 0;
         while(i < LEN)
         {
            item = this.itemVec[i];
            item.init(getIdArr(GameUnitManager.hero.job,GameUnitManager.hero.sex,this.indexArr[i]),GameUnitManager.hero.job);
            i++;
         }
      }
      
      override public function resetPosition() : void
      {
         x = (Global.stage.stageWidth - 724) / 2;
         y = (Global.stage.stageHeight - 390) / 2;
      }
   }
}

