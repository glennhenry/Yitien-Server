package com.yiTian.view.modules.keJu
{
   import com.ui.controls.MyTextField;
   import com.utils.ComponentUtil;
   import com.yiTian.gameUnit.magic.Effect;
   import com.yiTian.manager.EffectManager;
   import com.yiTian.manager.LangConfig;
   import com.yiTian.manager.UIManager;
   import com.yiTian.net.message.cg.KejuCGMessage;
   import com.yiTian.utils.HtmlUtil;
   import com.yiTian.view.modules.mainUIBtnContainer.MainUIBtn;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   
   public class Keju_XSBtn
   {
      
      private static var _instance:Keju_XSBtn;
      
      private var content:MyTextField;
      
      private var btnEff:Effect;
      
      private var baseView:Sprite;
      
      public function Keju_XSBtn()
      {
         super();
         this.init();
      }
      
      public static function get instance() : Keju_XSBtn
      {
         if(!_instance)
         {
            _instance = new Keju_XSBtn();
         }
         return _instance;
      }
      
      private function init() : void
      {
         this.baseView = new Sprite();
         var kejuBtn:MainUIBtn = new MainUIBtn("resource/image/keju/keju_1.png");
         this.baseView.addChild(kejuBtn);
         this.content = ComponentUtil.getTextField("",this.baseView,{
            "y":kejuBtn.y + kejuBtn.height + 3,
            "x":-7
         });
         this.content.align = "center";
         kejuBtn.addEventListener(MouseEvent.CLICK,this.onClick);
      }
      
      public function show() : void
      {
         UIManager.mainUiBtnContainer.addBTN(this.baseView);
      }
      
      public function canJoin(value:Boolean) : void
      {
         if(value)
         {
            this.content.htmlText = HtmlUtil.bold(HtmlUtil.font(LangConfig.getWord("80021",8),"#FFFF00",12));
         }
         else
         {
            this.content.htmlText = "";
         }
         this.show_btn(value);
      }
      
      public function hide() : void
      {
         UIManager.mainUiBtnContainer.removeBTN(this.baseView);
         this.content.htmlText = "";
         this.show_btn(false);
      }
      
      private function onClick(event:MouseEvent) : void
      {
         KejuCGMessage.CG_GETKEJU_NPC();
         this.show_btn(false);
      }
      
      public function show_btn(hasEff:Boolean) : void
      {
         if(hasEff)
         {
            if(!this.btnEff)
            {
               this.btnEff = EffectManager.addEffect("35343",this.baseView,1000,32,29,true);
            }
         }
         else
         {
            if(!this.btnEff)
            {
               return;
            }
            EffectManager.removeEffect(this.btnEff);
            this.btnEff = null;
         }
      }
   }
}

