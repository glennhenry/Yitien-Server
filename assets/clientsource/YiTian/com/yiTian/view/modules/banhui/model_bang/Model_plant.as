package com.yiTian.view.modules.banhui.model_bang
{
   import com.yiTian.Global;
   import com.yiTian.gameUnit.magic.Effect;
   import com.yiTian.manager.EffectManager;
   import com.yiTian.manager.UIManager;
   import com.yiTian.view.modules.mainUIBtnContainer.Enum_mainUIBtn_hide;
   import com.yiTian.view.modules.mainUIBtnContainer.MainUIBtn;
   import flash.events.MouseEvent;
   
   public class Model_plant
   {
      
      private static var _instance:Model_plant;
      
      private var _plantBtn:MainUIBtn;
      
      private var plantEff:Effect;
      
      public function Model_plant()
      {
         super();
      }
      
      public static function get instance() : Model_plant
      {
         if(!_instance)
         {
            _instance = new Model_plant();
         }
         return _instance;
      }
      
      public function show_plant_btn(hasEff:Boolean) : void
      {
         if(!this.plantBtn)
         {
            this._plantBtn = new MainUIBtn("resource/image/bang/bhzz.png",null,null,null,true);
            this.plantBtn.addEventListener(MouseEvent.CLICK,this.plantHandle);
         }
         if(UIManager.mainUiBtnContainer.hasBTN(this.plantBtn) == true)
         {
            return;
         }
         if(hasEff)
         {
            if(!this.plantEff)
            {
               this.plantEff = EffectManager.addEffect("35343",this.plantBtn,1000,32,29,true);
            }
            else
            {
               EffectManager.removeEffect(this.plantEff);
               this.plantEff = null;
            }
         }
         UIManager.mainUiBtnContainer.addBTN(this.plantBtn);
         Global.control.sendNotification(Enum_mainUIBtn_hide.CHANGE_STATUS,[Enum_mainUIBtn_hide.BangHuiZhongZhi,1]);
      }
      
      public function remove_plant_btn() : void
      {
         UIManager.mainUiBtnContainer.removeBTN(this.plantBtn);
         Global.control.sendNotification(Enum_mainUIBtn_hide.CHANGE_STATUS,[Enum_mainUIBtn_hide.BangHuiZhongZhi,2]);
         if(Boolean(this.plantEff))
         {
            EffectManager.removeEffect(this.plantEff);
            this.plantEff = null;
         }
      }
      
      private function plantHandle(e:MouseEvent = null) : void
      {
         UIManager.bangPlant.visible = !UIManager.bangPlant.visible;
      }
      
      public function get plantBtn() : MainUIBtn
      {
         return this._plantBtn;
      }
   }
}

