package com.yiTian.view.modules.skill.masterSk
{
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.data.vo.Vo_Skill;
   import com.yiTian.data.vo.Vo_grid;
   import com.yiTian.manager.UIManager;
   import com.yiTian.view.modules.skill.Model_skill;
   
   public class View_masterSkill extends ChildSprite
   {
      
      public static var lightId:int;
      
      public static const MSG_SKILL_CHANGE:String = "msg_skill_change";
      
      public static var sgSkillArr:Array = [];
      
      public static var masterSkillItem:Array = [];
      
      private var skillItemVec:Vector.<Child_SKItem> = new Vector.<Child_SKItem>();
      
      private var giVec1:Vector.<GItem> = new Vector.<GItem>();
      
      private var giVec2:Vector.<GItem> = new Vector.<GItem>();
      
      public function View_masterSkill()
      {
         super();
         regResource("lang/ch/SMJN.swf","SMJNdm");
      }
      
      override protected function initSource() : void
      {
         var i:int = 0;
         var sItem:Child_SKItem = null;
         var xPostion:Number = NaN;
         var yPostion:Number = NaN;
         var GI:GItem = null;
         var _gi:GItem = null;
         ComponentUtil.getBitmap("Back_SMJN",this,{
            "x":34,
            "y":50
         },Global.SMJNdm);
         var angle:Number = -Math.PI * 2 / 3;
         i = 0;
         while(i < 6)
         {
            sItem = new Child_SKItem(11 + i);
            this.skillItemVec.push(sItem);
            addChild(sItem);
            xPostion = 260 + Math.cos(angle) * 140;
            yPostion = 215 + Math.sin(angle) * 135;
            ComponentUtil.setPropertie(sItem,{
               "x":xPostion,
               "y":yPostion
            });
            angle += Math.PI / 3;
            i++;
         }
         ComponentUtil.getBitmap("Line_JNSX",this,{
            "x":76,
            "y":395
         },Global.SMJNdm);
         i = 0;
         while(i < 6)
         {
            GI = new GItem(false,i + 1);
            addChild(GI);
            GI.initBg(ComponentUtil.getBitmapData("Girld_PTPL",Global.SMJNdm));
            ComponentUtil.setPropertie(GI,{
               "x":118 + i * 48,
               "y":433
            });
            this.giVec1.push(GI);
            i++;
         }
         i = 0;
         while(i < 2)
         {
            _gi = new GItem(true,i + 17,true);
            addChild(_gi);
            _gi.initBg(ComponentUtil.getBitmapData("Girld_SGPL",Global.SMJNdm));
            ComponentUtil.setPropertie(_gi,{
               "x":55 + 351 * i,
               "y":381
            });
            this.giVec2.push(_gi);
            i++;
         }
      }
      
      public function show() : void
      {
         visible = visible || true;
         Global.control.registerCallBack(MSG_SKILL_CHANGE,this.updateBattleGrid);
         Global.control.registerCallBack("masterSkillSingleUpdate",this.updateMasterSkill);
         Global.control.registerCallBack("masterKillData",this.updateMasterSkill);
         Global.control.registerCallBack("updateSGBattleGrid",this.updateSGBattleGrid);
         Global.control.registerCallBack("singleMSData",this.updateMS);
         this.updateBattleGrid();
         this.updateSGBattleGrid();
         this.updateMasterSkill();
         if(Model_skill.isGuideSkill)
         {
            Model_skill.addGuideMask(this);
         }
      }
      
      public function updateMasterSkill() : void
      {
         var voK:Vo_Skill = null;
         var item:Child_SKItem = null;
         var i:int = 0;
         i = 0;
         while(i < masterSkillItem.length)
         {
            voK = masterSkillItem[i];
            item = this.skillItemVec[i];
            item.setGridData(voK);
            i++;
         }
      }
      
      public function updateMS(_index:int) : void
      {
         var voK:Vo_Skill = masterSkillItem[_index - 1];
         var item:Child_SKItem = this.skillItemVec[_index - 1];
         item.setGridData(voK);
      }
      
      private function updateBattleGrid() : void
      {
         var i:int = 0;
         var ggii:GItem = null;
         var voG:Vo_grid = null;
         i = 0;
         while(i < this.giVec1.length)
         {
            ggii = this.giVec1[i];
            voG = UIManager.skillPanel.battleSkillGrids[i].vo;
            ggii.update(voG);
            i++;
         }
      }
      
      public function updateSGBattleGrid() : void
      {
         var i:int = 0;
         var ggii:GItem = null;
         i = 0;
         while(i < this.giVec2.length)
         {
            ggii = this.giVec2[i];
            ggii.update(sgSkillArr[i]);
            if((sgSkillArr[i] as Vo_Skill).id == lightId)
            {
               ggii.lighting = true;
            }
            else
            {
               ggii.lighting = false;
            }
            i++;
         }
      }
   }
}

