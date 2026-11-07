package com.yiTian.view.modules.boatChall
{
   import com.yiTian.Global;
   import com.yiTian.command.Enum_MsgType;
   import com.yiTian.gameUnit.GameUnit;
   import com.yiTian.gameUnit.magic.Effect;
   import com.yiTian.manager.CameraManager;
   import com.yiTian.manager.EffectManager;
   import com.yiTian.manager.GameUnitManager;
   import com.yiTian.manager.UIManager;
   import com.yiTian.scene.GameScene;
   import com.yiTian.utils.Singleton;
   import com.yiTian.utils.Tween;
   import com.yiTian.utils.call.Delegate123;
   import com.yiTian.view.modules.bianqiangzhiyin.View_bqzy;
   import com.yiTian.view.modules.boatChall.VTip.QuitBtn;
   import com.yiTian.view.modules.boatChall.VTip.V_helpTBtn;
   import com.yiTian.view.modules.boatChall.VTip.V_returnBtn;
   import com.yiTian.view.modules.ship.Ship;
   import flash.utils.Dictionary;
   import flash.utils.setTimeout;
   
   public class BoatManager
   {
      
      public static var init_x:int;
      
      public static var init_y:int;
      
      private static var len:int;
      
      private static var count:int;
      
      private static var lastUpdateTime:int;
      
      public static var overObj:GameUnit;
      
      public static var isMyShipEnding:Boolean = false;
      
      public static var mainUIConY:int = 0;
      
      public static var mainMenuCY:int = -73;
      
      public static var headCY:int = 5;
      
      public static var specialCY:int = -96;
      
      public static var questCX:int = -240;
      
      public static var newBtnCX:int = 0;
      
      public static var gameStarting:Boolean = true;
      
      public static const WATCH_X:int = 2562;
      
      public static const WATCH_Y:int = 7182;
      
      public static var END_X:int = 0;
      
      public static var END_Y:int = 0;
      
      private static var endEffArr:Array = [];
      
      private static var startEffArr:Array = [];
      
      public static var isEnterScene:Boolean = false;
      
      public static var list:Array = [];
      
      private static var sort:Array = ["state","y"];
      
      public static var bindBoatGift2Ship:Dictionary = new Dictionary();
      
      public function BoatManager()
      {
         super();
      }
      
      public static function init() : void
      {
         Global.control.registerCallBack(Enum_MsgType.MSG_ASK_CHANGE_SCENE_OK,enterSceneHd);
      }
      
      private static function enterSceneHd(sceneId:int) : void
      {
         var top:int = 0;
         var bottom:int = 0;
         var right:int = 0;
         var delay:int = 0;
         var mm:int = 0;
         var nn:int = 0;
         var ship:Ship = null;
         top = 0;
         var left:int = 0;
         bottom = Global.stage.stageHeight;
         right = Global.stage.stageWidth;
         if(sceneId == 14401)
         {
            isEnterScene = true;
            P_enterGamePanel.ask_to_enter = 60;
            CameraManager.wacth(WATCH_X,WATCH_Y);
            GameScene.mainLayer.mouseEnabled = true;
            GameScene.mainLayer.mouseChildren = true;
            delay = int(setTimeout(function():void
            {
               Tween.to(UIManager.mainUiBtnContainer,400,{"y":[UIManager.mainUiBtnContainer.y,top - UIManager.mainUiBtnContainer.height - 20]},function():void
               {
                  mainUIConY = top - UIManager.mainUiBtnContainer.height - 20;
               });
               Tween.to(UIManager.mainMenu,400,{"y":[UIManager.mainMenu.y,bottom + 100]},function():void
               {
                  mainMenuCY = bottom + 100;
               });
               Tween.to(UIManager.petHeadPanel,400,{"y":[UIManager.petHeadPanel.y,top - UIManager.petHeadPanel.height - 20]},function():void
               {
                  headCY = top - UIManager.petHeadPanel.height - 20;
               });
               Tween.to(UIManager.special_btn,400,{"y":[UIManager.special_btn.y,bottom + 100]},function():void
               {
                  specialCY = bottom + 100;
               });
               Tween.to(UIManager.questTraceView,400,{"x":[UIManager.questTraceView.x,right + 100]},function():void
               {
                  questCX = 100;
               });
               if(Boolean(View_bqzy.instance))
               {
                  Tween.to(View_bqzy.instance,400,{"x":[View_bqzy.instance.x,right + 100]},function():void
                  {
                     questCX = 100;
                  });
               }
               Tween.to(UIManager.newMainBtnContainer,400,{"x":[UIManager.newMainBtnContainer.x,right + 100]},function():void
               {
                  newBtnCX = right + 100;
               });
            },100));
            mm = int(setTimeout(function():void
            {
               QuitBtn.instance.show(Global.stage);
               Tween.to(QuitBtn.instance,500,{"y":[-50,10]});
               V_helpTBtn.instance.show(Global.stage);
               Tween.to(QuitBtn.instance,500,{"y":[-50,10]});
               V_helpTBtn.instance.show(Global.stage);
               Tween.to(V_helpTBtn.instance,500,{"y":[-50,10]});
            },400));
            P_enterGamePanel.instance.visible = false;
            UIManager.tipBtnContainer.visible = false;
            UIManager.smallMap.changeBtnEnable(false);
            UIManager.heroHead.changeBtnEnable(false);
            addEndEffLine();
            if(!gameStarting)
            {
               addStartEffLine();
            }
         }
         else if(isEnterScene)
         {
            isEnterScene = false;
            GameScene.mainLayer.mouseEnabled = false;
            GameScene.mainLayer.mouseChildren = false;
            dispose();
            GameUnitManager.addUnit(GameUnitManager.hero);
            Tween.to(QuitBtn.instance,500,{"y":[10,-50]},function():void
            {
               QuitBtn.instance.hide(Global.stage);
            });
            Tween.to(V_helpTBtn.instance,500,{"y":[10,-50]},function():void
            {
               V_helpTBtn.instance.hide(Global.stage);
            });
            nn = int(setTimeout(function():void
            {
               Tween.to(UIManager.mainUiBtnContainer,400,{"y":[UIManager.mainUiBtnContainer.y,0]});
               Tween.to(UIManager.mainMenu,400,{"y":[UIManager.mainMenu.y,bottom - 73]});
               Tween.to(UIManager.petHeadPanel,400,{"y":[UIManager.petHeadPanel.y,5]});
               Tween.to(UIManager.special_btn,400,{"y":[UIManager.special_btn.y,bottom - 96]});
               Tween.to(UIManager.questTraceView,400,{"x":[UIManager.questTraceView.x,right - 240]});
               if(Boolean(View_bqzy.instance))
               {
                  Tween.to(View_bqzy.instance,400,{"x":[View_bqzy.instance.x,right - 240]});
               }
               Tween.to(UIManager.newMainBtnContainer,400,{"x":[UIManager.newMainBtnContainer.x,0]});
               quitScene();
            },200));
            ShipCrues.instance.visible = ShipCrues.instance.visible && false;
            Child_DaoJiShi.instance.visible = Child_DaoJiShi.instance.visible && false;
            UIManager.tipBtnContainer.visible = true;
            for each(ship in list)
            {
               removeUnit(ship);
            }
            (Singleton.getInstance(Delegate123) as Delegate123).dosomething(P_enterGamePanel.instance,BoatGrids.instance.hide);
            BuffGrids.instance.visible = false;
            if(Boolean(GameUnitManager.hero.bindShip))
            {
               GameUnitManager.hero.bindShip = null;
            }
            UIManager.smallMap.changeBtnEnable(true);
            UIManager.heroHead.changeBtnEnable(true);
            BoatPH.instance.hide();
            isMyShipEnding = false;
            END_X = END_Y = 0;
            removeEndEffLine();
            Ship.myShip = null;
            EndTipPan.instance.visible = false;
            if(Boolean(V_returnBtn.instance) && Boolean(V_returnBtn.instance.parent))
            {
               V_returnBtn.instance.hide(V_returnBtn.instance.parent);
            }
            Ship.endShipList.length = 0;
            (Singleton.getInstance(Delegate123) as Delegate123).dosomething(BoatGrids.instance,BoatGrids.instance.hide);
         }
      }
      
      private static function addEndEffLine() : void
      {
         var i:int = 0;
         while(i < 10)
         {
            endEffArr.push(EffectManager.addEffect("35361",GameScene.mainLayer,1000,5338,6000 + i * 142,true));
            i++;
         }
      }
      
      private static function removeEndEffLine() : void
      {
         var eff:Effect = null;
         while(Boolean(endEffArr.length))
         {
            eff = endEffArr.shift();
            GameScene.mainLayer.removeChild(eff);
            eff = null;
         }
      }
      
      public static function addStartEffLine() : void
      {
         var i:int = 0;
         while(i < 8)
         {
            startEffArr.push(EffectManager.addEffect("35360",GameScene.mainLayer,1000,2058 + i * 142,6696,true));
            i++;
         }
      }
      
      public static function removeStartEffLine() : void
      {
         var eff:Effect = null;
         while(Boolean(startEffArr.length))
         {
            eff = startEffArr.shift();
            if(Boolean(eff) && Boolean(eff.parent))
            {
               GameScene.mainLayer.removeChild(eff);
               eff = null;
            }
         }
      }
      
      public static function enterScene() : void
      {
         isEnterScene = true;
      }
      
      public static function quitScene() : void
      {
         isEnterScene = false;
         mainUIConY = 0;
         mainMenuCY = -73;
         headCY = 5;
         specialCY = -96;
         questCX = -240;
         newBtnCX = 0;
      }
      
      public static function run(now:int) : void
      {
         len = list.length;
         count = len - 1;
         while(count >= 0)
         {
            if(list[count])
            {
               list[count].update(now);
            }
            --count;
         }
         if(now - lastUpdateTime > 180)
         {
            len = list.length;
            list.sortOn(sort,Array.NUMERIC);
            count = len - 1;
            while(count >= 0)
            {
               if(GameScene.mainLayer.getChildIndex(list[count]) != count)
               {
                  GameScene.mainLayer.setChildIndex(list[count],count);
               }
               --count;
            }
            lastUpdateTime = now;
         }
         count = len - 1;
         while(count >= 0)
         {
            if(Boolean(list[count]) && list[count] == Ship.myShip)
            {
               GameScene.mainLayer.setChildIndex(list[count],len - 1);
               break;
            }
            --count;
         }
      }
      
      public static function addUnit(unit:GameUnit) : void
      {
         if(list.indexOf(unit) == -1)
         {
            list.push(unit);
            GameScene.mainLayer.addChild(unit);
         }
         if(list.length > 100)
         {
            if(Global.stage.frameRate == 30)
            {
               Global.stage.frameRate = 24;
            }
         }
         unit.show();
      }
      
      public static function removeUnit(unit:GameUnit) : void
      {
         var ship:Ship = null;
         var index:int = list.indexOf(unit);
         if(index >= 0)
         {
            list.splice(index,1);
         }
         if(Boolean(unit) && unit is Ship)
         {
            ship = unit as Ship;
            UIManager.smallMap.removeShip(ship);
            UIManager.mappanel.curMap.removeShip(ship);
         }
         if(Boolean(unit.parent))
         {
            unit.parent.removeChild(unit);
         }
         unit.dispose();
      }
      
      public static function findUnit(id:*, type:int = 1) : GameUnit
      {
         var dic:Dictionary = null;
         if(type == 2)
         {
            dic = BoatBuff.list;
            return BoatBuff.list[id];
         }
         return Ship.list[id];
      }
      
      public static function getUnit(type:int = 1) : GameUnit
      {
         if(type == 2)
         {
            return BoatBuff.pool.pop() || new BoatBuff();
         }
         return Ship.pool.pop() || new Ship();
      }
      
      public static function dispose() : void
      {
         var i:int = list.length - 1;
         while(i >= 0)
         {
            removeUnit(list[i]);
            i--;
         }
      }
   }
}

