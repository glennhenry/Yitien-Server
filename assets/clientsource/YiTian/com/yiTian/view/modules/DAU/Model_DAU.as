package com.yiTian.view.modules.DAU
{
   import com.yiTian.Global;
   import com.yiTian.data.Enum_SPStr;
   import com.yiTian.gameUnit.magic.Effect;
   import com.yiTian.manager.EffectManager;
   import com.yiTian.manager.GameUnitManager;
   import com.yiTian.manager.UIManager;
   import com.yiTian.net.message.cg.DAUCGMessage;
   import com.yiTian.view.modules.broadcast.Enum_BroadCastTool;
   import com.yiTian.view.modules.guaji.BitmapBtn;
   import flash.events.MouseEvent;
   
   public class Model_DAU
   {
      
      public static var tipBtn:BitmapBtn;
      
      public static var DAU_summy_reward_info:Object;
      
      private static var _isShow:Boolean = false;
      
      public static const SUMMY_REWARD_INFO_UPDATE:String = "dau_summy_info_update";
      
      private static const rewardInfo:Array = [[43012,1,46410,1],[43003,1,46402,1,46221,2],[46439,10,46411,1,46226,1]];
      
      public function Model_DAU()
      {
         super();
      }
      
      public static function init() : void
      {
         if(GameUnitManager.hero.level >= 30)
         {
            showBTN();
         }
      }
      
      public static function handleLevelUp() : void
      {
         if(GameUnitManager.hero.level >= 30)
         {
            if(Global.DAUCtrl && Global.pf == Enum_SPStr.QQGAME)
            {
               showBTN();
            }
         }
      }
      
      public static function showBTN() : void
      {
         if(_isShow)
         {
            return;
         }
         _isShow = true;
         if(!tipBtn)
         {
            tipBtn = new BitmapBtn();
            tipBtn.init();
            tipBtn.buttonMode = true;
            tipBtn.setBgDir("resource/image/DAU/HappySummry.png");
            tipBtn.clickCallBack = tipBtnClickHd;
         }
         UIManager.mainUiBtnContainer.addBTN(tipBtn);
      }
      
      private static function tipBtnClickHd(e:MouseEvent) : void
      {
         var pnl:View_DAU_summyRewardPanel = UIManager.DAU_summryReward;
         DAUCGMessage.CG_DAU_GET_REWARDINFO();
         Global.delegate.dosomething(pnl,pnl.visible ? pnl.hide : pnl.show);
      }
      
      public static function hideBTN() : void
      {
         _isShow = false;
         hasEff(false);
         if(Boolean(tipBtn))
         {
            UIManager.mainUiBtnContainer.removeBTN(tipBtn);
         }
      }
      
      public static function hasEff(v:Boolean) : void
      {
         if(Boolean(tipBtn))
         {
            if(v && !tipBtn.extraObject)
            {
               tipBtn.extraObject = EffectManager.addEffect("35343",tipBtn,1000,32,29,true);
            }
            else if(Boolean(tipBtn.extraObject))
            {
               EffectManager.removeEffect(tipBtn.extraObject as Effect);
               tipBtn.extraObject = null;
            }
         }
      }
      
      public static function updateInfo(info:Object) : void
      {
         DAU_summy_reward_info = info;
         Global.control.sendNotification(SUMMY_REWARD_INFO_UPDATE,info);
      }
      
      public static function getRewardTxt(index:int) : String
      {
         var id:int = 0;
         var count:int = 0;
         var info:Array = rewardInfo[index];
         var txts:Array = [];
         var i:int = 0;
         while(i < info.length)
         {
            id = int(info[i]);
            count = int(info[i + 1]);
            txts.push(Enum_BroadCastTool.instance.getItemText(id) + "×" + count.toString());
            i += 2;
         }
         var result:String = txts.join("\n");
         txts.splice(0);
         return result;
      }
   }
}

