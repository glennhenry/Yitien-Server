package com.yiTian.view.modules.HeFuHuoDong
{
   import com.utils.ComponentUtil;
   import com.utils.DateUtil;
   import com.yiTian.Global;
   import com.yiTian.data.Data_lib;
   import com.yiTian.data.model.Model_HeFuHuoDong;
   import com.yiTian.data.vo.Vo_equip;
   import com.yiTian.data.vo.Vo_grid;
   import com.yiTian.data.vo.Vo_item;
   import com.yiTian.utils.ComboTweenStep;
   import com.yiTian.view.comp.View_Grid;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   
   public class View_HefuHuoDong1 extends Sprite
   {
      
      private static var _instance:View_HefuHuoDong1;
      
      private var giftArray:Array;
      
      private var currentSelect:int;
      
      private var gridArray:Array;
      
      public function View_HefuHuoDong1()
      {
         super();
         this.Init();
      }
      
      public static function get instance() : View_HefuHuoDong1
      {
         if(!_instance)
         {
            _instance = new View_HefuHuoDong1();
         }
         return _instance;
      }
      
      private function Init() : void
      {
         var gift:CardHeFu = null;
         ComponentUtil.getScaleBitmap("Back_Green_List",[5,5,1,1],this,{
            "x":0,
            "y":190,
            "width":744,
            "height":260
         },Global.Img_Cdm);
         ComponentUtil.getBitmap("NeiRong_Back",this,{
            "x":10,
            "y":349
         },Global.HeFu_Imgsdm);
         ComponentUtil.getBitmap("Text_Back",this,{
            "x":2,
            "y":10
         },Global.HeFu_Imgsdm);
         ComponentUtil.getBitmap("Text_HuiGui",this,{
            "x":89,
            "y":20
         },Global.HeFu_Imgsdm);
         ComponentUtil.getTextField("活动详情：",this,{
            "x":20,
            "y":80,
            "color":11523767,
            "size":12,
            "leading":0
         });
         ComponentUtil.getTextField("活动时间：",this,{
            "x":20,
            "y":109,
            "color":11523767,
            "size":12,
            "leading":0
         });
         ComponentUtil.getTextField(DateUtil.getYMDHM(Model_HeFuHuoDong.startTime) + " 至 " + DateUtil.getYMDHM(Model_HeFuHuoDong.endTime),this,{
            "x":80,
            "y":109,
            "color":13424242,
            "size":12,
            "leading":0
         });
         ComponentUtil.getTextField("50级以上，合服前7天以上没有登录过游戏的玩家，合服后一周内登录游戏可以领取回归礼包",this,{
            "x":80,
            "y":80,
            "color":13424242,
            "size":12,
            "leading":0
         });
         ComponentUtil.getBitmap("Text_NeiRong",this,{
            "x":361,
            "y":354
         },Global.HeFu_Imgsdm);
         this.giftArray = [];
         var len:int = int(Data_lib.laowanjiahuigui.getLength());
         var i:int = 0;
         while(i < len)
         {
            gift = new CardHeFu(1,i + 1);
            if(len < 8 && len > 1)
            {
               gift.x = 10 + (744 - 20 - gift.width) / (len - 1) * i;
            }
            else
            {
               gift.x = 10 + i * 112;
            }
            gift.y = 200;
            addChild(gift);
            this.giftArray.push(gift);
            gift.addEventListener(MouseEvent.CLICK,this.onClickGift);
            i++;
         }
      }
      
      override public function set visible(value:Boolean) : void
      {
         var i:* = undefined;
         super.visible = value;
         this.currentSelect = 0;
         for(i in this.giftArray)
         {
            if(i == this.currentSelect)
            {
               this.giftArray[i].select = true;
            }
            else
            {
               this.giftArray[i].select = false;
            }
         }
         this.setGrid();
      }
      
      private function onClickGift(e:MouseEvent) : void
      {
         var i:* = undefined;
         if(e.currentTarget.id == this.currentSelect + 1)
         {
            return;
         }
         for(i in this.giftArray)
         {
            if(this.giftArray[i] == e.currentTarget)
            {
               this.giftArray[i].select = true;
               this.currentSelect = i;
            }
            else
            {
               this.giftArray[i].select = false;
            }
         }
         this.setGrid();
      }
      
      private function setGrid() : void
      {
         var vo:Vo_grid = null;
         var itemArr:Array = null;
         var grid:View_Grid = null;
         if(!this.gridArray)
         {
            this.gridArray = [];
         }
         var arr:Array = Data_lib.laowanjiahuigui[this.currentSelect + 1][0].split(",");
         var len:uint = arr.length;
         var i:int = 0;
         while(true)
         {
            if(i < len)
            {
               itemArr = arr[i].split("_");
               if(Boolean(this.gridArray[i]))
               {
                  if(itemArr[0] == 1)
                  {
                     vo = new Vo_item();
                     vo.id = itemArr[1];
                     (vo as Vo_item).Init_lib();
                  }
                  else if(itemArr[0] == 2)
                  {
                     vo = new Vo_equip();
                     vo.id = itemArr[1];
                     (vo as Vo_equip).Init_lib();
                  }
                  this.gridArray[i].visible = true;
               }
               else
               {
                  grid = new View_Grid();
                  grid.set_bmp_bg();
                  grid.set_bmp_over();
                  grid.set_tf_count();
                  if(itemArr[0] == 1)
                  {
                     vo = new Vo_item();
                     vo.id = itemArr[1];
                     (vo as Vo_item).Init_lib();
                  }
                  else if(itemArr[0] == 2)
                  {
                     vo = new Vo_equip();
                     vo.id = itemArr[1];
                     (vo as Vo_equip).Init_lib();
                  }
                  grid.x = 28 + 49 * i;
                  grid.y = 389;
                  addChild(grid);
                  this.gridArray.push(grid);
               }
               this.gridArray[i].vo = vo;
               this.gridArray[i].count = itemArr[2];
            }
            else
            {
               if(!Boolean(this.gridArray[i]))
               {
                  break;
               }
               this.gridArray[i].visible = false;
            }
            i++;
         }
      }
      
      public function updateMenu() : void
      {
         var i:* = undefined;
         for(i in Model_HeFuHuoDong.arr1)
         {
            this.giftArray[i].label = Model_HeFuHuoDong.arr1[i];
         }
      }
      
      public function FlyToBag() : void
      {
         var i:* = undefined;
         for(i in this.gridArray)
         {
            ComboTweenStep.toBag(this.gridArray[i]);
         }
      }
   }
}

