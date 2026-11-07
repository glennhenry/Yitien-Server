package com.yiTian.view.modules.worldLevel
{
   import com.ui.controls.Button;
   import com.ui.controls.MyTextField;
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.data.vo.Vo_worldLevRewItem;
   import com.yiTian.manager.GameUnitManager;
   import com.yiTian.manager.LangConfig;
   import com.yiTian.manager.TipManager;
   import com.yiTian.manager.UIManager;
   import com.yiTian.net.message.cg.WorldLevCGMessage;
   import com.yiTian.utils.ComboTweenStep;
   import com.yiTian.utils.Utils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.text.TextFormatAlign;
   
   public class WorldLvRewItem extends Sprite
   {
      
      private static var moneyTip:Array;
      
      private static var moneyData:Array = [0,10,50,100];
      
      private var bmContainer:Sprite;
      
      private var bm:Bitmap;
      
      private var moneyTf:MyTextField;
      
      private var getRewBtn:Button;
      
      private var _index:int;
      
      private var _iconBm:Bitmap;
      
      private var itemType:int;
      
      public function WorldLvRewItem(index:int)
      {
         moneyTip = [LangConfig.getWord("60357",6),LangConfig.getWord("60358",6),LangConfig.getWord("60359",6),LangConfig.getWord("60360",6)];
         super();
         this._index = index;
         this.bmContainer = new Sprite();
         addChild(this.bmContainer);
         this.bm = new Bitmap();
         this.bmContainer.addChild(this.bm);
         this.moneyTf = ComponentUtil.getTextField(moneyTip[index],this,{
            "x":0,
            "y":82,
            "color":16764206,
            "size":12,
            "leading":0,
            "realWidth":64
         });
         this.moneyTf.align = TextFormatAlign.CENTER;
         this.getRewBtn = ComponentUtil.getButton(LangConfig.getWord("60361",6),"Button_Two64",this,{
            "x":0,
            "y":56,
            "textColor":16184781
         },Global.Img_Cdm);
         this.getRewBtn.addEventListener(MouseEvent.CLICK,this.click);
         this._iconBm = new Bitmap();
         this._iconBm.x = 14;
         this._iconBm.y = 3;
         addChild(this._iconBm);
      }
      
      public function set data(item:Vo_worldLevRewItem) : void
      {
         this.itemType = item.type;
         TipManager.bind(this.bmContainer,(item.type == 1 ? LangConfig.getWord("60238",6) : LangConfig.getWord("60267",6)) + "：" + item.value);
         if(item.status == 1)
         {
            this.getRewBtn.label = LangConfig.getWord("60361",6);
            this.getRewBtn.enabled = true;
         }
         else
         {
            this.getRewBtn.label = LangConfig.getWord("60351",6);
            this.getRewBtn.enabled = false;
         }
         Utils.getLoadBitmap("resource/image/iconBg/open.png",this.bm,{
            "x":11,
            "y":0
         });
         Utils.getLoadBitmap("resource/image/icon/" + (item.type == 1 ? 46383 : 46382) + ".png",this._iconBm);
      }
      
      private function click(e:MouseEvent) : void
      {
         if(GameUnitManager.hero.money < int(moneyData[this._index]))
         {
            UIManager.centerBroadcast.addMsg(LangConfig.getWord("60362",6));
            return;
         }
         WorldLevCGMessage.CG_WL_REWARD(this._index);
         if(this.itemType == 1)
         {
            ComboTweenStep.toBag(this._iconBm);
         }
      }
   }
}

