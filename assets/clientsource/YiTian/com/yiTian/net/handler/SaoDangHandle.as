package com.yiTian.net.handler
{
   import com.yiTian.manager.LangConfig;
   import com.yiTian.manager.UIManager;
   import com.yiTian.view.modules.fubenSel.View_fuBenSaodanging;
   
   public class SaoDangHandle
   {
      
      public function SaoDangHandle()
      {
         super();
      }
      
      public static function GC_CONFIRM_CLEAN(result:int) : void
      {
         if(result == 1)
         {
            View_fuBenSaodanging.isQingJiao = true;
            UIManager.saoDangFuben.dispose();
            UIManager.saoDangFuben.dataFrameHandle();
            UIManager.saoDangFuben.setBtnLabel(LangConfig.getWord("674",0));
         }
         else if(result == 2)
         {
            UIManager.centerBroadcast.addMsg(LangConfig.getWord("675",0));
         }
         else if(result == 3)
         {
            UIManager.centerBroadcast.addMsg(LangConfig.getWord("676",0));
         }
      }
      
      public static function GC_CURRENT_CLEAN_TIMES(currenNum:int, lefeNum:int, exp:int, meridian:int, bindSilver:int, temArr:Array) : void
      {
         UIManager.saoDangFuben.dataFrameHandle();
         UIManager.saoDangFuben.setBtn(true);
         UIManager.saoDangFuben.updata(currenNum,lefeNum,exp,meridian,bindSilver,temArr);
      }
      
      public static function GC_SAODANG_BAG_FULL_TISHI() : void
      {
         UIManager.saoDangFuben.bagFullHandle();
      }
   }
}

