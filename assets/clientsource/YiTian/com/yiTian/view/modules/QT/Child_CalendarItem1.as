package com.yiTian.view.modules.QT
{
   import com.ui.controls.Button;
   import com.ui.controls.MyTextField;
   import com.utils.ComponentUtil;
   import com.utils.DateUtil;
   import com.yiTian.Global;
   import com.yiTian.manager.UIManager;
   import com.yiTian.net.message.cg.QTSignCGMessage;
   import com.yiTian.view.modules.sign.Enum_Sign;
   import com.yiTian.view.modules.sign.Model_Sign;
   import com.yiTian.view.modules.sign.SignUtil;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.text.TextFieldAutoSize;
   
   public class Child_CalendarItem1 extends Sprite
   {
      
      private var txtDay:MyTextField;
      
      private var btn:Button;
      
      private var qianIcon:Bitmap;
      
      private var buIcon:Bitmap;
      
      private var qianIcon2:Bitmap;
      
      private var todayIcon:Bitmap;
      
      private var openIcon:Bitmap;
      
      private var closeIcon:Bitmap;
      
      private var sprite:Sprite;
      
      private var yearAndMonth:int;
      
      private var day:int;
      
      public function Child_CalendarItem1()
      {
         super();
         this.closeIcon = ComponentUtil.getBitmap("Back_Date_Close",this,{
            "x":0,
            "y":0
         },Global.QTSIGNdm);
         this.openIcon = ComponentUtil.getBitmap("Back_Date_Open",this,{
            "x":0,
            "y":0
         },Global.QTSIGNdm);
         this.todayIcon = ComponentUtil.getBitmap("Today_Img",this,{
            "x":40,
            "y":0
         },Global.QTSIGNdm);
         this.txtDay = ComponentUtil.getTextField("资源塔*00",this,{
            "x":0,
            "y":0,
            "color":16772287,
            "size":14,
            "leading":0
         });
         this.txtDay.realWidth = 60;
         this.txtDay.align = TextFieldAutoSize.CENTER;
         this.txtDay.filters = null;
         this.qianIcon = ComponentUtil.getBitmap("Qian_Img",this,{
            "x":18,
            "y":0
         },Global.QTSIGNdm);
         this.qianIcon2 = ComponentUtil.getBitmap("Qian_Img",this,{
            "x":18,
            "y":0
         },Global.QTSIGNdm);
         this.openIcon.visible = false;
         this.closeIcon.visible = false;
      }
      
      public function enable(value:Boolean) : void
      {
         this.openIcon.visible = value;
         this.closeIcon.visible = !value;
      }
      
      public function update(yearAndMonty:int, day:int, status:int, isNowDay:int, value:Boolean, nowMonty:Boolean) : void
      {
         var canShowBuQian:Boolean = false;
         var year:String = yearAndMonty.toString().substr(0,4);
         var month:String = yearAndMonty.toString().substr(4,2);
         var thisDate:Date = DateUtil.getDateFromDefaultString(year + "-" + month + "-" + day + " 00:00:00");
         var kfDate:int = Model_Sign.sysDate;
         var date:Date = DateUtil.getDateFromDefaultString(Enum_Sign.nowDay);
         if(kfDate < date.time / 1000)
         {
            kfDate = date.time / 1000;
         }
         if(kfDate <= thisDate.time / 1000)
         {
            canShowBuQian = true;
         }
         else
         {
            canShowBuQian = false;
         }
         this.yearAndMonth = yearAndMonty;
         this.day = day;
         this.txtDay.text = day + "";
         this.enable(value);
         if(nowMonty == true)
         {
            this.txtDay.color = 16772287;
         }
         else
         {
            this.txtDay.color = 16748544;
         }
         if(isNowDay == Enum_Sign.TODAY)
         {
            this.todayIcon.visible = true;
         }
         else
         {
            this.todayIcon.visible = false;
         }
         if(status == Enum_Sign.SIGN)
         {
            if(nowMonty == true)
            {
               this.qianIcon.visible = true;
               this.qianIcon2.visible = false;
            }
            else
            {
               this.qianIcon2.visible = true;
               this.qianIcon.visible = false;
            }
            mouseEnabled = false;
         }
         else
         {
            if(isNowDay != Enum_Sign.TODAY)
            {
               if(this.hasEventListener(MouseEvent.CLICK))
               {
                  this.removeEventListener(MouseEvent.CLICK,this.clickHd);
                  this.buttonMode = false;
               }
            }
            else
            {
               this.buttonMode = true;
               this.addEventListener(MouseEvent.CLICK,this.clickHd);
               mouseEnabled = true;
               if(parent != null)
               {
                  SignUtil.showSingleTips("35075",parent as Sprite,x + 30,y + 9);
               }
            }
            this.qianIcon.visible = false;
            this.qianIcon2.visible = false;
         }
      }
      
      private function clickHd(e:MouseEvent) : void
      {
         var arr:Array = null;
         var i:int = 0;
         if(View_qtSign._signCount >= 30)
         {
            arr = Model_qtSign.signRewardStatusData;
            i = 0;
            while(i < arr.length)
            {
               if(arr[i] != 2)
               {
                  UIManager.centerBroadcast.addMsg("请领完所有签到奖励礼包，才能继续签到");
                  return;
               }
               i++;
            }
         }
         QTSignCGMessage.CG_QTSign_SIGN();
      }
   }
}

