package com.yiTian.view.modules.battle
{
   import com.ui.controls.MyTextField;
   import com.utils.ComponentUtil;
   import com.yiTian.data.Data_lib;
   import com.yiTian.utils.Bitmap2;
   import com.yiTian.utils.Pool;
   import com.yiTian.view.modules.shenBing.Enum_ShenBing;
   import flash.display.Sprite;
   import flash.filters.GlowFilter;
   import flash.text.TextFieldAutoSize;
   
   public class Child_SbBattleBigIcon extends Sprite
   {
      
      public var bmBg:Bitmap2;
      
      public var bmIcon:Bitmap2;
      
      private var _tfSkillName:MyTextField;
      
      public function Child_SbBattleBigIcon()
      {
         super();
         this.bmBg = new Bitmap2();
         this.bmIcon = new Bitmap2();
         this.bmIcon.x = 101;
         this.bmIcon.y = 4;
         addChild(this.bmBg);
         addChild(this.bmIcon);
         this.bmBg.load("resource/image/shenBing/battleIcon/BG_ZDJND.png");
         this._tfSkillName = ComponentUtil.getTextField("",this,{
            "x":132,
            "y":93,
            "size":16,
            "color":16776960
         },TextFieldAutoSize.CENTER);
         this._tfSkillName.filters = [new GlowFilter(16750848,1,2,2,10)];
      }
      
      public function update(id:int) : void
      {
         this.bmIcon.load("resource/image/shenBing/battleIcon/" + Data_lib.sbSkill[id][Enum_ShenBing.SKILL_ICON] + ".png");
         this._tfSkillName.htmlText = Data_lib.sbSkill[id][Enum_ShenBing.SKILL_NAME];
      }
      
      public function dispose() : void
      {
         this.bmIcon.load(null);
         Pool.saveObject(this);
      }
   }
}

