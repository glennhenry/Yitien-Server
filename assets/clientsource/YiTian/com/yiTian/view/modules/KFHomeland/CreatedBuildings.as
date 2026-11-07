package com.yiTian.view.modules.KFHomeland
{
   import com.ui.controls.MyTextField;
   import com.ui.controls.ScaleBitmap;
   import com.utils.ComponentUtil;
   import com.utils.DisplayData;
   import com.utils.ResObj;
   import com.yiTian.Global;
   import com.yiTian.gameUnit.GameUnit;
   import com.yiTian.gameUnit.config.State;
   import com.yiTian.manager.ResourceManager;
   import com.yiTian.scene.GameScene;
   import com.yiTian.utils.HtmlUtil;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   import flash.utils.Dictionary;
   import flash.utils.getTimer;
   
   public class CreatedBuildings extends GameUnit
   {
      
      public static const btnBitStrVec:Vector.<String> = new <String>["Icon_Dui","Icon_ShuaXin","Icon_Cuo","Icon_Chai"];
      
      public static var list:Dictionary = new Dictionary();
      
      public static var pool:Array = [];
      
      private var _bitBuildings:Bitmap;
      
      private var _btnVec:Vector.<SmallButton>;
      
      private var dragStatusBit:Bitmap;
      
      private var initDragBitW:int = 148;
      
      private var dragBitH:int = 40;
      
      private var greenCol:uint = 327424;
      
      private var redCol:uint = 16646144;
      
      private var fillRect:Rectangle;
      
      public var buffId:int;
      
      public var orient:int;
      
      public var xGrid:int;
      
      public var yGrid:int;
      
      public var bWidth:int;
      
      public var bHeight:int;
      
      public var needOccupyGridNum:int;
      
      private var _nameTxt:MyTextField;
      
      private var canTurn:int;
      
      private var sourceUrl:String = "modelRes/role/jiayuan/";
      
      private var isOwnerOut:int;
      
      private var oneInfo:InfoItemBuildings;
      
      private var _name:String;
      
      private var _colorStr:String;
      
      private var _lastScale:Number = 1;
      
      private var lastTime:int;
      
      private var res:ResObj;
      
      private var _way:int;
      
      private var oneOrient:DisplayData;
      
      private var otherOrient:DisplayData;
      
      private var _tipsTxt:MyTextField;
      
      private var border:ScaleBitmap;
      
      public function CreatedBuildings()
      {
         super();
         this.init();
      }
      
      private function init() : void
      {
         var i:int = 0;
         var btn:SmallButton = null;
         this._bitBuildings = new Bitmap();
         addChild(this._bitBuildings);
         this.dragStatusBit = new Bitmap();
         addChild(this.dragStatusBit);
         this.dragStatusBit.alpha = 0.4;
         var bitMapData:BitmapData = new BitmapData(this.initDragBitW,this.dragBitH,false,this.greenCol);
         this.dragStatusBit.bitmapData = bitMapData;
         this.fillRect = new Rectangle(0,0,this.dragStatusBit.width,this.dragStatusBit.height);
         this._btnVec = new Vector.<SmallButton>(4,true);
         i = 0;
         while(i < 4)
         {
            btn = new SmallButton(i);
            addChild(btn);
            if(i == 3)
            {
               btn.x = this.dragStatusBit.x + 1 * 46;
               btn.y = this.dragStatusBit.y + this.dragStatusBit.height - 1;
            }
            else
            {
               btn.x = this.dragStatusBit.x + i * 46;
               btn.y = this.dragStatusBit.y + this.dragStatusBit.height - 1;
            }
            btn.buttonMode = true;
            btn.visible = false;
            this._btnVec[i] = btn;
            btn.addEventListener(MouseEvent.CLICK,this.btnClkHandle);
            i++;
         }
         this.dragStatusBit.visible = false;
         this.orient = 1;
         this._nameTxt = ComponentUtil.getTextField("",this);
         this._nameTxt.visible = false;
         this.border = ComponentUtil.getScaleBitmap("Back_Floating",[8,9,4,2],this,{
            "x":0,
            "y":0,
            "width":87,
            "height":95
         },Global.Img_Cdm);
         addChild(this.border);
         this.border.visible = false;
         this._tipsTxt = ComponentUtil.getTextField("拆除家具需要消耗一张拆除符      拆除符在商铺和礼券商城中购买   拆除后的家具将在建筑背包中",this,{
            "x":0,
            "y":0,
            "color":16777215,
            "size":12,
            "leading":0,
            "realWidth":172,
            "multiline":true,
            "wordWrap":true
         });
         this._tipsTxt.visible = false;
      }
      
      private function clkSelHandle(evt:MouseEvent) : void
      {
         if(VoHome.isDismant)
         {
            this.dismantleHandle(evt);
         }
      }
      
      private function btnClkHandle(evt:MouseEvent) : void
      {
         var _curClkBtn:SmallButton = evt.target as SmallButton;
         switch(_curClkBtn._type)
         {
            case 0:
               this.sureHandle(evt);
               break;
            case 1:
               this.rotaryHandle(evt);
               break;
            case 2:
               this.canelHandle(evt);
               break;
            case 3:
               this.dismantleHandle(evt);
         }
      }
      
      public function set way(value:int) : void
      {
         if(!this._bitBuildings || !this.oneOrient)
         {
            return;
         }
         this.orient = value;
         if(this.canTurn == 1)
         {
            this._bitBuildings.scaleX = this.orient == 1 ? 1 : -1;
            if(value == 1)
            {
               this._bitBuildings.x = this.oneOrient.x;
            }
            else
            {
               this._bitBuildings.x = -this.oneOrient.x;
            }
         }
         else if(this._way == 2)
         {
            this._bitBuildings.bitmapData = null;
            if(this.orient == 1)
            {
               this._bitBuildings.x = this.oneOrient.x;
               this._bitBuildings.y = this.oneOrient.y;
               this._bitBuildings.bitmapData = this.oneOrient.p;
            }
            else if(this.orient == 2)
            {
               this._bitBuildings.x = this.otherOrient.x;
               this._bitBuildings.y = this.otherOrient.y;
               this._bitBuildings.bitmapData = this.otherOrient.p;
            }
         }
         this.adjustPosit();
      }
      
      public function get way() : int
      {
         return this.orient;
      }
      
      public function showBuildBtn(boo:Boolean) : void
      {
         var i:int = 0;
         while(i < 3)
         {
            this._btnVec[i].visible = boo;
            i++;
         }
      }
      
      public function get adjustX() : Number
      {
         return this._bitBuildings.x + this.bWidth * GameScene.homeScale;
      }
      
      public function get adjustY() : Number
      {
         return this.bHeight * (1 - GameScene.homeScale);
      }
      
      private function sureHandle(evt:MouseEvent) : void
      {
         this.dragStatusBit.visible = false;
         this.showBuildBtn(false);
         BuildAction.instance.sureBuilding();
         EnterHomeControl.instance.exitBuildHome();
      }
      
      private function canelHandle(evt:MouseEvent) : void
      {
         BuildAction.instance.canelBuilding();
      }
      
      private function rotaryHandle(evt:MouseEvent) : void
      {
         this.orient = this.orient == 1 ? 2 : 1;
         this.way = this.orient;
      }
      
      public function dismantleHandle(evt:MouseEvent) : void
      {
         EnterHomeControl.instance.exitDismanle();
         EnterHomeControl.dismantId = id;
         EnterHomeControl.xDismantGrid = this.xGrid;
         EnterHomeControl.yDismantGrid = this.yGrid;
         HomeLandCGMessage.CG_DISMANTLE(id,this.xGrid,this.yGrid,this.orient);
      }
      
      public function canSit() : void
      {
         if(!this.dragStatusBit)
         {
            return;
         }
         if(!this.dragStatusBit.visible)
         {
            this.dragStatusBit.visible = true;
         }
         if(Boolean(this.dragStatusBit.bitmapData))
         {
            this.dragStatusBit.bitmapData.fillRect(this.fillRect,this.greenCol);
         }
         this.adjustPosit();
      }
      
      public function noSit() : void
      {
         if(!this.dragStatusBit)
         {
            return;
         }
         if(!this.dragStatusBit.visible)
         {
            this.dragStatusBit.visible = true;
         }
         if(Boolean(this.dragStatusBit.bitmapData))
         {
            this.dragStatusBit.bitmapData.fillRect(this.fillRect,this.redCol);
         }
         this.adjustPosit();
      }
      
      override public function show() : void
      {
         super.show();
         state = State.LIFE;
      }
      
      public function dismantleStatus(boo:Boolean) : void
      {
         if(Boolean(this.dragStatusBit))
         {
            this.dragStatusBit.visible = boo;
         }
         if(Boolean(this._btnVec) && this._btnVec.length >= 4)
         {
            this._btnVec[3].visible = boo;
         }
         this.adjustPosit();
         this._nameTxt.visible = VoHome.isDismant;
         if(VoHome.isDismant)
         {
            this._nameTxt.htmlText = HtmlUtil.fontNoSize(this._name,this._colorStr);
            ComponentUtil.setPropertie(this._nameTxt,{
               "x":this.dragStatusBit.x + (this.initDragBitW - this._nameTxt.width) / 2,
               "y":this.dragStatusBit.y - 50
            });
         }
      }
      
      public function updateBInfo() : void
      {
         this.oneInfo = new InfoItemBuildings();
         this.oneInfo.id = id;
         if(VoHome.checkIsCarpet(id))
         {
            this.reOrder = 1;
         }
         else
         {
            this.reOrder = 9;
         }
         this.oneInfo.initListInfo();
         this.buffId = this.oneInfo.localDataArr[Enum_SortBuildins.BUFFID_ATT];
         this.needOccupyGridNum = this.oneInfo.localDataArr[Enum_SortBuildins.GRID_NEED];
         this._name = this.oneInfo.localDataArr[Enum_SortBuildins.NAME_ATT];
         this._colorStr = VoHome.colorVec[int(this.oneInfo.localDataArr[Enum_SortBuildins.COLOR_ATT])];
         this.isOwnerOut = this.oneInfo.localDataArr[Enum_SortBuildins.OUT_INNER];
         this.canTurn = this.oneInfo.localDataArr[Enum_SortBuildins.CAN_TURN];
         this.sourceUrl = "modelRes/role/jiayuan/" + id + ".swf";
         if(ResourceManager.hasLoaded(this.sourceUrl))
         {
            this.updateBitmap();
         }
         else
         {
            ResourceManager.load(this.sourceUrl);
            GameScene.instance.addFrameCallBack(this.runTime);
         }
      }
      
      public function setScale(scale:Number) : void
      {
         this._bitBuildings.scaleX = scale;
         if(VoHome.isOut == 1)
         {
            this._bitBuildings.scaleY = scale;
         }
         else
         {
            this._bitBuildings.scaleY = 0.9;
         }
         this.adjustPosit();
      }
      
      private function runTime() : void
      {
         if(getTimer() - this.lastTime >= 1000)
         {
            this.lastTime = getTimer();
            this.updateBitmap();
         }
      }
      
      private function updateBitmap() : void
      {
         if(!this._bitBuildings)
         {
            return;
         }
         this.res = ResourceManager.resourceIndex[this.sourceUrl];
         if(Boolean(this.res) && this.res.isLoad)
         {
            GameScene.instance.removeFrameCallBack(this.runTime);
            this._way = this.res.way;
            this.oneOrient = ResourceManager.find(this.res,0);
            this._bitBuildings.x = this.oneOrient.x;
            this._bitBuildings.y = this.oneOrient.y;
            this._bitBuildings.bitmapData = this.oneOrient.p;
            this.bWidth = this.oneOrient.p.width;
            this.bHeight = this.oneOrient.p.height;
            if(this._way > 1)
            {
               this.otherOrient = ResourceManager.find(this.res,1);
            }
            this.way = this.orient;
         }
      }
      
      private function adjustPosit() : void
      {
         var btn:SmallButton = null;
         var adjW:Number = NaN;
         if(!this._bitBuildings)
         {
            return;
         }
         if(this.orient == 2 && this._way == 1 && this.canTurn == 1)
         {
            this.dragStatusBit.x = -this._bitBuildings.x + (this._bitBuildings.width - this.initDragBitW) / 2;
         }
         else
         {
            this.dragStatusBit.x = this._bitBuildings.x + (this._bitBuildings.width - this.initDragBitW) / 2;
         }
         this.dragStatusBit.y = this._bitBuildings.y + this._bitBuildings.height - 70;
         var i:int = 0;
         while(i < 4)
         {
            btn = this._btnVec[i] as SmallButton;
            adjW = this.dragStatusBit.x + 14;
            if(i == 3)
            {
               btn.x = adjW + 1 * 46;
               btn.y = this.dragStatusBit.y + 4;
            }
            else
            {
               btn.x = adjW + i * 46;
               btn.y = this.dragStatusBit.y + 4;
            }
            i++;
         }
      }
      
      override public function mouseOver() : void
      {
         if(VoHome.isDismant)
         {
            this._tipsTxt.visible = true;
            ComponentUtil.setPropertie(this._tipsTxt,{
               "x":this.dragStatusBit.x - 60,
               "y":this.dragStatusBit.y + this.dragBitH + 10
            });
            this.border.visible = true;
            this.border.x = this._tipsTxt.x - 5;
            this.border.y = this._tipsTxt.y - 5;
            this.border.width = this._tipsTxt.width + 10;
            this.border.height = this._tipsTxt.height + 12;
         }
      }
      
      override public function mouseOut() : void
      {
         if(this._tipsTxt.visible)
         {
            this._tipsTxt.visible = false;
         }
         if(this.border.visible)
         {
            this.border.visible = false;
         }
      }
      
      override public function update(nowTime:int) : void
      {
         var res:ResObj = null;
         var temp:int = 0;
         var data:DisplayData = null;
         if(!this._bitBuildings)
         {
            return;
         }
         res = ResourceManager.resourceIndex[this.sourceUrl];
         if(Boolean(res) && res.isLoad)
         {
            if(res.way == 2)
            {
               temp = this.orient == 1 ? 0 : 1;
            }
            else
            {
               temp = 0;
            }
            data = ResourceManager.find(res,temp);
            this._bitBuildings.x = data.x;
            this._bitBuildings.y = data.y;
            this._bitBuildings.bitmapData = data.p;
            if(res.way == 1 && this.orient == 2 && this.canTurn == 1)
            {
               this._bitBuildings.scaleX = -1;
               this._bitBuildings.x = -data.x;
            }
         }
      }
      
      override public function align() : void
      {
         x = global_x;
         y = global_y;
      }
      
      public function reset() : void
      {
         if(this._btnVec[0].visible)
         {
            this.showBuildBtn(false);
         }
         if(this._btnVec[3].visible)
         {
            this.dismantleStatus(false);
         }
         if(this._nameTxt.visible)
         {
            this._nameTxt.visible = false;
         }
         if(this._tipsTxt.visible)
         {
            this._tipsTxt.visible = false;
         }
         if(this.border.visible)
         {
            this.border.visible = false;
         }
         id = 0;
         this.xGrid = 0;
         this.yGrid = 0;
         this.orient = 1;
         this.needOccupyGridNum = 0;
         this._way = 0;
         this.oneOrient = null;
         this.otherOrient = null;
         this.sourceUrl = "";
         this._bitBuildings.scaleX = 1;
         this._bitBuildings.bitmapData = null;
         this.canTurn = -1;
         this.res = null;
      }
      
      public function realDispose() : void
      {
         var i:int = 0;
         super.dispose();
         if(Boolean(this._btnVec))
         {
            i = 0;
            while(i < 4)
            {
               if(Boolean(this._btnVec[i]))
               {
                  this._btnVec[i].removeEventListener(MouseEvent.CLICK,this.btnClkHandle);
                  this._btnVec[i] = null;
               }
               i++;
            }
         }
         GameScene.instance.removeFrameCallBack(this.runTime);
         this._bitBuildings = null;
         this.dragStatusBit = null;
         this._btnVec = null;
      }
      
      override public function dispose() : void
      {
         var index:int = 0;
         this.mouseOut();
         if(Global.isInHome)
         {
            index = pool.indexOf(this);
            if(index >= 0)
            {
               pool.splice(index,1);
               this.realDispose();
            }
            else
            {
               pool.push(this);
            }
         }
         else
         {
            pool.length = 0;
            this.realDispose();
         }
      }
   }
}

import com.utils.ComponentUtil;
import com.yiTian.Global;
import com.yiTian.view.modules.KFHomeland.CreatedBuildings;
import flash.display.Sprite;

class SmallButton extends Sprite
{
   
   public var _type:int;
   
   public function SmallButton(type:int)
   {
      super();
      this._type = type;
      this.init();
   }
   
   private function init() : void
   {
      ComponentUtil.getBitmap(CreatedBuildings.btnBitStrVec[this._type],this,null,Global.KFJYdm);
   }
}
