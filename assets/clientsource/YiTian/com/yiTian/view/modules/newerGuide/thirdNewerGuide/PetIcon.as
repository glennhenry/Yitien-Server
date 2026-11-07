package com.yiTian.view.modules.newerGuide.thirdNewerGuide
{
   import com.ui.controls.MyTextField;
   import com.utils.ComponentUtil;
   import com.utils.DateUtil;
   import com.yiTian.Global;
   import com.yiTian.command.Enum_MsgType;
   import com.yiTian.gameUnit.magic.Effect;
   import com.yiTian.manager.GameUnitManager;
   import com.yiTian.manager.TipManager;
   import com.yiTian.manager.UIManager;
   import com.yiTian.net.message.cg.GuideCGMessage;
   import com.yiTian.utils.HtmlUtil;
   import com.yiTian.utils.Utils;
   import flash.display.Bitmap;
   import flash.events.MouseEvent;
   import flash.utils.getTimer;
   import flashx.textLayout.formats.TextAlign;
   
   public class PetIcon
   {
      
      private static var icon:BtnSpr;
      
      public static var time:int;
      
      private static var tf:MyTextField;
      
      private static var btnEff:Effect;
      
      private static var lastTime:int;
      
      public function PetIcon()
      {
         super();
      }
      
      public static function show(status:int = 1) : void
      {
         if(!icon)
         {
            icon = new BtnSpr();
            icon.addChild(Utils.getLoadBitmap("resource/image/thirdNewerGuide/Icon_pet.png",new Bitmap()));
            tf = ComponentUtil.getTextField("",icon,{
               "x":-4,
               "y":60,
               "realWidth":60,
               "align":TextAlign.CENTER
            });
            thirdNewerContainer.instance.addBtn(icon,status);
            TipManager.bind(icon,"一秒变萌宠，形象大转变");
            icon.addEventListener(MouseEvent.CLICK,getHd);
         }
         else
         {
            move(status,thirdNewerContainer.INSIDE_MOVE);
         }
         if(time > 0)
         {
            tf.htmlText = HtmlUtil.bold(HtmlUtil.font(DateUtil.getMSBySecond3(time),"#FFFF00",12));
            addFrame();
         }
         else if(time == 0)
         {
            if(status == 1)
            {
               tf.htmlText = HtmlUtil.bold(HtmlUtil.font("30级领取","#FFFF00",12));
            }
            else if(status == 2)
            {
               tf.htmlText = HtmlUtil.bold(HtmlUtil.font("点击领取","#FFFF00",12));
            }
         }
      }
      
      public static function show_btn(hasEff:Boolean) : void
      {
      }
      
      private static function getHd(e:MouseEvent) : void
      {
         if(time <= 0)
         {
            if(GameUnitManager.hero.level < 30)
            {
               UIManager.centerBroadcast.addMsg("少侠你目前的等级不足无法领取。");
               return;
            }
            GuideCGMessage.CG_THIRDNEWER_PETCHANGE();
         }
         else
         {
            Model_thirdNewer.showPan(Model_thirdNewer.PETINDEX);
         }
      }
      
      public static function addFrame() : void
      {
         Global.control.registerCallBack(Enum_MsgType.MSG_ENTERFRAME,run);
      }
      
      public static function removeFrame() : void
      {
         Global.control.removeCallBack(Enum_MsgType.MSG_ENTERFRAME,run);
      }
      
      private static function run() : void
      {
         var colorStr:String = null;
         var now:int = getTimer();
         if(now - lastTime >= 1000)
         {
            lastTime = now;
            --time;
            if(time <= 60)
            {
               colorStr = "#fe0000";
            }
            else
            {
               colorStr = "#04ff00";
            }
            tf.htmlText = HtmlUtil.bold(HtmlUtil.font(DateUtil.getMSBySecond3(time),colorStr,12));
            if(time <= 0)
            {
               hide();
            }
         }
      }
      
      public static function hide() : void
      {
         if(Boolean(icon))
         {
            thirdNewerContainer.instance.removeBtn(icon,icon.status);
         }
         removeFrame();
      }
      
      private static function move(status:int, moveStyle:String) : void
      {
         thirdNewerContainer.instance.moveBtn(icon,status,2000,moveStyle);
      }
   }
}

