package com.yiTian.view.modules.yellowDiamond.newAct
{
   import com.ui.controls.Button;
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.data.Enum_SPStr;
   import com.yiTian.data.vo.Vo_item;
   import com.yiTian.manager.GameUnitManager;
   import com.yiTian.manager.UIManager;
   import com.yiTian.manager.YellowDiaManager;
   import com.yiTian.net.message.cg.YelloDiaCGMessage;
   import com.yiTian.net.message.gc.YelloDiaGCMessage;
   import com.yiTian.utils.ComboTweenStep;
   import com.yiTian.utils.SingleLoader;
   import com.yiTian.view.Panel;
   import com.yiTian.view.modules.yellowDiamond.View_hzTribute;
   import flash.display.Bitmap;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   
   public class NewYearAct extends Panel
   {
      
      private static var _instance:NewYearAct;
      
      private static var actionsArr:Array;
      
      private static var isUILoad:Boolean = false;
      
      private var actTilBmp:Bitmap;
      
      private var fBmp:Bitmap;
      
      private var sBmp:Bitmap;
      
      private var bmpVec:Vector.<Bitmap> = new Vector.<Bitmap>(2);
      
      private var HongBaoVec:Vector.<Item> = new Vector.<Item>(2);
      
      private var buttonGet:Button;
      
      private var curAct:int;
      
      private var isLan:int;
      
      private var isGet:int;
      
      private var itemIdArr:Array = [[44479,44480,44481],[44482,44483,44484]];
      
      public function NewYearAct()
      {
         super();
      }
      
      public static function get instance() : NewYearAct
      {
         if(!_instance)
         {
            _instance = new NewYearAct();
         }
         return _instance;
      }
      
      private function initD() : void
      {
         var tilStr:String;
         var hongBaoS:String;
         var j:int;
         var i:int;
         var ktXF:String;
         var ssUrl:String = null;
         var _item:Item = null;
         var bmp:Bitmap = null;
         ComponentUtil.getBitmap("Back_Img",this,{
            "x":0,
            "y":0
         },Global.NewYear01_Imgdm);
         tilStr = "";
         hongBaoS = "";
         if(Global.pf == Enum_SPStr.QQGAME)
         {
            tilStr = "Text_DaTing";
            hongBaoS = "DaTing_Bag";
         }
         else if(Global.pf == Enum_SPStr.QQ3366)
         {
            tilStr = "Text_3366";
            hongBaoS = "Bag_3366";
         }
         ComponentUtil.getBitmap(tilStr,this,{
            "x":101,
            "y":70
         },Global.NewYear01_Imgdm);
         j = 0;
         while(j < this.HongBaoVec.length)
         {
            ssUrl = "";
            if(j == 0)
            {
               ssUrl = hongBaoS;
            }
            else
            {
               ssUrl = "LanZuan_Bag";
            }
            _item = new Item();
            addChild(_item);
            _item.initUrl(ssUrl);
            ComponentUtil.setPropertie(_item,{
               "x":75 + 198 * j,
               "y":280
            });
            this.HongBaoVec[j] = _item;
            j++;
         }
         this.buttonGet = ComponentUtil.getButton("","Button_Get",this,{
            "x":210,
            "y":442,
            "textColor":16184781,
            "callBack":function(e:MouseEvent):void
            {
               if(isLan == 0 && isGet == 0)
               {
                  if(Global.pf == Enum_SPStr.QQGAME)
                  {
                     UIManager.centerBroadcast.addMsg("您已经领取过大厅红包，开通蓝钻可领取蓝钻红包");
                  }
                  else if(Global.pf == Enum_SPStr.QQ3366)
                  {
                     UIManager.centerBroadcast.addMsg("您已经领取过3366红包，开通蓝钻可领取蓝钻红包");
                  }
                  return;
               }
               YelloDiaCGMessage.CG_GET_NEWYEAR_AWARD(curAct);
            }
         },Global.NewYear01_Imgdm);
         this.actTilBmp = new Bitmap();
         addChild(this.actTilBmp);
         ComponentUtil.setPropertie(this.actTilBmp,{
            "x":112,
            "y":153
         });
         this.fBmp = new Bitmap();
         addChild(this.fBmp);
         this.sBmp = new Bitmap();
         addChild(this.sBmp);
         ComponentUtil.setPropertie(this.fBmp,{
            "x":506,
            "y":251
         });
         ComponentUtil.setPropertie(this.sBmp,{
            "x":506,
            "y":386
         });
         i = 0;
         while(i < this.bmpVec.length)
         {
            bmp = new Bitmap();
            ComponentUtil.setPropertie(bmp,{
               "x":601,
               "y":232 + 135 * i
            });
            this.bmpVec[i] = bmp;
            addChild(bmp);
            i++;
         }
         ktXF = "";
         if(GameUnitManager.hero.ylDiaLvl > 0)
         {
            ktXF = "Button_BuleXF";
         }
         else
         {
            ktXF = "Button_BuleKT";
         }
         ComponentUtil.getButton("",ktXF,this,{
            "x":508,
            "y":184,
            "textColor":16184781,
            "callBack":function(e:MouseEvent):void
            {
               View_hzTribute.sendType = "self";
               YellowDiaManager.buy();
            }
         },Global.NewYear01_Imgdm);
         move = new Rectangle(0,0,705,80);
         ComponentUtil.getButton("","Button_Close",this,{
            "x":675,
            "y":49,
            "textColor":16184781,
            "callBack":function(e:MouseEvent):void
            {
               visible = false;
            }
         },Global.NewYear01_Imgdm);
         isUILoad = true;
         this.update();
      }
      
      public function show(_curAct:int, _isLan:int, _isGet:int) : void
      {
         this.curAct = _curAct;
         this.isLan = _isLan;
         this.isGet = _isGet;
         if(!visible)
         {
            visible = true;
         }
         if(YelloDiaGCMessage.statusSave == 0)
         {
            visible = false;
         }
         if(!isUILoad)
         {
            SingleLoader.add("lang/ch/NewYear01_Img.swf",function(info:Object):void
            {
               Global.NewYear01_Imgdm = info.applicationDomain;
               initD();
            });
         }
         else
         {
            this.update();
         }
      }
      
      private function update() : void
      {
         var copyArr:Array = null;
         actionsArr = [["Part01_List","Part01_On"],["Part03_List","Part02_On"],["Part02_List","Part03_On"]];
         var _arrAct:Array = actionsArr[this.curAct - 1];
         copyArr = actionsArr;
         copyArr.splice(copyArr.indexOf(_arrAct),1);
         this.actTilBmp.bitmapData = ComponentUtil.getBitmapData(_arrAct[0],Global.NewYear01_Imgdm);
         this.fBmp.bitmapData = ComponentUtil.getBitmapData(copyArr[0][1],Global.NewYear01_Imgdm);
         this.sBmp.bitmapData = ComponentUtil.getBitmapData(copyArr[1][1],Global.NewYear01_Imgdm);
         this.updateOverTime();
         this.updateTip();
      }
      
      public function getAwards() : void
      {
         var __vo:Vo_item = null;
         var __item:Item = null;
         var _p:Point = null;
         if(Boolean(this.isLan))
         {
            __item = this.HongBaoVec[1];
            __vo = __item.vo;
         }
         else
         {
            __item = this.HongBaoVec[0];
            __vo = __item.vo;
         }
         if(Boolean(__vo))
         {
            _p = localToGlobal(new Point(__item.x,__item.y));
            ComboTweenStep.toBag(__vo,_p.x + 100,_p.y + 100,null,"bsToBag");
         }
      }
      
      private function updateTip() : void
      {
         var _item:Item = null;
         var _id:int = 0;
         var j:int = 0;
         while(j < this.HongBaoVec.length)
         {
            _item = this.HongBaoVec[j];
            _id = int(this.itemIdArr[j][this.curAct - 1]);
            if(_item)
            {
               _item.id = _id;
            }
            j++;
         }
      }
      
      private function updateOverTime() : void
      {
         var bmp1:Bitmap = this.bmpVec[0];
         var bmp2:Bitmap = this.bmpVec[1];
         if(!bmp1 || !bmp2)
         {
            return;
         }
         ComponentUtil.setPropertie(this.fBmp,{
            "x":506,
            "y":251
         });
         ComponentUtil.setPropertie(this.sBmp,{
            "x":506,
            "y":386
         });
         switch(this.curAct)
         {
            case 1:
               bmp1.bitmapData = ComponentUtil.getBitmapData("Wait_Img",Global.NewYear01_Imgdm);
               bmp2.bitmapData = ComponentUtil.getBitmapData("Wait_Img",Global.NewYear01_Imgdm);
               break;
            case 2:
               bmp1.bitmapData = ComponentUtil.getBitmapData("Wait_Img",Global.NewYear01_Imgdm);
               bmp2.bitmapData = ComponentUtil.getBitmapData("Over_Img",Global.NewYear01_Imgdm);
               ComponentUtil.setPropertie(this.fBmp,{
                  "x":506,
                  "y":386
               });
               ComponentUtil.setPropertie(this.sBmp,{
                  "x":506,
                  "y":251
               });
               break;
            case 3:
               bmp1.bitmapData = ComponentUtil.getBitmapData("Over_Img",Global.NewYear01_Imgdm);
               bmp2.bitmapData = ComponentUtil.getBitmapData("Over_Img",Global.NewYear01_Imgdm);
         }
      }
      
      public function hide() : void
      {
         visible = false;
      }
      
      override public function resetPosition() : void
      {
         x = (Global.stage.stageWidth - 711) / 2;
         y = (Global.stage.stageHeight - 528) / 2;
      }
   }
}

import com.utils.ComponentUtil;
import com.yiTian.Global;
import com.yiTian.data.vo.Vo_item;
import com.yiTian.manager.TipManager;
import flash.display.Bitmap;
import flash.display.Sprite;
import flash.events.MouseEvent;

class Item extends Sprite
{
   
   private static var isOn:Boolean = false;
   
   private var bmp:Bitmap;
   
   private var sp:Sprite;
   
   public var vo:Vo_item;
   
   private var _id:int;
   
   public function Item()
   {
      super();
      this.bmp = new Bitmap();
      this.sp = new Sprite();
      this.sp.graphics.beginFill(0,0);
      this.sp.graphics.drawRect(39,24,105,133);
      this.sp.graphics.endFill();
      addChild(this.bmp);
      addChild(this.sp);
   }
   
   public function initUrl(url:String) : void
   {
      this.bmp.bitmapData = ComponentUtil.getBitmapData(url,Global.NewYear01_Imgdm);
   }
   
   private function moveOn(e:MouseEvent) : void
   {
      if(isOn)
      {
         TipManager.view_tip.x = Global.stage.mouseX;
         TipManager.view_tip.y = Global.stage.mouseY;
      }
   }
   
   public function set id(value:int) : void
   {
      this._id = value;
      if(!this._id)
      {
         return;
      }
      this.vo = new Vo_item();
      this.vo.id = this._id;
      this.vo.Init_lib();
      if(!this.sp.hasEventListener(MouseEvent.MOUSE_OVER))
      {
         this.sp.addEventListener(MouseEvent.MOUSE_OVER,this.showTip);
      }
      if(!this.sp.hasEventListener(MouseEvent.MOUSE_OUT))
      {
         this.sp.addEventListener(MouseEvent.MOUSE_OUT,this.hideTip);
      }
      if(!this.sp.hasEventListener(MouseEvent.MOUSE_MOVE))
      {
         this.sp.addEventListener(MouseEvent.MOUSE_MOVE,this.moveOn);
      }
   }
   
   private function showTip(e:MouseEvent) : void
   {
      isOn = true;
      TipManager.update(this.vo);
      TipManager.view_tip.x = Global.stage.mouseX;
      TipManager.view_tip.y = Global.stage.mouseY;
   }
   
   private function hideTip(e:MouseEvent) : void
   {
      isOn = false;
      TipManager.hide();
   }
}
