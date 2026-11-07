package com.yiTian.net.handler
{
   import com.utils.Util;
   import com.yiTian.Global;
   import com.yiTian.data.config.Enum_scene_type;
   import com.yiTian.data.model.Model_WLParty;
   import com.yiTian.data.model.Model_team;
   import com.yiTian.data.vo.Vo_WlDahui;
   import com.yiTian.gameUnit.config.Status;
   import com.yiTian.gameUnit.config.UnitType;
   import com.yiTian.gameUnit.role.Player;
   import com.yiTian.manager.CameraManager;
   import com.yiTian.manager.EffectManager;
   import com.yiTian.manager.GameUnitManager;
   import com.yiTian.manager.LangConfig;
   import com.yiTian.manager.UIManager;
   import com.yiTian.net.message.cg.WulinPartyCGMessage;
   import com.yiTian.utils.Utils;
   import com.yiTian.view.comp.View_Alert;
   import com.yiTian.view.modules.WulinDaHui.Model_wuLin;
   import com.yiTian.view.modules.WulinDaHui.View_WulinEff;
   import com.yiTian.view.modules.WulinDaHui.WulinEffect;
   import com.yiTian.view.modules.activity.Model_actDaily;
   import flash.display.Bitmap;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import flash.text.TextFormatAlign;
   
   public class WulinPartyHandle
   {
      
      private static var str:String = LangConfig.getWord("710",0);
      
      private static var isRunning:Boolean = false;
      
      public function WulinPartyHandle()
      {
         super();
      }
      
      public static function GC_ENTER_WULIN_DAHUI(rs:int) : void
      {
         if(rs == 1)
         {
            UIManager.wulin_enter_map.visible = false;
            if(GameUnitManager.hero.status != Status.WU_LING)
            {
               GameUnitManager.hero.status = Status.WU_LING;
            }
            if(Boolean(UIManager.farm))
            {
               if(UIManager.farm.visible)
               {
                  UIManager.farm.visible = false;
               }
            }
            UIManager.questTraceView.visible = false;
            UIManager.wulin_intro.visible = true;
            UIManager.wulin_intro.setTile(2);
            UIManager.wulin_record.visible = true;
         }
         else if(rs == 2)
         {
            UIManager.centerBroadcast.addMsg(LangConfig.getWord("707",0));
            UIManager.wulin_intro.visible = !UIManager.wulin_intro.visible;
            UIManager.wulin_intro.setTile(1);
         }
         else if(rs == 3)
         {
            UIManager.centerBroadcast.addMsg(LangConfig.getWord("708",0));
            UIManager.wulin_intro.visible = !UIManager.wulin_intro.visible;
            UIManager.wulin_intro.setTile(1);
         }
         else if(rs == 4)
         {
            UIManager.centerBroadcast.addMsg(LangConfig.getWord("709",0));
            UIManager.wulin_intro.visible = !UIManager.wulin_intro.visible;
            UIManager.wulin_intro.setTile(1);
         }
         else if(rs == 5)
         {
            getTishi();
         }
      }
      
      public static function GC_TIPEUP(leftLife:int, scores:int) : void
      {
         UIManager.wulin_record.updata(leftLife,scores);
      }
      
      public static function GC_PAIHANG_WULIN(len:int, itemsArr:Array, selfScore:int) : void
      {
         var temVoWL:Vo_WlDahui = null;
         if(!len)
         {
            return;
         }
         var temArr:Array = [];
         var i:int = 0;
         while(i < len)
         {
            temVoWL = new Vo_WlDahui();
            temVoWL.init(itemsArr[i]);
            Model_WLParty.paiHang_arr.push(temVoWL);
            temArr.push(temVoWL);
            i++;
         }
         UIManager.wulin_paihang.update_self(len,selfScore,temArr);
      }
      
      public static function GC_WULIN_BEGIN(rs:int) : void
      {
         Model_wuLin.instance.rs = rs != 0;
         Model_wuLin.instance.show_wulin_btn(true);
      }
      
      public static function GC_BATTLE_WULIN(rs:int) : void
      {
         Model_wuLin.instance.show_wulin_btn(true);
         UIManager.countDown_tip.removeFrame();
      }
      
      public static function GC_QUIT_MEETING(rs:int) : void
      {
         UIManager.questTraceView.visible = true;
         UIManager.wulin_record.visible = false;
         UIManager.deadthCountPan.visible = false;
         GameUnitManager.hero.filters = [];
         UIManager.countDown_tip.removeFrame();
         if(rs == 1)
         {
            UIManager.countDown_tip.removeFrame();
            if(GameUnitManager.hero.status == Status.WU_LING)
            {
               GameUnitManager.hero.status = Status.NOMAL;
            }
         }
         else
         {
            UIManager.centerBroadcast.addMsg(LangConfig.getWord("711",0));
         }
      }
      
      public static function GC_WULIN_END(rs:int) : void
      {
         UIManager.questTraceView.visible = true;
         UIManager.wulin_record.visible = false;
         UIManager.deadthCountPan.visible = false;
         GameUnitManager.hero.filters = [];
         Model_wuLin.instance.remove_wulin_btn();
         UIManager.countDown_tip.removeFrame();
         if(rs == 1)
         {
            UIManager.centerBroadcast.addMsg(LangConfig.getWord("712",0));
         }
         Model_actDaily.getInstance().updateAct(4,false);
      }
      
      public static function GC_WULIN_ONLINE_TIP(remainTime:int) : void
      {
         Model_actDaily.getInstance().updateAct(4,true);
         var b:Boolean = remainTime > 0;
         Model_wuLin.instance.show_wulin_btn(b);
         UIManager.smallMap.addTip(0);
      }
      
      public static function GC_WULIN_ADD_FRESH_ITEM(result:int) : void
      {
         if(Boolean(result))
         {
            UIManager.wulin_record.updataRefresh();
         }
      }
      
      public static function GC_WULIN_START_COUNT(result:int) : void
      {
         if(Boolean(result))
         {
            UIManager.wulin_record.startCount();
            UIManager.countDown_tip.isBattleHandle();
         }
      }
      
      public static function GC_ENTER_WULIN_DATA(result:int, partyTime:int, lifeRemain:int, score:int, itemTimeCount:int, DeadCount:int) : void
      {
         UIManager.wulin_record.getData(partyTime,lifeRemain,score,itemTimeCount,DeadCount);
      }
      
      public static function GC_CLICK_HERO_BATTLE(result:int) : void
      {
         if(result == 1)
         {
            UIManager.countDown_tip.visible = false;
         }
         else if(result == 2)
         {
            UIManager.centerBroadcast.addMsg(LangConfig.getWord("713",0));
         }
         else if(result == 3)
         {
            UIManager.centerBroadcast.addMsg(LangConfig.getWord("714",0));
         }
         else if(result == 4)
         {
            UIManager.centerBroadcast.addMsg(LangConfig.getWord("715",0));
         }
         else if(result == 5)
         {
            UIManager.centerBroadcast.addMsg(LangConfig.getWord("716",0));
         }
      }
      
      public static function GC_TIMEUP_BACK(result:int) : void
      {
         UIManager.countDown_tip.deadTimeHandle();
      }
      
      public static function GC_DEADCOUNT(result:int) : void
      {
         GameUnitManager.hero.filters = [];
         UIManager.countDown_tip.isBattleHandle();
      }
      
      public static function GC_BEEN_LIGHTTEN(roleId:Number) : void
      {
         var _player:Player = GameUnitManager.findUnit(roleId,UnitType.PLAYER) as Player;
         if(Boolean(_player))
         {
            _player.addEffect("19003",false,10,-236,300);
         }
      }
      
      public static function GC_DEAN_EFFECT(roleId:Number) : void
      {
         var _player:Player = GameUnitManager.findUnit(roleId,UnitType.PLAYER) as Player;
         if(Boolean(_player))
         {
            _player.filters = Util.disabled;
         }
      }
      
      public static function GC_LIFE_EFFECT(roleId:Number) : void
      {
         var _player:Player = GameUnitManager.findUnit(roleId,UnitType.PLAYER) as Player;
         if(Boolean(_player))
         {
            _player.filters = [];
         }
      }
      
      public static function GC_WULIN_ENTER_RESULT_HANDLE(result:int) : void
      {
         if(result == 1)
         {
            getTishi();
         }
      }
      
      public static function getTishi() : void
      {
         View_Alert.show(str,View_Alert.OK_CANCAL,function(evt:MouseEvent = null):void
         {
            if(Boolean(Model_team.isTeam[GameUnitManager.hero.id]))
            {
               UIManager.centerBroadcast.addMsg(LangConfig.getWord("717",0),1);
               return;
            }
            if(Global.sceneType != Enum_scene_type.COMMON_SCENE)
            {
               UIManager.centerBroadcast.addMsg(LangConfig.getWord("718",0),1);
               return;
            }
            WulinPartyCGMessage.CG_ENTER_WULIN_DAHUI();
         },null,null,null,310,LangConfig.getWord("719",0),LangConfig.getWord("5",0),TextFormatAlign.CENTER);
      }
      
      public static function GC_PICKTOOLBACK(result:int) : void
      {
         var p:Point = null;
         var image:Bitmap = new Bitmap();
         if(result == 1)
         {
            p = UIManager.heroHead.getExpBarXY(1);
            image = Utils.getLoadBitmap("resource/image/wulinParty/blood.png",image);
            EffectManager.flyEff(new Point(GameUnitManager.hero.global_x - CameraManager.sightX,GameUnitManager.hero.global_y - CameraManager.sightY),p);
            compleHandle(image);
         }
         else if(result == 2)
         {
            p = UIManager.heroHead.getExpBarXY(2);
            image = Utils.getLoadBitmap("resource/image/wulinParty/neili.png",image);
            compleHandle(image);
         }
         else if(result == 3)
         {
            image = Utils.getLoadBitmap("resource/image/wulinParty/gongji.png",image);
            compleHandle(image);
         }
         else if(result == 4)
         {
            image = Utils.getLoadBitmap("resource/image/wulinParty/defance.png",image);
            compleHandle(image);
         }
         else if(result == 5)
         {
            image = Utils.getLoadBitmap("resource/image/wulinParty/life.png",image);
            compleHandle(image);
         }
      }
      
      private static function compleHandle(image:Bitmap) : void
      {
         UIManager.heroBroadcast.addObj(image);
      }
      
      public static function GC_COUNT_BACK(result:int) : void
      {
         UIManager.centerBroadcast.addMsg(LangConfig.getWord("720",0),1);
      }
      
      private static function switchHandle(count:int, pla:Player) : void
      {
         switch(count)
         {
            case 5:
            case 10:
            case 20:
            case 30:
            case 50:
            case 100:
               pla.addWordsEff("<font color=\'#66ff66\' size=\'24\'>" + "<b>" + String(count) + "连斩积分:+" + String(count) + "</b>" + "</font>");
         }
      }
      
      public static function GC_WULIN_PARTY_EVEN_CUT(count:int) : void
      {
         var pla:Player = GameUnitManager.findUnit(GameUnitManager.hero.id,UnitType.PLAYER) as Player;
         switchHandle(count,pla);
         var _instanc:WulinEffect = WulinEffect.getInstance();
         _instanc.getNums(count);
         if(count == 0)
         {
            return;
         }
         var ins:View_WulinEff = View_WulinEff.getInstance();
         ins.change(count);
      }
   }
}

