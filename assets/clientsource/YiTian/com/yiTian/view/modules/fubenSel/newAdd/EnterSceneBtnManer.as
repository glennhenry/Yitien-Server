package com.yiTian.view.modules.fubenSel.newAdd
{
   import com.yiTian.Global;
   import com.yiTian.manager.SceneConfig;
   import com.yiTian.manager.UIManager;
   import com.yiTian.view.modules.crossClanBattle.View_CrossClanBattleIconTip;
   import com.yiTian.view.modules.guangMingDing.GuangMingDingConfig;
   import com.yiTian.view.modules.mainUIBtnContainer.View_mainUiBtn_container;
   import com.yiTian.view.modules.qiJu.QiJu_Btn;
   import com.yiTian.view.modules.worldLevel.View_wlRewardBtn;
   import flash.display.DisplayObject;
   
   public class EnterSceneBtnManer
   {
      
      public static var isHideBtnHappens:Boolean = false;
      
      public function EnterSceneBtnManer()
      {
         super();
      }
      
      public static function addEnterSceneLis() : void
      {
         if(isHideBtnHappens)
         {
            isHideBtnHappens = false;
            Global.control.removeCallBack(View_mainUiBtn_container.ADD_BTN,addBtnLis);
            UIManager.mainUiBtnContainer.partAdd();
            UIManager.newMainBtnContainer.visible = true;
         }
      }
      
      public static function addEnterFubenLis() : void
      {
         var i:int = 0;
         var btn:DisplayObject = null;
         if(is_special_scene())
         {
            i = 0;
            while(i < btnArr.length)
            {
               btn = btnArr[i];
               UIManager.mainUiBtnContainer.partPauseRemove(btn);
               i++;
            }
            isHideBtnHappens = true;
            Global.control.registerCallBack(View_mainUiBtn_container.ADD_BTN,addBtnLis);
            UIManager.newMainBtnContainer.visible = false;
            if(SceneConfig.getSceneType() == SceneConfig.WULIN)
            {
               UIManager.mainUiBtnContainer.partPauseRemove(UIManager.jjc_panel.jingBtn);
            }
         }
      }
      
      private static function addBtnLis(btn:DisplayObject) : void
      {
         var disObj:DisplayObject = null;
         for each(disObj in btnArr)
         {
            if(disObj == btn)
            {
               UIManager.mainUiBtnContainer.partPauseRemove(btn);
            }
         }
      }
      
      public static function get btnArr() : Array
      {
         return [UIManager.mainUiBtnContainer.enterTTFBtn,UIManager.wanAnSiPanel.icon,GuangMingDingConfig.bmBtn,QiJu_Btn.instance.qiJuBtn,UIManager.kuafuBtn.KuaFuBtn,View_CrossClanBattleIconTip.tipBtn,View_wlRewardBtn.instance];
      }
      
      public static function is_special_scene() : Boolean
      {
         var sceneType:int = SceneConfig.getSceneType();
         if(sceneType == SceneConfig.FISH || sceneType == SceneConfig.BEACH || sceneType == SceneConfig.SIMPLEFUNBEN || sceneType == SceneConfig.KUNLUN || sceneType == SceneConfig.PATA || sceneType == SceneConfig.PATA2 || sceneType == SceneConfig.WANANSI || sceneType == SceneConfig.WULIN || sceneType == SceneConfig.BangShenShou || sceneType == SceneConfig.BZ_READY || sceneType == SceneConfig.BZ_BATTLE || sceneType == SceneConfig.GMD || sceneType == SceneConfig.BANGPLANT || sceneType == SceneConfig.QIJU || sceneType == SceneConfig.HUNLI || sceneType == SceneConfig.KEJU)
         {
            return true;
         }
         return false;
      }
   }
}

