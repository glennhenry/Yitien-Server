package com.yiTian.view.modules.boatChall
{
   import com.ui.controls.Button;
   import com.ui.controls.MyTextField;
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.command.Enum_MsgType;
   import com.yiTian.net.message.cg.BoatCGMessage;
   import com.yiTian.utils.Singleton;
   import com.yiTian.view.Panel123;
   import com.yiTian.view.modules.ship.Ship;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   import flash.utils.getTimer;
   
   public class ShipCrues extends Panel123
   {
      
      public static var firstName:String = "";
      
      private var btn:Button;
      
      private var leftTf:MyTextField;
      
      private var rightTf:MyTextField;
      
      private var lTime:int;
      
      private var counts:int;
      
      public function ShipCrues()
      {
         super();
         regResource("lang/ch/FWLZ.swf","FWLZdm");
      }
      
      public static function get instance() : ShipCrues
      {
         return Singleton.getInstance(ShipCrues);
      }
      
      override protected function initUI2() : void
      {
         ComponentUtil.getBitmap("Back_LZRenYuan",this,{
            "x":0,
            "y":0
         },Global.FWLZdm);
         move = new Rectangle(0,0,250,30);
         ComponentUtil.getBitmap("Text_YPCY",this,{
            "x":154,
            "y":15
         },Global.FWLZdm);
         ComponentUtil.getBitmap("Text_ZPCY",this,{
            "x":43,
            "y":15
         },Global.FWLZdm);
         this.leftTf = ComponentUtil.getTextField("玩家名六个字",this,{
            "x":29,
            "y":34,
            "color":16773588,
            "size":12,
            "leading":8,
            "wordWrap":true,
            "multiline":true,
            "realWidth":85,
            "realHeight":140
         });
         this.rightTf = ComponentUtil.getTextField("玩家名六个字",this,{
            "x":141,
            "y":34,
            "color":16773588,
            "size":12,
            "leading":8,
            "wordWrap":true,
            "multiline":true,
            "realWidth":85,
            "realHeight":140
         });
         this.btn = ComponentUtil.getButton("","Button_RYHuanLei",this,{
            "x":53,
            "y":170,
            "textColor":16771436
         },Global.FWLZdm);
         this.btn.callBack = function(e:MouseEvent):void
         {
            BoatCGMessage.CG_LEFT_RIGHT();
         };
      }
      
      private function daoTime(intereval:int) : void
      {
         var now:int = getTimer();
         if(now - this.lTime >= 1000)
         {
            --this.counts;
            this.btn.label = this.counts.toString();
            if(this.counts == 0)
            {
               Global.control.removeCallBack(Enum_MsgType.MSG_ENTERFRAME,this.daoTime);
               this.btn.label = "";
               this.btn.enabled = true;
            }
            this.lTime = now;
         }
      }
      
      public function show(lefts:Array, rights:Array, idStr:String) : void
      {
         var ss:String = null;
         var sss:String = null;
         this.reset();
         var i:int = 0;
         while(i < lefts.length)
         {
            ss = lefts[i];
            this.leftTf.htmlText += ss + "\n";
            i++;
         }
         var j:int = 0;
         while(j < rights.length)
         {
            sss = rights[j];
            this.rightTf.htmlText += sss + "\n";
            j++;
         }
         if(Boolean(Ship.myShip) && Ship.myShip.idStr == idStr)
         {
            this.btn.visible = true;
            if(lefts[0] != "")
            {
               firstName = lefts[0];
            }
            else
            {
               firstName = rights[0];
            }
         }
         else
         {
            this.btn.visible = false;
         }
         visible = visible || true;
      }
      
      private function hide(e:* = null) : void
      {
         visible = visible && false;
      }
      
      private function reset() : void
      {
         var _temp_1:* = this.leftTf;
         this.rightTf.text = "";
         _temp_1.text = "";
      }
      
      override public function resetPosition() : void
      {
         x = 5;
         y = 110;
      }
   }
}

