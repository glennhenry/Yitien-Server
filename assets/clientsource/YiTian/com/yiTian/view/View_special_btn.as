package com.yiTian.view
{
   import com.utils.Util;
   import com.yiTian.Global;
   import com.yiTian.command.Enum_MsgType;
   import com.yiTian.data.config.Enum_quest_id;
   import com.yiTian.data.model.Model_bag;
   import com.yiTian.data.model.Model_sms;
   import com.yiTian.data.model.Model_wing;
   import com.yiTian.manager.EffectManager;
   import com.yiTian.manager.GameUnitManager;
   import com.yiTian.manager.LangConfig;
   import com.yiTian.manager.UIManager;
   import com.yiTian.net.message.cg.WingCGMessage;
   import com.yiTian.scene.GameScene;
   import com.yiTian.utils.Bezier;
   import com.yiTian.utils.Singleton;
   import com.yiTian.utils.Tween;
   import com.yiTian.utils.Utils;
   import com.yiTian.utils.call.Delegate123;
   import com.yiTian.view.modules.boatChall.BoatManager;
   import com.yiTian.view.modules.friends.View_inviteReward;
   import com.yiTian.view.modules.guaji.BitmapBtn;
   import com.yiTian.view.modules.mainMenu.MicroButton;
   import com.yiTian.view.modules.panel.Enum_panel_cast;
   import com.yiTian.view.modules.wing.View_wing_buyGuide;
   import com.yiTian.view.modules.wing.View_wing_menu;
   import com.yiTian.view.modules.yellowDiamond.Model_txAction;
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import flash.utils.clearTimeout;
   import flash.utils.setTimeout;
   
   public class View_special_btn extends MainUIBase
   {
      
      private var type_arr:Array = ["MiJing","DuanZhao","ChongWu","Wing"];
      
      private var iconBtn:MicroButton;
      
      private var vecIcon:Vector.<MicroButton>;
      
      private var mijingBtn:MicroButton;
      
      private var duanzhaoBtn:MicroButton;
      
      public var petBtn:MicroButton;
      
      private var wingBtn:MicroButton;
      
      private const wingLevelLimit:int = 67;
      
      private var nowVisIconLen:int;
      
      private var isYDLight:Boolean = false;
      
      private var _items:Array = [];
      
      private var isNotFin:Boolean = false;
      
      public function View_special_btn()
      {
         super();
      }
      
      override protected function initStaticView() : void
      {
         var i:int = 0;
         this.vecIcon = new Vector.<MicroButton>();
         i = 0;
         while(i < this.type_arr.length)
         {
            this.iconBtn = new MicroButton(this.type_arr[i],"");
            this.iconBtn.x = -15 + i * 48;
            this.iconBtn.y = -20;
            this.iconBtn.tabIndex = i + 1;
            this.iconBtn.addEventListener(MouseEvent.CLICK,this.cliHd);
            addChild(this.iconBtn);
            this.iconBtn.visible = false;
            this.vecIcon.push(this.iconBtn);
            i++;
         }
         this.mijingBtn = this.vecIcon[0];
         this.mijingBtn.setVisValue(MicroButton.FROM_LEVEL,30);
         this.duanzhaoBtn = this.vecIcon[1];
         this.duanzhaoBtn.setVisValue(MicroButton.FROM_QUEST,Enum_quest_id.DUAN_ZHAO);
         this.petBtn = this.vecIcon[2];
         this.petBtn.setVisValue(MicroButton.FROM_QUEST,Enum_quest_id.PET);
         this.wingBtn = this.vecIcon[3];
         this.wingBtn.setVisValue(MicroButton.FROM_LEVEL,this.wingLevelLimit);
         this.visible = true;
         Global.control.registerCallBack(Enum_MsgType.STAGE_RESIZE,this.resetPosition);
         Global.control.registerCallBack(Enum_MsgType.MSG_LV_UP_2,this.onLevelUp);
      }
      
      private function onLevelUp(e:* = null) : void
      {
         if(GameUnitManager.hero.level >= this.wingLevelLimit && this.wingBtn.visible == false)
         {
            this.showWing();
         }
      }
      
      public function showMijing() : void
      {
         var delay:int = 0;
         if(this.mijingBtn.visible)
         {
            return;
         }
         this.openNewMicro(this.mijingBtn);
         delay = this.loadBesi(this.mijingBtn);
         this.showOpenMicroEff(this.mijingBtn,delay);
      }
      
      private function showWing() : void
      {
         var delay:int = 0;
         this.openNewMicro(this.wingBtn);
         delay = this.loadBesi(this.wingBtn);
         this.showOpenMicroEff(this.wingBtn,delay);
      }
      
      public function initMicroBtns(questId:int) : void
      {
         var nowIndex:int = 0;
         var item:MicroButton = null;
         var i:int = 0;
         while(i < this.vecIcon.length)
         {
            item = this.vecIcon[i];
            if(item.visType == MicroButton.FROM_QUEST && item.visValue < questId || item.visType == MicroButton.FROM_LEVEL && item.visValue <= GameUnitManager.hero.level)
            {
               item.visible = true;
               item.x = -15 + nowIndex * 48;
               nowIndex++;
               ++this.nowVisIconLen;
            }
            else
            {
               item.visible = false;
            }
            i++;
         }
         this.sort();
      }
      
      public function updateMicro(questId:int) : void
      {
         var delay:int = 0;
         if(questId == Enum_quest_id.PET)
         {
            this.openNewMicro(this.petBtn);
            delay = this.loadBesi(this.petBtn);
            this.showOpenMicroEff(this.petBtn,delay);
         }
         else if(questId == Enum_quest_id.DUAN_ZHAO)
         {
            this.openNewMicro(this.duanzhaoBtn);
            delay = this.loadBesi(this.duanzhaoBtn);
            this.showOpenMicroEff(this.duanzhaoBtn,delay);
         }
      }
      
      private function openNewMicro(icon:MicroButton) : void
      {
         var nowIndex:int = 0;
         var item:MicroButton = null;
         var isNeedMove:Boolean = false;
         ++this.nowVisIconLen;
         var i:int = 0;
         while(i < this.vecIcon.length)
         {
            item = this.vecIcon[i];
            if(item == icon)
            {
               item.visible = true;
               item.alpha = 0;
               item.x = -15 + nowIndex * 48;
               nowIndex++;
               isNeedMove = true;
            }
            else if(item.visible)
            {
               if(isNeedMove)
               {
                  Tween.to(item,1000,{"x":[item.x,-15 + nowIndex * 48]});
               }
               nowIndex++;
            }
            i++;
         }
         if(isNeedMove)
         {
            this.moveBitmapBtns();
         }
      }
      
      private function moveBitmapBtns() : void
      {
         var item:Sprite = null;
         var i:int = 0;
         while(i < this._items.length)
         {
            item = this._items[i];
            Tween.to(item,1000,{"x":[item.x,item.x + 48]});
            i++;
         }
      }
      
      private function showOpenMicroEff(icon:MicroButton, delay:int) : void
      {
         var inter:int = 0;
         inter = int(setTimeout(function():void
         {
            EffectManager.addEffect("35196",UIManager.special_btn,1000,icon.x + 23,icon.y + 35,false,1);
            icon.alpha = 1;
            clearTimeout(inter);
         },delay));
      }
      
      private function loadBesi(icon:MicroButton) : int
      {
         var aimPoint:Point = null;
         var bm:Bitmap = null;
         aimPoint = localToGlobal(new Point(icon.x,icon.y));
         bm = new Bitmap();
         bm.bitmapData = icon.getIconBMD();
         bm.x = Global.stage.stageWidth / 2;
         bm.y = Global.stage.stageHeight / 2;
         var totalTime:int = Math.pow(Math.pow(aimPoint.y - bm.y,2) + Math.pow(aimPoint.x - bm.x,2),0.5) * 7;
         var point2:Point = new Point(bm.x + Util.rnd(-100,400),bm.y + Utils.rnd(100,200));
         var point3:Point = new Point(bm.x + Util.rnd(-300,100),bm.y - Utils.rnd(200,300));
         Bezier.getInstance().addTarget(bm,aimPoint,totalTime,GameScene.upUILayer,-1,[point3,point2],this.CFUN);
         return totalTime;
      }
      
      public function openHorse() : void
      {
         var icon:BitmapBtn = null;
         var inter:int = 0;
         icon = this._items[0];
         var delay:int = this.loadHorseIcon(icon);
         inter = int(setTimeout(function():void
         {
            clearTimeout(inter);
            EffectManager.addEffect("35196",UIManager.special_btn,1000,icon.x + 23,icon.y + 35,false,1);
            icon.alpha = 1;
         },delay));
         icon.visible = true;
         icon.alpha = 0;
      }
      
      private function loadHorseIcon(icon:BitmapBtn) : int
      {
         var aimPoint:Point = null;
         var bm:Bitmap = null;
         aimPoint = localToGlobal(new Point(icon.x,icon.y));
         bm = Utils.getLoadBitmap("resource/image/horse/mainIcon.png");
         bm.x = Global.stage.stageWidth / 2;
         bm.y = Global.stage.stageHeight / 2;
         var totalTime:int = Math.pow(Math.pow(aimPoint.y - bm.y,2) + Math.pow(aimPoint.x - bm.x,2),0.5) * 7;
         var point2:Point = new Point(bm.x + Util.rnd(-100,400),bm.y + Utils.rnd(100,200));
         var point3:Point = new Point(bm.x + Util.rnd(-300,100),bm.y - Utils.rnd(200,300));
         Bezier.getInstance().addTarget(bm,aimPoint,totalTime,GameScene.upUILayer,-1,[point3,point2],this.CFUN);
         return totalTime;
      }
      
      private function CFUN(o:DisplayObject) : void
      {
         GameScene.upUILayer.removeChild(o);
         if(Boolean((o as Bitmap).bitmapData))
         {
            (o as Bitmap).bitmapData = null;
         }
      }
      
      public function showYD(value:Boolean) : void
      {
         if(value)
         {
            Model_txAction.instance.showYellowBtn(true);
         }
         else
         {
            Model_txAction.instance.removeEff();
         }
      }
      
      private function cliHd(e:MouseEvent) : void
      {
         var type:int = (e.target as MicroButton).tabIndex;
         switch(type)
         {
            case 1:
               this.smsHandle();
               break;
            case 2:
               this.forginHandle();
               break;
            case 3:
               if(Boolean(UIManager.petPanel.petVO))
               {
                  UIManager.petPanel.visible = !UIManager.petPanel.visible;
                  break;
               }
               UIManager.centerBroadcast.addMsg("<font color=\'#ffff00\'>" + LangConfig.getWord("10172",1) + "</font>");
               break;
            case 4:
               Global.delegate.dosomething(View_wing_menu.instance,function():void
               {
                  if(Model_wing.wingId > 0)
                  {
                     if(View_wing_menu.instance.visible)
                     {
                        View_wing_menu.instance.visible = false;
                     }
                     else
                     {
                        WingCGMessage.CG_WING_OPEN();
                     }
                  }
                  else if(View_wing_buyGuide.instance.visible)
                  {
                     View_wing_buyGuide.instance.visible = false;
                  }
                  else
                  {
                     WingCGMessage.CG_WING_OPEN();
                  }
               });
         }
      }
      
      public function joinIconEff(value:Boolean) : void
      {
      }
      
      override public function resetPosition() : void
      {
         x = UIManager.mainMenu.x + 339;
         y = Global.stage.stageHeight + BoatManager.specialCY;
      }
      
      public function handle_func(type:int) : void
      {
         var pnl:View_inviteReward = null;
         if(type == 1)
         {
            this.smsHandle();
         }
         else if(type == 2)
         {
            this.forginHandle();
         }
         else if(type == 3)
         {
            pnl = UIManager.inviteReward;
            (Singleton.getInstance(Delegate123) as Delegate123).dosomething(pnl,function():void
            {
               UIManager.inviteReward.visible = !UIManager.inviteReward.visible;
            });
            this.joinIconEff(false);
         }
         else if(type == 4)
         {
         }
      }
      
      public function appendItem(o:DisplayObject, index:int = -1) : void
      {
         if(this._items.indexOf(o) == -1)
         {
            if(index != -1 && index < this._items.length)
            {
               this._items.splice(index,0,o);
            }
            else
            {
               this._items.push(o);
            }
            addChild(o);
            this.sort();
         }
      }
      
      private function sort() : void
      {
         var offset:int = (this.vecIcon.length - this.nowVisIconLen) * 48;
         var i:int = 0;
         while(i < this._items.length)
         {
            this._items[i].x = 83 + (this.type_arr.length - 3) * 48 + 48 * (i + 1) - offset;
            i += 1;
         }
      }
      
      public function smsHandle(e:MouseEvent = null) : void
      {
         if(GameUnitManager.hero.level < 30)
         {
            UIManager.centerBroadcast.addMsg(LangConfig.getWord("904",0));
            return;
         }
         UIManager.sm_shop.visible = !UIManager.sm_shop.visible;
         this.setMoveEff(0,false);
      }
      
      public function forginHandle(e:MouseEvent = null) : void
      {
         UIManager.castPanel.visible = !UIManager.castPanel.visible;
         if(UIManager.castPanel.visible)
         {
            if(Model_bag.isCastDiscard == 0 && Model_bag.pwdLockState == Model_bag.PWD_STATE_LOCK_T)
            {
               UIManager.castPanel.openView(Enum_panel_cast.EQUIP_DECOMPOSE);
            }
            else
            {
               UIManager.castPanel.openView(Enum_panel_cast.EQUIP_INTENSIFY);
            }
         }
      }
      
      public function getPos(_index:int) : Point
      {
         return localToGlobal(new Point(this.vecIcon[_index].x,this.vecIcon[_index].y));
      }
      
      public function getEff(_index:int) : void
      {
         var sty:int = 0;
         if(this.isNotFin)
         {
            return;
         }
         sty = this.vecIcon[_index].y;
         this.vecIcon[_index].y = -this.vecIcon[_index].height;
         this.isNotFin = true;
         Tween.to(this.vecIcon[_index],200,{"scaleY":[1,1.1]},function():void
         {
            vecIcon[_index].y = sty;
            vecIcon[_index].scaleX = 1;
            vecIcon[_index].scaleY = 1;
            isNotFin = false;
         });
      }
      
      public function showExB() : void
      {
         var showB:Function = function(index:int):void
         {
            var btn:MicroButton;
            var n:int = 0;
            var m:int = 0;
            if(index >= vecIcon.length)
            {
               return;
            }
            btn = vecIcon[index];
            if(btn.visible)
            {
               n = int(setTimeout(function():void
               {
                  clearTimeout(n);
                  showB(++index);
               },1800));
            }
            else
            {
               openNewMicro(btn);
               showOpenMicroEff(btn,500);
               m = int(setTimeout(function():void
               {
                  clearTimeout(m);
                  showB(++index);
               },1800));
            }
         };
         showB(0);
      }
      
      public function setMoveEff(index:int, open:Boolean) : void
      {
         var btn:DisplayObject = null;
         if(Boolean(this.vecIcon) && Boolean(this.vecIcon[index]))
         {
            btn = this.vecIcon[index];
            if(open)
            {
               BtnEff.btnMove(btn);
            }
            else
            {
               BtnEff.disBtnMov(btn);
            }
         }
      }
      
      override public function set visible(value:Boolean) : void
      {
         super.visible = value;
         if(value)
         {
            if(Model_sms.showGuide)
            {
               this.setMoveEff(0,true);
            }
         }
      }
   }
}

import com.yiTian.manager.UIManager;
import com.yiTian.utils.Tween;
import com.yiTian.utils.Utils;
import flash.display.Bitmap;
import flash.display.DisplayObject;
import flash.display.Sprite;
import flash.events.MouseEvent;
import flash.geom.Point;
import flash.utils.Dictionary;

class Icon_btn extends Sprite
{
   
   private var overStyle:Bitmap;
   
   private var upStyle:Bitmap;
   
   private var downStyle:Bitmap;
   
   private var _type_index:int;
   
   private var isOver:Boolean = false;
   
   public function Icon_btn(_x:int, _y:int, typeStr:String, type_index:int)
   {
      super();
      this._type_index = type_index;
      this.buttonMode = true;
      var str1:String = "resource/image/exBtn/" + typeStr + "_up.png";
      var str2:String = "resource/image/exBtn/" + typeStr + "_over.png";
      var str3:String = "resource/image/exBtn/" + typeStr + "_down.png";
      this.upStyle = Utils.getLoadBitmap(str1);
      this.overStyle = Utils.getLoadBitmap(str2);
      this.downStyle = Utils.getLoadBitmap(str3);
      addChild(this.upStyle);
      addChild(this.overStyle);
      addChild(this.downStyle);
      this.overStyle.visible = false;
      this.downStyle.visible = false;
      this.x = _x;
      this.y = _y;
      addEventListener(MouseEvent.MOUSE_OVER,this.overHandle);
      addEventListener(MouseEvent.MOUSE_OUT,this.outHandle);
      addEventListener(MouseEvent.MOUSE_DOWN,this.downHandle);
      addEventListener(MouseEvent.CLICK,this.cliHandle);
   }
   
   private function reset() : void
   {
      this.upStyle.visible = false;
      this.overStyle.visible = false;
      this.downStyle.visible = false;
   }
   
   private function overHandle(e:MouseEvent) : void
   {
      this.reset();
      this.isOver = true;
      this.overStyle.visible = true;
   }
   
   private function outHandle(e:MouseEvent) : void
   {
      this.reset();
      this.isOver = false;
      this.upStyle.visible = true;
   }
   
   private function downHandle(e:MouseEvent) : void
   {
      this.reset();
      this.downStyle.visible = true;
   }
   
   private function cliHandle(e:MouseEvent) : void
   {
      this.reset();
      if(this.isOver)
      {
         this.overStyle.visible = true;
      }
      else
      {
         this.upStyle.visible = true;
      }
      UIManager.special_btn.handle_func(this._type_index);
   }
}

class BtnEff
{
   
   private static var posDic:Dictionary = new Dictionary();
   
   private static const MOVE_RANG:int = 6;
   
   public function BtnEff()
   {
      super();
   }
   
   public static function btnMove(target:DisplayObject) : void
   {
      if(Boolean(posDic[target]))
      {
         return;
      }
      posDic[target] = new Point(target.x,target.y);
      Tween.to(target,400,{"y":[target.y,target.y - MOVE_RANG]},moveFun);
   }
   
   private static function moveFun(target:DisplayObject) : void
   {
      var pos:Point = posDic[target] as Point;
      if(target.y <= pos.y - MOVE_RANG)
      {
         Tween.to(target,800,{"y":[target.y,pos.y + MOVE_RANG]},moveFun);
      }
      else
      {
         Tween.to(target,800,{"y":[target.y,pos.y - MOVE_RANG]},moveFun);
      }
   }
   
   public static function disBtnMov(target:DisplayObject) : void
   {
      var point:Point = null;
      if(Boolean(posDic[target]))
      {
         Tween.stop(target);
         point = posDic[target] as Point;
         target.x = point.x;
         target.y = point.y;
         delete posDic[target];
      }
   }
}
