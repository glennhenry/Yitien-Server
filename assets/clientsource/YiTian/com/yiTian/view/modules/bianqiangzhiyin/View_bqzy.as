package com.yiTian.view.modules.bianqiangzhiyin
{
   import com.ui.constants.ScrollAutoType;
   import com.ui.containers.list.List;
   import com.ui.controls.Button;
   import com.ui.controls.MyTextField;
   import com.ui.controls.ScaleBitmap;
   import com.ui.controls.ScrollBar;
   import com.ui.controls.TabButton;
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.command.Enum_MsgType;
   import com.yiTian.data.model.Model_bag;
   import com.yiTian.data.model.Model_bqzy;
   import com.yiTian.manager.GameUnitManager;
   import com.yiTian.manager.UIManager;
   import com.yiTian.net.message.cg.WingCGMessage;
   import com.yiTian.net.message.cg.WuxingCGMessage;
   import com.yiTian.scene.GameScene;
   import com.yiTian.utils.Singleton;
   import com.yiTian.utils.Tween;
   import com.yiTian.utils.Utils;
   import com.yiTian.view.MainUIBase;
   import com.yiTian.view.modules.boatChall.BoatManager;
   import com.yiTian.view.modules.horse.View_horsePanel;
   import com.yiTian.view.modules.mainUIBtnContainer.MainUIBtn;
   import com.yiTian.view.modules.panel.Enum_panel_cast;
   import com.yiTian.view.modules.quest.View_quest_trace;
   import com.yiTian.view.modules.shenBing.ShenBingUtil;
   import com.yiTian.view.modules.wing.View_wing_menu;
   import com.yiTian.view.modules.wuXing.WuXingMter;
   import com.yiTian.view.modules.wuXing.WuxingPan;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   
   public class View_bqzy extends MainUIBase
   {
      
      public static var thisH:int;
      
      private static var _instance:View_bqzy;
      
      private var list:List;
      
      private var Button_PageUp:Button;
      
      private var con:Sprite;
      
      private var content:Sprite;
      
      private var b1:ScaleBitmap;
      
      private var moveBtn:Button;
      
      private var isRuning:Boolean;
      
      private var isEnd:Boolean;
      
      public function View_bqzy()
      {
         super();
      }
      
      public static function get instance() : View_bqzy
      {
         if(!_instance)
         {
            _instance = new View_bqzy();
         }
         return _instance;
      }
      
      override protected function initStaticView() : void
      {
         var bm:Bitmap = null;
         Model_bqzy.Init = true;
         this.content = new Sprite();
         addChild(this.content);
         var b:ScaleBitmap = ComponentUtil.getScaleBitmap("Back2",[5,5,10,10],this.content,{
            "x":0,
            "y":0,
            "width":239,
            "height":24
         },Global.Img_Cdm);
         this.b1 = ComponentUtil.getScaleBitmap("Back2",[5,5,10,10],this.content,{
            "x":0,
            "y":24,
            "width":239,
            "height":80
         },Global.Img_Cdm);
         this.moveBtn = ComponentUtil.getButton("","Button_MissionM",this.content,{
            "x":2,
            "y":2,
            "textColor":16771436
         },Global.Img_Cdm);
         bm = new Bitmap();
         bm.x = 22;
         bm.y = 2;
         this.content.addChild(bm);
         Utils.getLoadBitmap("resource/image/wybq/Back_WYBQ.png",bm);
         ComponentUtil.getTextField("我要变强",this.content,{
            "x":94,
            "y":3,
            "color":16184781,
            "size":12,
            "leading":0
         });
         this.list = ComponentUtil.getList(300,100,Child_bqItem,null,null,this.execut,0);
         this.list.y = 25;
         this.list.x = -8;
         this.list.scrollAutoType = ScrollAutoType.TO_TOP;
         this.content.addChild(this.list);
         this.con = new Sprite();
         addChild(this.con);
         this.Button_PageUp = ComponentUtil.getButton("","Button_NumMax",this.con,{
            "x":-10,
            "y":-10,
            "textColor":16771436
         },Global.Img_Cdm);
         ComponentUtil.setPropertie(this.con,{
            "x":227,
            "y":12
         });
         this.Button_PageUp.callBack = this.onClickHandler;
         this.content.addEventListener(MouseEvent.CLICK,this.onClick);
         this.resetPosition();
         Global.control.registerCallBack(Enum_MsgType.STAGE_RESIZE,this.resetPosition);
         Global.control.registerCallBack("resetPosition",null);
         this.moveBtn.addEventListener(MouseEvent.MOUSE_DOWN,this.downEvent);
         this.moveBtn.addEventListener(MouseEvent.MOUSE_UP,this.upEvent);
      }
      
      override public function resetPosition() : void
      {
         x = Global.stage.stageWidth + BoatManager.questCX;
         if(View_quest_trace._sign)
         {
            y = 429;
         }
         else
         {
            y = 377;
         }
      }
      
      private function upEvent(e:MouseEvent) : void
      {
         stopDrag();
      }
      
      private function downEvent(e:MouseEvent) : void
      {
         startDrag();
      }
      
      protected function onClickHandler(event:MouseEvent) : void
      {
         var obj:Object = null;
         if(this.isRuning)
         {
            return;
         }
         this.isRuning = true;
         if(this.isEnd)
         {
            obj = {"rotation":[180,0]};
            Tween.to(this.content,200,{
               "scaleX":[0,1],
               "scaleY":[0,1],
               "x":[this.content.x,this.content.x - 227]
            });
         }
         else
         {
            obj = {"rotation":[0,180]};
            Tween.to(this.content,200,{
               "scaleX":[1,0],
               "scaleY":[1,0],
               "x":[this.content.x,this.content.x + 227]
            });
         }
         Tween.to(this.con,200,obj,function():void
         {
            isRuning = false;
         });
         this.isEnd = !this.isEnd;
      }
      
      protected function onClick(event:MouseEvent) : void
      {
         if(event.target is MainUIBtn || event.target is Button || event.target is TabButton || event.target is ScrollBar || event.target is MyTextField || event.target is Child_bqItem)
         {
            return;
         }
         GameScene.instance.uiOnGo(event);
      }
      
      public function execut(data:Object) : void
      {
         var mainPnl:View_horsePanel = null;
         switch(data)
         {
            case "强化":
               UIManager.castPanel.visible = !UIManager.castPanel.visible;
               if(UIManager.castPanel.visible)
               {
                  if(Model_bag.isCastDiscard == 0 && Model_bag.pwdLockState == Model_bag.PWD_STATE_LOCK_T)
                  {
                     UIManager.castPanel.openView(Enum_panel_cast.EQUIP_DECOMPOSE);
                     break;
                  }
                  UIManager.castPanel.openView(Enum_panel_cast.EQUIP_INTENSIFY);
               }
               break;
            case "洗练":
               UIManager.castPanel.visible = !UIManager.castPanel.visible;
               if(UIManager.castPanel.visible)
               {
                  UIManager.castPanel.showXL();
               }
               break;
            case "宠物":
               UIManager.petPanel.showND();
               break;
            case "神兵":
               ShenBingUtil.askOpenShenBingPanel();
               break;
            case "坐骑":
               mainPnl = Singleton.getInstance(View_horsePanel);
               if(!mainPnl.visible)
               {
                  Global.delegate.dosomething(mainPnl,function():void
                  {
                     mainPnl.show(0);
                  });
                  break;
               }
               mainPnl.hide();
               break;
            case "翅膀":
               if(!View_wing_menu.instance.visible)
               {
                  Global.delegate.dosomething(View_wing_menu.instance,function():void
                  {
                     WingCGMessage.CG_WING_OPEN();
                  });
               }
               break;
            case "宝石":
               UIManager.castPanel.visible = !UIManager.castPanel.visible;
               if(UIManager.castPanel.visible)
               {
                  if(Model_bag.isCastDiscard == 0 && Model_bag.pwdLockState == Model_bag.PWD_STATE_LOCK_T)
                  {
                     UIManager.castPanel.openView(Enum_panel_cast.EQUIP_HOLE);
                     break;
                  }
                  UIManager.castPanel.openView(Enum_panel_cast.EQUIP_HOLE);
               }
               break;
            case "五行":
               if(GameUnitManager.hero.level < 50)
               {
                  UIManager.centerBroadcast.addMsg("等级不够");
                  return;
               }
               WuXingMter.getPan(WuxingPan,function(pan:WuxingPan):void
               {
                  pan.visible = !pan.visible;
                  if(pan.visible)
                  {
                     WuxingCGMessage.CG_OPEN_WUXINGPAN();
                  }
               });
         }
      }
      
      override public function set visible(value:Boolean) : void
      {
         this.update();
         this.resetPosition();
         if(value)
         {
            if(UIManager.questTraceView.visible)
            {
               super.visible = value;
            }
            else
            {
               super.visible = !value;
            }
         }
         else
         {
            super.visible = value;
         }
      }
      
      public function update() : void
      {
         var arr:Array = Model_bqzy.getListData();
         this.b1.height = 24 * arr.length;
         thisH = 23 + 24 * arr.length;
         this.list.source = arr;
         this.list.align();
         if(View_quest_trace._sign)
         {
            UIManager.newMainBtnContainer.y = 448 + 25 * arr.length;
         }
         else
         {
            UIManager.newMainBtnContainer.y = 399 + 25 * arr.length;
         }
      }
   }
}

