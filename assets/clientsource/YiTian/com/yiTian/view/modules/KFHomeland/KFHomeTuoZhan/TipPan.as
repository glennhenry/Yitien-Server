package com.yiTian.view.modules.KFHomeland.KFHomeTuoZhan
{
   import com.utils.ComponentUtil;
   import com.utils.Util;
   import com.yiTian.Global;
   import com.yiTian.command.Enum_MsgType;
   import com.yiTian.utils.Singleton;
   import com.yiTian.utils.Utils;
   import com.yiTian.view.Panel;
   import com.yiTian.view.comp.View_Grid;
   import com.yiTian.view.modules.KFHomeland.EnterHomeControl;
   import com.yiTian.view.modules.KFHomeland.HomeLandBtn;
   import com.yiTian.view.modules.KFHomeland.HomeLandCGMessage;
   import com.yiTian.view.modules.baby.babyIcon.BabyIcon;
   import com.yiTian.view.modules.mainUIBtnContainer.MainUIBtn;
   import flash.display.Bitmap;
   import flash.display.DisplayObjectContainer;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   
   public class TipPan extends Panel
   {
      
      private var tiliUrl:String = "resource/image/jiayuan/tili.png";
      
      private var danqiUrl:String = "resource/image/jiayuan/danqi.png";
      
      private var tiliIcon:MainUIBtn;
      
      private var danqiIcon:MainUIBtn;
      
      private var border:Bitmap;
      
      private var gridVec:Vector.<View_Grid> = new Vector.<View_Grid>();
      
      private var bmp1:Bitmap;
      
      private var bmp2:Bitmap;
      
      private var sp1:Sprite;
      
      private var sp2:Sprite;
      
      private var spArr:Array = [];
      
      public function TipPan()
      {
         super();
         if(!this.border)
         {
            this.border = ComponentUtil.getBitmap("Back_JYJL",this,{
               "x":0,
               "y":0
            },Global.KFJYdm);
            addChild(this.border);
         }
      }
      
      public static function get instance() : TipPan
      {
         return Singleton.getInstance(TipPan);
      }
      
      public function show() : void
      {
         var dis:int = 0;
         var sp:Sprite = null;
         if(Vo_TipPan.isCanGet == false)
         {
            return;
         }
         if(Vo_TipPan.tiLi == 1)
         {
            if(!this.bmp1)
            {
               this.bmp1 = ComponentUtil.getBitmap("Icon_LQTL",this,{
                  "x":10,
                  "y":10
               },Global.KFJYdm);
            }
            if(this.sp1 == null)
            {
               this.sp1 = new Sprite();
               addChild(this.sp1);
               this.spArr.push(this.sp1);
               this.sp1.addChild(this.bmp1);
               this.sp1.x = 0;
               this.sp1.y = 10;
               this.sp1.useHandCursor = this.sp1.buttonMode = true;
               this.sp1.name = "sp1_lqtl";
            }
            dis = this.sp1.x + this.sp1.width + 10;
         }
         if(Boolean(Vo_TipPan.danQi))
         {
            if(!this.bmp2)
            {
               this.bmp2 = ComponentUtil.getBitmap("Icon_LQDQ",this,{
                  "x":10,
                  "y":10
               },Global.KFJYdm);
            }
            if(this.sp2 == null)
            {
               this.sp2 = new Sprite();
               addChild(this.sp2);
               this.sp2.useHandCursor = this.sp2.buttonMode = true;
               this.sp2.addChild(this.bmp2);
               this.sp2.y = 10;
               this.sp2.name = "sp2_lqdq";
               this.spArr.push(this.sp2);
            }
            if(Boolean(this.sp1))
            {
               this.sp2.x = this.sp1.x + this.sp1.width + 5;
            }
            dis = this.sp2.x + this.sp2.width + 10;
         }
         for each(sp in this.spArr)
         {
            sp.addEventListener(MouseEvent.CLICK,this.onMouseClick);
            sp.addEventListener(MouseEvent.MOUSE_OVER,this.onOver);
            sp.addEventListener(MouseEvent.MOUSE_OUT,this.onOut);
         }
         this.border.width = 10 + dis;
         this.border.height = 80;
         Global.control.registerCallBack(Enum_MsgType.STAGE_RESIZE,this.resetPosition);
      }
      
      private function onOver(e:MouseEvent) : void
      {
         switch(e.target.name)
         {
            case "sp1_lqtl":
               this.bmp1.transform.colorTransform = Util.colorGlow;
               break;
            case "sp2_lqdq":
               this.bmp2.transform.colorTransform = Util.colorGlow;
         }
      }
      
      private function onOut(e:MouseEvent) : void
      {
         switch(e.target.name)
         {
            case "sp1_lqtl":
               this.bmp1.transform.colorTransform = Util.colorNomal;
               break;
            case "sp2_lqdq":
               this.bmp2.transform.colorTransform = Util.colorNomal;
         }
      }
      
      private function onMouseClick(e:MouseEvent) : void
      {
         Utils.print("what the fucking life");
         switch(e.target.name)
         {
            case "sp1_lqtl":
               HomeLandCGMessage.CG_ASK_GETGOODS(1);
               break;
            case "sp2_lqdq":
               Global.delegate.dosomething(View_GetDanQiPan.instance,function():void
               {
                  View_GetDanQiPan.instance.visible = true;
                  HomeLandCGMessage.CG_CLICK_DANQI();
               });
         }
      }
      
      public function dispose() : void
      {
         if(Boolean(this.bmp1))
         {
            this.bmp1.bitmapData = null;
            this.sp1.removeChild(this.bmp1);
            this.bmp1 = null;
         }
         if(Boolean(this.sp1))
         {
            removeChild(this.sp1);
            this.sp1 = null;
         }
         if(Boolean(this.bmp2))
         {
            this.bmp2.bitmapData = null;
            this.sp2.removeChild(this.bmp2);
            this.bmp2 = null;
         }
         if(Boolean(this.sp2))
         {
            removeChild(this.sp2);
            this.sp2 = null;
         }
         this.spArr = [];
      }
      
      override public function resetPosition() : void
      {
         var btn:MainUIBtn = null;
         var p:Point = null;
         btn = HomeLandBtn.instance._btn;
         if(Boolean(btn.parent) && visible == true)
         {
            p = btn.parent.localToGlobal(new Point(btn.x,btn.y));
            x = p.x - this.width / 2 + btn.width / 2;
            y = p.y + btn.height;
         }
      }
      
      public function showIcon() : void
      {
         var _parent:DisplayObjectContainer = null;
         var p:Point = null;
         if(Boolean(Vo_TipPan.danQi))
         {
            if(!this.danqiIcon)
            {
               this.danqiIcon = new MainUIBtn(this.danqiUrl);
               this.danqiIcon.mouseChildren = false;
               this.danqiIcon.name = "danqi";
               this.danqiIcon.addEventListener(MouseEvent.CLICK,this.onIconClick);
            }
            if(Boolean(EnterHomeControl.instance.exitBtn) && Boolean(EnterHomeControl.instance.exitBtn.parent))
            {
               _parent = EnterHomeControl.instance.exitBtn.parent;
               p = this.setIconPos(0);
               if(!_parent.contains(this.danqiIcon))
               {
                  _parent.addChild(this.danqiIcon);
               }
               ComponentUtil.setPropertie(this.danqiIcon,{
                  "x":p.x,
                  "y":p.y
               });
            }
         }
         if(Vo_TipPan.tiLi == 1)
         {
            if(!this.tiliIcon)
            {
               this.tiliIcon = new MainUIBtn(this.tiliUrl);
               this.tiliIcon.mouseChildren = false;
               this.tiliIcon.name = "tili";
               this.tiliIcon.addEventListener(MouseEvent.CLICK,this.onIconClick);
            }
            if(Boolean(EnterHomeControl.instance.exitBtn) && Boolean(EnterHomeControl.instance.exitBtn.parent))
            {
               _parent = EnterHomeControl.instance.exitBtn.parent;
               p = this.setIconPos(1);
               if(!_parent.contains(this.tiliIcon))
               {
                  _parent.addChild(this.tiliIcon);
               }
               ComponentUtil.setPropertie(this.tiliIcon,{
                  "x":p.x,
                  "y":p.y
               });
            }
         }
      }
      
      public function updateIconPos(type:int) : void
      {
         var p:Point = this.setIconPos(type);
         if(type == 1)
         {
            if(Boolean(this.tiliIcon) && Boolean(this.tiliIcon.parent))
            {
               ComponentUtil.setPropertie(this.tiliIcon,{
                  "x":p.x,
                  "y":p.y
               });
            }
         }
      }
      
      private function setIconPos(type:int) : Point
      {
         var point:Point = null;
         if(BabyIcon.hasIcon)
         {
            if(type == 1)
            {
               if(Boolean(this.danqiIcon) && Boolean(this.danqiIcon.parent))
               {
                  point = new Point(EnterHomeControl.instance.exitBtn.x - 3 * 65,EnterHomeControl.instance.exitBtn.y);
               }
               else
               {
                  point = new Point(EnterHomeControl.instance.exitBtn.x - 2 * 65,EnterHomeControl.instance.exitBtn.y);
               }
            }
            else if(type == 0)
            {
               point = new Point(EnterHomeControl.instance.exitBtn.x - 2 * 65,EnterHomeControl.instance.exitBtn.y);
            }
         }
         else if(type == 1)
         {
            if(Boolean(this.danqiIcon) && Boolean(this.danqiIcon.parent))
            {
               point = new Point(EnterHomeControl.instance.exitBtn.x - 2 * 65,EnterHomeControl.instance.exitBtn.y);
            }
            else
            {
               point = new Point(EnterHomeControl.instance.exitBtn.x - 65,EnterHomeControl.instance.exitBtn.y);
            }
         }
         else if(type == 0)
         {
            point = new Point(EnterHomeControl.instance.exitBtn.x - 65,EnterHomeControl.instance.exitBtn.y);
         }
         return point;
      }
      
      public function removeIcon() : void
      {
         if(Boolean(this.tiliIcon) && Boolean(this.tiliIcon.parent))
         {
            this.tiliIcon.parent.removeChild(this.tiliIcon);
         }
         if(Boolean(this.danqiIcon) && Boolean(this.danqiIcon.parent))
         {
            this.danqiIcon.parent.removeChild(this.danqiIcon);
         }
      }
      
      private function onIconClick(e:MouseEvent) : void
      {
         if(e.target.name == "tili")
         {
            HomeLandCGMessage.CG_ASK_GETGOODS(1);
         }
         else if(e.target.name == "danqi")
         {
            Global.delegate.dosomething(View_GetDanQiPan.instance,function():void
            {
               View_GetDanQiPan.instance.visible = true;
               HomeLandCGMessage.CG_CLICK_DANQI();
            });
         }
      }
   }
}

