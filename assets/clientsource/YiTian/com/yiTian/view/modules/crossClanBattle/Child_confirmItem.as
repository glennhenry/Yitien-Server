package com.yiTian.view.modules.crossClanBattle
{
   import com.ui.controls.MyTextField;
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.data.model.Model_heFu;
   import com.yiTian.utils.Utils;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.text.TextFormatAlign;
   
   public class Child_confirmItem extends Sprite
   {
      
      private var textcityName:MyTextField;
      
      private var textOwnName:MyTextField;
      
      private var textOneName:MyTextField;
      
      private var textSecondName:MyTextField;
      
      private var textOneSilver:MyTextField;
      
      private var textSecondSilver:MyTextField;
      
      private var vo:CityVo;
      
      public function Child_confirmItem()
      {
         super();
         ComponentUtil.getScaleBitmap("List_BackD",[4,4,2,2],this,{
            "x":0,
            "y":0,
            "width":595,
            "height":42
         },Global.Img_Cdm);
         this.textcityName = ComponentUtil.getTextField("城池名称",this,{
            "x":24,
            "y":11,
            "color":13424242,
            "size":12,
            "leading":0,
            "realWidth":100
         });
         this.textOwnName = ComponentUtil.getTextField("帮会中文名称.S000",this,{
            "x":83,
            "y":11,
            "color":13424242,
            "size":12,
            "leading":0,
            "realWidth":140
         });
         this.textOneSilver = ComponentUtil.getTextField("0000000000银两",this,{
            "x":227,
            "y":11,
            "color":13424242,
            "size":12,
            "leading":0,
            "realWidth":130
         });
         this.textOneName = ComponentUtil.getTextField("帮会中文名称.S000",this,{
            "x":350,
            "y":11,
            "color":13424242,
            "size":12,
            "leading":0,
            "realWidth":140
         });
         ComponentUtil.getButton("竞拍","Button_TwoBule91",this,{
            "x":494,
            "y":7,
            "textColor":16184781,
            "callBack":this.onAuction
         },Global.Img_Cdm);
         this.textOwnName.align = TextFormatAlign.CENTER;
         this.textOneSilver.align = TextFormatAlign.CENTER;
         this.textOneName.align = TextFormatAlign.CENTER;
      }
      
      public function update(vo:CityVo) : void
      {
         this.vo = vo;
         this.textcityName.htmlText = vo.name;
         this.textOwnName.htmlText = Model_heFu.repNameUseSerID(vo.clanName);
         if(vo.secondSpendSilver == 0)
         {
            this.textOneName.htmlText = Model_heFu.repNameUseSerID(vo.maxSpendclanName);
            this.textOneSilver.htmlText = Utils.getGapNum(vo.maxSpendSilver + "") + "银两";
         }
         else
         {
            this.textOneName.htmlText = Model_heFu.repNameUseSerID(vo.secondSpendclanName);
            this.textOneSilver.htmlText = Utils.getGapNum(vo.secondSpendSilver + "") + "银两";
         }
      }
      
      private function onAuction(e:MouseEvent) : void
      {
         View_BattleConfirmPanel.instance.show(this.vo);
      }
   }
}

