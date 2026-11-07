package com.yiTian.view.modules.treasureBowl
{
   import com.ui.controls.MyTextField;
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.data.model.Model_treasureBowl;
   import com.yiTian.manager.LangConfig;
   import com.yiTian.manager.UIManager;
   import com.yiTian.net.message.cg.TreasureCGMessage;
   import com.yiTian.utils.Utils;
   import com.yiTian.view.Panel;
   import com.yiTian.view.modules.mainMenu.MicroButton;
   import flash.display.Bitmap;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   
   public class View_treasureBowl extends Panel
   {
      
      private var secretPlaceBtn:MicroButton;
      
      private var describe:MyTextField;
      
      private var todayJoinCount:MyTextField;
      
      private var todayMondy:MyTextField;
      
      private var todayRank:MyTextField;
      
      private var myConsume:MyTextField;
      
      private var roles:Vector.<TreasureBowlRoleItem>;
      
      private var title:Bitmap;
      
      private var headBg:Bitmap;
      
      private var isLoadCom:Boolean;
      
      public function View_treasureBowl()
      {
         super();
      }
      
      override protected function initStaticView() : void
      {
         ComponentUtil.getScaleBitmap("Back1",[149,41,2,5],this,{
            "x":0,
            "y":0,
            "width":668,
            "height":470
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back2",[5,5,10,10],this,{
            "x":24,
            "y":40,
            "width":620,
            "height":420
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back3",[4,4,1,1],this,{
            "x":34,
            "y":249,
            "width":600,
            "height":200
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back_Num",[3,3,3,3],this,{
            "x":474,
            "y":259,
            "width":150,
            "height":180
         },Global.Img_Cdm);
         move = new Rectangle(0,0,650,50);
         this.CloseButton = ComponentUtil.getButton("","Button_Close",this,{
            "x":634,
            "y":6,
            "textColor":16184781
         },Global.Img_Cdm);
         this.describe = ComponentUtil.getTextField("",this,{
            "x":34,
            "y":184,
            "color":14662240,
            "size":12
         });
         this.describe.multiline = true;
         this.describe.htmlText = LangConfig.getWord("70001",7);
         ComponentUtil.getTextField(LangConfig.getWord("70013",7),this,{
            "x":44,
            "y":259,
            "color":11904647
         });
         this.todayJoinCount = ComponentUtil.getTextField("",this,{
            "x":133,
            "y":259,
            "color":14662240
         });
         ComponentUtil.getTextField(LangConfig.getWord("70014",7),this,{
            "x":44,
            "y":281,
            "color":11904647
         });
         this.todayMondy = ComponentUtil.getTextField("",this,{
            "x":145,
            "y":281,
            "color":14662240
         });
         ComponentUtil.getTextField(LangConfig.getWord("70015",7),this,{
            "x":44,
            "y":303,
            "color":11904647
         });
         ComponentUtil.getTextField(LangConfig.getWord("70016",7),this,{
            "x":484,
            "y":270,
            "color":11904647
         });
         this.secretPlaceBtn = new MicroButton("MiJing");
         this.secretPlaceBtn.addEventListener(MouseEvent.CLICK,this.onClickSecretPlaceBtn);
         this.secretPlaceBtn.x = 550 - 23;
         this.secretPlaceBtn.y = 350;
         this.addChild(this.secretPlaceBtn);
         this.myConsume = ComponentUtil.getTextField("",this,{
            "x":514,
            "y":289,
            "color":16764206,
            "size":14
         });
         this.addRoles();
      }
      
      private function onClickSecretPlaceBtn(evt:MouseEvent) : void
      {
         UIManager.special_btn.smsHandle();
         this.visible = false;
      }
      
      private function addRoles() : void
      {
         var role:TreasureBowlRoleItem = null;
         this.roles = new Vector.<TreasureBowlRoleItem>();
         var i:uint = 0;
         while(i < 3)
         {
            role = new TreasureBowlRoleItem();
            this.addChild(role);
            this.roles.push(role);
            role.x = 45 + i * 144;
            role.y = 325;
            i++;
         }
      }
      
      override public function set visible(value:Boolean) : void
      {
         super.visible = value;
         if(value)
         {
            if(!this.title)
            {
               this.title = new Bitmap();
               Utils.loadTitle("lang/ch/GuoQingHuoDong_Imgs.swf","Title_JuBaoPen",this.title,{
                  "x":254,
                  "y":5
               },this,this.onLoadCom);
            }
            if(!this.headBg)
            {
               this.headBg = new Bitmap();
               Utils.loadTitle("lang/ch/GuoQingHuoDong_Imgs.swf","JBP_Img",this.headBg,{
                  "x":34,
                  "y":50
               },this);
            }
            if(this.isLoadCom)
            {
               TreasureCGMessage.cg_treasure_bowl_data();
            }
         }
      }
      
      public function update() : void
      {
         this.todayJoinCount.text = Model_treasureBowl.instace.todayPlayerCount.toString();
         this.todayMondy.text = Model_treasureBowl.instace.todayMoney.toString() + LangConfig.getWord("70017",7);
         this.myConsume.text = Model_treasureBowl.instace.myConsume.toString() + LangConfig.getWord("70018",7);
         var i:uint = 0;
         while(i < this.roles.length)
         {
            this.roles[i].uqdate(i);
            i++;
         }
      }
      
      private function onLoadCom() : void
      {
         this.isLoadCom = true;
         TreasureCGMessage.cg_treasure_bowl_data();
      }
      
      override public function resetPosition() : void
      {
         x = (Global.stage.stageWidth - this.width) / 2;
         y = (Global.stage.stageHeight - this.height) / 2;
      }
   }
}

