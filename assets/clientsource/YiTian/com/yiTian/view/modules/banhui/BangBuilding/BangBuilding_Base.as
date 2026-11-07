package com.yiTian.view.modules.banhui.BangBuilding
{
   import com.ui.controls.MyTextField;
   import com.utils.ColorConstant;
   import com.utils.ComponentUtil;
   import com.utils.Util;
   import com.yiTian.Global;
   import com.yiTian.manager.TipManager;
   import com.yiTian.utils.HtmlUtil;
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import flash.display.DisplayObjectContainer;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   
   public class BangBuilding_Base extends Sprite
   {
      
      private var tf_buildingName:MyTextField;
      
      private var _tipString:String;
      
      private var _bmContainer:Sprite;
      
      protected var _btnContainer:Sprite;
      
      private var nameSp:Sprite;
      
      private var _displayObject:DisplayObject;
      
      private var tf_level:MyTextField;
      
      private var _level:int;
      
      private var _buildingType:int;
      
      private var _rollOverFunc:Function;
      
      private var _rollOutFunc:Function;
      
      private var _clickFunc:Function;
      
      public function BangBuilding_Base(parent:DisplayObjectContainer, proper:Object)
      {
         var key:String = null;
         super();
         for(key in proper)
         {
            this[key] = proper[key];
         }
         parent.addChild(this);
         this.initStaticViewer();
         this.initDynamicViewer();
         this.level = 0;
         this._buildingType = 0;
      }
      
      protected function initStaticViewer() : void
      {
         this._bmContainer = new Sprite();
         this.nameSp = new Sprite();
         var nameBG:Bitmap = ComponentUtil.getBitmap("NameBG",this.nameSp,null,Global.Bang_Imgsdm);
         this._btnContainer = new Sprite();
         this.tf_level = ComponentUtil.getTextField("",this.nameSp,{
            "x":60,
            "y":21.5
         });
         this.tf_buildingName = ComponentUtil.getTextField("",this.nameSp,{
            "x":17,
            "y":20
         });
         addChild(this._bmContainer);
         addChild(this.nameSp);
         addChild(this._btnContainer);
      }
      
      protected function initDynamicViewer() : void
      {
         this._btnContainer.visible = false;
         addEventListener(MouseEvent.ROLL_OVER,this.rollOverHandle);
         addEventListener(MouseEvent.ROLL_OUT,this.rollOutHandle);
         addEventListener(MouseEvent.CLICK,this.clickHandle);
         addEventListener(MouseEvent.MOUSE_MOVE,this.moveHandle);
         this._btnContainer.addEventListener(MouseEvent.MOUSE_MOVE,this.moveHandle2);
         this._btnContainer.addEventListener(MouseEvent.CLICK,this.clickHandle2);
         this.nameSp.mouseEnabled = false;
         this.nameSp.mouseChildren = false;
         buttonMode = true;
      }
      
      protected function setLabelPos(x:Number, y:Number) : void
      {
         this.nameSp.x = x;
         this.nameSp.y = y;
      }
      
      public function set viewer(value:DisplayObject) : void
      {
         if(Boolean(this._displayObject) && this._displayObject.parent == this._bmContainer)
         {
            this._bmContainer.removeChild(this._displayObject);
         }
         this._displayObject = value;
         this._bmContainer.addChild(value);
      }
      
      private function set tipString(value:String) : void
      {
         this._tipString = value;
      }
      
      protected function set buildingType(value:int) : void
      {
         this._buildingType = value;
         this.tf_buildingName.htmlText = HtmlUtil.font(Enum_BangMap.BulidingNameArr[value],ColorConstant.getColorStr(ColorConstant.ITEM_YELLOW),12);
         this.tipString = Enum_BangMap.TipStringArr[value];
      }
      
      protected function get buildingType() : int
      {
         return this._buildingType;
      }
      
      public function get buildingName() : String
      {
         return this.tf_buildingName.text;
      }
      
      public function set level(value:int) : void
      {
         this._level = value;
         this.tf_level.htmlText = HtmlUtil.font("LV." + value,ColorConstant.getColorStr(ColorConstant.ITEM_YELLOW),11);
      }
      
      public function get level() : int
      {
         return this._level;
      }
      
      public function set rollOverFunc(callBack:Function) : void
      {
         this.rollOverFunc = callBack;
      }
      
      public function set rollOutFunc(callBack:Function) : void
      {
         this._rollOutFunc = callBack;
      }
      
      public function set clickFunc(callBack:Function) : void
      {
         this._clickFunc = callBack;
      }
      
      private function moveHandle2(evt:MouseEvent) : void
      {
         evt.stopPropagation();
      }
      
      private function clickHandle2(evt:MouseEvent) : void
      {
         evt.stopPropagation();
      }
      
      private function moveHandle(evt:MouseEvent) : void
      {
         evt.stopPropagation();
         TipManager.update(this._tipString);
      }
      
      private function rollOverHandle(evt:MouseEvent) : void
      {
         evt.stopPropagation();
         this._bmContainer.transform.colorTransform = Util.colorGlow;
         if(this._rollOverFunc != null)
         {
            this._rollOverFunc();
         }
      }
      
      private function rollOutHandle(evt:MouseEvent) : void
      {
         evt.stopPropagation();
         this._bmContainer.transform.colorTransform = Util.colorNomal;
         this._btnContainer.visible = false;
         TipManager.hide();
         if(this._rollOutFunc != null)
         {
            this._rollOutFunc();
         }
      }
      
      private function clickHandle(evt:MouseEvent) : void
      {
         evt.stopPropagation();
         if(this._btnContainer.visible == false)
         {
            this._btnContainer.visible = true;
            this._btnContainer.x = evt.localX - this._btnContainer.width / 2;
            this._btnContainer.y = evt.localY - 35;
            if(this._clickFunc != null)
            {
               this._clickFunc();
            }
         }
      }
   }
}

