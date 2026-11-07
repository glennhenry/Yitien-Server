package com.yiTian.view.modules.newerGuide
{
   import com.utils.ComponentUtil;
   import com.yiTian.manager.GameUnitManager;
   import com.yiTian.manager.KeyboardManager;
   import com.yiTian.manager.UIManager;
   import com.yiTian.scene.GameScene;
   import com.yiTian.view.modules.guide.View_guide_dialog;
   import flash.display.Shape;
   
   public class Model_newer
   {
      
      private static var bb:Child_bmp;
      
      public static var way:int;
      
      private static var wordsEff:PlayWords;
      
      private static var shape:Shape;
      
      public static var finiser:int = 16;
      
      public static var zhenLongStr:String = "modelRes/role/horse/stand/24509.swf";
      
      public static var isRunning:Boolean = false;
      
      public static var petModelStr:String = "modelRes/role/body/run/20901.swf";
      
      public static var step:int = 1;
      
      private static var _count:int = 0;
      
      public static var questPanSpecialLen:int = 57;
      
      public static var stop:Boolean = false;
      
      private static var queArr:Array = [[52612,"少侠莫非是前往清水寨调查桃花岛主被杀妻之事。这桃花岛主与我有些渊源，我便送你一程到清水寨。"],[1,"熊猫兄，真是至情至义。"]];
      
      public static var _queArr:Array = [[1,"多谢熊猫兄一路相送。"],[52612,"区区小事，何足挂齿。只是桃花岛主的事还要拜托于你。"]];
      
      public function Model_newer()
      {
         super();
      }
      
      public static function get ZHENLONGID() : int
      {
         if(Model_newer.isRunning)
         {
            return 24509;
         }
         return GameUnitManager.hero.horse;
      }
      
      public static function newerHandle() : void
      {
         var __arr:Array = null;
         var _arr:Array = null;
         if(step == 2)
         {
            if(_count >= _queArr.length)
            {
               isRunning = false;
               showUI();
               if(Boolean(bb))
               {
                  bb.removeFrame();
               }
               GameUnitManager.hero.way = Model_newer.way;
               UIManager.guideDialog.visible = false;
               UIManager.guideDialog.showJumpBtn();
               KeyboardManager.isEnabled = true;
               GameUnitManager.hero.autoMove(51010);
            }
            else
            {
               if(Boolean(bb))
               {
                  bb.setWay(bb._way);
                  bb.addFrame();
                  bb.resetPos();
               }
               Model_newer.way = GameUnitManager.hero.way;
               GameUnitManager.hero.way = 3;
               GameUnitManager.hero.setHorse(GameUnitManager.hero._status,0);
               GameUnitManager.hero.setWeapon(GameUnitManager.hero._status,GameUnitManager.hero.weapon);
               GameUnitManager.hero.status = GameUnitManager.hero._status;
               __arr = _queArr[_count];
               if(!UIManager.guideDialog.visible)
               {
                  UIManager.guideDialog.visible = true;
               }
               UIManager.guideDialog.update(__arr[0],__arr[1]);
               ++_count;
            }
            return;
         }
         if(!bb)
         {
            bb = new Child_bmp();
            bb._way = 7;
            bb.init(zhenLongStr);
            bb.addFrame();
            bb.resetPos();
         }
         if(step == 1)
         {
            Model_newer.isRunning = true;
            if(_count >= queArr.length)
            {
               wordsEff = PlayWords.instance;
               wordsEff.playEff(0);
               wordsEff.resposition();
               GameUnitManager.hero.setHorse(GameUnitManager.hero._status,ZHENLONGID);
               GameUnitManager.hero.status = GameUnitManager.hero._status;
               if(Boolean(bb))
               {
                  bb.pause();
               }
               Model_newer.stop = false;
               GameUnitManager.hero.way = Model_newer.way;
               GameUnitManager.hero.autoMove(51010);
               _count = 0;
               UIManager.guideDialog.hide();
            }
            else
            {
               _arr = queArr[_count];
               if(!UIManager.guideDialog.visible)
               {
                  UIManager.guideDialog.visible = true;
               }
               UIManager.guideDialog.update(_arr[0],_arr[1]);
               Model_newer.way = GameUnitManager.hero.way;
               GameUnitManager.hero.way = 3;
               trace(Model_newer.way,GameUnitManager.hero.way);
               ++_count;
            }
         }
      }
      
      public static function newerGuideStart() : void
      {
         if(!UIManager.guideDialog)
         {
            UIManager.guideDialog = new View_guide_dialog();
            UIManager.guideDialog.init();
            UIManager.guideDialog.resetPosition();
         }
         if(!UIManager.guideDialog.visible)
         {
            UIManager.guideDialog.visible = true;
         }
         UIManager.guideDialog.hideJumpBtn();
         KeyboardManager.isEnabled = false;
         hideUI();
         Model_newer.stop = true;
         UIManager.guideDialog.hide();
         Model_newer.newerHandle();
      }
      
      public static function hideUI() : void
      {
         GameScene.downUILayer.visible = false;
         GameScene.uiLayer.visible = false;
         GameScene.popupLayer.visible = false;
         GameScene.modalLayer.visible = false;
         if(!shape)
         {
            shape = ComponentUtil.getShape(2500,2000,0,0.6);
         }
         GameScene.newGridLayer.addChild(shape);
      }
      
      public static function showUI() : void
      {
         GameScene.downUILayer.visible = true;
         GameScene.uiLayer.visible = true;
         GameScene.popupLayer.visible = true;
         GameScene.modalLayer.visible = true;
         if(Boolean(shape) && GameScene.newGridLayer.contains(shape))
         {
            GameScene.newGridLayer.removeChild(shape);
         }
      }
   }
}

