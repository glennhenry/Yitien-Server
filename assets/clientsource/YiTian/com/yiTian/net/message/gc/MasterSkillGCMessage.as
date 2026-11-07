package com.yiTian.net.message.gc
{
   import com.yiTian.Global;
   import com.yiTian.data.vo.Vo_Skill;
   import com.yiTian.manager.UIManager;
   import com.yiTian.net.message.MessageType;
   import com.yiTian.scene.GameScene;
   import com.yiTian.view.modules.cast.CastEffect;
   import com.yiTian.view.modules.skill.View_SkillPanel;
   import com.yiTian.view.modules.skill.masterSk.View_masterSkill;
   import flash.utils.IDataInput;
   
   public class MasterSkillGCMessage
   {
      
      private var tipsArr:Array = ["技能升级成功","升级此技能所需声望不足","升级此技能所需经验不足","需满足110级的等级要求","背包内无所需技能书","身上没有这个技能，技能ID有问题","任务未达标","该技能不存在","操作太频繁","系统正在维护中..","该技能等级已满级"];
      
      private var _tipsArr:Array = ["您选择了{0}神功进行战斗","您已经选择了该神功出战了","系统找不到这个神功id哦","操作太频繁了亲","系统正在维护中.. ","该神功技能还没学习，不能选择"];
      
      public function MasterSkillGCMessage(index:Array)
      {
         super();
         index[MessageType.GC_MASTERSKILL_SG] = GC_MASTERSKILL_SG;
         index[MessageType.GC_MASTERSKILL_COM] = GC_MASTERSKILL_COM;
         index[MessageType.GC_MASTERSKILL_LEARN_UP] = this.GC_MASTERSKILL_LEARN_UP;
         index[MessageType.GC_MASTERSKILL_CHOOSE] = this.GC_MASTERSKILL_CHOOSE;
         index[MessageType.GC_MASTERSKILL_ASKFOR_DATA] = this.GC_MASTERSKILL_ASKFOR_DATA;
         index[MessageType.GC_MASTERSKILL_ICTROL] = this.GC_MASTERSKILL_ICTROL;
      }
      
      public static function GC_MASTERSKILL_SG(patch:IDataInput = null) : void
      {
         var skillId:int = 0;
         var len:int = patch.readByte();
         View_masterSkill.sgSkillArr = [];
         var i:int = 0;
         while(i < len)
         {
            skillId = patch.readInt();
            if(skillId == 0)
            {
               throw new Error("神功技能id为0啦，打黄华锦");
            }
            View_masterSkill.sgSkillArr.push(new Vo_Skill(skillId));
            i++;
         }
         var lightUpSKId:int = patch.readInt();
         View_masterSkill.lightId = lightUpSKId;
         Global.control.sendNotification("updateSGBattleGrid",null);
      }
      
      public static function GC_MASTERSKILL_COM(patch:IDataInput = null) : void
      {
         var skillId:int = 0;
         var len:int = patch.readByte();
         View_masterSkill.masterSkillItem = [];
         var i:int = 0;
         while(i < len)
         {
            skillId = patch.readInt();
            if(skillId == 0)
            {
               throw new Error("神功技能id为0啦，打黄华锦");
            }
            View_masterSkill.masterSkillItem.push(new Vo_Skill(skillId));
            i++;
         }
         Vo_Skill.masterData = View_masterSkill.masterSkillItem;
         Global.control.sendNotification("masterKillData",null);
      }
      
      private function GC_MASTERSKILL_LEARN_UP(patch:IDataInput) : void
      {
         var _temVoS:Vo_Skill = null;
         var i:int = 0;
         var voS:Vo_Skill = null;
         var status:int = patch.readByte();
         var index:int = patch.readByte();
         var skillId:int = patch.readInt();
         if(status == 1)
         {
            if((View_masterSkill.masterSkillItem[index - 1] as Vo_Skill).current_grade == 0)
            {
               CastEffect.getSkillEffect("learntSkill",GameScene.popupLayer);
            }
            else
            {
               CastEffect.getSkillEffect("upSkill",GameScene.popupLayer);
            }
            _temVoS = new Vo_Skill(skillId);
            if(_temVoS.skill_type == 3)
            {
               Global.control.sendNotification(_temVoS.str_name,_temVoS);
               i = 0;
               while(i < View_masterSkill.sgSkillArr.length)
               {
                  voS = View_masterSkill.sgSkillArr[i];
                  if(voS.str_name == _temVoS.str_name)
                  {
                     View_masterSkill.sgSkillArr[i] = _temVoS;
                  }
                  i++;
               }
            }
            Vo_Skill.masterData[index - 1] = View_masterSkill.masterSkillItem[index - 1] = new Vo_Skill(skillId);
            Global.control.sendNotification("singleMSData",index);
         }
         else
         {
            UIManager.centerBroadcast.addMsg(this.tipsArr[status - 1],1);
         }
      }
      
      private function GC_MASTERSKILL_CHOOSE(patch:IDataInput) : void
      {
         var status:int = patch.readByte();
         if(status == 1)
         {
            Global.control.sendNotification("masterSkillChose",null);
         }
         else
         {
            UIManager.centerBroadcast.addMsg(this._tipsArr[status - 1],1);
         }
      }
      
      private function GC_MASTERSKILL_ASKFOR_DATA(patch:IDataInput) : void
      {
         var skillId:int = 0;
         var skItem:Vo_Skill = null;
         var index:int = 0;
         var len:int = patch.readByte();
         var arr:Array = [];
         var i:int = 0;
         while(i < len)
         {
            skillId = patch.readInt();
            for each(skItem in View_masterSkill.masterSkillItem)
            {
               if(skItem.id == skillId)
               {
                  index = View_masterSkill.masterSkillItem.indexOf(skItem);
                  skItem = new Vo_Skill(skillId);
                  skItem.isDaBiao = true;
                  View_masterSkill.masterSkillItem[index] = skItem;
                  break;
               }
            }
            i++;
         }
         Global.control.sendNotification("masterSkillSingleUpdate",arr);
      }
      
      private function GC_MASTERSKILL_ICTROL(patch:IDataInput) : void
      {
         var result:int = patch.readByte();
         if(result == 1)
         {
            UIManager.skillPanel.tabChange_MS(View_SkillPanel.saveE);
         }
         else if(result == 2)
         {
            UIManager.centerBroadcast.addMsg("该系统暂时未开放",1);
         }
         else if(result == 3)
         {
            UIManager.centerBroadcast.addMsg("110级开启师门技能系统，大侠速去练级吧!",1);
         }
      }
   }
}

