package com.yiTian.view.modules.fishing
{
   import com.ui.controls.Button;
   import com.ui.controls.ScaleBitmap;
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.data.config.Enum_fishing;
   import com.yiTian.data.config.Enum_loaderType;
   import com.yiTian.data.config.Enum_resType;
   import com.yiTian.data.model.Model_bang;
   import com.yiTian.manager.CommandManager;
   import com.yiTian.manager.GameUnitManager;
   import com.yiTian.manager.LangConfig;
   import com.yiTian.manager.UIManager;
   import com.yiTian.net.message.cg.FishingCGMessage;
   import com.yiTian.view.Panel;
   import com.yiTian.view.modules.loading.View_loading;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   
   public class View_myFishMark extends Panel
   {
      
      private var titleBg:Bitmap;
      
      private var btn_refresh:Button;
      
      private var btn_toBag:Button;
      
      private var btn_toRiver:Button;
      
      private var fishMarkItemVec:Vector.<Child_fishMarkItem>;
      
      private var _count:int = 0;
      
      private var selectedSp:Sprite;
      
      public function View_myFishMark()
      {
         super();
      }
      
      override protected function initStaticView() : void
      {
         var back:ScaleBitmap = ComponentUtil.getScaleBitmap("Back1",[149,41,2,5],this,{
            "x":0,
            "y":0,
            "width":308,
            "height":377
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back2",[5,5,10,10],this,{
            "x":24,
            "y":40,
            "width":260,
            "height":300
         },Global.Img_Cdm);
         move = new Rectangle(0,0,back.width,38);
         CloseButton = ComponentUtil.getButton("","Button_Close",this,{
            "x":260,
            "y":6,
            "textColor":16184781
         },Global.Img_Cdm);
         this.btn_refresh = ComponentUtil.getButton(LangConfig.getWord("60109",6),"Button_Two64",this,{
            "x":210,
            "y":46,
            "textColor":16184781
         },Global.Img_Cdm);
         this.createItem(5);
         this.btn_toBag = ComponentUtil.getButton(LangConfig.getWord("29094",2),"Button_Four",this,{
            "x":65.75,
            "y":342.85,
            "textColor":16184781
         },Global.Img_Cdm);
         this.btn_toRiver = ComponentUtil.getButton(LangConfig.getWord("29095",2),"Button_Four",this,{
            "x":175.75,
            "y":342.85,
            "textColor":16184781
         },Global.Img_Cdm);
         this.selectedSp = new Sprite();
         this.selectedSp.graphics.beginFill(11184895,0.15);
         this.selectedSp.graphics.drawRect(0,0,250,50);
         this.selectedSp.graphics.endFill();
      }
      
      override protected function initDynamicView() : void
      {
         super.initDynamicView();
         this.btn_refresh.callBack = this.refreshClickHandle;
         this.btn_toBag.callBack = this.toBagClickHandle;
         this.btn_toRiver.callBack = this.toRiverClickHandle;
         addEventListener(MouseEvent.CLICK,this.clickHandle);
      }
      
      override public function resetPosition() : void
      {
         x = (Global.stage.stageWidth - width) / 2 + 50;
         y = (Global.stage.stageHeight - height) / 2 - 50;
      }
      
      override public function set visible(value:Boolean) : void
      {
         if(GameUnitManager.hero.partyId < 1 && Model_bang.partyType == 0)
         {
            this.btn_toRiver.enabled = false;
         }
         else
         {
            this.btn_toRiver.enabled = true;
         }
         if(value)
         {
            if(!Global.Fishing_Imgsdm)
            {
               this.load();
            }
            else if(!this.titleBg)
            {
               this.sourceComplete();
            }
         }
         else if(value == false)
         {
            if(Boolean(this.selectedSp) && Boolean(this.selectedSp.parent))
            {
               this.selectedSp.parent.removeChild(this.selectedSp);
            }
         }
         super.visible = value;
      }
      
      private function load() : void
      {
         var arr:Array = [];
         arr.push([Enum_fishing.FISHINGSOURCE,this.sourceComplete,LangConfig.getWord("20000",2),Enum_loaderType.SINGLE,Enum_resType.RES_URL]);
         View_loading.instance.load(arr,function():void
         {
            View_loading.instance.visible = false;
         });
      }
      
      private function sourceComplete(info:Object = null) : void
      {
         this.titleBg = ComponentUtil.getBitmap("Title_MyYuLan",this,{
            "x":74,
            "y":5
         },Global.Fishing_Imgsdm);
      }
      
      private function refreshClickHandle(evt:MouseEvent) : void
      {
         FishingCGMessage.CG_CHECK_FISH(Model_fishing.getInstance().currentRiverId,GameUnitManager.hero.id);
      }
      
      private function toBagClickHandle(evt:MouseEvent) : void
      {
         if(!this.selectedSp.parent || (this.selectedSp.parent as Child_fishMarkItem).isEmpty() == true)
         {
            UIManager.centerBroadcast.addMsg(LangConfig.getWord("23319",2));
         }
         else
         {
            if(CommandManager.get_bag_canUse() < 1)
            {
               UIManager.centerBroadcast.addMsg(LangConfig.getWord("29055",2));
               return;
            }
            FishingCGMessage.CG_FISH_TO_WHERE(Model_fishing.getInstance().currentRiverId,(this.selectedSp.parent as Child_fishMarkItem).itemIndex,1);
         }
         evt.stopPropagation();
      }
      
      private function toRiverClickHandle(evt:MouseEvent) : void
      {
         if(!this.selectedSp.parent || (this.selectedSp.parent as Child_fishMarkItem).isEmpty() == true)
         {
            UIManager.centerBroadcast.addMsg(LangConfig.getWord("23319",2));
         }
         else
         {
            FishingCGMessage.CG_FISH_TO_WHERE(Model_fishing.getInstance().currentRiverId,(this.selectedSp.parent as Child_fishMarkItem).itemIndex,2);
         }
         evt.stopPropagation();
      }
      
      public function set data(value:Array) : void
      {
         var index:int = 0;
         while(index < this._count)
         {
            this.fishMarkItemVec[index].data = value[index];
            index++;
         }
         this.fishMarkItemVec[0].dispatchEvent(new MouseEvent(MouseEvent.CLICK));
      }
      
      public function set data1AtVoid(value:Object) : void
      {
         var index:int = 0;
         while(index < this._count)
         {
            if(this.fishMarkItemVec[index].data == null)
            {
               this.fishMarkItemVec[index].data = value;
               this.fishMarkItemVec[index].dispatchEvent(new MouseEvent(MouseEvent.CLICK));
               return;
            }
            index++;
         }
      }
      
      private function createItem(count:int) : void
      {
         var posY1:Number = NaN;
         var offsetY:Number = NaN;
         var index:int = 0;
         var fmi:Child_fishMarkItem = null;
         this._count = count;
         posY1 = 75;
         offsetY = 52;
         this.fishMarkItemVec = new Vector.<Child_fishMarkItem>();
         index = 0;
         while(index < count)
         {
            fmi = new Child_fishMarkItem();
            fmi.x = 29;
            fmi.y = posY1 + offsetY * index;
            fmi.itemIndex = index + 1;
            addChild(fmi);
            this.fishMarkItemVec.push(fmi);
            index++;
         }
      }
      
      private function clickHandle(evt:MouseEvent) : void
      {
         var fmi:Child_fishMarkItem = null;
         evt.stopPropagation();
         if(evt.target is Child_fishMarkItem)
         {
            fmi = evt.target as Child_fishMarkItem;
            fmi.addChild(this.selectedSp);
            if(Boolean(GameUnitManager.hero.partyId))
            {
               this.btn_toRiver.enabled = fmi.data != 44604;
            }
            else if(Model_bang.partyType == 1)
            {
               this.btn_toRiver.enabled = true;
            }
            else
            {
               this.btn_toRiver.enabled = false;
            }
         }
      }
      
      public function resetChoose() : void
      {
         this.fishMarkItemVec[0].dispatchEvent(new MouseEvent(MouseEvent.CLICK));
      }
   }
}

