package com.yiTian.view.modules.fishing
{
   import com.ui.controls.MyTextField;
   import com.utils.ComponentUtil;
   import com.utils.Util;
   import com.yiTian.Global;
   import com.yiTian.data.config.Enum_fishing;
   import com.yiTian.data.config.Enum_loaderType;
   import com.yiTian.data.config.Enum_resType;
   import com.yiTian.data.model.Model_heFu;
   import com.yiTian.manager.GameUnitManager;
   import com.yiTian.manager.LangConfig;
   import com.yiTian.manager.UIManager;
   import com.yiTian.net.message.cg.FishingCGMessage;
   import com.yiTian.view.modules.loading.View_loading;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.text.TextFieldAutoSize;
   
   public class Child_fishingPlayerItem extends Sprite
   {
      
      private var _vo:Object;
      
      private var bm_basket:Bitmap;
      
      private var tf_name:MyTextField;
      
      public function Child_fishingPlayerItem()
      {
         super();
         this.init();
      }
      
      public function load() : void
      {
         if(!Global.Fishing_Imgsdm)
         {
            this.onload();
         }
         else if(!this.bm_basket)
         {
            this.sourceComplete();
         }
      }
      
      private function onload() : void
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
         if(Boolean(info))
         {
            Global.Fishing_Imgsdm = info.applicationDomain;
         }
         this.bm_basket = ComponentUtil.getBitmap("YuLan",this,null,Global.Fishing_Imgsdm);
         this.bm_basket.x = 25;
         this.bm_basket.y = 4;
      }
      
      private function init() : void
      {
         this.tf_name = ComponentUtil.getTextField("",this,{
            "x":6,
            "y":51,
            "height":20,
            "realWidth":86.5,
            "width":86.5
         });
         this.tf_name.autoSize = TextFieldAutoSize.CENTER;
         this.tf_name.text = LangConfig.getWord("23318",2);
         buttonMode = true;
         addEventListener(MouseEvent.CLICK,this.clickHandle);
         this.vo = null;
      }
      
      public function set vo(value:Object) : void
      {
         if(Boolean(value))
         {
            this._vo = value;
            this.tf_name.text = Model_heFu.repNameByHero(value.name);
            if(Boolean(this.bm_basket))
            {
               this.bm_basket.filters = [];
            }
         }
         else
         {
            this._vo = null;
            this.tf_name.text = LangConfig.getWord("23318",2);
            if(Boolean(this.bm_basket))
            {
               this.bm_basket.filters = Util.disabled;
            }
         }
      }
      
      private function clickHandle(evt:MouseEvent) : void
      {
         if(Boolean(this._vo) && Boolean(this._vo.id))
         {
            if(GameUnitManager.hero.id == this._vo.id)
            {
               if(UIManager.myFishMark.visible == true)
               {
                  UIManager.myFishMark.visible = false;
               }
               else
               {
                  FishingCGMessage.CG_CHECK_FISH(Model_fishing.getInstance().currentRiverId,this._vo.id);
               }
            }
            else if(UIManager.otherFishMark.id == this._vo.id && UIManager.otherFishMark.visible)
            {
               UIManager.otherFishMark.visible = false;
            }
            else
            {
               FishingCGMessage.CG_CHECK_FISH(Model_fishing.getInstance().currentRiverId,this._vo.id);
            }
         }
      }
   }
}

