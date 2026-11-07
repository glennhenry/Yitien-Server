package com.yiTian.view.modules.pet
{
   import com.ui.controls.Button;
   import com.ui.controls.ComboBox;
   import com.ui.controls.MyTextField;
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.manager.GameUnitManager;
   import com.yiTian.manager.LangConfig;
   import com.yiTian.manager.UIManager;
   import com.yiTian.net.message.cg.PetCGMessage;
   import com.yiTian.view.Panel;
   import flash.display.DisplayObject;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   
   public class JiNengShuaXinPanel extends Panel
   {
      
      private var curNum:int;
      
      private var cbbSelectNum:ComboBox;
      
      private var txtYuanBao:MyTextField;
      
      private var btnShuaXin:Button;
      
      private var _index:int;
      
      public function JiNengShuaXinPanel()
      {
         super();
      }
      
      override protected function initStaticView() : void
      {
         var back:DisplayObject = ComponentUtil.getScaleBitmap("Back1",[149,41,2,5],this,{
            "x":0,
            "y":0,
            "width":318,
            "height":185
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back2",[5,5,10,10],this,{
            "x":24,
            "y":40,
            "width":270,
            "height":135
         },Global.Img_Cdm);
         ComponentUtil.getBitmap("Title_WXPrompt",this,{
            "x":79,
            "y":5
         },Global.Img_Cdm);
         move = new Rectangle(0,0,back.width,35);
         CloseButton = ComponentUtil.getButton("","Button_Close",this,{
            "x":284,
            "y":6,
            "textColor":16184781
         },Global.Img_Cdm);
         ComponentUtil.getTextField(LangConfig.getWord("10050",1),this,{
            "x":71,
            "y":63,
            "color":11904647,
            "size":12,
            "leading":0
         });
         ComponentUtil.getTextField(LangConfig.getWord("10051",1),this,{
            "x":71,
            "y":98,
            "color":11904647,
            "size":12,
            "leading":0
         });
         this.txtYuanBao = ComponentUtil.getTextField("120",this,{
            "x":165,
            "y":98,
            "color":14662240,
            "size":12,
            "leading":0
         });
         this.btnShuaXin = ComponentUtil.getButton(LangConfig.getWord("10052",1),"Button_Orange",this,{
            "x":131,
            "y":132,
            "textColor":16184781
         },Global.Img_Cdm);
         this.btnShuaXin.addEventListener(MouseEvent.CLICK,this.onClick);
         this.cbbSelectNum = new ComboBox([["1",1],["2",2],["3",3],["4",4],["5",5],["6",6]],function(value:Object):void
         {
            curNum = int(value);
            txtYuanBao.text = String(curNum * 20);
         },70,"Button_PageDown","ComboBox_background");
         addChild(this.cbbSelectNum);
         this.cbbSelectNum.x = 169;
         this.cbbSelectNum.y = 63;
         this.curNum = 6;
         this.cbbSelectNum.defaultText = "6";
      }
      
      protected function onClick(e:MouseEvent) : void
      {
         var m:int = GameUnitManager.hero.money;
         if(m < int(this.txtYuanBao.text))
         {
            UIManager.centerBroadcast.addMsg(LangConfig.getWord("10044",1));
         }
         else
         {
            PetCGMessage.CG_PET_JINGNENG_XILIAN(this.curNum,this._index);
            this.visible = false;
         }
      }
      
      public function show(value:int) : void
      {
         this._index = value;
         visible = true;
      }
      
      override public function resetPosition() : void
      {
         x = (Global.stage.stageWidth - width) / 2;
         y = (Global.stage.stageHeight - height) / 2;
      }
   }
}

