package com.yiTian.view.modules.FeiXingQi
{
   import com.ui.controls.MyTextField;
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.manager.DailyBtnManager;
   import com.yiTian.manager.GameUnitManager;
   import com.yiTian.manager.UIManager;
   import com.yiTian.net.message.cg.FeiXingQiCGMessage;
   import com.yiTian.view.modules.guaji.BitmapBtn;
   import com.yiTian.view.modules.mainUIBtnContainer.Enum_mainUIBtn_hide;
   import com.yiTian.view.modules.mainUIBtnContainer.IMainUiBtn;
   import flash.events.MouseEvent;
   import flash.text.TextFieldAutoSize;
   
   public class Model_FeiXingQi
   {
      
      public static var myUnit:Child_FeiXingQiUnit;
      
      public static var tipBtn:BitmapBtn;
      
      public static const tileArr:Array = [];
      
      public static const unitArr:Array = [];
      
      public static const embellishs:Array = [];
      
      public static var isTween:Boolean = false;
      
      public static var version:int = -1;
      
      public static var unitsPool:Array = [];
      
      public static var disIndex:int = -1;
      
      public function Model_FeiXingQi()
      {
         super();
      }
      
      public static function findUnit(value:Object, key:String = "id") : Child_FeiXingQiUnit
      {
         var u:Child_FeiXingQiUnit = null;
         for each(u in unitArr)
         {
            if(u[key] == value)
            {
               return u;
            }
         }
         return null;
      }
      
      public static function getUnit() : Child_FeiXingQiUnit
      {
         return Boolean(unitsPool.length) ? unitsPool.pop() : new Child_FeiXingQiUnit();
      }
      
      public static function setTipBtnRemainStr(str:String) : void
      {
         var tf:MyTextField = null;
         if(Boolean(tipBtn))
         {
            tf = tipBtn.extraObject.tf;
            tf.text = str;
         }
      }
      
      public static function hidTipBtn() : void
      {
         if(Boolean(tipBtn))
         {
            UIManager.mainUiBtnContainer.removeBTN(tipBtn);
         }
         Global.control.sendNotification(Enum_mainUIBtn_hide.CHANGE_STATUS,[Enum_mainUIBtn_hide.ChuangGuan,2]);
      }
      
      public static function countTimes(ct:int) : void
      {
         if(GameUnitManager.hero.level < Enum_FeiXingQi.FXQOPENLVNEED)
         {
            hidTipBtn();
            return;
         }
         if(ct > 0)
         {
            showTipBtn();
         }
         else
         {
            hidTipBtn();
         }
      }
      
      private static function tipBtnClickHd(evt:MouseEvent) : void
      {
         if(UIManager.feiXingQiPanel.visible == false)
         {
            FeiXingQiCGMessage.CG_FXQINFO(Model_FeiXingQi.version);
         }
         else
         {
            UIManager.feiXingQiPanel.visible = false;
         }
      }
      
      public static function showTipBtn() : IMainUiBtn
      {
         var tf:MyTextField = null;
         if(!tipBtn)
         {
            tipBtn = new BitmapBtn(true);
            tipBtn.setBgDir(Enum_FeiXingQi.ICONDIR);
            tipBtn.init(2,2,46,46);
            tipBtn.buttonMode = true;
            tipBtn.clickCallBack = tipBtnClickHd;
            updateBtnCount(DailyBtnManager.getCount(DailyBtnManager.CG));
            tf = ComponentUtil.getTextField("",tipBtn,{
               "y":52,
               "realWidth":65,
               "color":16776960,
               "bold":true
            });
            tf.autoSize = TextFieldAutoSize.CENTER;
            tipBtn.extraObject = {"tf":tf};
         }
         UIManager.mainUiBtnContainer.addBTN(tipBtn);
         Global.control.sendNotification(Enum_mainUIBtn_hide.CHANGE_STATUS,[Enum_mainUIBtn_hide.ChuangGuan,1]);
         return tipBtn;
      }
      
      public static function updateBtnCount(count:int) : void
      {
         if(Boolean(tipBtn))
         {
            tipBtn.showTime(count);
         }
         Global.control.sendNotification(Enum_mainUIBtn_hide.SET_COUNT,[Enum_mainUIBtn_hide.ChuangGuan,count]);
      }
   }
}

