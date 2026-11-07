package com.yiTian.view.modules.QT
{
   import com.ui.controls.Button;
   import com.ui.controls.MyTextField;
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.manager.UIManager;
   import com.yiTian.scene.GameScene;
   import com.yiTian.utils.Bitmap2;
   import com.yiTian.utils.Tween;
   import com.yiTian.view.modules.sign.Enum_Sign;
   import com.yiTian.view.modules.sign.SignUtil;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import flash.net.URLRequest;
   import flash.net.navigateToURL;
   
   public class View_qtSign extends Sprite
   {
      
      private static var _instance:View_qtSign;
      
      public static var _signCount:int = 0;
      
      private var _bmCon:Sprite;
      
      private var _getBtn:Button;
      
      private var _datachoose:Child_DateChoose1;
      
      private var rewardItemVec:Vector.<Child_SignRewardItem1> = new Vector.<Child_SignRewardItem1>();
      
      private var txtCount:MyTextField;
      
      private var _date:Date;
      
      public function View_qtSign()
      {
         super();
         this.initUI();
      }
      
      public static function get instance() : View_qtSign
      {
         if(!_instance)
         {
            _instance = new View_qtSign();
         }
         return _instance;
      }
      
      private function initUI() : void
      {
         ComponentUtil.getBitmap("Back_NHL",this,{
            "x":35,
            "y":75
         },Global.QTHDdm);
         ComponentUtil.getBitmap("Back_QTQD",this,{
            "x":40,
            "y":189
         },Global.QTHDdm);
         ComponentUtil.getBitmap("Text_NHL",this,{
            "x":101,
            "y":78
         },Global.QTHDdm);
         this._bmCon = new Sprite();
         addChild(this._bmCon);
         this._bmCon.buttonMode = true;
         ComponentUtil.getBitmap("MMfreeX",this._bmCon,{
            "x":451,
            "y":84
         },Global.QTHDdm);
         ComponentUtil.getBitmap("MMoneX",this._bmCon,{
            "x":559,
            "y":84
         },Global.QTHDdm);
         this._bmCon.addEventListener(MouseEvent.CLICK,this.onClickBm);
         ComponentUtil.getBitmap("Back_QTRenWu",this,{
            "x":-75,
            "y":129
         },Global.QTHDdm);
         ComponentUtil.getButton("","Button_Close",this,{
            "x":692,
            "y":6,
            "textColor":16771436
         },Global.Img_Cdm);
         ComponentUtil.getBitmap("Title_QTHD",this,{
            "x":283,
            "y":5
         },Global.QTHDdm);
         ComponentUtil.getTextField("活动详情",this,{
            "x":42,
            "y":45,
            "color":16773818,
            "size":12,
            "leading":0
         });
         ComponentUtil.getTextField("QT签到",this,{
            "x":122,
            "y":45,
            "color":16773818,
            "size":12,
            "leading":0
         });
         ComponentUtil.getBitmap("Text_MeiRiQT",this,{
            "x":255,
            "y":193
         },Global.QTHDdm);
         ComponentUtil.getTextField("星期日      星期一      星期二      星期三      星期四      星期五      星期六",this,{
            "x":269,
            "y":231,
            "color":16774101,
            "size":12,
            "leading":0,
            "filters":null
         });
         ComponentUtil.getTextField("累计签到次数:",this,{
            "x":574,
            "y":375,
            "color":16772287,
            "size":12,
            "leading":0
         });
         this.txtCount = ComponentUtil.getTextField("16",this,{
            "x":654,
            "y":375,
            "color":258560,
            "size":12,
            "leading":0,
            "filters":null
         });
         this._getBtn = ComponentUtil.getButton("","Button_LJLQ",this,{
            "x":573,
            "y":193,
            "textColor":16771436
         },Global.QTHDdm);
         this._getBtn.callBack = this.onClickBm;
         Model_qtSign.setSignRewardData();
         this._datachoose = new Child_DateChoose1();
         addChild(this._datachoose);
         this._datachoose.x = 257;
         this._datachoose.y = 221;
         this.createRewardItem();
         visible = false;
      }
      
      private function createRewardItem() : void
      {
         var item:Child_SignRewardItem1 = null;
         var i:int = 0;
         i = 0;
         while(i < Enum_Sign.HOLIDAY_REWARD_MAX_NUM)
         {
            item = new Child_SignRewardItem1();
            item.x = 263 + 84 * i;
            item.y = 369;
            addChild(item);
            this.rewardItemVec.push(item);
            i++;
         }
      }
      
      public function flyRewardIcon(i:int) : void
      {
         if(Boolean(this.rewardItemVec[i]))
         {
            this.flyIcon(this.rewardItemVec[i].x,this.rewardItemVec[i].y);
         }
      }
      
      public function flyIcon(x:int, y:int) : void
      {
         var disPoint:Point = null;
         var p:Point = null;
         var bm:Bitmap2 = null;
         var dir:String = "resource/image/QT/gift.png";
         disPoint = UIManager.mainMenu.getbagPoint();
         p = this.localToGlobal(new Point(x,y));
         bm = new Bitmap2();
         bm.load(dir);
         bm.x = p.x + 15;
         bm.y = p.y - 25;
         GameScene.upUILayer.addChild(bm);
         Tween.to(bm,2500,{
            "x":[bm.x,disPoint.x],
            "y":[bm.y,disPoint.y]
         },function(bm:Bitmap2):void
         {
            if(Boolean(bm.parent))
            {
               bm.parent.removeChild(bm);
            }
         },null,Tween.SIN);
      }
      
      private function updateRewardItem() : void
      {
         var i:int = 0;
         i = 0;
         while(i < Enum_Sign.HOLIDAY_REWARD_MAX_NUM)
         {
            if(Boolean(this.rewardItemVec[i]))
            {
               this.rewardItemVec[i].update(Model_qtSign.signRewardStatusData[i],Model_qtSign.signRewardData[i]);
            }
            i++;
         }
      }
      
      public function getAward() : void
      {
         var i:int = 0;
         while(i < this.rewardItemVec.length)
         {
            if(i == Model_qtSign.AWARD_INDEX)
            {
               Model_qtSign.signRewardStatusData[i] = 2;
               this.rewardItemVec[i].update(Model_qtSign.signRewardStatusData[i],Model_qtSign.signRewardData[i]);
               break;
            }
            i++;
         }
         this.flyRewardIcon(Model_qtSign.AWARD_INDEX);
      }
      
      public function sign() : void
      {
         var year:int = this._date.fullYear;
         var month:int = this._date.month + 1;
         var month1:String = month < 10 ? "0" + month : month + "";
         var day:String = this._date.date < 10 ? "0" + this._date.date : this._date.date.toString();
         var str:String = "" + year + month1 + day;
         Model_qtSign.signStatusData[str] = "1";
         ++_signCount;
         if(_signCount > 30)
         {
            _signCount -= 30;
         }
         var arr1:Array = Model_qtSign.signStatusData;
         var arr2:Array = Model_qtSign.yearAndMontyData;
         SignUtil.removeSingleTips();
         this.updateAwardStatus();
         this.update(_signCount,this._date);
      }
      
      private function updateAwardStatus() : void
      {
         var statusArr:Array = Model_qtSign.signRewardStatusData;
         var numArr:Array = Model_qtSign.signRewardData;
         var i:int = 0;
         while(i < statusArr.length)
         {
            if(statusArr[i] == 0 && _signCount >= numArr[i][1])
            {
               statusArr[i] = 1;
            }
            i++;
         }
      }
      
      public function update(count:int, date:Date) : void
      {
         _signCount = count;
         this.txtCount.text = _signCount.toString();
         this._date = date;
         this.updateRewardItem();
         this._datachoose.updateDate(date);
         visible = true;
      }
      
      protected function onClickBm(event:MouseEvent) : void
      {
         navigateToURL(new URLRequest("http://qt.qq.com/go.html?roomid=5151&ADTAG=qtweb.yl.ghd21"));
      }
   }
}

