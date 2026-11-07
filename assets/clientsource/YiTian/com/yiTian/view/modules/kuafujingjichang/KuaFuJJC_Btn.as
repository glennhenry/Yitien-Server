package com.yiTian.view.modules.kuafujingjichang
{
   import com.yiTian.Global;
   import com.yiTian.data.model.Model_team;
   import com.yiTian.gameUnit.magic.Effect;
   import com.yiTian.manager.EffectManager;
   import com.yiTian.manager.GameUnitManager;
   import com.yiTian.manager.SceneConfig;
   import com.yiTian.manager.UIManager;
   import com.yiTian.view.modules.guangMingDing.Model_guangMingDing;
   import com.yiTian.view.modules.mainUIBtnContainer.Enum_mainUIBtn_hide;
   import com.yiTian.view.modules.mainUIBtnContainer.MainUIBtn;
   import flash.events.MouseEvent;
   
   public class KuaFuJJC_Btn
   {
      
      public var KuaFuBtn:MainUIBtn;
      
      private var _eff:Effect;
      
      public function KuaFuJJC_Btn()
      {
         super();
         this.init();
      }
      
      private function init() : void
      {
         this.KuaFuBtn = new MainUIBtn("resource/image/kuafujingjichang/KuaFuJJC.png",null,null,null,true);
      }
      
      public function updateBtnCount(count:int) : void
      {
         this.KuaFuBtn.showTime(count);
      }
      
      public function eff(v:Boolean) : void
      {
         if(v && !this._eff)
         {
            this._eff = EffectManager.addEffect("35343",this.KuaFuBtn,1000,32,29,true);
         }
         else if(!v && Boolean(this._eff))
         {
            EffectManager.removeEffect(this._eff);
            this._eff = null;
         }
      }
      
      public function show() : void
      {
         var i:int = 0;
         var j:int = 0;
         if(KuaFuJJCVO.see == 1)
         {
            UIManager.mainUiBtnContainer.addBTN(this.KuaFuBtn);
            Global.control.sendNotification(Enum_mainUIBtn_hide.CHANGE_STATUS,[Enum_mainUIBtn_hide.DuoRenJingJi,1]);
            this.KuaFuBtn.addEventListener(MouseEvent.CLICK,this.KuaFuBtnClick);
         }
         else if(KuaFuJJCVO.see == 2)
         {
            UIManager.mainUiBtnContainer.removeBTN(this.KuaFuBtn);
            Global.control.sendNotification(Enum_mainUIBtn_hide.CHANGE_STATUS,[Enum_mainUIBtn_hide.DuoRenJingJi,0]);
            TeamPanel.instance.starBtn.enabled = true;
            TeamPanel.instance.inviteBtn.enabled = true;
            TeamPanel.instance.readyBtn.enabled = true;
            TeamPanel.instance.quxiaoBtn.enabled = true;
            if(Boolean(TeamPanel.instance._bmc))
            {
               TeamPanel.instance._bmc.visible = false;
            }
            i = 0;
            while(i < TeamPanel.instance._zbBmArr.length)
            {
               if(Boolean(TeamPanel.instance._zbBmArr[i]))
               {
                  TeamPanel.instance._zbBmArr[i].visible = false;
               }
               i++;
            }
            DRKFlistPanel.instance.hide();
            TeamPanel.instance.hide();
            DRKFlawPanel.instance.hide();
            YaoQingPanel.instance.hide();
            passwordPanel.instance.hide();
            SeachPanel.instance.hide();
            if(Boolean(this._eff))
            {
               this.eff(false);
            }
            this.KuaFuBtn.removeEventListener(MouseEvent.CLICK,this.KuaFuBtnClick);
         }
         else if(KuaFuJJCVO.see == 3)
         {
            if(Boolean(this._eff))
            {
               this.eff(false);
            }
            Global.control.sendNotification(Enum_mainUIBtn_hide.CHANGE_STATUS,[Enum_mainUIBtn_hide.DuoRenJingJi,-1]);
            if(TeamPanel.instance.starBtn != null)
            {
               TeamPanel.instance.starBtn.enabled = true;
            }
            if(TeamPanel.instance.inviteBtn != null)
            {
               TeamPanel.instance.inviteBtn.enabled = true;
            }
            if(TeamPanel.instance.readyBtn != null)
            {
               TeamPanel.instance.readyBtn.enabled = true;
            }
            if(TeamPanel.instance.quxiaoBtn != null)
            {
               TeamPanel.instance.quxiaoBtn.enabled = true;
            }
            if(TeamPanel.instance._bmc != null)
            {
               TeamPanel.instance._bmc.visible = false;
            }
            j = 0;
            while(j < TeamPanel.instance._zbBmArr.length)
            {
               if(Boolean(TeamPanel.instance._zbBmArr[j]))
               {
                  TeamPanel.instance._zbBmArr[j].visible = false;
               }
               j++;
            }
            DRKFlistPanel.instance.hide();
            TeamPanel.instance.hide();
            DRKFlawPanel.instance.hide();
            YaoQingPanel.instance.hide();
            passwordPanel.instance.hide();
            SeachPanel.instance.hide();
         }
         else if(KuaFuJJCVO.see == 4)
         {
            UIManager.mainUiBtnContainer.addBTN(this.KuaFuBtn);
            Global.control.sendNotification(Enum_mainUIBtn_hide.CHANGE_STATUS,[Enum_mainUIBtn_hide.DuoRenJingJi,1]);
            this.KuaFuBtn.addEventListener(MouseEvent.CLICK,this.KuaFuBtnClick);
            this.eff(true);
         }
      }
      
      public function KuaFuBtnClick(e:MouseEvent) : void
      {
         if(SceneConfig.getSceneType() != SceneConfig.COMMON)
         {
            UIManager.centerBroadcast.addMsg("该场景不支持进入多人跨服");
            return;
         }
         if(GameUnitManager.hero.paoBiao != 0)
         {
            UIManager.centerBroadcast.addMsg("跑镖状态不支持进入多人跨服");
            return;
         }
         if(Model_team.hasTeam() || Model_guangMingDing.isTeamShow)
         {
            UIManager.centerBroadcast.addMsg("组队状态不支持进入多人跨服");
            return;
         }
         if(TeamPanel.instance.visible || DRKFlawPanel.instance.visible || DRKFlistPanel.instance.visible)
         {
            UIManager.centerBroadcast.addMsg("正在多人跨服");
            return;
         }
         this.eff(false);
         Global.delegate.dosomething(UIManager.kuafujoin,UIManager.kuafujoin.show);
      }
   }
}

