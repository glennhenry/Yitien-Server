package com.yiTian.view.modules.skill.masterSk
{
   import com.ui.controls.Button;
   import com.ui.controls.MyTextField;
   import com.ui.controls.ScaleBitmap;
   import com.utils.ComponentUtil;
   import com.utils.Util;
   import com.yiTian.Global;
   import com.yiTian.data.vo.Vo_Skill;
   import com.yiTian.data.vo.Vo_grid;
   import com.yiTian.manager.TipManager;
   import com.yiTian.net.message.cg.MasterSkillCGMessage;
   import com.yiTian.view.modules.skill.View_SkillPanel;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import flashx.textLayout.formats.TextAlign;
   
   public class Child_SKItem extends Sprite
   {
      
      private var gridItem:GItem;
      
      private var isBigIcon:Boolean = false;
      
      public var _index:int;
      
      private var lgIcon:Bitmap;
      
      private var btn:Button;
      
      private var tf:MyTextField;
      
      private var backScalBm:ScaleBitmap;
      
      private var __type:int;
      
      private var __vo:Vo_Skill;
      
      public function Child_SKItem(index:int)
      {
         super();
         this._index = index;
         this.gridItem = new GItem(false,index);
         addChild(this.gridItem);
         this.init();
      }
      
      public function init() : void
      {
         this.gridItem.initBg(ComponentUtil.getBitmapData("Girld_PTJN",Global.SMJNdm));
         this.gridItem.iconBm = ComponentUtil.getBitmapData("lock",Global.SMJNdm);
         ComponentUtil.setPropertie(this.gridItem,{
            "x":-this.gridItem.width / 2,
            "y":-this.gridItem.height / 2
         });
         this.lgIcon = ComponentUtil.getBitmap("Icon_WJF",this,{
            "x":this.gridItem.x - 16,
            "y":this.gridItem.y - 16,
            "visible":false
         },Global.SMJNdm);
         this.btn = ComponentUtil.getButton("","Button_JNSJ",this,{
            "x":(this.gridItem.x + this.gridItem.width) / 2 - 23,
            "y":this.gridItem.y + this.gridItem.height - 4
         },Global.SMJNdm);
         this.btn.callBack = this.LearnUp;
         this.backScalBm = ComponentUtil.getScaleBitmap("Back_ComboBox",[4,4,3,3],this,{
            "x":this.gridItem.x + this.gridItem.width - 25,
            "y":this.gridItem.y + this.gridItem.height - 20,
            "width":22,
            "height":17
         },Global.Img_Cdm);
         this.tf = ComponentUtil.getTextField("0",this,{
            "x":this.backScalBm.x,
            "y":this.backScalBm.y - 1,
            "align":TextAlign.CENTER,
            "realWidth":22,
            "realHeight":19
         });
         this.backScalBm.visible = false;
         this.tf.visible = false;
         this.lgIcon.visible = false;
         this.btn.visible = false;
         addEventListener(MouseEvent.ROLL_OVER,this.over);
         addEventListener(MouseEvent.ROLL_OUT,this.out);
         this.__type = -2;
      }
      
      private function LearnUp(e:MouseEvent) : void
      {
         MasterSkillCGMessage.CG_MASTERSKILL_LEARN_UP(this.gridItem.vo.id);
      }
      
      public function setGridData(vo:Vo_grid) : void
      {
         if((vo as Vo_Skill).skill_type == 3)
         {
            this.gridItem.isBig = true;
            this.gridItem.initBg(ComponentUtil.getBitmapData("Girld_SGJN",Global.SMJNdm));
         }
         else
         {
            this.gridItem.isBig = false;
            this.gridItem.initBg(ComponentUtil.getBitmapData("Girld_PTJN",Global.SMJNdm));
         }
         this.gridItem.update(vo);
         this.tf.text = (vo as Vo_Skill).current_grade.toString();
         this.backScalBm.visible = true;
         if((vo as Vo_Skill).current_grade == 0)
         {
            this.tf.visible = false;
            this.backScalBm.visible = false;
            this.lgIcon.visible = true;
            if((vo as Vo_Skill).isDaBiao)
            {
               this.__type = 0;
               this.btn.label = "学习";
               this.lgIcon.bitmapData = ComponentUtil.getBitmapData("Ready_Learn",View_SkillPanel.skillDm);
            }
            else
            {
               this.lgIcon.bitmapData = ComponentUtil.getBitmapData("Icon_WJF",Global.SMJNdm);
               this.btn.visible = false;
               this.__type = -1;
            }
            this.gridItem.setfilters(Util.disabled);
         }
         else
         {
            this.__type = 1;
            this.__vo = vo as Vo_Skill;
            this.lgIcon.bitmapData = ComponentUtil.getBitmapData("Ready_LvUp",View_SkillPanel.skillDm);
            this.lgIcon.visible = true;
            this.backScalBm.visible = true;
            this.tf.visible = true;
            this.btn.label = "升级";
            this.gridItem.setfilters([]);
            Global.control.sendNotification("dataChanged_ofMskill",this.__vo);
         }
         if((vo as Vo_Skill).current_grade >= 15)
         {
            this.btn.visible = false;
            MskillExtral.instance.hideExt();
            this.lgIcon.visible = false;
         }
         this.resize();
      }
      
      private function over(e:MouseEvent) : void
      {
         this.setVisItem(true);
      }
      
      private function out(e:MouseEvent) : void
      {
         this.setVisItem(false);
      }
      
      private function setVisItem(bool:Boolean) : void
      {
         if(this.__type != -1)
         {
            if(this.__type == 0)
            {
               this.btn.visible = bool;
            }
            else if(this.__type == 1)
            {
               if(this.__vo.current_grade < 15)
               {
                  this.btn.visible = bool;
                  if(bool)
                  {
                     if(this.__vo.skill_type == 4)
                     {
                        MskillExtral.instance.showExt(this,this.__vo,new Point(this.gridItem.x + this.gridItem.width - 10,0),2);
                     }
                     else
                     {
                        MskillExtral.instance.showExt(this,this.__vo,new Point(this.gridItem.x + 12,0),1);
                     }
                  }
                  else
                  {
                     MskillExtral.instance.hideExt();
                  }
               }
            }
            else if(this.__type == -2)
            {
               TipManager.bind(this,"暂时未开放");
            }
         }
      }
      
      private function resize() : void
      {
         ComponentUtil.setPropertie(this.lgIcon,{
            "x":this.gridItem.x - 16,
            "y":this.gridItem.y - 16
         });
         ComponentUtil.setPropertie(this.btn,{
            "x":this.gridItem.x + this.gridItem.width / 2 - 22,
            "y":this.gridItem.y + this.gridItem.height - 4
         });
         ComponentUtil.setPropertie(this.backScalBm,{
            "x":this.gridItem.x + this.gridItem.width - 25,
            "y":this.gridItem.y + this.gridItem.height - 20
         });
         ComponentUtil.setPropertie(this.tf,{
            "x":this.backScalBm.x,
            "y":this.backScalBm.y - 1
         });
      }
   }
}

