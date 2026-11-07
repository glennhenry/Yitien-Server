package com.yiTian.view.modules.ShouChongTiaoZheng
{
   import com.ui.controls.Button;
   import com.ui.controls.MyTextField;
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.command.Enum_MsgType;
   import com.yiTian.data.Data_lib;
   import com.yiTian.data.config.Enum_job;
   import com.yiTian.data.vo.Vo_equip;
   import com.yiTian.data.vo.Vo_item;
   import com.yiTian.data.vo.Vo_valuable;
   import com.yiTian.manager.EffectManager;
   import com.yiTian.manager.GameUnitManager;
   import com.yiTian.manager.UIManager;
   import com.yiTian.net.message.cg.ShouChongTiaoZhengCGMessage;
   import com.yiTian.utils.ComboTweenStep;
   import com.yiTian.view.Panel123;
   import com.yiTian.view.comp.View_Grid;
   import com.yiTian.view.modules.mainUIBtnContainer.MainUIBtn;
   import com.yiTian.view.modules.panel.View_updata_panelTip;
   import flash.display.Bitmap;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import flash.utils.clearInterval;
   import flash.utils.getTimer;
   import flash.utils.setInterval;
   import flash.utils.setTimeout;
   
   public class View_ShouChongTiaoZheng_menu extends Panel123
   {
      
      private static var _instance:View_ShouChongTiaoZheng_menu;
      
      private var _iconType:int;
      
      private var _tableId:int;
      
      private var _day:int;
      
      private var _btn:MainUIBtn;
      
      private var time:int;
      
      private var nowTime:int;
      
      private var countDownTxt:MyTextField;
      
      private var wingTipBitmap:Bitmap;
      
      private var wingBitmap:Bitmap;
      
      private var wingBitmapId:int = 1;
      
      private var intervalId:uint;
      
      private var gridArr:Array;
      
      private var gridEffArr:Array;
      
      private var prizeArr:Array;
      
      private var ChongZhiBtn:Button;
      
      private var flyPrizeArr:Array;
      
      private var backBm:Bitmap;
      
      private var backBm2:Bitmap;
      
      public function View_ShouChongTiaoZheng_menu()
      {
         super();
         if(Boolean(_instance))
         {
            return;
         }
         regResource("lang/ch/ShouChongTiaoZheng.swf","ShouChongTiaoZheng");
      }
      
      public static function get instance() : View_ShouChongTiaoZheng_menu
      {
         if(!_instance)
         {
            _instance = new View_ShouChongTiaoZheng_menu();
         }
         return _instance;
      }
      
      override protected function initUI2() : void
      {
         var i:int = 0;
         var grid:View_Grid = null;
         move = new Rectangle(0,0,698,30);
         ComponentUtil.getScaleBitmap("Back1",[149,41,2,5],this,{
            "x":0,
            "y":0,
            "width":698,
            "height":482
         },Global.Img_Cdm);
         this.backBm = ComponentUtil.getBitmap("Back_Img",this,{
            "x":24,
            "y":40
         },Global.ShouChongTiaoZheng);
         this.backBm.visible = false;
         this.backBm2 = ComponentUtil.getBitmap("Back_Img2",this,{
            "x":24,
            "y":40
         },Global.ShouChongTiaoZheng);
         this.backBm2.visible = false;
         CloseButton = ComponentUtil.getButton("","Button_Close",this,{
            "x":663,
            "y":6,
            "textColor":16184781
         },Global.Img_Cdm);
         CloseButton.callBack = function():void
         {
            visible = false;
         };
         ComponentUtil.getBitmap("Title_ChongZhi",this,{
            "x":249,
            "y":5
         },Global.ShouChongTiaoZheng);
         this.wingTipBitmap = ComponentUtil.getBitmap("Text_XKCB",this,{
            "x":590,
            "y":291
         },Global.ShouChongTiaoZheng);
         this.wingTipBitmap.visible = false;
         this.ChongZhiBtn = ComponentUtil.getButton("","Button_MSQJL",this,{
            "x":339,
            "y":370,
            "textColor":16771436
         },Global.ShouChongTiaoZheng);
         this.ChongZhiBtn.callBack = function():void
         {
            UIManager.yuanBaoXiang.visible = !UIManager.yuanBaoXiang.visible;
         };
         this.countDownTxt = ComponentUtil.getTextField("",this,{
            "x":667,
            "y":448,
            "color":16711680,
            "size":16
         },"right");
         this.gridArr = [];
         this.gridEffArr = [];
         i = 0;
         while(i < 8)
         {
            grid = new View_Grid(true);
            grid.set_bmp_bg(View_Grid.GRID_BIGGEST_OPEN);
            grid.set_bmp_over(true,null);
            grid.set_tf_count();
            grid.x = 230 + i % 4 * 74;
            grid.y = 207 + int(i / 4) * 74;
            addChild(grid);
            this.gridArr.push(grid);
            i++;
         }
         this.wingBitmap = new Bitmap();
         addChild(this.wingBitmap);
         this.wingBitmap.visible = false;
         this.wingBitmap.x = 333;
         this.wingBitmap.y = 103;
         this._btn = new MainUIBtn("resource/image/shouchong/ShouChong_1.png");
         this.btn.addEventListener(MouseEvent.CLICK,this.onBtnClick);
      }
      
      override public function set visible(value:Boolean) : void
      {
         super.visible = value;
         if(value)
         {
            this.intervalId = setInterval(this.playWing,200);
         }
         else if(this.intervalId > 0)
         {
            clearInterval(this.intervalId);
            this.intervalId = 0;
         }
      }
      
      private function playWing() : void
      {
         this.wingBitmap.bitmapData = ComponentUtil.getBitmapData("wing" + this.wingBitmapId,Global.ShouChongTiaoZheng);
         ++this.wingBitmapId;
         if(this.wingBitmapId > 4)
         {
            this.wingBitmapId = 1;
         }
      }
      
      private function onBtnClick(e:MouseEvent) : void
      {
         if(this.iconType == 1)
         {
            ShouChongTiaoZhengCGMessage.CG_ShouChongTiaoZheng_GET_PRIZE();
         }
         else if(this.iconType == 0)
         {
            this.visible = !this.visible;
         }
      }
      
      public function get btn() : MainUIBtn
      {
         return this._btn;
      }
      
      public function setTime(_time:int) : void
      {
         this.time = _time * 1000;
         this.nowTime = getTimer();
         this.btn.setCountDown(_time);
         Global.control.registerCallBack(Enum_MsgType.MSG_ENTERFRAME,this.updateTime);
      }
      
      private function updateTime() : void
      {
         var day:int = 0;
         var hour:int = 0;
         var minute:int = 0;
         var interval:int = getTimer() - this.nowTime;
         this.time -= interval;
         if(this.time > 0)
         {
            day = this.time / 1000 / 86400;
            hour = this.time / 1000 / 3600 % 24;
            minute = this.time / 1000 / 60 % 60;
            if(day > 0)
            {
               this.countDownTxt.text = "活动截止：" + day + "天" + hour + "时";
            }
            else
            {
               this.countDownTxt.text = "活动截止：" + hour + "时" + minute + "分";
            }
            this.nowTime = getTimer();
         }
         else
         {
            Global.control.removeCallBack(Enum_MsgType.MSG_ENTERFRAME,this.updateTime);
            UIManager.mainUiBtnContainer.removeBTN(this._btn);
            this.visible = false;
         }
      }
      
      public function get iconType() : int
      {
         return this._iconType;
      }
      
      public function set iconType(value:int) : void
      {
         this._iconType = value;
         if(this.iconType == 1)
         {
            this.btn.setSource("resource/image/shouchong/ShouChongGet.png");
            this.btn.effectBegin();
         }
         else
         {
            this.btn.effectEnd();
         }
      }
      
      public function get tableId() : int
      {
         return this._tableId;
      }
      
      public function set tableId(value:int) : void
      {
         var prize:Array = null;
         var vo:Vo_valuable = null;
         this._tableId = value;
         this.prizeArr = Data_lib.ShouChongTiaoZheng[this.tableId][Enum_job.getBaseJob(GameUnitManager.hero.job)].split(",");
         var i:int = 0;
         while(i < 8)
         {
            if(Boolean(this.prizeArr[i]))
            {
               this.gridArr[i].visible = true;
               prize = this.prizeArr[i].split("_");
               if(prize[0] == 1)
               {
                  vo = new Vo_item();
                  vo.id = prize[1];
                  vo.count = prize[2];
                  (vo as Vo_item).Init_lib();
                  if(Boolean(this.gridEffArr[i]))
                  {
                     EffectManager.removeEffect(this.gridEffArr[i]);
                     this.gridEffArr[i] = null;
                  }
               }
               else if(prize[0] == 2)
               {
                  vo = new Vo_equip();
                  vo.id = prize[1];
                  vo.count = prize[2];
                  (vo as Vo_equip).Init_lib();
                  if(!this.gridEffArr[i])
                  {
                     this.gridEffArr[i] = EffectManager.addEffect("35180",this.gridArr[i],1000,32,32,true);
                  }
               }
               this.gridArr[i].vo = vo;
               if(this.tableId == 1)
               {
                  this.gridArr[i].x = 230 + i % 4 * 74;
               }
               else
               {
                  this.gridArr[i].x = 303 + i % 4 * 74;
               }
            }
            else
            {
               this.gridArr[i].visible = false;
            }
            i++;
         }
         if(this.tableId == 1)
         {
            this.wingBitmap.visible = true;
            this.wingTipBitmap.visible = true;
            this.backBm.visible = true;
            this.backBm2.visible = false;
         }
         else
         {
            this.wingBitmap.visible = false;
            this.wingTipBitmap.visible = false;
            this.backBm.visible = false;
            this.backBm2.visible = true;
         }
      }
      
      public function get day() : int
      {
         return this._day;
      }
      
      public function set day(value:int) : void
      {
         this._day = value;
         if(this.iconType != 1)
         {
            this.btn.setSource("resource/image/shouchong/ShouChong_" + this.day + ".png");
         }
      }
      
      public function getPrize() : void
      {
         var interval:int;
         var p:Point = null;
         var i:* = undefined;
         var prizeStr:Array = null;
         var wingVo:Vo_valuable = null;
         p = UIManager.mainUiBtnContainer.getT(this.btn);
         if(!p)
         {
            return;
         }
         interval = 0;
         this.flyPrizeArr = [];
         for(i in this.gridArr)
         {
            if(Boolean(this.gridArr[i].visible))
            {
               this.flyPrizeArr[i] = this.gridArr[i];
            }
            setTimeout(function():void
            {
               ComboTweenStep.toBag(flyPrizeArr.shift().vo,p.x,p.y);
            },interval);
            interval += 500;
         }
         if(Boolean(this.prizeArr[8]))
         {
            prizeStr = this.prizeArr[8].split("_");
            if(prizeStr[0] == 1)
            {
               wingVo = new Vo_item();
            }
            else
            {
               wingVo = new Vo_equip();
            }
            wingVo.id = prizeStr[1];
            wingVo.Init_lib();
            setTimeout(function():void
            {
               ComboTweenStep.toBag(wingVo,p.x,p.y);
               View_updata_panelTip.getInstance().updata_vo(wingVo);
            },interval);
         }
         UIManager.mainUiBtnContainer.removeBTN(this.btn);
         this.btn.effectEnd();
         this.visible = false;
      }
   }
}

