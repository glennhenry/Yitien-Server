package com.yiTian.view.modules.roleHead
{
   import com.ui.controls.MyTextField;
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.data.Const_strImg;
   import com.yiTian.data.config.Enum_job;
   import com.yiTian.data.model.Model_heFu;
   import com.yiTian.gameUnit.role.Npc;
   import com.yiTian.gameUnit.role.Player;
   import com.yiTian.gameUnit.role.Role;
   import com.yiTian.manager.SceneConfig;
   import com.yiTian.utils.Utils;
   import com.yiTian.view.Panel;
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import flash.display.Shape;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.text.TextFormatAlign;
   
   public class TargetHead extends Panel
   {
      
      private const WIDTH:int = 120;
      
      private const HEIGHT:int = 10;
      
      private var hpBM:Bitmap;
      
      private var hpMask:Shape;
      
      private var mpBM:Bitmap;
      
      private var mpMask:Shape;
      
      private var targetBM:Bitmap;
      
      private var Lever_text:MyTextField;
      
      private var targetName_text:MyTextField;
      
      private var setMask:Sprite;
      
      private var _role:Role;
      
      public function TargetHead()
      {
         super();
      }
      
      override protected function initStaticView() : void
      {
         var back:DisplayObject = ComponentUtil.getBitmap("Back_TeamHead",this,{
            "x":0,
            "y":0
         },Global.Scenedm);
         this.hpBM = ComponentUtil.getBitmap("Player_Head_HP",this,{
            "x":67,
            "y":32
         },Global.Scenedm);
         this.hpMask = new Shape();
         this.draw(this.hpMask,this.WIDTH);
         addChild(this.hpMask);
         this.hpMask.x = this.hpBM.x;
         this.hpMask.y = this.hpBM.y;
         this.hpBM.mask = this.hpMask;
         this.mpBM = ComponentUtil.getBitmap("Player_Head_MP",this,{
            "x":66,
            "y":45
         },Global.Scenedm);
         this.mpMask = new Shape();
         this.draw(this.mpMask,this.WIDTH);
         addChild(this.mpMask);
         this.mpMask.x = this.mpBM.x;
         this.mpMask.y = this.mpBM.y;
         this.mpBM.mask = this.mpMask;
         this.targetBM = new Bitmap();
         addChild(this.targetBM);
         this.targetBM.x = 5;
         this.targetBM.y = -5;
         this.setMask = new Sprite();
         this.setMask.graphics.beginFill(16777215,0);
         this.setMask.graphics.drawCircle(0,0,25);
         this.setMask.graphics.endFill();
         addChild(this.setMask);
         this.setMask.x = 33;
         this.setMask.y = 42;
         this.Lever_text = ComponentUtil.getTextField("106",this,{
            "x":56,
            "y":7,
            "color":16777215,
            "size":11,
            "leading":0
         });
         this.Lever_text.realWidth = 20;
         this.Lever_text.align = TextFormatAlign.CENTER;
         this.targetName_text = ComponentUtil.getTextField("",this,{
            "x":90,
            "y":11,
            "color":16777215
         });
      }
      
      private function draw(shape:Shape, width:int) : void
      {
         shape.graphics.beginFill(0,1);
         shape.graphics.drawRect(0,0,this.WIDTH,this.HEIGHT);
         shape.graphics.endFill();
      }
      
      public function show(role:Role) : void
      {
         var w:int = 0;
         if(Boolean(role))
         {
            this._role = role;
            if((this.setMask as Sprite).hasEventListener(MouseEvent.CLICK))
            {
               (this.setMask as Sprite).removeEventListener(MouseEvent.CLICK,this.onClick);
            }
            if(role is Npc)
            {
               Utils.getLoadBitmap(Const_strImg.getNpcHeadUrl(role.head),this.targetBM);
               (this.setMask as Sprite).buttonMode = false;
            }
            else if(role is Player)
            {
               Utils.getLoadBitmap("resource/image/icon/23" + Enum_job.getBaseJob(role.job) + "1" + role.sex + ".png",this.targetBM);
               (this.setMask as Sprite).addEventListener(MouseEvent.CLICK,this.onClick);
               (this.setMask as Sprite).buttonMode = true;
            }
            w = role.hp > role.hpMax ? this.WIDTH : int(role.hp / role.hpMax * this.WIDTH);
            this.hpMask.width = w;
            w = role.mp > role.mpMax ? this.WIDTH : int(role.mp / role.mpMax * this.WIDTH);
            this.mpMask.width = w;
            this.Lever_text.text = role.level.toString();
            this.targetName_text.htmlText = Model_heFu.repNameByHero(role.name);
            this.visible = true;
         }
      }
      
      private function onClick(e:MouseEvent) : void
      {
         e.stopPropagation();
         if(SceneConfig.getSceneType() == SceneConfig.KFBZ_BATTLE || SceneConfig.getSceneType() == SceneConfig.AiDeBaoBao || SceneConfig.getSceneType() == SceneConfig.CROSS_CAMP_BATTLE)
         {
            return;
         }
         PlayerMenu.isSpecialCheck = false;
         if(Global.isInHome)
         {
            PlayerMenu.getInstance().show([PlayerMenu.zdqq],{
               "id":this._role.id,
               "name":this._role.name,
               "x":this._role.x,
               "y":this._role.y
            });
         }
         else
         {
            PlayerMenu.getInstance().show([PlayerMenu.zdqq,PlayerMenu.ckzl,PlayerMenu.fqjy,PlayerMenu.fsyj,PlayerMenu.fzmz,PlayerMenu.jhmd,PlayerMenu.jwhy,PlayerMenu.sl],{
               "id":this._role.id,
               "name":this._role.name,
               "x":this._role.x,
               "y":this._role.y
            });
         }
      }
      
      public function hide() : void
      {
         this.visible = false;
      }
      
      override public function set visible(value:Boolean) : void
      {
         super.visible = value;
         if(value)
         {
            if(!this.hpBM.bitmapData)
            {
               this.hpBM = Utils.getLoadBitmap("resource/image/team/Team_HP.png",this.hpBM);
            }
            if(!this.mpBM.bitmapData)
            {
               this.hpBM = Utils.getLoadBitmap("resource/image/team/Team_MP.png",this.mpBM);
            }
         }
      }
      
      override public function resetPosition() : void
      {
         x = 400;
         y = 5;
      }
   }
}

