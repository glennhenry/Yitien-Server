package com.yiTian.view.modules.ship
{
   import com.ui.controls.Button;
   import com.ui.controls.MyTextField;
   import com.utils.ComponentUtil;
   import com.utils.Util;
   import com.yiTian.Global;
   import com.yiTian.gameUnit.GameUnit;
   import com.yiTian.gameUnit.config.Action;
   import com.yiTian.gameUnit.magic.Effect;
   import com.yiTian.manager.CameraManager;
   import com.yiTian.manager.EffectManager;
   import com.yiTian.manager.GameUnitManager;
   import com.yiTian.manager.UIManager;
   import com.yiTian.net.message.cg.BoatCGMessage;
   import com.yiTian.utils.AStar;
   import com.yiTian.utils.Singleton;
   import com.yiTian.utils.Tween;
   import com.yiTian.utils.Utils;
   import com.yiTian.utils.call.Delegate123;
   import com.yiTian.view.modules.boatChall.BoatBuff;
   import com.yiTian.view.modules.boatChall.BoatGrids;
   import com.yiTian.view.modules.boatChall.BoatManager;
   import com.yiTian.view.modules.boatChall.Child_DaoJiShi;
   import com.yiTian.view.modules.boatChall.EndTipPan;
   import com.yiTian.view.modules.boatChall.ShipCrues;
   import com.yiTian.view.modules.boatChall.VTip.V_returnBtn;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.filters.GlowFilter;
   import flash.geom.Point;
   import flash.utils.Dictionary;
   import flash.utils.clearTimeout;
   import flash.utils.getTimer;
   import flash.utils.setTimeout;
   
   public class Ship extends GameUnit
   {
      
      public static var nowSelectedShip:Ship;
      
      public static var myShip:Ship;
      
      public static var list:Dictionary = new Dictionary();
      
      public static var pool:Array = [];
      
      public static var endShipList:Array = [];
      
      public static var RUN_DISTANCE:int = 500;
      
      private static const wayPo:Array = [[[-57.5,-97,0],[24.5,-97,0]],[[-8,-97,30],[68.5,-61,30]],[[36.5,-101,60],[97.5,-32,60]],[[56.5,-87,90],[75.5,10,90]],[[43,-51,-30],[11,23,-30]],[[26.5,-44,-60],[-38.5,22,-43]],[[24.5,-5,0],[-62.5,-5,0]],[[-4.5,26,30],[-87.5,-47,30]],[[-57.5,32,60],[-92.5,-65,60]],[[-85.5,23,-90],[-83.5,-81,-90]],[[-126.5,-17,-60],[-76.5,-93,-60]],[[-99.5,-57,-30],[-32.5,-87,-30]]];
      
      public var _status:int;
      
      public var _way:int;
      
      public var modelId:int;
      
      private var _route:Array;
      
      private var start_x:int;
      
      private var start_y:int;
      
      private var end_x:int;
      
      private var end_y:int;
      
      private var dx:int;
      
      private var dy:int;
      
      private var _speed:int;
      
      private var nowSpeed:int;
      
      private var _action:int;
      
      private var lastTime:int;
      
      private var allTime:int;
      
      public var parts:Ship_part;
      
      private var rate:Number;
      
      public var idStr:String = "";
      
      public var index:int;
      
      private var _selected:Boolean;
      
      public var _position:int;
      
      public var bangId:Number = 0;
      
      public var quHao:int = 0;
      
      private var rentBtn:Button;
      
      private var _zhuanDong:Boolean;
      
      public var bool:Boolean = false;
      
      private var btn:Button;
      
      private var registerWay:int;
      
      public var boWen:BoatBuff;
      
      public var isStartingGame:Boolean = false;
      
      private var drawLine:Sprite;
      
      private var isCount:Boolean = false;
      
      private var counts:int;
      
      private var lCountTime:int;
      
      public var longJFId:int;
      
      private var lastHitTime:int;
      
      private var __lTime:int;
      
      private var shipNameBar:MyTextField;
      
      private var _sign:int = -10;
      
      private var yangFan:BoatBuff;
      
      private var bigGun:BoatBuff;
      
      public var isBoatBuffCouns:Boolean = false;
      
      public function Ship()
      {
         super();
         this.parts = new Ship_part(this);
         addChild(this.parts);
      }
      
      public static function get instance() : Ship
      {
         return pool.pop() || new Ship();
      }
      
      public static function canWalkable(global_x:int, global_y:int) : Boolean
      {
         if(AStar.getWalkable(global_x,global_y,false) || AStar.getWalkable(global_x,global_y,true))
         {
            return true;
         }
         return false;
      }
      
      public function set zhuanDong(value:Boolean) : void
      {
         this._zhuanDong = value;
         this.parts.setPartWay(0);
      }
      
      public function get zhuanDong() : Boolean
      {
         return this._zhuanDong;
      }
      
      public function init(idStr:String, status:int, action:int, name:String, global_x:int, global_y:int, speed:int, way:int, modelId:int) : void
      {
         this.idStr = idStr;
         this.name = name;
         this.global_x = global_x;
         this.global_y = global_y;
         this.speed = speed;
         this.way = way;
         this.action = action;
         this.status = status;
         this.speed = speed;
         if(!this.parts.hasAddEvent)
         {
            this.parts.addEvent();
         }
         this.updateModel(modelId);
      }
      
      public function bindBtn() : void
      {
         if(!this.rentBtn)
         {
            this.rentBtn = ComponentUtil.getButton("","Button_Orange7026",this,{
               "x":-34,
               "y":35
            },Global.Img_Cdm);
            this.rentBtn.addEventListener(MouseEvent.CLICK,this.rentEvent);
         }
         var label:String = "";
         if(this.sign == Enum_Ship_Sign.ON_RENT)
         {
            label = "租龙舟";
         }
         else if(this.sign == Enum_Ship_Sign.RENTED)
         {
            label = "加入";
         }
         else if(this.sign == Enum_Ship_Sign.SELF)
         {
            label = "退出";
         }
         this.setRentLabel(label);
      }
      
      public function unBindBtn() : void
      {
         if(Boolean(this.rentBtn) && Boolean(this.rentBtn.parent))
         {
            this.rentBtn.parent.removeChild(this.rentBtn);
         }
         if(Boolean(this.rentBtn))
         {
            this.rentBtn.removeEventListener(MouseEvent.CLICK,this.rentEvent);
         }
         this.rentBtn = null;
      }
      
      public function setRentLabel(value:String) : void
      {
         if(Boolean(this.rentBtn))
         {
            this.rentBtn.label = value;
            if(value == "加入")
            {
               this.bool = true;
            }
            else
            {
               this.bool = false;
            }
            this.shipStatusHandler();
         }
      }
      
      public function ship_glow(end_or_start:Boolean = false) : void
      {
         var glow:Function = function(gIndex:int):void
         {
            var arr:Array;
            var n:int;
            if(!bool)
            {
               return;
            }
            if(gIndex > 10)
            {
               gIndex = 1;
            }
            arr = [new GlowFilter(16776960,0.6,gIndex,gIndex,8,1)];
            if(Boolean(rentBtn))
            {
               rentBtn.filters = arr;
            }
            n = int(setTimeout(function():void
            {
               glow(++gIndex);
            },50));
         };
         if(end_or_start)
         {
            this.bool = true;
            glow(1);
         }
         else
         {
            this.bool = false;
            if(Boolean(this.rentBtn))
            {
               this.rentBtn.filters = [];
            }
         }
      }
      
      public function shipStatusHandler() : void
      {
         var ship:Ship = null;
         var _ship:Ship = null;
         if(Boolean(myShip))
         {
            for each(ship in list)
            {
               ship.ship_glow(false);
            }
         }
         else
         {
            for each(_ship in list)
            {
               if(Boolean(_ship.rentBtn) && _ship.rentBtn.label == "加入")
               {
                  _ship.ship_glow(true);
               }
               else
               {
                  _ship.ship_glow(false);
               }
            }
         }
      }
      
      private function rentEvent(e:MouseEvent) : void
      {
         if((e.target as Button).label == "退出")
         {
            BoatCGMessage.CG_QUIT_SHIP();
         }
         else
         {
            BoatCGMessage.CG_RENTSHIP(this.idStr);
         }
         e.stopPropagation();
      }
      
      private function showRotationBtn() : void
      {
         if(!this.btn)
         {
            this.btn = ComponentUtil.getButton("","Button_" + this.way,this,{
               "x":-71.5,
               "y":-97,
               "tabIndex":3
            },Global.FWLZdm);
         }
         this.btn.x = wayPo[this.way][this.position][0];
         this.btn.y = wayPo[this.way][this.position][1];
         if(this.position == 0)
         {
            this.btn.tabIndex = 3;
            this.btn.style = "Button_" + this.getRWay((this.way + 6) % 12);
         }
         else
         {
            this.btn.tabIndex = 4;
            this.btn.style = "Button_" + this.getRWay(this.way);
         }
         this.btn.callBack = this.changeRotation;
      }
      
      private function getRWay(value:int) : int
      {
         if(value > 11)
         {
            return 11;
         }
         if(value < 0)
         {
            return 0;
         }
         return value;
      }
      
      public function set position(value:int) : void
      {
         if(value == this._position)
         {
            return;
         }
         this._position = value;
         if(Boolean(this.btn))
         {
            this.btn.x = wayPo[this.way][value][0];
            this.btn.y = wayPo[this.way][value][1];
            if(this.position == 0)
            {
               this.btn.tabIndex = 3;
               this.btn.style = "Button_" + this.getRWay((this.way + 6) % 12);
            }
            else
            {
               this.btn.tabIndex = 4;
               this.btn.style = "Button_" + this.getRWay(this.way);
            }
         }
      }
      
      public function get position() : int
      {
         return this._position;
      }
      
      private function changeRotation(e:MouseEvent) : void
      {
         if(this.sign == Enum_Ship_Sign.END)
         {
            return;
         }
         BoatCGMessage.CG_BTNCLICK((e.target as Button).tabIndex,this.wayOperationOnBtnClick((e.target as Button).tabIndex));
      }
      
      private function wayOperationOnBtnClick(tabIndex:int) : int
      {
         var tempWay:int = 0;
         switch(tabIndex)
         {
            case 3:
               tempWay = this.way - 1 < 0 ? 11 : int(this.way - 1);
               break;
            case 4:
               tempWay = this.way + 1 > 11 ? 0 : int(this.way + 1);
         }
         return tempWay;
      }
      
      public function getAngle(way:int, CONST_LEN:int = 250) : Point
      {
         var gX:int = 0;
         var gY:int = 0;
         switch(way)
         {
            case 0:
               gX = global_x;
               gY = global_y - CONST_LEN;
               break;
            case 1:
               gX = global_x + CONST_LEN * 1 / 2;
               gY = global_y - CONST_LEN * 1.732 / 2;
               break;
            case 2:
               gX = global_x + CONST_LEN * 1.732 / 2;
               gY = global_y - CONST_LEN * 1 / 2;
               break;
            case 3:
               gX = global_x + CONST_LEN;
               gY = global_y;
               break;
            case 4:
               gX = global_x + CONST_LEN * 1.732 / 2;
               gY = global_y + CONST_LEN * 1 / 2;
               break;
            case 5:
               gX = global_x + CONST_LEN * 1 / 2;
               gY = global_y + CONST_LEN * 1.732 / 2;
               break;
            case 6:
               gX = global_x;
               gY = global_y + CONST_LEN;
               break;
            case 7:
               gX = global_x - CONST_LEN * 1 / 2;
               gY = global_y + CONST_LEN * 1.732 / 2;
               break;
            case 8:
               gX = global_x - CONST_LEN * 1.7321 / 2;
               gY = global_y + CONST_LEN * 1 / 2;
               break;
            case 9:
               gX = global_x - CONST_LEN;
               gY = global_y;
               break;
            case 10:
               gX = global_x - CONST_LEN * 1.7321 / 2;
               gY = global_y - CONST_LEN * 1 / 2;
               break;
            case 11:
               gX = global_x - CONST_LEN * 1 / 2;
               gY = global_y - CONST_LEN * 1.7321 / 2;
         }
         return new Point(gX,gY);
      }
      
      override public function mouseOver() : void
      {
         this.parts.getPart().transform.colorTransform = Util.colorGlow;
      }
      
      override public function mouseOut() : void
      {
         this.parts.getPart().transform.colorTransform = Util.colorNomal;
      }
      
      override public function interaction(mode:int = 0) : void
      {
         if(Boolean(myShip && (myShip.sign >= 0 || myShip.sign < -11)) && Boolean(this.sign == -2) && this.sign == -1)
         {
            return;
         }
         if(this.idStr != null && (Boolean(myShip && myShip.sign == -1 && myShip.sign == -2) || Boolean(myShip == null)))
         {
            BoatCGMessage.CG_SHIPERS(this.idStr);
         }
         if(GameUnitManager.hero.bindShip == null && this.sign == Enum_Ship_Sign.RENTED)
         {
            BoatCGMessage.CG_RENTSHIP(this.idStr);
         }
         if(Boolean(nowSelectedShip) && nowSelectedShip.selected)
         {
            nowSelectedShip.selected = false;
         }
         this.selected = true;
         nowSelectedShip = this;
      }
      
      public function set selected(value:Boolean) : void
      {
         if(value == this._selected)
         {
            return;
         }
         this._selected = value;
         if(value)
         {
            this.parts.getPart().transform.colorTransform = Util.colorGlow;
         }
         else
         {
            this.parts.getPart().transform.colorTransform = Util.colorNomal;
         }
      }
      
      public function get selected() : Boolean
      {
         return this._selected;
      }
      
      public function set status(value:int) : void
      {
         if(value == this._status)
         {
            return;
         }
         this._status = value;
      }
      
      public function get status() : int
      {
         return this._status;
      }
      
      public function set action(value:int) : void
      {
         if(value == this._action || this.sign == Enum_Ship_Sign.END)
         {
            return;
         }
         this._action = value;
         this.updateModel(this.modelId);
      }
      
      public function get action() : int
      {
         return this._action;
      }
      
      public function set way(value:int) : void
      {
         if(this._way == value)
         {
            return;
         }
         this._way = value;
         if(this.way > 11)
         {
            this.way = 11;
         }
         if(Boolean(this.boWen))
         {
            this.boWen.way = value;
         }
         if(Boolean(this.yangFan))
         {
            this.yangFan.way = value;
         }
         if(value > 0 && value < 6)
         {
            this.parts.scaleX = 1;
         }
         else
         {
            this.parts.scaleX = -1;
         }
         if(Boolean(this.btn))
         {
            this.btn.x = wayPo[this.way][this.position][0];
            this.btn.y = wayPo[this.way][this.position][1];
            if(this.position == 0)
            {
               this.btn.tabIndex = 3;
               this.btn.style = "Button_" + this.getRWay((this.way + 6) % 12);
            }
            else
            {
               this.btn.tabIndex = 4;
               this.btn.style = "Button_" + this.getRWay(this.way);
            }
         }
         UIManager.smallMap.refreshShip(this);
      }
      
      public function start_longZhou_chanllenge() : void
      {
         this.unBindBtn();
         this.isStartingGame = true;
         this.showRotationBtn();
      }
      
      public function end_longZhou_chanllenge() : void
      {
         this.isStartingGame = false;
      }
      
      public function get way() : int
      {
         return this._way;
      }
      
      public function updateModel(value:int) : void
      {
         this.modelId = value;
         this.parts.setPart(value,0);
         this.parts.reset();
      }
      
      override public function show() : void
      {
         super.show();
         list[this.idStr] = this;
      }
      
      public function set route(path:Array) : void
      {
         var rotation:Number = NaN;
         this._route = path;
         if(!this._route || !this._route.length)
         {
            this.action = Action.STAND;
            return;
         }
         var nextTarget:Array = this._route.shift();
         this.start_x = global_x;
         this.start_y = global_y;
         this.end_x = nextTarget[0];
         this.end_y = nextTarget[1];
         var len:int = Math.ceil(Math.sqrt((this.end_x - this.start_x) * (this.end_x - this.start_x) + (this.end_y - this.start_y) * (this.end_y - this.start_y)));
         if(len < 1)
         {
            this.moveOver();
            this.route = this._route;
            return;
         }
         if(this.end_x == this.start_x)
         {
            this.nowSpeed = this.speed;
         }
         else
         {
            this.nowSpeed = Math.sin(Math.PI / 3) * this.speed;
         }
         if(this.nowSpeed == 0)
         {
            this.end_x = this.start_x = global_x;
            this.end_y = this.start_y = global_y;
            align();
         }
         this.allTime = len / this.nowSpeed * 1000;
         this.lastTime = getTimer();
         this.dx = this.end_x - this.start_x;
         this.dy = this.end_y - this.start_y;
         if(this == myShip)
         {
            rotation = Math.atan2(this.end_y - this.start_y,this.end_x - this.start_x) * 180 / Math.PI + 180;
            UIManager.smallMap.setRotation(rotation);
            UIManager.mappanel.setRotation(rotation);
         }
      }
      
      public function get route() : Array
      {
         return this._route;
      }
      
      public function autoMove() : void
      {
         var path:Array = null;
         var _index:int = 0;
         var _way:int = 0;
         var point:Point = null;
         if(Boolean(AStar._grid))
         {
            if(!canWalkable(global_x,global_y))
            {
               _index = 1;
               _way = 0;
               do
               {
                  point = this.getAngle(_way,25 * _index);
                  if(canWalkable(point.x,point.y))
                  {
                     global_x = point.x;
                     global_y = point.y;
                     break;
                  }
                  _way++;
                  if(_way > 11)
                  {
                     _way = 0;
                     _index++;
                  }
               }
               while(_index <= 100);
            }
            path = this.getPath(global_x,global_y,this.way);
            if(Boolean(path.length) && Boolean(this.isStartingGame) && this == myShip)
            {
               BoatCGMessage.CG_SHIP_MVOES(path,this.way,1);
               this.action = Action.RUN;
               this.route = path;
            }
            else if(this == myShip)
            {
               this.action = Action.STAND;
               this.route = [];
               this.moveOver();
               BoatCGMessage.CG_SHIP_MVOES([[global_x,global_y]],this.way,2);
            }
         }
      }
      
      private function drawLineFunc(startX:int, startY:int, endX:int, endY:int) : void
      {
         if(!this.drawLine)
         {
            this.drawLine = new Sprite();
         }
      }
      
      private function getPath(global_x:int, global_y:int, way:int) : Array
      {
         var find_ph:Function = function(index:int):void
         {
            var point:Point = getAngle(way,30 * index);
            if(canWalkable(point.x,point.y))
            {
               find_ph(++index);
            }
            else if(index > 1)
            {
               patch = [[getAngle(way,30 * (index - 1)).x,getAngle(way,30 * (index - 1)).y]];
            }
         };
         var patch:Array = [];
         var i:int = 1;
         find_ph(i);
         return patch;
      }
      
      public function countTime(cnt:int) : void
      {
         this.counts = cnt;
         if(Boolean(this.btn))
         {
            this.btn.enabled = false;
            this.btn.label = this.counts + "";
         }
         this.isCount = true;
         this.lCountTime = getTimer();
      }
      
      private function beginCount(index:int) : void
      {
         if(Boolean(this.btn))
         {
            this.btn.label = index.toString();
         }
         if(index <= 0)
         {
            if(Boolean(this.btn))
            {
               this.btn.label = "";
               this.btn.enabled = true;
            }
            this.isCount = false;
            if(this.isBoatBuffCouns && this == myShip)
            {
               this.autoMove();
            }
            this.isBoatBuffCouns = false;
            if(this.zhuanDong)
            {
               this.parts.turnToNormal();
               this.zhuanDong = false;
               BoatCGMessage.CG_SEND_TO_SEVER_DEL(this.longJFId);
            }
         }
      }
      
      private function move(now:int) : void
      {
         var __toX:int = 0;
         var __toY:int = 0;
         var Pos:Array = null;
         var dis:int = 0;
         if(this.action == Action.RUN)
         {
            this.rate = (now - this.lastTime) / this.allTime;
            if(this.rate > 1)
            {
               if(Boolean(this._route) && Boolean(this._route.length))
               {
                  this.route = this._route;
               }
               else
               {
                  this.moveOver();
                  this.action = Action.STAND;
               }
            }
            else
            {
               __toX = this.rate * this.dx + this.start_x;
               __toY = this.rate * this.dy + this.start_y;
               global_x = this.rate * this.dx + this.start_x;
               global_y = this.rate * this.dy + this.start_y;
               if(now - this.lastHitTime >= 200 && this == myShip)
               {
                  for each(Pos in BoatBuff.boatPosDic)
                  {
                     if(this.parts.getPart().hitTestObject(Pos[0]))
                     {
                        if(Pos[2] == 35350)
                        {
                           dis = Utils.dist(Pos[0].global_x,Pos[0].global_y + 50,global_x,global_y);
                           if(dis <= 4900)
                           {
                              BoatCGMessage.CG_ESH_HAPPENS(1,Pos[1]);
                              break;
                           }
                        }
                        else
                        {
                           dis = Utils.dist(Pos[0].global_x,Pos[0].global_y,global_x,global_y);
                           if(dis <= 1600)
                           {
                              BoatCGMessage.CG_ESH_HAPPENS(4,Pos[1]);
                              break;
                           }
                        }
                     }
                  }
                  this.lastHitTime = now;
               }
               align();
               UIManager.smallMap.refreshShip(this);
            }
            if(now - this.__lTime >= 800 && this == myShip && ShipCrues.firstName == GameUnitManager.hero.name)
            {
               this.__lTime = now;
               BoatCGMessage.CG_SENDTO_SERVER_XY(global_x,global_y);
            }
         }
      }
      
      override public function set name(value:String) : void
      {
         super.name = value;
         if(!this.shipNameBar)
         {
            this.shipNameBar = ComponentUtil.getTextField("",this);
         }
         this.shipNameBar.text = value;
         if(Boolean(value) && value != "")
         {
            this.shipNameBar.htmlText = value + "的龙舟";
         }
         this.shipNameBar.x = -this.shipNameBar.width / 2;
         this.shipNameBar.y = -59;
      }
      
      override public function update(now:int) : void
      {
         this.parts.update(now);
         this.move(now);
         if(Boolean(this.boWen))
         {
            this.boWen.update(now);
         }
         if(Boolean(this.yangFan))
         {
            this.yangFan.update(now);
         }
         if(Boolean(this.bigGun))
         {
            this.bigGun.update(now);
         }
         if(this == myShip && this.isStartingGame)
         {
            CameraManager.wacth(global_x,global_y);
         }
         if(this.isCount)
         {
            if(now - this.lCountTime >= 1000)
            {
               this.beginCount(this.counts);
               --this.counts;
               this.lCountTime = now;
            }
         }
      }
      
      public function set sign(value:int) : void
      {
         var b:Bitmap = null;
         var nn:int = 0;
         var __nn:int = 0;
         var eff:Effect = null;
         this._sign = value;
         if(value == Enum_Ship_Sign.ON_RENT)
         {
            this.bindBtn();
            this.rentBtn.visible = true;
         }
         else if(value == Enum_Ship_Sign.RENTED)
         {
            this.bindBtn();
            this.rentBtn.visible = true;
         }
         else if(value == Enum_Ship_Sign.SELF)
         {
            myShip = this;
            if(BoatManager.isMyShipEnding)
            {
               BoatManager.isMyShipEnding = false;
               CameraManager.cameraFromTo(BoatManager.END_X,BoatManager.END_Y,BoatManager.WATCH_X,BoatManager.WATCH_Y,500,function():void
               {
                  var _temp_1:* = BoatManager;
                  BoatManager.END_Y = 0;
                  _temp_1.END_X = 0;
                  Global.isPlayingMarriageEffect = false;
                  Child_DaoJiShi.instance.visible = true;
                  EndTipPan.instance.hide();
                  if(Boolean(V_returnBtn.instance) && Boolean(V_returnBtn.instance.parent))
                  {
                     V_returnBtn.instance.hide(Global.stage);
                  }
                  BoatGrids.instance.hide();
               });
            }
         }
         else if(value == Enum_Ship_Sign.END)
         {
            if(this == myShip)
            {
               UIManager.centerBroadcast.addMsg("恭喜您所在帮会龙舟成功划完龙舟",1);
               b = new Bitmap();
               b.bitmapData = ComponentUtil.getBitmapData("Text_WCBS",Global.FWLZdm);
               ComponentUtil.setPropertie(b,{
                  "x":(Global.stage.stageWidth - 600) / 2,
                  "y":(Global.stage.stageHeight - 200) / 2
               });
               b.alpha = 0.3;
               Global.stage.addChild(b);
               b.scaleX = 4;
               b.scaleY = 4;
               Tween.to(b,500,{
                  "x":[b.x,(Global.stage.stageWidth - 150) / 2],
                  "y":[b.y,(Global.stage.stageHeight - 50) / 2],
                  "scaleX":[4,1],
                  "scaleY":[4,1],
                  "alpha":[0.3,1]
               },function(bb:Bitmap):void
               {
                  Tween.to(bb,500,{
                     "y":[bb.y,bb.y - 100],
                     "alpha":[1,0]
                  },function(bbb:Bitmap):void
                  {
                     if(Boolean(bbb) && Boolean(bbb.parent))
                     {
                        bbb.parent.removeChild(bbb);
                     }
                     bbb.bitmapData = null;
                     bbb = null;
                  });
               });
               myShip = null;
               this.isStartingGame = false;
               BoatManager.isMyShipEnding = true;
               BoatManager.END_X = global_x;
               BoatManager.END_Y = global_y;
               (Singleton.getInstance(Delegate123) as Delegate123).dosomething(EndTipPan.instance,EndTipPan.instance.show);
               V_returnBtn.instance.show(Global.stage);
               endShipList.push(this);
               if(endShipList.length > 50)
               {
                  BoatManager.removeUnit(endShipList.shift() as GameUnit);
               }
            }
         }
         else if(value > 0)
         {
            if(Boolean(this.rentBtn))
            {
               this.unBindBtn();
            }
            if(!this.boWen)
            {
               this.boWen = new BoatBuff();
               this.boWen.type = -11;
               this.boWen.init_buff(11111,0,0,35355);
               addChildAt(this.boWen,0);
            }
            if(this == myShip)
            {
               this.updateModel(12346);
            }
         }
         else if(value == Enum_Ship_Sign.PURIFY)
         {
            EffectManager.addEffect("35349",this,1000,0,-66);
            if(this.isBoatBuffCouns)
            {
               this.beginCount(0);
               if(this == myShip && this.action == Action.STAND)
               {
                  this.autoMove();
               }
            }
            if(this == myShip)
            {
               UIManager.centerBroadcast.addMsg("我们船使用了净化道具",1);
            }
         }
         else if(value == Enum_Ship_Sign.FIRING_GUN)
         {
            if(!this.bigGun)
            {
               this.bigGun = new BoatBuff();
               this.bigGun.type = Enum_Ship_Sign.FIRING_GUN;
               this.bigGun.way = this.way;
               this.bigGun.init_buff(11113,0,0,35354);
               addChild(this.bigGun);
            }
            nn = int(setTimeout(function():void
            {
               clearTimeout(nn);
               if(Boolean(bigGun) && Boolean(bigGun.parent))
               {
                  bigGun.parent.removeChild(bigGun);
               }
               if(Boolean(bigGun))
               {
                  bigGun.dispose();
               }
               bigGun = null;
            },500));
            if(this == myShip)
            {
               UIManager.centerBroadcast.addMsg("我们使用了高射炮道具",1);
            }
         }
         else if(value == Enum_Ship_Sign.HIT_BY_GUN)
         {
            EffectManager.addEffect("35352",this,1000,0,-66);
            EffectManager.addEffect("35353",this,3000,0,-66);
            this.isBoatBuffCouns = true;
            this.countTime(5);
            this.action = Action.STAND;
            if(this == myShip)
            {
               UIManager.centerBroadcast.addMsg("我们的船受到了高射炮攻击",1);
            }
         }
         else if(value == Enum_Ship_Sign.SET_SAIL)
         {
            if(!this.yangFan)
            {
               this.yangFan = new BoatBuff();
               this.yangFan.type = Enum_Ship_Sign.SET_SAIL;
               this.yangFan.way = this.way;
               this.yangFan.init_buff(11112,0,0,35356);
               if(this == myShip)
               {
                  addChildAt(this.yangFan,getChildIndex(this.btn) - 1);
               }
               else
               {
                  addChild(this.yangFan);
               }
            }
            __nn = int(setTimeout(function():void
            {
               clearTimeout(__nn);
               if(Boolean(yangFan) && Boolean(yangFan.parent))
               {
                  yangFan.parent.removeChild(yangFan);
                  yangFan.dispose();
               }
               yangFan = null;
            },5000));
            if(this == myShip)
            {
               UIManager.centerBroadcast.addMsg("我们的船使用了扬帆道具",1);
            }
         }
         else if(value == Enum_Ship_Sign.SET_TORPEDO)
         {
            eff = EffectManager.addEffect("35351",this,500,0,-60);
            if(this == myShip)
            {
               UIManager.centerBroadcast.addMsg("我们的船发射了鱼雷",1);
            }
         }
         else if(value == Enum_Ship_Sign.HIT_BY_TORPEDO)
         {
            EffectManager.addEffect("35352",this,1000,0,-66);
            EffectManager.addEffect("35353",this,5000,0,-66);
            this.action = Action.STAND;
            this.isBoatBuffCouns = true;
            this.countTime(5);
            if(this == myShip)
            {
               UIManager.centerBroadcast.addMsg("我们的船受到了鱼雷攻击，停止前进",1);
            }
         }
         else if(value == Enum_Ship_Sign.HIT_BY_TORNADO)
         {
            this.zhuanDong = true;
            this.isBoatBuffCouns = true;
            this.countTime(5);
            this.action = Action.STAND;
            if(this == myShip)
            {
               UIManager.centerBroadcast.addMsg("我们的船受到了龙卷风袭击，停止前进",1);
            }
         }
      }
      
      public function get sign() : int
      {
         return this._sign;
      }
      
      public function set speed(value:int) : void
      {
         if(value == this._speed)
         {
            return;
         }
         this._speed = value;
         if(Boolean(this._route) && this.action == Action.RUN)
         {
            this.parts.reset(value);
            if(this.end_x != 0 && this.end_y != 0)
            {
               this._route.unshift([this.end_x,this.end_y]);
               this.route = this._route;
            }
         }
      }
      
      public function get speed() : int
      {
         return this._speed;
      }
      
      private function moveOver() : void
      {
         var _temp_1:* = this;
         this.end_y = 0;
         _temp_1.end_x = 0;
      }
      
      override public function dispose() : void
      {
         pool.push(this);
         delete list[this.idStr];
         super.dispose();
         this.zhuanDong = false;
         if(this.parts.hasAddEvent)
         {
            this.parts.removeEvent();
         }
         if(Boolean(this.btn) && contains(this.btn))
         {
            removeChild(this.btn);
         }
         this.btn = null;
         this.parts.getPart().transform.colorTransform = Util.colorNomal;
         this.parts.rotation = 0;
         if(Boolean(this.rentBtn))
         {
            this.rentBtn.label = "租借";
         }
         if(Boolean(this.boWen) && Boolean(this.boWen.parent))
         {
            this.boWen.parent.removeChild(this.boWen);
         }
         this.boWen = null;
         if(Boolean(this.yangFan) && Boolean(this.yangFan.parent))
         {
            this.yangFan.parent.removeChild(this.yangFan);
         }
         this.yangFan = null;
         if(Boolean(this.bigGun) && Boolean(this.bigGun.parent))
         {
            this.bigGun.parent.removeChild(this.bigGun);
         }
         this.bigGun = null;
         this.isStartingGame = false;
         this.zhuanDong = false;
         this.shipNameBar.text = "";
         this._sign = -2;
         this._way = 0;
         visible = true;
      }
   }
}

