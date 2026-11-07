package com.yiTian.view.modules.pet
{
   import com.ui.controls.Button;
   import com.ui.controls.MyTextField;
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.manager.LangConfig;
   import com.yiTian.view.Panel123;
   import flash.display.DisplayObject;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   
   public class PetDiPanel extends Panel123
   {
      
      private static var _instance:PetDiPanel;
      
      private var tipInfo:MyTextField;
      
      private var Button_OK:Button;
      
      public function PetDiPanel()
      {
         super();
         regResource("lang/ch/Pet_Imgs.swf","Pet_Imgsdm");
      }
      
      public static function get instance() : PetDiPanel
      {
         if(!_instance)
         {
            _instance = new PetDiPanel();
         }
         return _instance;
      }
      
      override protected function initUI2() : void
      {
         var back:DisplayObject = ComponentUtil.getScaleBitmap("Back1",[149,41,2,5],this,{
            "x":0,
            "y":0,
            "width":318,
            "height":187
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back2",[5,5,10,10],this,{
            "x":29,
            "y":45,
            "width":260,
            "height":130
         },Global.Img_Cdm);
         move = new Rectangle(0,0,back.width,40);
         CloseButton = ComponentUtil.getButton("","Button_Close",this,{
            "x":284,
            "y":6,
            "textColor":16184781
         },Global.Img_Cdm);
         CloseButton.addEventListener(MouseEvent.CLICK,this.close);
         this.Button_OK = ComponentUtil.getButton(LangConfig.getWord("10125",1),"Button_Orange",this,{
            "x":120,
            "y":125,
            "textColor":16184781
         },Global.Img_Cdm);
         this.Button_OK.addEventListener(MouseEvent.CLICK,function(e:MouseEvent):void
         {
            CloseButton.dispatchEvent(new MouseEvent(MouseEvent.CLICK));
         });
         ComponentUtil.getBitmap("Title_TJJN",this,{
            "x":84,
            "y":5
         },Global.Pet_Imgsdm);
         this.tipInfo = ComponentUtil.getTextField("",this,{
            "x":43,
            "y":71,
            "color":16184781,
            "size":12,
            "leading":0
         });
      }
      
      public function show() : void
      {
         this.visible = true;
      }
      
      override public function set visible(value:Boolean) : void
      {
         super.visible = value;
      }
      
      private function close(e:MouseEvent) : void
      {
         this.visible = false;
      }
      
      public function update(str:String) : void
      {
         this.tipInfo.htmlText = "恭喜成功开启第" + str + "个技能槽洗练<font color = \'#00ffff\'>特级技能</font>";
      }
      
      override public function resetPosition() : void
      {
         x = (Global.stage.stageWidth - width) / 2;
         y = (Global.stage.stageHeight - height) / 2;
      }
   }
}

