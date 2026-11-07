package com.yiTian.view.modules.fubenSel
{
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.data.Data_lib;
   import com.yiTian.data.config.Enum_quest_step_type;
   import com.yiTian.data.model.Model_quest;
   import com.yiTian.data.vo.quest.Vo_questStep;
   import com.yiTian.manager.QuestGuiManager;
   import com.yiTian.manager.UIManager;
   import com.yiTian.utils.MassLoader;
   import com.yiTian.view.Panel;
   import com.yiTian.view.modules.guide.View_questGuiJian;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.geom.Rectangle;
   import flash.utils.Dictionary;
   
   public class View_fubensel_panel extends Panel
   {
      
      private static var map:Bitmap;
      
      private static var isLoadFB_Back:Boolean = false;
      
      private var title:Bitmap;
      
      private var itemContainer:Sprite;
      
      private var mapItems:Array;
      
      private var mapItDic:Dictionary = new Dictionary();
      
      private var _lastFuben:int;
      
      public function View_fubensel_panel()
      {
         super();
      }
      
      override protected function initStaticView() : void
      {
         ComponentUtil.getScaleBitmap("Back1",[149,41,2,5],this,{
            "x":0,
            "y":0,
            "width":772,
            "height":488
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back2",[5,5,10,10],this,{
            "x":24,
            "y":40,
            "width":724,
            "height":438
         },Global.Img_Cdm);
         move = new Rectangle(0,0,875,36);
         CloseButton = ComponentUtil.getButton("","Button_Close",this,{
            "x":738,
            "y":6,
            "textColor":16184781
         },Global.Img_Cdm);
         this.title = new Bitmap();
         this.title.y = 5;
         addChild(this.title);
         map = new Bitmap();
         map.x = 29;
         map.y = 45;
         addChild(map);
         this.itemContainer = new Sprite();
         this.itemContainer.x = 15;
         this.itemContainer.y = 45;
         addChild(this.itemContainer);
         this.mapItems = [];
      }
      
      public function update(fubenPointId:int) : void
      {
         var itemsStr:String;
         var items:Array;
         var len:int;
         var curQuestMapId:int = 0;
         var i:int = 0;
         var step:Vo_questStep = null;
         var itemData:Array = null;
         var fubenItem:FubenItem = null;
         var itemInfo:Array = null;
         var point:Array = null;
         if(!isLoadFB_Back)
         {
            MassLoader.add("resource/image/fuben/FB_Back.jpg",function(info:Object):void
            {
               info.obj.bitmapData = (info.content as Bitmap).bitmapData;
               isLoadFB_Back = true;
            },null,MassLoader.LEVEL3,map);
         }
         if(this._lastFuben != fubenPointId)
         {
            this.dispose();
            MassLoader.add("resource/image/fuben/fubenTitle/" + fubenPointId + ".png",function(info:Object):void
            {
               info.obj.bitmapData = (info.content as Bitmap).bitmapData;
               info.obj.x = (width - info.obj.width) / 2 - 62;
            },null,MassLoader.LEVEL1,this.title);
         }
         itemsStr = Data_lib.fubenPoint[fubenPointId][0];
         items = itemsStr.split(";");
         if(Boolean(Model_quest.curMainQ) && Model_quest.curMainQ.status == 0)
         {
            step = Model_quest.curMainQ.continueStep[Model_quest.curMainQ.step - 1];
            if(step.stepType == Enum_quest_step_type.TONG_GUAN)
            {
               curQuestMapId = step.mapId;
            }
         }
         len = int(items.length);
         i = 0;
         while(i < len)
         {
            if(items[i] != "")
            {
               itemData = items[i].split(":");
               if(this._lastFuben == fubenPointId)
               {
                  fubenItem = this.mapItDic[itemData[0]];
               }
               else
               {
                  fubenItem = FubenItem.getItem();
                  fubenItem.fubenId = itemData[0];
                  fubenItem.pointId = fubenPointId;
                  this.mapItDic[itemData[0]] = fubenItem;
               }
               itemInfo = itemData[1].split(",");
               if(itemInfo[0].indexOf("X_") != -1)
               {
                  fubenItem.condition = itemInfo.splice(1);
               }
               else
               {
                  fubenItem.condition = itemInfo;
               }
               if(this._lastFuben != fubenPointId)
               {
                  point = itemInfo[0].split("_");
                  fubenItem.x = 17 + int(i % 4) * 181;
                  fubenItem.y = 11 + int(i / 4) * 141;
                  this.itemContainer.addChild(fubenItem);
                  this.mapItems.push(fubenItem);
               }
               if(fubenItem.fubenId == curQuestMapId)
               {
                  QuestGuiManager.addKuang(null,25,110,20,23);
                  QuestGuiManager.addJian(this,this.itemContainer.x + fubenItem.x + 130,this.itemContainer.y + fubenItem.y + 60,180);
               }
            }
            i++;
         }
         if(this._lastFuben != fubenPointId)
         {
            this.align();
            this._lastFuben = fubenPointId;
         }
      }
      
      private function align() : void
      {
         this.mapItems.sortOn(["y","x"],Array.NUMERIC);
         var count:int = this.mapItems.length - 1;
         while(count >= 0)
         {
            this.itemContainer.setChildIndex(this.mapItems[count],count);
            count--;
         }
      }
      
      private function dispose() : void
      {
         var bm:FubenItem = null;
         if(!this.title)
         {
            return;
         }
         if(Boolean(this.title.bitmapData))
         {
            this.title.bitmapData.dispose();
            this.title.bitmapData = null;
         }
         var i:int = this.mapItems.length - 1;
         while(i >= 0)
         {
            if(Boolean(this.mapItems[i]))
            {
               bm = this.mapItems[i];
               delete this.mapItDic[bm.fubenId];
               this.itemContainer.removeChild(bm);
               bm.dispose();
               this.mapItems.splice(i,1);
            }
            i--;
         }
      }
      
      override public function set visible(value:Boolean) : void
      {
         super.visible = value;
         if(!value)
         {
            if(View_questGuiJian.instance.bindSpr == this)
            {
               UIManager.questTraceView.showMainQGuide();
            }
         }
      }
      
      override public function resetPosition() : void
      {
         x = (Global.stage.stageWidth - width) / 2;
         y = (Global.stage.stageHeight - height) / 2;
      }
   }
}

