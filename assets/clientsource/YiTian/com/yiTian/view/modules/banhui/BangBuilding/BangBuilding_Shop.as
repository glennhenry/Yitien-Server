package com.yiTian.view.modules.banhui.BangBuilding
{
   import com.ui.controls.Button;
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.data.model.Model_bang;
   import com.yiTian.data.vo.Vo_BangUpdateInfo;
   import com.yiTian.manager.LangConfig;
   import com.yiTian.manager.TipManager;
   import com.yiTian.manager.UIManager;
   import com.yiTian.net.message.cg.BangCGMessage;
   import com.yiTian.utils.Utils;
   import flash.display.Bitmap;
   import flash.display.DisplayObjectContainer;
   import flash.events.MouseEvent;
   
   public class BangBuilding_Shop extends BangBuilding_Base
   {
      
      private var btn_enterShop:Button;
      
      private var btn_update:Button;
      
      private var bg:Bitmap;
      
      public function BangBuilding_Shop(parent:DisplayObjectContainer, proper:Object)
      {
         super(parent,proper);
         this.btn_enterShop = ComponentUtil.getButton(LangConfig.getWord("29164",2),"Button_Two",_btnContainer,null,Global.Img_Cdm);
         this.btn_enterShop.visible = false;
         this.btn_update = ComponentUtil.getButton(LangConfig.getWord("29163",2),"Button_Two",_btnContainer,null,Global.Img_Cdm);
         this.bg = Utils.getLoadBitmap("resource/image/myPath/" + "mapShop.png",this.bg);
         viewer = this.bg;
         setLabelPos(-4,-23);
         this.btn_update.addEventListener(MouseEvent.MOUSE_OVER,this.updateMouseOverHandle);
         this.btn_update.callBack = this.updateClickHandle;
         buildingType = 3;
      }
      
      private function updateMouseOverHandle(evt:MouseEvent) : void
      {
         var vo:Vo_BangUpdateInfo = null;
         evt.stopPropagation();
         if(level == 10)
         {
            TipManager.update(LangConfig.getWord("22631",2));
         }
         else
         {
            vo = new Vo_BangUpdateInfo();
            vo.mainStr = LangConfig.getWord("22641",2,buildingName,(level + 1).toString());
            vo.buildConditionStr = LangConfig.getWord("29070",2);
            vo.needSource = Enum_BangMap.BarUpdateCost[level];
            vo.currentSource = Model_bang.partyInfo.party_forturn;
            TipManager.update(vo);
         }
      }
      
      private function enterShopClickHandle(evt:MouseEvent) : void
      {
         BangCGMessage.CG_ENTER_BUILDING(3);
         UIManager.bang_store.visible = true;
      }
      
      private function updateClickHandle(evt:MouseEvent) : void
      {
         if(Model_bang.partyInfo.party_position > 2)
         {
            UIManager.centerBroadcast.addMsg(LangConfig.getWord("22633",2));
            return;
         }
         if(Model_bang.partyInfo.party_forturn < Enum_BangMap.BarUpdateCost[level])
         {
            UIManager.centerBroadcast.addMsg(LangConfig.getWord("22636",2));
            return;
         }
         if(level >= Model_bang.bangBuildingLevel[0])
         {
            UIManager.centerBroadcast.addMsg(Enum_BangMap.BubbleTipText[4]);
            return;
         }
         if(level >= 10)
         {
            UIManager.centerBroadcast.addMsg(Enum_BangMap.BubbleTipText[0]);
         }
         else
         {
            BangCGMessage.CG_UPDATE_BUILDING(buildingType);
         }
      }
   }
}

