package com.yiTian.view.modules.tip.tips
{
   import com.ui.controls.MyTextField;
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.data.vo.Vo_DynamicTip;
   
   public class View_DynamicStrTip extends View_tip
   {
      
      private var tf:MyTextField;
      
      private var _oldW:Number = -1;
      
      private var _oldH:Number = -1;
      
      public function View_DynamicStrTip()
      {
         super();
      }
      
      override public function Init() : void
      {
         addBorder();
         this.tf = ComponentUtil.getTextField("",null,{
            "x":3,
            "y":3,
            "align":"left",
            "leading":3,
            "wordWrap":true,
            "multiline":true,
            "realWidth":222
         });
         addChild(this.tf);
      }
      
      override public function Show(obj:Object, type:int = 1, stoneLvl:int = 0) : void
      {
         this.tf.textColor = 16777215;
         if(obj is Vo_DynamicTip)
         {
            this.tf.htmlText = (obj as Vo_DynamicTip).info;
            this.tf.realWidth = (obj as Vo_DynamicTip)._w;
            x = Global.stage.mouseX + 10;
            y = Global.stage.mouseY + 5;
         }
         var newWidth:Number = this.tf.textWidth + 14;
         var newHeight:Number = this.tf.textHeight + 14;
         if(this._oldW != newWidth || this._oldH != newHeight)
         {
            this._oldW = border.width = newWidth;
            this._oldH = border.height = newHeight;
         }
         setChildIndex(border,0);
         this.tf.x = (border.width - this.tf.textWidth) * 0.5;
         this.tf.y = (border.height - this.tf.textHeight) * 0.5;
         if(x + border.width > Global.stage.stageWidth)
         {
            x = Global.stage.stageWidth - border.width;
         }
         if(y + height > Global.stage.stageHeight)
         {
            y = Global.stage.stageHeight - height;
         }
      }
   }
}

