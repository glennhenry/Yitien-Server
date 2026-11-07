package com.yiTian.view.modules.paoku.userCom.state
{
   import com.ui.controls.Button;
   import com.ui.controls.CheckBox;
   import com.yiTian.view.modules.kupao.KPMap;
   import com.yiTian.view.modules.paoku.core.state.IState;
   import com.yiTian.view.modules.paoku.model.Model_KuPao;
   import com.yiTian.view.modules.paoku.userCom.KuPaoEntity;
   import com.yiTian.view.modules.paoku.userCom.KuPaoEntityMsgConst;
   import com.yiTian.view.modules.paoku.userCom.KuPaoMgr;
   import com.yiTian.view.modules.paoku.userCom.input.KuPaoInput;
   import com.yiTian.view.modules.paoku.userCom.role.EntityFactory;
   import com.yiTian.view.modules.paoku.userCom.role.state.KuPaoRoleStates;
   import com.yiTian.view.modules.paoku.view.Child_GameingMenu;
   import com.yiTian.view.modules.paoku.view.View_kuPaoPnl;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   
   public class KuPaoGameingState implements IState
   {
      
      private var _viewLayer:Sprite;
      
      private var btnReturn:Button;
      
      private var btnPause:Button;
      
      private var _returnClick:Boolean = false;
      
      private var _cbDrawRect:CheckBox;
      
      private var _menu:Child_GameingMenu;
      
      public function KuPaoGameingState()
      {
         super();
         this._viewLayer = new Sprite();
         this._menu = Child_GameingMenu.instance;
      }
      
      private function cbClickHd(cb:CheckBox) : void
      {
         Model_KuPao.isDrawRect = cb.selected;
      }
      
      public function enter(param:*) : void
      {
         var hero:KuPaoEntity = null;
         View_kuPaoPnl.instance.addToContainer(this._menu);
         View_kuPaoPnl.instance.addChild(this._viewLayer);
         this._menu.visible = true;
         Model_KuPao.gameingCoin = 0;
         hero = EntityFactory.getHero();
         hero.moveData.xPos = 0;
         hero.moveData.yPos = 80;
         hero.clearMsgs();
         Model_KuPao.speedMul = 1;
         Model_KuPao.numFloatUse = 0;
         Model_KuPao.numShieldUse = 0;
         Model_KuPao.numDoubleUse = 0;
         Model_KuPao.numDieFLoatUse = 0;
         if(Boolean(Model_KuPao.getNumTool(Model_KuPao.INDEX_STARTFLOAT)))
         {
            ++Model_KuPao.numFloatUse;
            hero.addMsg(KuPaoEntityMsgConst.CHANGE_STATE,{"state":KuPaoRoleStates.ST_FLOAT});
         }
         if(Model_KuPao.getNumTool(Model_KuPao.INDEX_BULLET_SHEILD) > 0)
         {
            hero.addMsg(KuPaoEntityMsgConst.ADD_EFFECT,{
               "id":"36131",
               "time":1000,
               "isLoop":true
            });
         }
         if(Model_KuPao.getNumTool(Model_KuPao.INDEX_DOUBLESCROE) > 0)
         {
            ++Model_KuPao.numDoubleUse;
         }
         var p:Point = KuPaoMgr.instance.focusPoint;
         p.x = p.y = 0;
         KPMap.instance._view.x = 0;
         KPMap.instance.addEntity(hero);
         Model_KuPao.gameing = true;
         KuPaoInput.instance.resume();
         this._returnClick = false;
      }
      
      public function exit(param:*) : void
      {
         View_kuPaoPnl.instance.removeChild(this._viewLayer);
         Model_KuPao.gameing = false;
         Model_KuPao.isFloating = false;
         KuPaoInput.instance.pause();
         KuPaoInput.instance.clearKeys();
      }
      
      public function update(param:*) : void
      {
         this._menu.update();
      }
      
      public function askExit(nextState:int) : Boolean
      {
         if(nextState == KuPaoMgr.GST_GAMEOVER || this._returnClick)
         {
            return true;
         }
         return false;
      }
      
      private function returnClickHandler(e:MouseEvent) : void
      {
         this._returnClick = true;
         KuPaoMgr.instance.paokuGlobalSM.changeState(KuPaoMgr.GST_STARTMENU,null);
      }
      
      private function pauseClickHandler(e:MouseEvent) : void
      {
         Model_KuPao.gameing = !Model_KuPao.gameing;
      }
   }
}

