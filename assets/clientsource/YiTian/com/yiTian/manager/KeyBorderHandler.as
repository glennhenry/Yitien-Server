package com.yiTian.manager
{
   import com.utils.Util;
   import com.yiTian.Global;
   import com.yiTian.ResourceVersionConfig;
   import com.yiTian.command.Enum_MsgType;
   import com.yiTian.data.model.Model_team;
   import com.yiTian.data.model.Model_trans;
   import com.yiTian.net.message.cg.BangCGMessage;
   import com.yiTian.net.message.cg.ChatCGMessage;
   import com.yiTian.net.message.cg.JiaoYiCGMessage;
   import com.yiTian.net.message.cg.JingJiChangCGMessage;
   import com.yiTian.net.message.cg.LetterCGMessage;
   import com.yiTian.net.message.cg.PetCGMessage;
   import com.yiTian.net.message.cg.TeamCGMessage;
   import com.yiTian.utils.Singleton;
   import com.yiTian.utils.Utils;
   import com.yiTian.view.Enum_explor;
   import com.yiTian.view.modules.AiDeBaoBao.View_AiDeBaoBao_skillBar;
   import com.yiTian.view.modules.KFHomeland.BuildAction;
   import com.yiTian.view.modules.KFHomeland.EnterHomeControl;
   import com.yiTian.view.modules.KFHomeland.VoHome;
   import com.yiTian.view.modules.Shopping.shoppingMall.ShoppingMallPan;
   import com.yiTian.view.modules.activity.Model_actDaily;
   import com.yiTian.view.modules.friends.Model_Friends;
   import com.yiTian.view.modules.friends.View_friQuestList;
   import com.yiTian.view.modules.mainMenu.MicroButton;
   import com.yiTian.view.modules.newRolePan.View_rolePan;
   import com.yiTian.view.modules.panel.Enum_panel_role;
   import com.yiTian.view.modules.team.TeamListPanel;
   import com.yiTian.view.modules.wuXing.WuXingMter;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.KeyboardEvent;
   import flash.events.MouseEvent;
   
   public class KeyBorderHandler
   {
      
      public static var PHPParam:Object;
      
      private static var sx:int = 500;
      
      private static var sy:int = 300;
      
      private static var count:Number = 0;
      
      public static var isUsingKeyBoardP:Boolean = false;
      
      private var speedBoo:Boolean = false;
      
      private var speed:int;
      
      private var msgArr:Array = ["攻击力","防御力","气血","内力","格挡","暴击伤害","命中","怒气","暴击伤害"];
      
      private var time:int = 0;
      
      private var runSpri:Sprite;
      
      public function KeyBorderHandler(cast:Array)
      {
         super();
         cast[KeyboardManager.ESCAPE] = this.ESCAPE;
         cast[KeyboardManager.ENTER] = this.ENTER;
         cast[KeyboardManager.B] = this.B;
         cast[KeyboardManager.V] = this.V;
         cast[KeyboardManager.S] = this.S;
         cast[KeyboardManager.L] = this.L;
         cast[KeyboardManager.F] = this.F;
         cast[KeyboardManager.A] = this.A;
         cast[KeyboardManager.O] = this.O;
         cast[KeyboardManager.C] = this.C;
         cast[KeyboardManager.Z] = this.Z;
         cast[KeyboardManager.J] = this.J;
         cast[KeyboardManager.M] = this.M;
         cast[KeyboardManager.U] = this.U;
         cast[KeyboardManager.H] = this.H;
         cast[KeyboardManager.D] = this.D;
         cast[KeyboardManager.T] = this.T;
         cast[KeyboardManager.Q] = this.Q;
         cast[KeyboardManager.P] = this.P;
         cast[KeyboardManager.I] = this.I;
         cast[KeyboardManager.X] = this.X;
         cast[KeyboardManager.E] = this.E;
         cast[KeyboardManager.G] = this.G;
         cast[KeyboardManager.Y] = this.Y;
         cast[KeyboardManager.K] = this.K;
         cast[KeyboardManager.R] = this.R;
         cast[KeyboardManager.W] = this.W;
         cast[KeyboardManager.F9] = this.F9;
         cast[KeyboardManager.NUMBER1] = this.NUMBER1;
         cast[KeyboardManager.NUMBER2] = this.NUMBER2;
         cast[KeyboardManager.NUMBER3] = this.NUMBER3;
         cast[KeyboardManager.NUMBER4] = this.NUMBER4;
      }
      
      private function R(e:KeyboardEvent = null) : void
      {
         var arr:Array = Model_actDaily.getInstance().rchdArr.getData() as Array;
         Utils.print(arr);
      }
      
      private function W(e:KeyboardEvent = null) : void
      {
         var k:String = null;
         if(Boolean(PHPParam))
         {
            for(k in PHPParam)
            {
               Utils.print("PHP参数：" + k + "=" + PHPParam[k]);
            }
         }
      }
      
      private function ESCAPE(e:KeyboardEvent = null) : void
      {
         var j:int = 0;
         var spr:Sprite = null;
         if(Global.isInHome && VoHome.isDismant)
         {
            EnterHomeControl.instance.exitDismanle();
         }
         if(Global.isInHome && Global.isBuildHome)
         {
            BuildAction.instance.upHandle();
            BuildAction.instance.canelBuilding();
         }
         var i:int = UIManager.visiblePanels.length - 1;
         while(i >= 0)
         {
            j = UIManager.visiblePanels[i].length - 1;
            if(j >= 0)
            {
               spr = UIManager.visiblePanels[i][j] as Sprite;
               spr.visible = false;
               return;
            }
            i--;
         }
      }
      
      private function X(e:KeyboardEvent = null) : void
      {
         if(!ResourceVersionConfig.isRelease)
         {
            ChatCGMessage.CG_CHAT(2,"bshowdate");
         }
      }
      
      private function B(e:KeyboardEvent = null) : void
      {
         if(Global.isInHome)
         {
            return;
         }
         if(SceneConfig.getSceneType() == SceneConfig.AiDeBaoBao || SceneConfig.getSceneType() == SceneConfig.KuaFuPaiDui)
         {
            return;
         }
         UIManager.bagPanel.visible = !UIManager.bagPanel.visible;
      }
      
      private function C(e:KeyboardEvent = null) : void
      {
         if(Global.isInHome)
         {
            return;
         }
         if(SceneConfig.getSceneType() == SceneConfig.AiDeBaoBao || SceneConfig.getSceneType() == SceneConfig.KuaFuPaiDui)
         {
            return;
         }
         WuXingMter.getPan(View_rolePan,function(pan:View_rolePan):void
         {
            pan.visible = !pan.visible;
         });
      }
      
      private function D(e:KeyboardEvent = null) : void
      {
         var pan:View_rolePan;
         if(Global.isInHome)
         {
            return;
         }
         if(SceneConfig.getSceneType() == SceneConfig.AiDeBaoBao || SceneConfig.getSceneType() == SceneConfig.KuaFuPaiDui)
         {
            return;
         }
         pan = Singleton.getInstance(View_rolePan);
         if(pan.visible)
         {
            pan.visible = false;
         }
         else
         {
            WuXingMter.getPan(View_rolePan,function(pan:View_rolePan):void
            {
               pan.showView(Enum_panel_role.MERIDIAN);
            });
         }
      }
      
      private function E(e:KeyboardEvent = null) : void
      {
         if(Global.isInHome)
         {
            return;
         }
         if(SceneConfig.getSceneType() == SceneConfig.AiDeBaoBao || SceneConfig.getSceneType() == SceneConfig.KuaFuPaiDui)
         {
            return;
         }
         UIManager.castPanel.visible = !UIManager.castPanel.visible;
      }
      
      private function K(e:KeyboardEvent = null) : void
      {
         PetCGMessage.CG_BT_JINGXIU(4,0);
      }
      
      private function ENTER(e:KeyboardEvent = null) : void
      {
         UIManager.chatPanel.setFocus();
      }
      
      private function G(e:KeyboardEvent = null) : void
      {
         if(Global.isInHome)
         {
            return;
         }
         if(SceneConfig.getSceneType() == SceneConfig.AiDeBaoBao || SceneConfig.getSceneType() == SceneConfig.KuaFuPaiDui)
         {
            return;
         }
         if(!MicroButton(Enum_explor.bindDic[Enum_explor.BTN_PARTY]).visible)
         {
            return;
         }
         if(UIManager.bangList.visible)
         {
            UIManager.bangList.visible = false;
            return;
         }
         if(UIManager.banghuiBack.visible)
         {
            UIManager.banghuiBack.visible = false;
            return;
         }
         BangCGMessage.CG_BANG_PAGE_SEARCH(1,"","",1);
      }
      
      private function V(e:KeyboardEvent = null) : void
      {
         if(Global.isInHome)
         {
            return;
         }
         if(SceneConfig.getSceneType() == SceneConfig.AiDeBaoBao || SceneConfig.getSceneType() == SceneConfig.KuaFuPaiDui)
         {
            return;
         }
         if(!MicroButton(Enum_explor.bindDic[Enum_explor.BTN_SKILL]).visible)
         {
            return;
         }
         UIManager.skillPanel.visible = !UIManager.skillPanel.visible;
         UIManager.skillPanel.get_first_grid_select(0);
      }
      
      private function H(e:KeyboardEvent = null) : void
      {
         if(Global.isInHome)
         {
            return;
         }
         if(SceneConfig.getSceneType() == SceneConfig.AiDeBaoBao || SceneConfig.getSceneType() == SceneConfig.KuaFuPaiDui)
         {
            return;
         }
         if(GameUnitManager.hero.level < 30)
         {
            UIManager.centerBroadcast.addMsg(LangConfig.getWord("10506",1,30));
            return;
         }
         JingJiChangCGMessage.CG_GET_PAIMING();
         JingJiChangCGMessage.CG_GET_WAR_INFO();
         UIManager.jjc_panel.visible = !UIManager.jjc_panel.visible;
      }
      
      private function S(e:KeyboardEvent = null) : void
      {
         if(Global.isInHome)
         {
            return;
         }
         if(SceneConfig.getSceneType() == SceneConfig.AiDeBaoBao || SceneConfig.getSceneType() == SceneConfig.KuaFuPaiDui)
         {
            return;
         }
         var pan:ShoppingMallPan = Singleton.getInstance(ShoppingMallPan) as ShoppingMallPan;
         pan.visible = !pan.visible;
      }
      
      private function A(e:KeyboardEvent = null) : void
      {
         BattleManager.jumpBattle();
      }
      
      private function L(e:KeyboardEvent = null) : void
      {
         if(Global.isInHome)
         {
            return;
         }
         if(SceneConfig.getSceneType() == SceneConfig.AiDeBaoBao || SceneConfig.getSceneType() == SceneConfig.KuaFuPaiDui)
         {
            return;
         }
         UIManager.letterManagerViewPanel.visible = !UIManager.letterManagerViewPanel.visible;
         if(UIManager.letterManagerViewPanel.visible)
         {
            LetterCGMessage.CG_MAIL(1,1);
         }
      }
      
      private function F(e:KeyboardEvent = null) : void
      {
         if(Global.isInHome)
         {
            return;
         }
         if(SceneConfig.getSceneType() == SceneConfig.AiDeBaoBao || SceneConfig.getSceneType() == SceneConfig.KuaFuPaiDui)
         {
            return;
         }
         var questIns:View_friQuestList = UIManager.friQuestPanel;
         if(Model_Friends.hasNewQuest)
         {
            if(questIns.visible)
            {
               questIns.visible = false;
            }
            else
            {
               questIns.show();
            }
            return;
         }
         if(questIns.visible == true)
         {
            questIns.visible = false;
         }
         UIManager.friendPanel.visible = !UIManager.friendPanel.visible;
      }
      
      private function O(e:KeyboardEvent = null) : void
      {
         if(Global.isInHome)
         {
            return;
         }
         if(SceneConfig.getSceneType() == SceneConfig.AiDeBaoBao || SceneConfig.getSceneType() == SceneConfig.KuaFuPaiDui)
         {
            return;
         }
         if(!MicroButton(Enum_explor.bindDic[Enum_explor.BTN_NEIGONG]).visible)
         {
            return;
         }
         UIManager.xinFaPanel.visible = !UIManager.xinFaPanel.visible;
      }
      
      private function Z(e:KeyboardEvent = null) : void
      {
         Global.control.sendNotification(Enum_MsgType.MSG_GUAJIA,null);
      }
      
      private function J(e:KeyboardEvent = null) : void
      {
         if(Global.isInHome)
         {
            return;
         }
         if(SceneConfig.getSceneType() == SceneConfig.AiDeBaoBao || SceneConfig.getSceneType() == SceneConfig.KuaFuPaiDui)
         {
            return;
         }
         UIManager.trans_panel.visible = !UIManager.trans_panel.visible;
         if(UIManager.trans_panel.visible)
         {
            UIManager.trans_panel.parent.setChildIndex(UIManager.trans_panel,UIManager.trans_panel.parent.numChildren - 1);
            if(Boolean(Model_trans.trans_list_data_arr.length))
            {
               UIManager.trans_panel.update_trans_item(Model_trans.trans_list_data_arr);
            }
            else
            {
               JiaoYiCGMessage.CG_JIAOYI_LIST();
            }
         }
      }
      
      private function M(e:KeyboardEvent = null) : void
      {
         if(SceneConfig.getSceneType() == SceneConfig.AiDeBaoBao || SceneConfig.getSceneType() == SceneConfig.KuaFuPaiDui)
         {
            return;
         }
         UIManager.mappanel.visible = !UIManager.mappanel.visible;
      }
      
      private function U(e:KeyboardEvent = null) : void
      {
      }
      
      private function I(e:KeyboardEvent = null) : void
      {
      }
      
      private function P(e:KeyboardEvent = null) : void
      {
         var menu:Sprite = null;
         var disx:Number = NaN;
         var disy:Number = NaN;
         var speed:Number = NaN;
         var initMenu:Function = function(n:int):void
         {
            var i:int = 0;
            var mc:Sprite = null;
            while(i < n)
            {
               mc = new Sprite();
               mc.graphics.beginFill(0,1);
               mc.graphics.drawCircle(0,0,30);
               mc.graphics.endFill();
               var _temp_1:* = mc;
               mc.scaleY = 0.5;
               _temp_1.scaleX = 0.5;
               menu.addChild(mc);
               i++;
            }
         };
         var moveMenu:Function = function(e:Event):void
         {
            var depthArray:Array = null;
            var angle:Number = NaN;
            var z:int = 0;
            var mc:Sprite = null;
            var iconCount:int = menu.numChildren;
            depthArray = new Array();
            angle = 360 / iconCount;
            while(z < iconCount)
            {
               mc = menu.getChildAt(z) as Sprite;
               mc.filters = Util.glowFFFF00;
               mc.x = cosD(speed + angle * z) * disx;
               mc.y = sinD(speed + angle * z) * disy;
               setProp(mc,"alpha");
               setProp(mc,"scaleX",0.2,0.7);
               setProp(mc,"scaleY",0.2,0.7);
               depthArray[z] = mc;
               z++;
            }
            arrange(depthArray);
            speed += 2;
         };
         var arrange:Function = function(depthArray:Array):void
         {
            depthArray.sortOn("y",Array.NUMERIC);
            var i:int = int(depthArray.length);
            while(Boolean(i--))
            {
               menu.setChildIndex(depthArray[i],i);
            }
         };
         var setProp:Function = function(mc:Sprite, prop:String, n1:Number = 0.5, n2:Number = 1):void
         {
            mc[prop] = ((mc.y + 2 * disy) / disy - 1) / 2 * (n2 - n1) + n1;
         };
         var angleToRadian:Function = function(angle:Number):Number
         {
            return angle * (Math.PI / 180);
         };
         var radianToAngle:Function = function(radian:Number):Number
         {
            return radian * (180 / Math.PI);
         };
         var sinD:Function = function(angle:Number):Number
         {
            return Math.sin(angleToRadian(angle));
         };
         var cosD:Function = function(angle:Number):Number
         {
            return Math.cos(angleToRadian(angle));
         };
         var atan2D:Function = function(y:Number, x:Number):Number
         {
            return radianToAngle(Math.atan2(y,x));
         };
      }
      
      private function T(e:KeyboardEvent = null) : void
      {
         var teamL:TeamListPanel = null;
         if(SceneConfig.getSceneType() == SceneConfig.GMD || SceneConfig.getSceneType() == SceneConfig.AiDeBaoBao || SceneConfig.getSceneType() == SceneConfig.KuaFuPaiDui)
         {
            UIManager.centerBroadcast.addMsg("该场景不能打开组队面板");
            return;
         }
         if(!Model_team.isTeam[GameUnitManager.hero.id])
         {
            UIManager.teamSearchPanel.visible = !UIManager.teamSearchPanel.visible;
            TeamCGMessage.CG_TEAM(1);
         }
         else
         {
            trace("队伍变化:",Model_team.teamMumberInfo_data_save);
            if(Boolean(TeamListPanel.data[Model_team.team_id]))
            {
               TeamListPanel.data[Model_team.team_id].visible = !TeamListPanel.data[Model_team.team_id].visible;
               TeamListPanel.data[Model_team.team_id].updata(Model_team.teamMumberInfo_data_save);
            }
            else
            {
               teamL = new TeamListPanel();
               TeamListPanel.data[Model_team.team_id] = teamL;
               teamL.init();
               teamL._leastLevel = Model_team.leastLvlSave;
               teamL._biggestLevel = Model_team.biggestLvlSave;
               TeamListPanel.data[Model_team.team_id].visible = !TeamListPanel.data[Model_team.team_id].visible;
               teamL.updata(Model_team.teamMumberInfo_data_save);
            }
         }
      }
      
      private function Q(e:KeyboardEvent = null) : void
      {
         if(Global.isInHome)
         {
            return;
         }
         if(SceneConfig.getSceneType() == SceneConfig.AiDeBaoBao || SceneConfig.getSceneType() == SceneConfig.KuaFuPaiDui)
         {
            return;
         }
         UIManager.questPanel.visible = !UIManager.questPanel.visible;
      }
      
      private function F9(e:KeyboardEvent = null) : void
      {
         if(Global.isInHome)
         {
            return;
         }
         if(SceneConfig.getSceneType() == SceneConfig.AiDeBaoBao || SceneConfig.getSceneType() == SceneConfig.KuaFuPaiDui)
         {
            return;
         }
         UIManager.smallMap.biClick(null);
      }
      
      private function NUMBER1(e:KeyboardEvent = null) : void
      {
         if(SceneConfig.getSceneType() == SceneConfig.AiDeBaoBao && Boolean(View_AiDeBaoBao_skillBar.instance.BtnArray[0]))
         {
            View_AiDeBaoBao_skillBar.instance.BtnArray[0].dispatchEvent(new MouseEvent(MouseEvent.CLICK));
         }
      }
      
      private function NUMBER2(e:KeyboardEvent = null) : void
      {
         if(SceneConfig.getSceneType() == SceneConfig.AiDeBaoBao && Boolean(View_AiDeBaoBao_skillBar.instance.BtnArray[1]))
         {
            View_AiDeBaoBao_skillBar.instance.BtnArray[1].dispatchEvent(new MouseEvent(MouseEvent.CLICK));
         }
      }
      
      private function NUMBER3(e:KeyboardEvent = null) : void
      {
         if(SceneConfig.getSceneType() == SceneConfig.AiDeBaoBao && Boolean(View_AiDeBaoBao_skillBar.instance.BtnArray[2]))
         {
            View_AiDeBaoBao_skillBar.instance.BtnArray[2].dispatchEvent(new MouseEvent(MouseEvent.CLICK));
         }
      }
      
      private function NUMBER4(e:KeyboardEvent = null) : void
      {
         if(SceneConfig.getSceneType() == SceneConfig.AiDeBaoBao && Boolean(View_AiDeBaoBao_skillBar.instance.BtnArray[3]))
         {
            View_AiDeBaoBao_skillBar.instance.BtnArray[3].dispatchEvent(new MouseEvent(MouseEvent.CLICK));
         }
      }
      
      private function Y(e:KeyboardEvent = null) : void
      {
         if(Global.isInHome)
         {
            return;
         }
         if(SceneConfig.getSceneType() == SceneConfig.AiDeBaoBao || SceneConfig.getSceneType() == SceneConfig.KuaFuPaiDui)
         {
            return;
         }
         if(!UIManager.special_btn.petBtn || !UIManager.special_btn.petBtn.visible)
         {
            return;
         }
         if(Boolean(UIManager.petPanel.petVO))
         {
            UIManager.petPanel.visible = !UIManager.petPanel.visible;
         }
         else
         {
            UIManager.centerBroadcast.addMsg("<font color=\'#ffff00\'>" + LangConfig.getWord("10172",1) + "</font>");
         }
      }
   }
}

