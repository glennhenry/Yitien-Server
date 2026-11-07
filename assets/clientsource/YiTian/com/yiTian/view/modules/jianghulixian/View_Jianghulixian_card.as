package com.yiTian.view.modules.jianghulixian
{
   import com.utils.ComponentUtil;
   import com.utils.Util;
   import com.yiTian.Global;
   import com.yiTian.data.config.Enum_Jianghulixian;
   import com.yiTian.manager.TipManager;
   import com.yiTian.net.message.cg.JianghulixianCGMessage;
   import com.yiTian.utils.Tween;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.geom.Matrix;
   import flash.geom.PerspectiveProjection;
   import flash.geom.Point;
   
   public class View_Jianghulixian_card extends Sprite
   {
      
      public var id:int;
      
      public var status:int;
      
      public var isPlay:Boolean;
      
      private var touziBM:Bitmap;
      
      private var spr_front:Sprite;
      
      private var spr_back:Sprite;
      
      private var front:Bitmap;
      
      private var back:Bitmap;
      
      public function View_Jianghulixian_card(_id:int)
      {
         super();
         this.id = _id;
         this.Init();
      }
      
      private function Init() : void
      {
         this.buttonMode = true;
         this.mouseChildren = false;
         this.spr_front = new Sprite();
         this.spr_back = new Sprite();
         this.front = ComponentUtil.getBitmap("Card_" + (this.id + 1),this.spr_front,{
            "x":0,
            "y":0
         },Global.LiXian_Imgsdm);
         this.front.x = -this.front.width / 2;
         this.front.y = -this.front.height / 2;
         this.back = ComponentUtil.getBitmap("CardBack",this.spr_back,{
            "x":0,
            "y":0
         },Global.LiXian_Imgsdm);
         this.back.x = -this.back.width / 2;
         this.back.y = -this.back.height / 2;
         this.spr_back.x = this.spr_back.width / 2;
         this.spr_back.y = this.spr_back.height / 2;
         this.spr_front.x = this.spr_back.x;
         this.spr_front.y = this.spr_back.y;
         this.spr_front.visible = false;
         this.addChild(this.spr_front);
         this.addChild(this.spr_back);
         this.addEventListener(MouseEvent.CLICK,this.onClick);
         this.addEventListener(MouseEvent.ROLL_OVER,this.onRoll);
         this.addEventListener(MouseEvent.ROLL_OUT,this.onRoll);
         var p:PerspectiveProjection = new PerspectiveProjection();
         p.projectionCenter = new Point(this.spr_back.x,this.spr_back.y);
         this.spr_back.transform.perspectiveProjection = p;
         this.spr_front.transform.perspectiveProjection = p;
         Global.control.registerCallBack(Enum_Jianghulixian.Jianghulixian_GAME_CHANGE_STATUS,this.changeStatus);
         Global.control.registerCallBack(Enum_Jianghulixian.Jianghulixian_GAME_START,this.gameStart);
      }
      
      private function gameStart(e:Object = null) : void
      {
         this.buttonMode = false;
         this.mouseEnabled = false;
      }
      
      private function onRoll(e:MouseEvent) : void
      {
         if(e.type == MouseEvent.ROLL_OVER)
         {
            this.transform.colorTransform = Util.colorWhite2;
         }
         else
         {
            this.transform.colorTransform = Util.colorNomal;
         }
      }
      
      public function setCard(_id:int) : void
      {
         this.front.bitmapData = ComponentUtil.getBitmapData("Card_" + _id,Global.LiXian_Imgsdm);
      }
      
      private function onClick(e:MouseEvent) : void
      {
         if(Enum_Jianghulixian.GameStatus == 0)
         {
            View_Jianghulixian_menu.inGame = true;
            JianghulixianCGMessage.CG_Jianghulixian_GET_RESULT(1);
         }
         else if(Enum_Jianghulixian.GameStatus == 1)
         {
            if(this.status == 0)
            {
               this.OpenCard();
            }
            else if(this.status == 1)
            {
               this.CloseCard();
            }
         }
      }
      
      public function OpenCard() : void
      {
         this.status = 1;
         this.isPlay = true;
         this.buttonMode = false;
         this.mouseEnabled = false;
         Global.control.sendNotification(Enum_Jianghulixian.Jianghulixian_CHECK_CHANGE_CARD,null);
         Tween.to(this.spr_back,150,{"rotationY":[0,90]},function():void
         {
            spr_back.visible = false;
            spr_front.rotationY = -90;
            spr_front.visible = true;
            Tween.to(spr_front,150,{"rotationY":[-90,0]},opened);
         });
      }
      
      private function opened() : void
      {
         this.isPlay = false;
         this.buttonMode = true;
         this.mouseEnabled = true;
         TipManager.bind(this,"更换此牌");
         this.spr_front.transform.matrix = new Matrix(1,0,0,1,this.spr_front.x,this.spr_front.y);
         this.spr_back.transform.matrix = new Matrix(1,0,0,1,this.spr_back.x,this.spr_back.y);
         Global.control.sendNotification(Enum_Jianghulixian.Jianghulixian_CARD_OPENED,null);
      }
      
      public function CloseCard() : void
      {
         this.status = 0;
         this.isPlay = true;
         this.buttonMode = false;
         this.mouseEnabled = false;
         Global.control.sendNotification(Enum_Jianghulixian.Jianghulixian_CHECK_CHANGE_CARD,null);
         Tween.to(this.spr_front,150,{"rotationY":[0,90]},function():void
         {
            spr_front.visible = false;
            spr_back.rotationY = -90;
            spr_back.visible = true;
            Tween.to(spr_back,150,{"rotationY":[-90,0]},closed);
         });
      }
      
      private function closed() : void
      {
         this.isPlay = false;
         this.buttonMode = true;
         this.mouseEnabled = true;
         TipManager.unBind(this);
         this.spr_front.transform.matrix = new Matrix(1,0,0,1,this.spr_front.x,this.spr_front.y);
         this.spr_back.transform.matrix = new Matrix(1,0,0,1,this.spr_back.x,this.spr_back.y);
      }
      
      private function changeStatus(e:Object = null) : void
      {
         if(Enum_Jianghulixian.GameStatus == 2)
         {
            this.buttonMode = false;
            this.mouseEnabled = false;
            TipManager.unBind(this);
         }
         else if(Enum_Jianghulixian.GameStatus == 1)
         {
            this.buttonMode = true;
            this.mouseEnabled = true;
            TipManager.bind(this,"更换此牌");
         }
         else if(Enum_Jianghulixian.GameStatus == 0)
         {
            this.spr_front.visible = false;
            this.spr_back.visible = true;
            this.spr_back.rotationY = 0;
            this.spr_back.transform.matrix = new Matrix(1,0,0,1,this.spr_back.x,this.spr_back.y);
            this.buttonMode = true;
            this.mouseEnabled = true;
            TipManager.unBind(this);
         }
      }
      
      public function SetOneKeyResult() : void
      {
         this.spr_front.visible = false;
         this.spr_back.visible = true;
         this.spr_back.rotationY = 0;
         this.spr_back.transform.matrix = new Matrix(1,0,0,1,this.spr_back.x,this.spr_back.y);
      }
   }
}

