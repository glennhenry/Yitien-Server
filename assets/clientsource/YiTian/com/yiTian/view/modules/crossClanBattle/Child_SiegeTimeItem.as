package com.yiTian.view.modules.crossClanBattle
{
   import com.ui.controls.Button;
   import com.ui.controls.MyTextField;
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.data.config.Enum_CrossType;
   import com.yiTian.data.model.Model_heFu;
   import com.yiTian.net.message.cg.CrossClanBattleCGMessage;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.text.TextFormatAlign;
   
   public class Child_SiegeTimeItem extends Sprite
   {
      
      private var textcityName:MyTextField;
      
      private var textOneame:MyTextField;
      
      private var textTwoName:MyTextField;
      
      private var textTime:MyTextField;
      
      private var btnEnter:Button;
      
      private var id:int;
      
      public function Child_SiegeTimeItem()
      {
         super();
         ComponentUtil.getScaleBitmap("List_BackD",[4,4,2,2],this,{
            "x":0,
            "y":0,
            "width":595,
            "height":42
         },Global.Img_Cdm);
         ComponentUtil.getBitmap("Text_VS",this,{
            "x":189,
            "y":8
         },Global.KFBang_CCdm);
         this.textcityName = ComponentUtil.getTextField("帮会中文",this,{
            "x":5,
            "y":11,
            "color":13424242,
            "size":12,
            "leading":0
         });
         this.textOneame = ComponentUtil.getTextField("帮会中文名称.S000",this,{
            "x":70,
            "y":11,
            "color":13424242,
            "size":12,
            "leading":0
         });
         this.textTwoName = ComponentUtil.getTextField("帮会中文名称.S000",this,{
            "x":238,
            "y":11,
            "color":13424242,
            "size":12,
            "leading":0
         });
         this.textTime = ComponentUtil.getTextField("0000-00-00 00:00 - 00:00",this,{
            "x":372,
            "y":11,
            "color":13424242,
            "size":12,
            "leading":0
         });
         this.btnEnter = ComponentUtil.getButton("进入战场","Button_TwoBule91",this,{
            "x":501,
            "y":7,
            "textColor":16184781
         },Global.Img_Cdm);
         this.btnEnter.addEventListener(MouseEvent.CLICK,this.onClick);
         this.textOneame.align = TextFormatAlign.CENTER;
         this.textTwoName.align = TextFormatAlign.CENTER;
      }
      
      public function update(id:int, cityName:String, nameOne:String, nameTwo:String, time:int) : void
      {
         this.id = id;
         this.textcityName.htmlText = cityName;
         this.textOneame.htmlText = Model_heFu.repNameUseSerID(nameOne);
         this.textTwoName.htmlText = Model_heFu.repNameUseSerID(nameTwo);
         this.textTime.htmlText = Model_CrossClanBattle.transDate(time);
      }
      
      private function onClick(e:MouseEvent) : void
      {
         if(Model_CrossClanBattle.notEnterScene() == true)
         {
            return;
         }
         Global.crossType = Enum_CrossType.CROSS_CLAN_BATTLE;
         CrossClanBattleCGMessage.CG_ENTER_BATTLE_SCENE(Global.crossType,this.id + "");
         Model_CrossClanBattle.currentCityId = this.id;
      }
   }
}

