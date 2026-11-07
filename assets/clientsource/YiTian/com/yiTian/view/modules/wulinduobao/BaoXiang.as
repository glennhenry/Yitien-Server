package com.yiTian.view.modules.wulinduobao
{
   import com.ui.controls.MyTextField;
   import com.utils.ComponentUtil;
   import com.yiTian.data.model.Model_team;
   import com.yiTian.gameUnit.config.Action;
   import com.yiTian.gameUnit.config.Status;
   import com.yiTian.gameUnit.config.UnitType;
   import com.yiTian.gameUnit.role.Role;
   import com.yiTian.manager.GameUnitManager;
   import com.yiTian.manager.LangConfig;
   import com.yiTian.manager.UIManager;
   import com.yiTian.net.message.cg.WuLinDuoBaoCGMessage;
   import com.yiTian.scene.GameScene;
   import com.yiTian.view.modules.collect.View_collect;
   import flash.utils.Dictionary;
   import flash.utils.getTimer;
   
   public class BaoXiang extends Role
   {
      
      private static var lastTime:int;
      
      private static var _collectBar:View_collect;
      
      private static var _curFlag:int;
      
      public static var pool:Array = [];
      
      public static var list:Dictionary = new Dictionary();
      
      private static var idArr:Array = [56950,56951,56952];
      
      private static var totalTime:int = 30;
      
      private var nameTxt:MyTextField;
      
      public function BaoXiang()
      {
         super();
      }
      
      public static function collectBX(npcId:int) : void
      {
         if(Boolean(_collectBar) && GameScene.uiLayer.contains(_collectBar))
         {
            reqHideCB(false);
            return;
         }
         var status:int = GameUnitManager.hero.status;
         if(status == Status.SIT || status == Status.FISH)
         {
            UIManager.centerBroadcast.addMsg(LangConfig.getWord("10541",1));
            return;
         }
         if(Model_team.teamMumberInfo_data_save.length > 0)
         {
            UIManager.centerBroadcast.addMsg("<font color=\'#ffff00\'>" + LangConfig.getWord("10618",1) + "</font>");
            return;
         }
         var _flag:int = idArr.indexOf(npcId) + 1;
         if(_flag == 1)
         {
            if(GameUnitManager.hero.level < 30 || GameUnitManager.hero.level > 44)
            {
               UIManager.centerBroadcast.addMsg("<font color=\'#ffff00\'>" + LangConfig.getWord("10619",1) + "</font>");
               return;
            }
         }
         else if(_flag == 2)
         {
            if(GameUnitManager.hero.level < 45 || GameUnitManager.hero.level > 59)
            {
               UIManager.centerBroadcast.addMsg("<font color=\'#ffff00\'>" + LangConfig.getWord("10620",1) + "</font>");
               return;
            }
         }
         else if(_flag == 3)
         {
            if(GameUnitManager.hero.level < 60 || GameUnitManager.hero.level > 160)
            {
               UIManager.centerBroadcast.addMsg("<font color=\'#ffff00\'>" + LangConfig.getWord("10621",1) + "</font>");
               return;
            }
         }
         var t:int = BaoXiangVO.lastTime;
         if(Boolean(BaoXiangVO.lastTime) && getTimer() - BaoXiangVO.lastTime <= 30000)
         {
            UIManager.centerBroadcast.addMsg("<font color=\'#ffff00\'>" + LangConfig.getWord("10622",1,30 - int((getTimer() - BaoXiangVO.lastTime) / 1000)) + "</font>");
            return;
         }
         _curFlag = _flag;
         WuLinDuoBaoCGMessage.CG_DUOBAO(_curFlag);
      }
      
      public static function get isCollect() : Boolean
      {
         return Boolean(_collectBar) && GameScene.uiLayer.contains(_collectBar);
      }
      
      public static function showCollectBar(value:Boolean) : void
      {
         if(value)
         {
            if(!_collectBar)
            {
               _collectBar = new View_collect();
               _collectBar.label = "采集中";
            }
            GameScene.uiLayer.addChild(_collectBar);
            _collectBar.resetPosition();
            _collectBar.reset();
            lastTime = getTimer();
            GameUnitManager.hero.status = Status.COLLECT;
            if(!GameScene.instance.hasFrameCallBack(refreshCollectBar))
            {
               GameScene.instance.addFrameCallBack(refreshCollectBar);
            }
         }
         else
         {
            if(Boolean(_collectBar))
            {
               if(GameScene.uiLayer.contains(_collectBar))
               {
                  GameScene.uiLayer.removeChild(_collectBar);
                  GameUnitManager.hero.status = Status.NOMAL;
               }
            }
            if(GameScene.instance.hasFrameCallBack(refreshCollectBar))
            {
               GameScene.instance.removeFrameCallBack(refreshCollectBar);
            }
         }
      }
      
      public static function reqHideCB(value:Boolean) : void
      {
         if(!value)
         {
            if(Boolean(_collectBar) && GameScene.uiLayer.contains(_collectBar))
            {
               WuLinDuoBaoCGMessage.CG_CANCEL_GET_BAOXIANG(_curFlag);
            }
         }
      }
      
      private static function refreshCollectBar(interval:int) : void
      {
         var now:int = getTimer();
         _collectBar.update((now - lastTime) / (totalTime * 1000));
         if(totalTime - int((now - lastTime) / 1000) <= 0)
         {
            WuLinDuoBaoCGMessage.CG_GET_BAOXIANG(_curFlag);
            if(GameScene.instance.hasFrameCallBack(refreshCollectBar))
            {
               GameScene.instance.removeFrameCallBack(refreshCollectBar);
            }
         }
      }
      
      public function init(id:Number, flag:int, x:int, y:int) : void
      {
         this.id = id;
         this.type = UnitType.BAOXIANG;
         global_x = x;
         global_y = y;
         this.setShadow(Status.NOMAL,11);
         this.setBody(Status.NOMAL,56917);
         way = int(4);
         status = Status.NOMAL;
         this.nameTxt = ComponentUtil.getTextField("",this,{
            "x":-40,
            "y":-90
         });
      }
      
      override public function interaction(mode:int = 0) : void
      {
      }
      
      override public function show() : void
      {
         super.show();
         nameBar.show();
         list[id] = this;
      }
      
      override public function set bodyLoaded(value:Boolean) : void
      {
         super.bodyLoaded = value;
      }
      
      override public function dispose() : void
      {
         super.dispose();
         delete list[id];
         if(Boolean(_collectBar) && GameScene.uiLayer.contains(_collectBar))
         {
            reqHideCB(false);
         }
         if(Boolean(this.nameTxt))
         {
            removeChild(this.nameTxt);
            this.nameTxt = null;
         }
         pool.push(this);
         action = Action.STAND;
      }
   }
}

