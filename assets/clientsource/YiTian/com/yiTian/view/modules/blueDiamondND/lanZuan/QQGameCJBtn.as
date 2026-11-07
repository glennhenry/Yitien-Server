package com.yiTian.view.modules.blueDiamondND.lanZuan
{
   import com.yiTian.Global;
   import com.yiTian.command.Enum_MsgType;
   import com.yiTian.data.Enum_SPStr;
   import com.yiTian.manager.GameUnitManager;
   import com.yiTian.manager.UIManager;
   import com.yiTian.net.message.cg.BlueDiamondCGMessage;
   import com.yiTian.view.modules.actions.xsHaoli.LinkManager;
   import com.yiTian.view.modules.blueDiamondND.ViewBlueDiamondNDPanel;
   import com.yiTian.view.modules.blueDiamondND.xiaofeiCJ.Model_xiaoFeiCJ;
   import com.yiTian.view.modules.mainUIBtnContainer.MainUIBtn;
   
   public class QQGameCJBtn
   {
      
      private static var tipBtn:MainUIBtn;
      
      public function QQGameCJBtn()
      {
         super();
      }
      
      public static function show() : void
      {
         if(GameUnitManager.hero.level < 30)
         {
            Global.control.registerCallBack(Enum_MsgType.MSG_LV_UP_2,show);
            return;
         }
         if(Global.pf != Enum_SPStr.QQGAME)
         {
            return;
         }
         Global.control.removeCallBack(Enum_MsgType.MSG_LV_UP,show);
         if(!tipBtn)
         {
            tipBtn = new MainUIBtn("resource/image/qqGameZP/qqGamezp.png");
         }
         LinkManager.jump(function():void
         {
            BlueDiamondCGMessage.CG_QQGAMECJ_OPENPAN();
            var pan:ViewBlueDiamondNDPanel = Model_xiaoFeiCJ.cjPan(Model_xiaoFeiCJ.LZSTR);
            pan.titleUrl = Model_xiaoFeiCJ.LZSTR;
         },tipBtn);
      }
      
      public static function hide() : void
      {
         if(Boolean(tipBtn))
         {
            UIManager.mainUiBtnContainer.removeBTN(tipBtn);
         }
      }
   }
}

