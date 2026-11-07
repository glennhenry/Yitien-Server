package com.yiTian.view.modules.skill.masterSk
{
   import com.utils.ComponentUtil;
   import com.yiTian.view.Panel;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   
   public class MasterSkill extends Panel
   {
      
      public static var GAP_HEIGHT:int = 24;
      
      protected var commonSkillContainer:Sprite;
      
      protected var masterSkillContainer:Sprite;
      
      public function MasterSkill()
      {
         super();
         this.commonSkillContainer = new Sprite();
         super.addChild(this.commonSkillContainer);
         ComponentUtil.setPropertie(this.commonSkillContainer,{"y":GAP_HEIGHT});
         this.masterSkillContainer = new Sprite();
         super.addChild(this.masterSkillContainer);
         ComponentUtil.setPropertie(this.masterSkillContainer,{"y":GAP_HEIGHT});
         this.masterSkillContainer.visible = false;
      }
      
      public function superAddChild(child:DisplayObject) : DisplayObject
      {
         super.addChild(child);
         return child;
      }
      
      public function superRemoveChild(child:DisplayObject) : DisplayObject
      {
         super.removeChild(child);
         return child;
      }
      
      public function superAddChildAt(child:DisplayObject, index:int) : DisplayObject
      {
         super.addChildAt(child,index);
         return child;
      }
      
      override public function addChild(child:DisplayObject) : DisplayObject
      {
         this.commonSkillContainer.addChild(child);
         return child;
      }
      
      override public function addChildAt(child:DisplayObject, index:int) : DisplayObject
      {
         this.commonSkillContainer.addChildAt(child,index);
         return child;
      }
      
      override public function removeChild(child:DisplayObject) : DisplayObject
      {
         this.commonSkillContainer.removeChild(child);
         return child;
      }
      
      override public function removeChildAt(index:int) : DisplayObject
      {
         return this.commonSkillContainer.removeChildAt(index);
      }
      
      override public function setChildIndex(child:DisplayObject, index:int) : void
      {
         this.commonSkillContainer.setChildIndex(child,index);
      }
      
      override public function getChildIndex(child:DisplayObject) : int
      {
         return this.commonSkillContainer.getChildIndex(child);
      }
      
      override public function getChildAt(index:int) : DisplayObject
      {
         return this.commonSkillContainer.getChildAt(index);
      }
   }
}

