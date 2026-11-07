package com.yiTian.view.modules.actions
{
   import com.ui.controls.TabButton;
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.net.message.cg.ActionsCGMessage;
   import com.yiTian.scene.GameScene;
   import com.yiTian.utils.Singleton;
   import com.yiTian.view.Panel123;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   
   public class OldPlayerBack extends Panel123
   {
      
      private var fuli:Fuli;
      
      private var huiGui:HuiGui;
      
      private var teQuan:TeQuan;
      
      private var tabFuli:TabButton;
      
      private var tabHuiG:TabButton;
      
      private var tabTequan:TabButton;
      
      private var now:TabButton;
      
      public function OldPlayerBack()
      {
         super();
         regResource("lang/ch/OldPlayerHuiGui.swf","HuiGuidm");
         GameScene.uiLayer.addChild(this);
      }
      
      override protected function initUI2() : void
      {
         ComponentUtil.getScaleBitmap("Back1",[149,41,2,5],this,{
            "x":0,
            "y":0,
            "width":850,
            "height":504
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back4",[3,3,1,1],this,{
            "x":166,
            "y":40,
            "width":660,
            "height":454
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back4",[3,3,1,1],this,{
            "x":24,
            "y":40,
            "width":142,
            "height":454
         },Global.Img_Cdm);
         ComponentUtil.getBitmap("Title_HuiGui",this,{
            "x":345,
            "y":5
         },Global.HuiGuidm);
         move = new Rectangle(0,0,850,38);
         ComponentUtil.getButton("","Button_Close",this,{
            "x":818,
            "y":7,
            "callBack":function(e:MouseEvent):void
            {
               visible = false;
            }
         },Global.Img_Cdm);
         this.tabFuli = ComponentUtil.getTabButton("大侠福利","Button_ClassHG",this,{
            "x":34,
            "y":50,
            "textColor":10351261,
            "chooseColor":15138534
         },Global.HuiGuidm);
         this.tabFuli.addEventListener(MouseEvent.CLICK,function(e:MouseEvent):void
         {
            ActionsCGMessage.CG_OPEN_BACKPLAYER_PAN();
         });
         this.tabHuiG = ComponentUtil.getTabButton("大侠归来","Button_ClassHG",this,{
            "x":34,
            "y":99,
            "textColor":10351261,
            "chooseColor":15138534
         },Global.HuiGuidm);
         this.tabHuiG.addEventListener(MouseEvent.CLICK,function(e:MouseEvent):void
         {
            ActionsCGMessage.CG_CHONGZHI_PAN();
         });
         this.tabTequan = ComponentUtil.getTabButton("大侠特权","Button_ClassHG",this,{
            "x":34,
            "y":148,
            "textColor":10351261,
            "chooseColor":15138534
         },Global.HuiGuidm);
         this.tabTequan.addEventListener(MouseEvent.CLICK,function(e:MouseEvent):void
         {
            ActionsCGMessage.CG_TEQUAN_PAN();
         });
      }
      
      public function showView(time:String, noDenglu:int, denglu:int, status1:int, status2:int, status3:int, _viewType:int = 1, chongZhi:int = 0, status4:int = 0, status5:int = 0) : void
      {
         if(Boolean(this.huiGui))
         {
            this.huiGui.visible = false;
         }
         if(Boolean(this.fuli))
         {
            this.fuli.visible = false;
         }
         if(Boolean(this.teQuan))
         {
            this.teQuan.visible = false;
         }
         if(_viewType == 1)
         {
            if(!this.fuli)
            {
               this.fuli = Singleton.getInstance(Fuli) as Fuli;
               addChild(this.fuli);
               ComponentUtil.setPropertie(this.fuli,{
                  "x":0,
                  "y":0
               });
               this.fuli.loadComp(function():void
               {
                  visible = true;
                  fuli.update(time,noDenglu,denglu,status1,status2,status3);
               });
            }
            else
            {
               this.fuli.visible = true;
            }
            if(Boolean(this.now))
            {
               this.now.choose = false;
            }
            this.tabFuli.choose = true;
            this.now = this.tabFuli;
         }
         else if(_viewType == 2)
         {
            if(!this.huiGui)
            {
               this.huiGui = Singleton.getInstance(HuiGui) as HuiGui;
               addChild(this.huiGui);
               ComponentUtil.setPropertie(this.huiGui,{
                  "x":0,
                  "y":0
               });
               this.huiGui.loadComp(function():void
               {
                  huiGui.update(status1,status2,status3,chongZhi,time);
               });
            }
            else
            {
               this.huiGui.update(status1,status2,status3,chongZhi,time);
               this.huiGui.visible = true;
            }
            if(Boolean(this.now))
            {
               this.now.choose = false;
            }
            this.tabHuiG.choose = true;
            this.now = this.tabHuiG;
         }
         else if(_viewType == 3)
         {
            if(!this.teQuan)
            {
               this.teQuan = Singleton.getInstance(TeQuan) as TeQuan;
               addChild(this.teQuan);
               ComponentUtil.setPropertie(this.teQuan,{
                  "x":0,
                  "y":0
               });
               this.teQuan.loadComp(function():void
               {
                  teQuan.update([status1,status2,status3,status4,status5],chongZhi,time);
               });
            }
            else
            {
               this.teQuan.update([status1,status2,status3,status4,status5],chongZhi,time);
               this.teQuan.visible = true;
            }
            if(Boolean(this.now))
            {
               this.now.choose = false;
            }
            this.tabTequan.choose = true;
            this.now = this.tabTequan;
         }
         if(!visible)
         {
            visible = true;
         }
      }
      
      public function updateSecc(bType:int, sType:int) : void
      {
         if(bType == 1)
         {
            this.fuli.updateSecc(sType);
         }
         else if(bType == 2)
         {
            this.huiGui.updateSecc(sType);
         }
         else if(bType == 3)
         {
            this.teQuan.updateSecc(sType);
         }
      }
      
      override public function resetPosition() : void
      {
         x = (Global.stage.stageWidth - width) / 2;
         y = (Global.stage.stageHeight - height) / 2;
      }
   }
}

