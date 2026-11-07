package com.yiTian.view.modules.crossClanBattle
{
   import com.ui.controls.MyTextField;
   import com.utils.ComponentUtil;
   import com.yiTian.data.model.Model_heFu;
   import com.yiTian.utils.Utils;
   import flash.display.Sprite;
   import flash.text.TextFormatAlign;
   
   public class Child_BattleCostItem extends Sprite
   {
      
      private var txtRank:MyTextField;
      
      private var txtClanName:MyTextField;
      
      private var txtSilver:MyTextField;
      
      public function Child_BattleCostItem()
      {
         super();
         this.txtRank = ComponentUtil.getTextField("0",this,{
            "x":0,
            "y":0,
            "color":13424242,
            "size":12,
            "leading":0
         });
         this.txtClanName = ComponentUtil.getTextField("帮会中文名称S.000",this,{
            "x":60,
            "y":0,
            "color":13424242,
            "size":12,
            "realWidth":120,
            "leading":0,
            "multiline":true,
            "wordWrap":true
         });
         this.txtSilver = ComponentUtil.getTextField("0000000",this,{
            "x":190,
            "y":0,
            "color":16776960,
            "size":12,
            "leading":0,
            "realWidth":150,
            "multiline":true,
            "wordWrap":true
         });
         this.txtClanName.align = TextFormatAlign.CENTER;
         this.txtSilver.align = TextFormatAlign.CENTER;
      }
      
      public function update(data:Array) : void
      {
         this.txtRank.htmlText = data[0];
         this.txtClanName.htmlText = Model_heFu.repNameUseSerID(data[1]);
         this.txtSilver.htmlText = Utils.getGapNum(data[2]) + " 银两";
      }
   }
}

