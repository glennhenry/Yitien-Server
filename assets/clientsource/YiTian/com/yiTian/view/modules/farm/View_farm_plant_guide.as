package com.yiTian.view.modules.farm
{
   import com.ui.controls.Button;
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.data.model.Model_farm;
   import com.yiTian.data.vo.Vo_farm_guide;
   import com.yiTian.manager.FarmGuideManager;
   import com.yiTian.manager.LangConfig;
   import com.yiTian.manager.UIManager;
   import com.yiTian.net.message.cg.FarmCGMessage;
   import com.yiTian.view.View_UI_modal;
   import flash.events.MouseEvent;
   
   public class View_farm_plant_guide extends View_UI_modal
   {
      
      private var gobtn:Button;
      
      public function View_farm_plant_guide()
      {
         super();
      }
      
      override protected function initStaticView() : void
      {
         ComponentUtil.getScaleBitmap("Back1",[149,41,2,5],this,{
            "x":0,
            "y":0,
            "width":464,
            "height":300
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back2",[5,5,10,10],this,{
            "x":24,
            "y":40,
            "width":416,
            "height":250
         },Global.Img_Cdm);
         ComponentUtil.getTextField(LangConfig.getWord("217",9),this,{
            "x":34,
            "y":50,
            "color":16764206,
            "size":12,
            "leading":0
         });
         ComponentUtil.getTextField("   " + LangConfig.getWord("219",9),this,{
            "x":34,
            "y":75,
            "color":14404503,
            "size":12,
            "leading":4
         });
         ComponentUtil.getTextField(LangConfig.getWord("220",9),this,{
            "x":34,
            "y":75 + 18,
            "color":14404503,
            "size":12,
            "leading":4
         });
         this.gobtn = ComponentUtil.getButton(LangConfig.getWord("218",9),"Button_282",this,{
            "x":96,
            "y":239,
            "textColor":16777215
         },Global.ShanZhuang_Imgsdm);
         this.gobtn.addEventListener(MouseEvent.CLICK,this.onClickGobtn);
         ComponentUtil.getBitmap("Title_YinDao",this,{
            "x":152,
            "y":5
         },Global.ShanZhuang_Imgsdm);
         ComponentUtil.getBitmap("Img_YinDao01",this,{
            "x":30,
            "y":125
         },Global.ShanZhuang_Imgsdm);
      }
      
      private function onClickGobtn(evt:MouseEvent = null) : void
      {
         Model_farm.instace.guide_plant_flag = false;
         FarmCGMessage.cg_farm_guide(1);
         this.visible = false;
         UIManager.farm.visible = true;
         FarmGuideManager.instance.setGuide(Vo_farm_guide.type_guide_plant,6);
         FarmGuideManager.instance.nextStep(1);
      }
      
      override public function set visible(value:Boolean) : void
      {
         super.visible = value;
      }
   }
}

