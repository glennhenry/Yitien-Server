package com.yiTian.view.modules.zhutizhou
{
   import com.ui.controls.Button;
   import com.ui.controls.MyTextField;
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.command.Enum_MsgType;
   import com.yiTian.data.Data_lib;
   import com.yiTian.data.vo.Vo_equip;
   import com.yiTian.data.vo.Vo_item;
   import com.yiTian.manager.EffectManager;
   import com.yiTian.manager.UIManager;
   import com.yiTian.net.message.cg.ZhuTiZhouCGMessage;
   import com.yiTian.utils.Tween;
   import com.yiTian.utils.Utils;
   import com.yiTian.view.Panel123;
   import com.yiTian.view.comp.View_Alert;
   import com.yiTian.view.comp.View_Grid;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   import flash.utils.getTimer;
   
   public class View_XianShiLiBaoPanel extends Panel123
   {
      
      public static var isLoaded:Boolean = false;
      
      public static const STR1:String = "resource/image/zhutizhou/xianshilibao.png";
      
      public static var index:int = 0;
      
      private var _gridVec:Array;
      
      public var id:int = 1;
      
      private var shouChongBtn:Sprite;
      
      private var scBM:Bitmap;
      
      private var leftTime:MyTextField;
      
      private var times:Number = 0;
      
      private var _isFirstOpen:Boolean = true;
      
      private var timeTF:MyTextField;
      
      private var getAwardBtn:Button;
      
      private var lastTime:int = 0;
      
      public function View_XianShiLiBaoPanel()
      {
         super();
         if(!isLoaded)
         {
            regResource("lang/ch/XSLB.swf","XianShiLiBao_Imgsdm");
            preFun();
         }
         else
         {
            this.initUI2();
         }
      }
      
      override protected function initUI2() : void
      {
         var grid:View_Grid = null;
         move = new Rectangle(0,0,690,38);
         ComponentUtil.getScaleBitmap("Back1",[149,41,2,5],this,{
            "x":0,
            "y":0,
            "width":690,
            "height":424
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back_InfList",[3,3,16,16],this,{
            "x":25,
            "y":40,
            "width":640,
            "height":374
         },Global.Img_Cdm);
         ComponentUtil.getBitmap("Back_XSLB",this,{
            "x":37,
            "y":52
         },Global.XianShiLiBao_Imgsdm);
         ComponentUtil.getBitmap("HJ_WPD",this,{
            "x":103,
            "y":220
         },Global.XianShiLiBao_Imgsdm);
         ComponentUtil.getBitmap("Text_SBLQ",this,{
            "x":165,
            "y":78
         },Global.XianShiLiBao_Imgsdm);
         ComponentUtil.getBitmap("Text_ZJLYX",this,{
            "x":172,
            "y":126
         },Global.XianShiLiBao_Imgsdm);
         ComponentUtil.getBitmap("Title_XSLB",this,{
            "x":250,
            "y":5
         },Global.XianShiLiBao_Imgsdm);
         ComponentUtil.getBitmap("grid_ShangCheng",this,{
            "x":128,
            "y":240
         },Global.Img_Cdm);
         ComponentUtil.getTextField("活动结束倒计时：",this,{
            "x":267,
            "y":182,
            "color":16777215,
            "size":12,
            "leading":0
         });
         this.timeTF = ComponentUtil.getTextField("0天13时46分",this,{
            "x":363,
            "y":182,
            "color":10092288,
            "size":12,
            "leading":0
         });
         this.getAwardBtn = ComponentUtil.getButton("","Button_XHYB",this,{
            "x":247,
            "y":337,
            "textColor":16771436,
            "callBack":this.awardBtnClick
         },Global.XianShiLiBao_Imgsdm);
         this._gridVec = [];
         var i:int = 0;
         while(i < 6)
         {
            grid = new View_Grid(true);
            grid.set_bmp_bg(View_Grid.GRID_BIGGEST_OPEN);
            grid.set_bmp_over(true,View_Grid.GRID_BIGGEST_OVER);
            grid.set_bmp_select(View_Grid.GRID_BIGGEST_DOWN);
            grid.set_tf_count(true,true,true);
            addChild(grid);
            this._gridVec.push(grid);
            ComponentUtil.setPropertie(grid,{
               "x":128 + i * 73,
               "y":240
            });
            i++;
         }
         CloseButton = ComponentUtil.getButton("","Button_Close",this,{
            "x":655,
            "y":6,
            "textColor":16184781
         },Global.Img_Cdm);
         super.initDynamicView();
         isLoaded = true;
      }
      
      private function awardBtnClick(e:MouseEvent) : void
      {
         var tip:String = "<font color=\'#ffffff\'>" + "确定花费" + "</font>" + "<font color=\'#f9ff00\'>" + Data_lib.zhutizhou[this.id][7] + "元宝</font>" + "<font color=\'#ffffff\'>" + "领取该奖励？" + "</font>";
         View_Alert.show(tip,View_Alert.OK_CANCAL,function():void
         {
            sendMessage();
         });
      }
      
      public function get libaoBtn() : Sprite
      {
         if(Boolean(this.shouChongBtn))
         {
            return this.shouChongBtn;
         }
         return new Sprite();
      }
      
      public function showIcon() : void
      {
         if(!this.shouChongBtn)
         {
            this.shouChongBtn = new Sprite();
            this.shouChongBtn.graphics.beginFill(16777215,0);
            this.shouChongBtn.graphics.drawRect(0,0,65,70);
            this.shouChongBtn.graphics.endFill();
            this.scBM = new Bitmap();
            this.shouChongBtn.addChild(this.scBM);
            this.shouChongBtn.buttonMode = true;
            this.shouChongBtn.addEventListener(MouseEvent.CLICK,this.shouChongOnClick);
         }
         UIManager.mainUiBtnContainer.addBTN(this.shouChongBtn);
         this.leftTime = ComponentUtil.getTextField("0时0分",this.shouChongBtn);
         Utils.getLoadBitmap(STR1,this.scBM);
         ComponentUtil.setPropertie(this.leftTime,{
            "x":(this.shouChongBtn.width - this.leftTime.width) * 0.5,
            "y":this.shouChongBtn.height - this.leftTime.height * 0.6,
            "color":16752915,
            "size":12
         });
      }
      
      private function shouChongOnClick(e:MouseEvent) : void
      {
         this.visible = !visible;
      }
      
      override public function set visible(value:Boolean) : void
      {
         if(value)
         {
            if(isLoaded)
            {
               super.visible = value;
               parent.addChildAt(this,parent.numChildren - 1);
               if(this._isFirstOpen)
               {
                  this._isFirstOpen = false;
                  this.initData();
               }
            }
         }
         else
         {
            super.visible = value;
         }
      }
      
      public function initData() : void
      {
         var itemsArr:Array = null;
         var itemLen:int = 0;
         var itemArr:Array = null;
         var i:int = 0;
         var type:int = 0;
         var id:int = 0;
         var count:int = 0;
         var eff:int = 0;
         var viewGrid:View_Grid = null;
         var voI:Vo_item = null;
         var voE:Vo_equip = null;
         var libaoId:int = int(Data_lib.zhutizhou[this.id][6]);
         if(libaoId > 0)
         {
            itemsArr = Data_lib.zhutizhou[this.id][8].split(",");
            itemLen = int(itemsArr.length);
            itemArr = [];
            this.getAwardBtn.label = "花费" + Data_lib.zhutizhou[this.id][7] + "元宝奖励抱走";
            this.getAwardBtn.labelSize = 18;
            this.getAwardBtn.labelTF.bold = true;
            i = 0;
            while(i < itemLen)
            {
               itemArr = itemsArr[i].split("_");
               type = int(itemArr[0]);
               id = int(itemArr[1]);
               count = int(itemArr[2]);
               eff = int(itemArr[3]);
               viewGrid = this._gridVec[i];
               if(type == 1)
               {
                  voI = new Vo_item();
                  voI.id = id;
                  voI.count = count;
                  voI.Init_lib();
                  viewGrid.vo = voI;
               }
               else if(type == 2)
               {
                  voE = new Vo_equip();
                  voE.id = id;
                  voE.count = count;
                  viewGrid.vo = voE;
               }
               if(Boolean(eff))
               {
                  EffectManager.addEffect("35180",viewGrid,1000,32,32,true);
               }
               i++;
            }
         }
      }
      
      public function updateIconData(id1:int, time:int) : void
      {
         this.id = id1;
         this.showIcon();
         this.times = Number(time);
         this.leftTime.text = this.getMSBySecond4(this.times);
         this.leftTime.x = (this.shouChongBtn.width - this.leftTime.width) * 0.5;
         Global.control.registerCallBack(Enum_MsgType.MSG_ENTERFRAME,this.onCalculateTime);
      }
      
      private function onCalculateTime(interval:int) : void
      {
         var now:uint = uint(getTimer());
         if(now - this.lastTime > 1000)
         {
            this.updateTime();
            this.lastTime = now;
         }
      }
      
      private function updateTime() : void
      {
         this.times -= 1;
         var timeStr:String = this.getMSBySecond4(this.times < 0 ? 0 : this.times);
         this.leftTime.text = timeStr;
         if(Boolean(this.timeTF))
         {
            this.timeTF.text = this.leftTime.text;
         }
         this.leftTime.x = (this.shouChongBtn.width - this.leftTime.width) * 0.5;
         if(this.times <= 0)
         {
            Global.control.removeCallBack(Enum_MsgType.MSG_ENTERFRAME,this.onCalculateTime);
            this.leftTime.visible = false;
            this.leftTime.text = "";
            this.visible = false;
            this.removeShouChongBtn();
         }
      }
      
      public function removeShouChongBtn() : void
      {
         if(Boolean(this.shouChongBtn))
         {
            UIManager.mainUiBtnContainer.removeBTN(this.shouChongBtn);
         }
      }
      
      public function getMSBySecond4(second:Number, division:String = "天时分秒") : String
      {
         var h:int = 0;
         var hour:int = 0;
         var h1:int = 0;
         var m:int = 0;
         var min:int = 0;
         var m1:int = 0;
         var s:int = 0;
         var sec:int = 0;
         var result:String = "";
         var day:String = uint(second / (3600 * 24)) + "";
         if(int(day) >= 1)
         {
            result = day + "天";
            h = second % (3600 * 24);
            if(h == 0)
            {
               return result + "0时";
            }
            hour = int(h / 3600);
            result = result + hour + "时";
         }
         else
         {
            h1 = int(uint(second / 3600));
            if(h1 >= 1)
            {
               result = h1 + "时";
               m = int(second % 3600);
               if(m == 0)
               {
                  return result + "0分";
               }
               min = int(m / 60);
               result = result + min + "分";
            }
            else
            {
               m1 = int(second / 60);
               if(m1 >= 0)
               {
                  result = m1 + "分";
                  s = int(second % 60);
                  if(s == 0)
                  {
                     return result + "0秒";
                  }
                  sec = s;
                  result = result + s + "秒";
               }
            }
         }
         return result;
      }
      
      public function sendMessage() : void
      {
         var libaoId:int = int(Data_lib.zhutizhou[this.id][6]);
         View_XianShiLiBaoPanel.index = this.id;
         if(libaoId > 0)
         {
            ZhuTiZhouCGMessage.XSLB_GETAWARD(this.id);
         }
      }
      
      public function getAward() : void
      {
         var len:int = int(this._gridVec.length);
         var i:int = 0;
         while(i < len)
         {
            Tween.gridToBagBezierFuncDef(this._gridVec[i]);
            i++;
         }
         this.visible = false;
         this.removeShouChongBtn();
      }
   }
}

