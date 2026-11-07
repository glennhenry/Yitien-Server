package com.yiTian.view.modules.sign
{
   import com.ui.controls.Button;
   import com.ui.controls.MyTextField;
   import com.utils.ComponentUtil;
   import com.utils.DateUtil;
   import com.yiTian.Global;
   import com.yiTian.manager.GameUnitManager;
   import com.yiTian.manager.UIManager;
   import com.yiTian.net.message.cg.SignCGMessage;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.utils.clearTimeout;
   import flash.utils.setTimeout;
   
   public class Child_CalendarItem extends Sprite
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
      
      public function Child_CalendarItem()
      {
         super();
         this.closeIcon = ComponentUtil.getBitmap("Back_Date_Close",this,{
            "x":0,
            "y":0
         },Global.ZaiXian_Imgsdm);
         this.openIcon = ComponentUtil.getBitmap("Back_Date_Open",this,{
            "x":0,
            "y":0
         },Global.ZaiXian_Imgsdm);
         this.sprite = new Sprite();
         addChild(this.sprite);
         this.sprite.buttonMode = true;
         this.sprite.addEventListener(MouseEvent.CLICK,this.sign);
         this.buIcon = ComponentUtil.getBitmap("Bu_Img",this,{
            "x":25,
            "y":8
         },Global.ZaiXian_Imgsdm);
         this.sprite.addChild(this.buIcon);
         this.qianIcon = ComponentUtil.getBitmap("Qian_Img",this,{
            "x":6,
            "y":2
         },Global.ZaiXian_Imgsdm);
         this.qianIcon2 = ComponentUtil.getBitmap("Qian_Img02",this,{
            "x":6,
            "y":2
         },Global.ZaiXian_Imgsdm);
         this.todayIcon = ComponentUtil.getBitmap("Today_Img",this,{
            "x":23,
            "y":0
         },Global.ZaiXian_Imgsdm);
         this.txtDay = ComponentUtil.getTextField("资源塔*00",this,{
            "x":3,
            "y":0,
            "color":6717035,
            "size":18,
            "leading":0
         });
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
            this.txtDay.color = 8111498;
         }
         else
         {
            this.txtDay.color = 6717035;
         }
         if(isNowDay == Enum_Sign.TODAY)
         {
            this.todayIcon.visible = true;
            this.sprite.visible = false;
         }
         else
         {
            this.todayIcon.visible = false;
            if(canShowBuQian == true)
            {
               this.sprite.visible = true;
            }
            else
            {
               this.sprite.visible = false;
            }
         }
         if(status == Enum_Sign.SIGN)
         {
            this.sprite.visible = false;
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
         }
         else
         {
            if(isNowDay != Enum_Sign.TODAY)
            {
               if(canShowBuQian == true)
               {
                  this.sprite.visible = true;
               }
               else
               {
                  this.sprite.visible = false;
               }
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
               if(parent != null)
               {
                  SignUtil.showSingleTips("35075",parent as Sprite,x + 24,y + 16);
               }
            }
            this.qianIcon.visible = false;
            this.qianIcon2.visible = false;
         }
         if(value == false)
         {
            if(this.sprite.visible == true)
            {
               this.sprite.visible = false;
            }
         }
      }
      
      private function clickHd(e:MouseEvent) : void
      {
         SignCGMessage.CG_SIGN(this.yearAndMonth,this.day,Enum_Sign.FREE);
      }
      
      private function sign(e:MouseEvent) : void
      {
         var tip:String = "";
         UIManager.wuXingProm.show(function():void
         {
            var timeOut:int = 0;
            if(GameUnitManager.hero.liquan >= 10)
            {
               SignCGMessage.CG_SIGN(yearAndMonth,day,Enum_Sign.NEED_FEE);
            }
            else
            {
               timeOut = int(setTimeout(function():void
               {
                  UIManager.wuXingProm.show(function():void
                  {
                     SignCGMessage.CG_SIGN(yearAndMonth,day,Enum_Sign.NEED_FEE);
                  },"礼券不足，是否花费10元宝进行补签？",100);
                  clearTimeout(timeOut);
               },100));
            }
         },"补签需要消耗10礼券，是否确认使用？",10);
      }
   }
}

