package com.yiTian.view.modules.guaji
{
   import com.ui.controls.Button;
   import com.utils.ColorConstant;
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.data.model.Model_heFu;
   import com.yiTian.manager.LangConfig;
   import com.yiTian.net.message.cg.GuaJiCGMessage;
   import com.yiTian.utils.HtmlUtil;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   
   public class Child_qysxListItem extends Sprite
   {
      
      private var tf_name:TextField;
      
      private var tf_sex:TextField;
      
      private var btn_sx:Button;
      
      private var bg:DisplayObject;
      
      private var _id:Number;
      
      public function Child_qysxListItem()
      {
         super();
         ComponentUtil.getScaleBitmap("Line",[29,1,2,0],this,{
            "x":0,
            "y":25,
            "width":164,
            "height":2
         },Global.Img_Cdm);
         this.tf_name = new TextField();
         this.tf_name.textColor = 8896312;
         this.tf_name.x = 6;
         this.tf_name.y = 4;
         this.tf_name.mouseEnabled = false;
         this.tf_name.height = 20;
         this.tf_name.width = 80;
         this.tf_sex = new TextField();
         this.tf_sex.textColor = 15235827;
         this.tf_sex.x = 91;
         this.tf_sex.y = 4;
         this.tf_sex.mouseEnabled = false;
         this.tf_sex.height = 20;
         this.tf_sex.width = 40;
         this.btn_sx = ComponentUtil.getButton(LangConfig.getWord("21126",2),"Button_Two",this,{
            "x":116,
            "y":0,
            "textColor":16184781
         },Global.Img_Cdm);
         addChild(this.tf_name);
         addChild(this.tf_sex);
         this.btn_sx.callBack = this.sxClickHandle;
      }
      
      public function set label(value:String) : void
      {
         if(value == LangConfig.getWord("21126",2))
         {
            this.btn_sx.enabled = true;
         }
         else
         {
            this.btn_sx.enabled = false;
         }
         this.btn_sx.label = value;
      }
      
      public function set data(value:Object) : void
      {
         if(value == null)
         {
            this._id = 0;
            this.tf_name.htmlText = "";
            this.tf_sex.htmlText = "";
            this.btn_sx.visible = false;
            return;
         }
         this._id = value.id;
         this.btn_sx.visible = true;
         value.name = Model_heFu.repNameByHero(value.name);
         this.tf_name.htmlText = HtmlUtil.font(value.name,ColorConstant.getColorStr(ColorConstant.ITEM_YELLOW),13);
         switch(value.sex)
         {
            case 1:
               this.tf_sex.htmlText = HtmlUtil.font(LangConfig.getWord("21130",2),ColorConstant.getColorStr(ColorConstant.BLUE),13);
               break;
            case 2:
               this.tf_sex.htmlText = HtmlUtil.font(LangConfig.getWord("21131",2),ColorConstant.getColorStr(ColorConstant.GREEN),13);
         }
      }
      
      public function get id() : Number
      {
         return this._id;
      }
      
      private function sxClickHandle(evt:MouseEvent) : void
      {
         GuaJiCGMessage.CG_SHUANGXIU_REQUEST(this._id);
      }
   }
}

