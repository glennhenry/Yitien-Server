package com.yiTian.view.modules.HeFuHuoDong
{
   import com.ui.controls.Button;
   import com.ui.controls.MaskProgressBar;
   import com.ui.controls.MyTextField;
   import com.utils.ComponentUtil;
   import com.utils.DateUtil;
   import com.yiTian.Global;
   import com.yiTian.data.Data_lib;
   import com.yiTian.data.model.Model_HeFuHuoDong;
   import com.yiTian.data.vo.Vo_equip;
   import com.yiTian.data.vo.Vo_grid;
   import com.yiTian.data.vo.Vo_item;
   import com.yiTian.manager.UIManager;
   import com.yiTian.utils.ComboTweenStep;
   import com.yiTian.view.comp.View_Grid;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   
   public class View_HefuHuoDong2 extends Sprite
   {
      
      private static var _instance:View_HefuHuoDong2;
      
      private var giftArray:Array;
      
      private var currentSelect:int;
      
      private var gridArray:Array;
      
      private var ChongZhiBtn:Button;
      
      private var bar:MaskProgressBar;
      
      private var progressTxt:MyTextField;
      
      public function View_HefuHuoDong2()
      {
         super();
         this.Init();
      }
      
      public static function get instance() : View_HefuHuoDong2
      {
         if(!_instance)
         {
            _instance = new View_HefuHuoDong2();
         }
         return _instance;
      }
      
      private function Init() : void
      {
         var len:int;
         var i:int;
         var gift:CardChongZhi = null;
         ComponentUtil.getScaleBitmap("Back_Green_List",[5,5,1,1],this,{
            "x":0,
            "y":170,
            "width":744,
            "height":280
         },Global.Img_Cdm);
         ComponentUtil.getBitmap("NeiRong_Back",this,{
            "x":10,
            "y":349
         },Global.HeFu_Imgsdm);
         ComponentUtil.getBitmap("Text_NeiRong",this,{
            "x":361,
            "y":354
         },Global.HeFu_Imgsdm);
         ComponentUtil.getBitmap("Text_Back",this,{
            "x":2,
            "y":10
         },Global.HeFu_Imgsdm);
         ComponentUtil.getTextField("活动详情：",this,{
            "x":20,
            "y":65,
            "color":11523767,
            "size":12,
            "leading":0
         });
         ComponentUtil.getTextField("活动时间：",this,{
            "x":20,
            "y":90,
            "color":11523767,
            "size":12,
            "leading":0
         });
         ComponentUtil.getTextField(DateUtil.getYMDHM(Model_HeFuHuoDong.startTime) + " 至 " + DateUtil.getYMDHM(Model_HeFuHuoDong.endTime),this,{
            "x":80,
            "y":90,
            "color":13424242,
            "size":12,
            "leading":0
         });
         ComponentUtil.getTextField("活动期间，玩家充值累计到一定额度，即可领取对应回馈礼包",this,{
            "x":80,
            "y":65,
            "color":13424242,
            "size":12,
            "leading":0
         });
         ComponentUtil.getBitmap("Text_ChongZhi",this,{
            "x":89,
            "y":20
         },Global.HeFu_Imgsdm);
         this.giftArray = [];
         len = int(Data_lib.hefuchongzhi.getLength());
         i = 0;
         while(i < len)
         {
            gift = new CardChongZhi(i + 1);
            if(len < 8 && len > 1)
            {
               gift.x = 10 + (744 - 20 - gift.width) / (len - 1) * i;
            }
            else
            {
               gift.x = 10 + i * 112;
            }
            gift.y = 175;
            addChild(gift);
            this.giftArray.push(gift);
            gift.addEventListener(MouseEvent.CLICK,this.onClickGift);
            i++;
         }
         ComponentUtil.getScaleBitmap("Progress_Back_SBm",[33,16,59,2],this,{
            "x":22,
            "y":120,
            "width":540,
            "height":34
         },Global.Img_Cdm);
         this.bar = new MaskProgressBar();
         this.bar.realWidth = 490;
         this.bar.bar = ComponentUtil.getScaleBitmap("Progress_SBm",[6,7,42,2],null,{
            "width":490,
            "height":16
         },Global.Img_Cdm);
         this.bar.x = 47;
         this.bar.y = 129;
         this.bar.init();
         addChild(this.bar);
         this.progressTxt = ComponentUtil.getTextField("",this,{
            "x":292,
            "y":126
         },"center");
         this.ChongZhiBtn = ComponentUtil.getButton("","Button_Chong",this,{
            "x":587,
            "y":113,
            "textColor":16184781
         },Global.HeFu_Imgsdm);
         this.ChongZhiBtn.callBack = function():void
         {
            UIManager.yuanBaoXiang.visible = !UIManager.yuanBaoXiang.visible;
         };
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
         var arr:Array = Data_lib.hefuchongzhi[this.currentSelect + 1][1].split(",");
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
         for(i in Model_HeFuHuoDong.arr2)
         {
            this.giftArray[i].label = Model_HeFuHuoDong.arr2[i];
         }
      }
      
      public function setProgress(count:int) : void
      {
         var i:int = 1;
         while(i < Data_lib.hefuchongzhi.getLength() && count >= Data_lib.hefuchongzhi[i][0])
         {
            i++;
         }
         count = count > Data_lib.hefuchongzhi[Data_lib.hefuchongzhi.getLength()][0] ? int(Data_lib.hefuchongzhi[Data_lib.hefuchongzhi.getLength()][0]) : count;
         this.progressTxt.text = count + "/" + Data_lib.hefuchongzhi[i][0];
         this.bar.persent = count / Data_lib.hefuchongzhi[i][0];
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

