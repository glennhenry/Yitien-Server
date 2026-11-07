package com.yiTian.gameUnit.role
{
   import com.ui.controls.MyTextField;
   import com.utils.ColorConstant;
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.command.Enum_MsgType;
   import com.yiTian.data.Data_lib;
   import com.yiTian.data.Enum_SPStr;
   import com.yiTian.data.config.Enum_Direct;
   import com.yiTian.data.config.Enum_job;
   import com.yiTian.data.model.Model_heFu;
   import com.yiTian.gameUnit.IBattleUnit;
   import com.yiTian.gameUnit.config.Action;
   import com.yiTian.gameUnit.config.State;
   import com.yiTian.gameUnit.config.Status;
   import com.yiTian.gameUnit.config.UnitType;
   import com.yiTian.gameUnit.magic.Effect;
   import com.yiTian.manager.BattleUnitManager;
   import com.yiTian.manager.GameUnitManager;
   import com.yiTian.scene.GameScene;
   import com.yiTian.utils.Tween;
   import com.yiTian.utils.Utils;
   import com.yiTian.view.comp.SceneWords;
   import com.yiTian.view.modules.guangMingDing.View_battleMiJiComp;
   import com.yiTian.view.modules.pet.PetPanel;
   import com.yiTian.view.modules.shenBing.Enum_ShenBing;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.DisplayObject;
   import flash.geom.Matrix;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import flash.utils.Dictionary;
   import flash.utils.getTimer;
   import flash.utils.setTimeout;
   
   public class BattleUnit extends IBattleUnit
   {
      
      public static var list:Dictionary = new Dictionary();
      
      public static var pool:Array = [];
      
      private static const PETNAMES:Array = ["熊猫","布鲁","麒麟","企鹅"];
      
      private var _state:int;
      
      public var sysId:int;
      
      public var sex:int;
      
      public var job:int;
      
      public var level:int;
      
      protected var _speed:int = 1200;
      
      public var hp:int;
      
      public var hpMax:int;
      
      public var mp:int;
      
      public var mpMax:int;
      
      public var angry:int;
      
      public var angryMax:int;
      
      private var _battleGrid:Array;
      
      public var buffs:Array = [];
      
      private var __route:Array;
      
      public var init_x:int;
      
      public var init_y:int;
      
      private var start_x:int;
      
      private var start_y:int;
      
      private var end_x:int;
      
      private var end_y:int;
      
      private var dx:int;
      
      private var dy:int;
      
      private var lastTime:int;
      
      private var allTime:int;
      
      private var _way:int;
      
      private var _action:int;
      
      public var direction:int;
      
      public var position:String;
      
      public var parts:BattleUnitParts;
      
      public var effects:Effects;
      
      public var partTem:Bitmap;
      
      public var hpBar:DisplayObject;
      
      public var hpBack:DisplayObject;
      
      public var nameBar:MyTextField;
      
      protected var _shadow:String;
      
      protected var _body:String;
      
      protected var _weapon:String;
      
      protected var _tuowei:String;
      
      public var needGoBackDie:Boolean = false;
      
      public var miJiComp:View_battleMiJiComp;
      
      private var pet_type_bmp:Bitmap;
      
      public var hasEffBFBZ:Boolean = false;
      
      private var babyId:uint = 20102;
      
      private var attackTime:int;
      
      public var ck_special_sign:Boolean = false;
      
      private var rate:Number;
      
      private var angryEff:Effect;
      
      public var isUpdate:Boolean = false;
      
      private var _bodyLoaded:Boolean;
      
      private var moveEndCB:Function;
      
      private var _isDeadPlaying:Boolean = false;
      
      private var shadows:Array = [];
      
      private var effectDic:Dictionary = new Dictionary();
      
      private var jianyuEff:Effect;
      
      private var sty:int;
      
      public var listWords:Array = [];
      
      public function BattleUnit()
      {
         super();
         this.parts = new BattleUnitParts(this);
         this.parts.visible = false;
         addChild(this.parts);
         this.partTem = new Bitmap();
         this.partTem.x = -20;
         this.partTem.y = -95;
         addChild(this.partTem);
         this.nameBar = ComponentUtil.getTextField("",this,{
            "align":"center",
            "mouseEnabled":false,
            "multiline":true,
            "wordWrap":true,
            "leading":2,
            "color":16776960
         });
         this.nameBar.y = -135;
         this.miJiComp = new View_battleMiJiComp();
         this.miJiComp.x = 28;
         this.miJiComp.y = -125;
         addChild(this.miJiComp);
         this.effects = new Effects(this);
         this.hpBack = ComponentUtil.getDisplayObject("blood_back",this);
         this.hpBack.x = -this.hpBack.width / 2;
         this.hpBack.y = -118;
         this.hpBar = ComponentUtil.getDisplayObject("blood",this,{
            "height":4,
            "x":this.hpBack.x + 1,
            "y":this.hpBack.y + 1
         });
         this.pet_type_bmp = new Bitmap();
         addChild(this.pet_type_bmp);
         ComponentUtil.setPropertie(this.pet_type_bmp,{
            "x":this.hpBack.x - 38,
            "y":this.hpBack.y - 55
         });
         this.state = State.LIFE;
      }
      
      private static function getFlyWord(type:String, value:String, target:BattleUnit, initY:Number = -175) : void
      {
         var flyword:FlyWord = FlyWord.getFlyWord();
         target.addChild(flyword);
         flyword.init(value,type,initY);
      }
      
      private function set _route(v:Array) : void
      {
         this.__route = v;
      }
      
      private function get _route() : Array
      {
         return this.__route;
      }
      
      public function init(id:Number, type:int, sysId:int, status:int, Direction:int, position:String, Name:String, Hp:int, Hp_max:int, Mp:int, Mp_max:int, mapItem:Array, body1:int, body2:int, Weapon:int, buffer:Array, Sex:int, job:int, angry:int, Level:int, huiYuan:int, pet_type:int) : void
      {
         this.id = id;
         this.type = type;
         this.sysId = sysId;
         this.sex = Sex;
         this.job = job;
         this.level = Level;
         this.direction = Direction;
         this.position = position;
         var Body:int = body1;
         if(Boolean(this.pet_type_bmp))
         {
            this.pet_type_bmp.bitmapData = null;
         }
         if(this.type == UnitType.PET)
         {
            if(pet_type > 0)
            {
               Utils.getLoadBitmap("resource/image/pet/pet_0" + pet_type + ".png",this.pet_type_bmp);
            }
            if(Global.pf == "qqgame" || Global.pf == "3366")
            {
               Body = body2;
               if(Body == 20907 || Body == 20807)
               {
                  if(PETNAMES.indexOf(Name) != -1)
                  {
                     Name = "布鲁";
                  }
               }
               if(PetPanel.vecNewModelID.indexOf(body2) >= 0)
               {
                  Body = body2;
               }
            }
            else if(Global.pf == "qplus" || Global.pf == Enum_SPStr.GUANWANG || Enum_SPStr.isUnion(Global.pf))
            {
               Body = huiYuan;
               if(Body == 20908 || Body == 20808)
               {
                  if(PETNAMES.indexOf(Name) != -1)
                  {
                     Name = "企鹅";
                  }
               }
               if(PetPanel.vecNewModelID.indexOf(huiYuan) >= 0)
               {
                  Body = huiYuan;
               }
            }
            else
            {
               Body = body1;
               if(Body == 20906 || Body == 20806)
               {
                  if(PETNAMES.indexOf(Name) != -1)
                  {
                     Name = "麒麟";
                  }
               }
               if(PetPanel.vecNewModelID.indexOf(body1) >= 0)
               {
                  Body = body1;
               }
            }
            if(Body == 20901)
            {
               if(PETNAMES.indexOf(Name) != -1)
               {
                  Name = "熊猫";
               }
            }
         }
         if(this.type == UnitType.PLAYER)
         {
            Name = Model_heFu.repNameByHero(Name);
            Name = Model_heFu.repsServName2(Name);
         }
         else if(this.type == UnitType.NPC)
         {
            if(Boolean(Data_lib.npcNameHeight[sysId]) && Boolean(Data_lib.npcNameHeight[sysId][1]))
            {
               this.setNameHeight(Data_lib.npcNameHeight[sysId][1]);
            }
         }
         this.name = Name;
         this.battleGrid = mapItem;
         this.setShadow("11");
         this.setBody(Body.toString());
         this.setWeapon(Weapon.toString());
         this.buffs = buffer;
         this.setInfo(Hp,Hp_max,Mp,Mp_max,angry,100);
         this.state = State.LIFE;
         Global.control.sendNotification(Enum_MsgType.BATTLEUNIT_INIT,this);
      }
      
      private function setNameHeight(y:int = 135) : void
      {
         this.nameBar.y = -y;
         this.hpBack.y = this.nameBar.y + 17;
         this.pet_type_bmp.y = this.hpBack.y - 55;
         this.hpBar.y = this.hpBack.y + 1;
         this.miJiComp.y = this.hpBar.y - 10;
      }
      
      public function set battleGrid(value:Array) : void
      {
         this._battleGrid = value;
         this.init_x = value[0];
         this.init_y = value[1];
         x = this.init_x;
         y = this.init_y;
      }
      
      public function get battleGrid() : Array
      {
         return this._battleGrid;
      }
      
      override public function show() : void
      {
         list[id] = this;
         this.nameBar.realWidth = name.length * 14;
         this.nameBar.x = -this.nameBar.width / 2;
         this.nameBar.text = name;
         this.action = Action.STAND;
      }
      
      private function setNameColor() : void
      {
         if(this.sysId == 55027)
         {
            this.nameBar.color = ColorConstant.getColorInt(ColorConstant.WHITE);
         }
         else if(this.sysId == 55028)
         {
            this.nameBar.color = ColorConstant.getColorInt(ColorConstant.GREEN);
         }
         else if(this.sysId == 55029)
         {
            this.nameBar.color = ColorConstant.getColorInt(ColorConstant.BLUE);
         }
         else if(this.sysId == 55030)
         {
            this.nameBar.color = ColorConstant.getColorInt(ColorConstant.PURPLE);
         }
         else
         {
            this.nameBar.color = 16776960;
         }
      }
      
      public function turn_to_normal() : void
      {
         this.hasEffBFBZ = false;
         this.parts.removeBFBZEff();
      }
      
      public function setShadow(value:String, skillUrl:String = "") : void
      {
         this.parts.setPart(BattleUnitParts.SHADOW,value + skillUrl);
         this._shadow = value;
      }
      
      public function setBody(value:String, skillUrl:String = "") : void
      {
         if(Global.pf == "qqgame")
         {
            if(value == "20906")
            {
               value = "20907";
            }
         }
         this.parts.setPart(BattleUnitParts.BODY,value + (skillUrl == "" ? "" : "_" + skillUrl));
         this._body = value;
      }
      
      public function getBody() : String
      {
         return this._body;
      }
      
      public function setWeapon(value:String, skillUrl:String = "") : void
      {
         this.parts.setPart(BattleUnitParts.WEAPON,value + (skillUrl == "" ? "" : "_" + skillUrl));
         this._weapon = value;
      }
      
      public function getWeapon() : String
      {
         return this._weapon;
      }
      
      public function set weaponVisible(value:Boolean) : void
      {
         this.parts.getPart(BattleUnitParts.WEAPON).visible = value;
      }
      
      override public function update(now:int) : void
      {
         this.effects.update(now);
         this.parts.update(now);
         this.move(now);
      }
      
      public function attack(actionUrl:int, attackTime:int) : void
      {
         this.attackTime = attackTime;
         this.action = Action.ATTACT;
         if(Boolean(actionUrl))
         {
            this.setBody(this._body,actionUrl.toString());
            this.setWeapon(this._weapon,actionUrl.toString());
         }
      }
      
      public function showbbAcionts(endCall:Function) : void
      {
         this.parts.showBBA(endCall);
      }
      
      public function addEffBFBZ(endCall:Function) : void
      {
         this.hasEffBFBZ = true;
         this.parts.EffBFBZ(endCall);
      }
      
      protected function move(now:int) : void
      {
         if(this.action != Action.RUN)
         {
            return;
         }
         this.rate = (now - this.lastTime) / this.allTime;
         if(!this._route)
         {
            return;
         }
         if(this.rate > 1)
         {
            if(Boolean(this._route.length))
            {
               this.route = this._route;
            }
            else
            {
               x = this.end_x;
               y = this.end_y;
            }
            this.onMoveEnd();
         }
         else
         {
            x = this.rate * this.dx + this.start_x;
            y = this.rate * this.dy + this.start_y;
         }
      }
      
      private function onMoveEnd() : void
      {
         if(this.needGoBackDie)
         {
            this.state = State.DEAD;
            if(type == UnitType.NPC)
            {
               this.playDead();
            }
            else
            {
               this.action = Action.DEAD;
            }
            this.needGoBackDie = false;
         }
         else
         {
            this.action = Action.STAND;
         }
         if(this.moveEndCB != null)
         {
            this.moveEndCB();
            this.moveEndCB = null;
         }
      }
      
      public function setValue(hp:int, hpMax:int, mp:int, mpMax:int) : void
      {
         var time:int = 0;
         this.hp = hp;
         this.hpMax = hpMax;
         this.mp = mp;
         this.mpMax = mpMax;
         var cur:Number = this.hpBar.width;
         var _per:Number = hp / hpMax > 1.2 ? 1 : hp / hpMax;
         var nxt:Number = _per * (this.hpBack.width - 2);
         if(nxt <= 0)
         {
            time = 800;
         }
         else
         {
            time = 1300;
         }
         Tween.to(this.hpBar,time,{"width":[cur,nxt]},null,null,Tween.SIN);
         if(this.needGoBackDie)
         {
            if(hp <= 0)
            {
               this.state = State.DEAD;
            }
            else
            {
               if(this.action == Action.DEAD)
               {
                  this.action = Action.STAND;
               }
               this.state = State.LIFE;
            }
         }
         this.isUpdate = true;
      }
      
      public function setInfo(hp:int, hpMax:int, mp:int, mpMax:int, angry:int, angryMax:int, canShowDead:Boolean = true) : void
      {
         var time:int = 0;
         if(Model_heFu.equalId(GameUnitManager.hero.id,this.id,parseInt(Global.zoneid)))
         {
            GameScene.battleLayer.updateMenuInfo(hp,hpMax,mp,mpMax,angry);
         }
         this.hp = hp;
         this.hpMax = hpMax;
         this.mp = mp;
         this.mpMax = mpMax;
         if(type == UnitType.PLAYER && GameUnitManager.hero.status != Status.KUN_LUN)
         {
            if(this.angry != 100 && angry == 100)
            {
               if(!this.angryEff && type == UnitType.PLAYER)
               {
                  this.angryEff = this.addEffect("35009",true);
               }
            }
            if(this.angry == 100 && angry != 100)
            {
               this.removeAngryEff();
            }
         }
         this.angry = angry;
         this.angryMax = angryMax;
         var cur:Number = this.hpBar.width;
         var _per:Number = hp / hpMax > 1.2 ? 1 : hp / hpMax;
         var nxt:Number = _per * (this.hpBack.width - 2);
         if(nxt <= 0)
         {
            time = 800;
         }
         else
         {
            time = 1300;
         }
         Tween.to(this.hpBar,time,{"width":[cur,nxt]},null,null,Tween.SIN);
         if(canShowDead && !this.needGoBackDie)
         {
            if(hp <= 0)
            {
               this.state = State.DEAD;
            }
            else
            {
               if(this.action == Action.DEAD)
               {
                  this.action = Action.STAND;
               }
               this.state = State.LIFE;
            }
         }
         this.isUpdate = true;
         Global.control.sendNotification(Enum_MsgType.BATTLEUNIT_UPDATE,this);
      }
      
      private function removeAngryEff() : void
      {
         if(Boolean(this.angryEff))
         {
            this.removeEffect(this.angryEff);
            this.angryEff = null;
         }
      }
      
      public function set action(value:int) : void
      {
         this._action = value;
         if(value == Action.STAND)
         {
            if(this.direction == Enum_Direct.SELF)
            {
               this.way = 7;
            }
            else
            {
               this.way = 3;
            }
         }
         else if(value != Action.RUN)
         {
            if(this.direction == Enum_Direct.SELF)
            {
               this.way = 0;
            }
            else
            {
               this.way = 1;
            }
            if(this._action == Action.HIT)
            {
               this.playHitMove();
            }
         }
         this.parts.reset(value,this.speed,this.attackTime);
         if(this.action != Action.ATTACT || type != UnitType.PLAYER)
         {
            this.setBody(this._body);
            this.setWeapon(this._weapon);
         }
         this.setLayerSwap();
      }
      
      public function get action() : int
      {
         return this._action;
      }
      
      public function get state() : int
      {
         return this._state;
      }
      
      public function set state(value:int) : void
      {
         this._state = value;
      }
      
      public function set way(value:int) : void
      {
         if(this._action == Action.STAND || this._action == Action.RUN)
         {
            this.parts.scaleX = value < 5 ? 1 : -1;
         }
         else
         {
            this.parts.scaleX = this.direction == Enum_Direct.SELF ? -1 : 1;
         }
         this._way = value;
         this.setLayerSwap();
      }
      
      public function get way() : int
      {
         return this._way;
      }
      
      private function setLayerSwap() : void
      {
         var data:Array = null;
         var isWeaponDown:int = 0;
         if(this._action == Action.STAND || this._action == Action.RUN)
         {
            data = Data_lib.avater[Enum_job.getBaseJob(this.job) + "" + this.sex];
            if(Boolean(data))
            {
               isWeaponDown = int(data[this.action * 5 + (this.way < 5 ? this.way : 8 - this.way)]);
               this.parts.changePart(isWeaponDown);
            }
         }
         else
         {
            this.parts.changePart(0);
         }
      }
      
      public function set bodyLoaded(value:Boolean) : void
      {
         if(value == this._bodyLoaded)
         {
            return;
         }
         this.partTem.visible = !value;
         this._bodyLoaded = value;
         if(value)
         {
            this.parts.visible = true;
         }
         else
         {
            this.parts.visible = false;
         }
      }
      
      public function get bodyLoaded() : Boolean
      {
         return this._bodyLoaded;
      }
      
      public function get speed() : int
      {
         return this._speed;
      }
      
      public function set speed(value:int) : void
      {
         if(this._speed == value)
         {
            return;
         }
         this._speed = value;
      }
      
      public function mouseOver() : void
      {
      }
      
      public function mouseOut() : void
      {
      }
      
      public function runTo(toX:int, toY:int, moveEndCallBack:Function = null) : void
      {
         this.moveEndCB = moveEndCallBack;
         this.route = [[toX,toY]];
         this.action = Action.RUN;
         if(this.direction == Enum_Direct.SELF)
         {
            this.way = 7;
         }
         else
         {
            this.way = 3;
         }
      }
      
      public function runBack() : void
      {
         this.ck_special_sign = false;
         this.route = [[this.init_x,this.init_y]];
         this.action = Action.RUN;
         if(this.direction == Enum_Direct.SELF)
         {
            this.way = 3;
         }
         else
         {
            this.way = 7;
         }
      }
      
      private function playHitMove() : void
      {
         var dir:Number = this.direction == 1 ? -1 : 1;
         Tween.to(this,60,{
            "x":[x,x - dir * 15],
            "y":[y,y - dir * 15 * 3 / 7]
         },this.hitStand);
      }
      
      private function hitStand() : void
      {
         Tween.to(this,180,null,this.hitBack);
      }
      
      private function hitBack() : void
      {
         Tween.to(this,60,{
            "x":[x,this.init_x],
            "y":[y,this.init_y]
         });
      }
      
      public function playKickBack() : void
      {
         var dir:Number = this.direction == 1 ? -1 : 1;
         Tween.to(this,120,{
            "x":[x,x - dir * 150],
            "y":[y,y - dir * 150 * 3 / 7]
         });
      }
      
      public function playDead() : void
      {
         if(this._isDeadPlaying)
         {
            return;
         }
         this._isDeadPlaying = true;
         Tween.to(this,200,{"alpha":[1,0.3]},this.remove);
      }
      
      private function remove() : void
      {
         alpha = 1;
         BattleUnitManager.removeUnit(this);
      }
      
      public function dodge() : void
      {
         this.dodgeOut();
      }
      
      public function dodgeOut() : void
      {
         var rate:int = this.direction == Enum_Direct.SELF ? -1 : 1;
         Tween.to(this,150,{
            "x":[x,x - rate * 70],
            "y":[y,y - rate * 15]
         },this.dodgeBack);
      }
      
      public function dodgeBack() : void
      {
         Tween.to(this,150,{
            "x":[x,this.init_x],
            "y":[y,this.init_y]
         });
      }
      
      private function drawDodgeShadow(alpha:Number, time:int) : void
      {
         var bitmap:Bitmap = null;
         var _rect:Rectangle = null;
         bitmap = new Bitmap(new BitmapData(this.parts.width,this.parts.height));
         _rect = this.parts.getBounds(this);
         bitmap.bitmapData.draw(this.parts,new Matrix(1,0,0,1,this.parts.x - _rect.x,this.parts.y - _rect.y));
         addChild(bitmap);
         bitmap.x = x - this.init_x - _rect.x;
         bitmap.y = y - this.init_y - _rect.y;
         bitmap.scaleX = this.way == 7 ? -1 : 1;
         bitmap.alpha = alpha;
         this.shadows.push(bitmap);
      }
      
      private function removeShadow() : void
      {
         var len:int = int(this.shadows.length);
         var i:int = len - 1;
         while(i >= 0)
         {
            setTimeout(function(bm:Bitmap):void
            {
               removeChild(bm);
               shadows.splice(shadows.indexOf(bm),1);
               bm.bitmapData.dispose();
            },i * 30,this.shadows[i]);
            i--;
         }
      }
      
      public function set route(path:Array) : void
      {
         if(this.state == State.DEAD || this.action == Action.DEAD)
         {
            return;
         }
         this._route = path;
         if(!this._route)
         {
            this.action = Action.STAND;
            return;
         }
         var nextTarget:Array = this._route.shift();
         this.start_x = x;
         this.start_y = y;
         this.end_x = nextTarget[0];
         this.end_y = nextTarget[1];
         var len:int = Math.ceil(Math.sqrt((this.end_y - this.start_y) * (this.end_y - this.start_y) + (this.end_x - this.start_x) * (this.end_x - this.start_x)));
         this.allTime = 300;
         this.lastTime = getTimer();
         this.dx = this.end_x - this.start_x;
         this.dy = this.end_y - this.start_y;
      }
      
      public function addShenBing(sb:int) : void
      {
         var type:int = 0;
         var newSbbuff:Array = null;
         if(!this.miJiComp.sbMap[sb])
         {
            type = int(Data_lib.sbSkill[sb][Enum_ShenBing.SKILL_TYPE]);
            newSbbuff = [sb];
         }
         this.miJiComp.addShenBing(sb);
      }
      
      public function setShenBing(sb:Array) : void
      {
         var sbIds:Array = null;
         var sbId:int = 0;
         var launcherId:Number = NaN;
         var launcher:BattleUnit = null;
         var skillType:int = 0;
         var singleEff1:int = 0;
         var newsSbbuff:Array = [];
         var myId:Number = GameUnitManager.hero.id;
         for each(sbIds in sb)
         {
            sbId = int(sbIds[0]);
            launcherId = Number(sbIds[1]);
            launcher = BattleUnitManager.findUnit(launcherId);
            if(!this.miJiComp.sbMap[sbId])
            {
               if(Boolean(launcher))
               {
                  if(launcherId % 1000000 == myId % 1000000)
                  {
                     newsSbbuff.push(sbId);
                  }
                  singleEff1 = int(Data_lib.sbSkill[sbId][Enum_ShenBing.SKILL_PERSON_EFF_1]);
                  if(singleEff1 != 0)
                  {
                     this.addEffect(singleEff1.toString(),false);
                  }
               }
               skillType = int(Data_lib.sbSkill[sbId][Enum_ShenBing.SKILL_SKILLTYPE]);
               if(skillType == 2)
               {
                  getFlyWord(FlyWord.POFANG,"",this,-205);
               }
               else if(skillType == 5)
               {
                  getFlyWord(FlyWord.FU_MINGZHONG,"",this,-205);
               }
            }
         }
         if(Boolean(newsSbbuff.length))
         {
            GameScene.battleLayer.showShenBingIcon(newsSbbuff,1);
         }
         this.miJiComp.setShenBingBuf(sb);
      }
      
      public function removeShenBing(sb:int) : void
      {
         this.miJiComp.removeShenBing(sb);
      }
      
      public function addEffs(bufIds:Array, bufPositions:Array) : void
      {
         var oldId:String = null;
         var len:int = 0;
         var i:int = 0;
         var k:String = null;
         var effID:String = null;
         var shenBingPersonEff:int = 0;
         for(oldId in this.effectDic)
         {
            if(!(oldId == "35009" || oldId == "35306" || oldId == "35308"))
            {
               if(!this.checkExist(int(oldId),bufIds))
               {
                  this.removeEffect(this.effectDic[oldId]);
               }
            }
         }
         len = int(bufIds.length);
         i = 0;
         while(i < len)
         {
            effID = bufIds[i];
            this.addEffect(effID,true,0,0,900,-1,null,0,bufPositions[i]);
            i++;
         }
         for(k in this.miJiComp.sbMap)
         {
            shenBingPersonEff = int(Data_lib.sbSkill[k][Enum_ShenBing.SKILL_PERSON_EFF]);
            if(shenBingPersonEff != 0)
            {
               this.addEffect(shenBingPersonEff.toString(),true,0,0,1500,-1,null,0,this.direction == Enum_Direct.SELF ? 1 : 0);
            }
         }
      }
      
      private function checkExist(oldId:int, bufIds:Array) : Boolean
      {
         var len:int = int(bufIds.length);
         var i:int = 0;
         while(i < len)
         {
            if(bufIds[i] == oldId)
            {
               return true;
            }
            i++;
         }
         return false;
      }
      
      public function addEffect(sourceID:String, isLoop:Boolean, px:int = 0, py:int = 0, totalTime:int = 1000, count:int = -1, endCallBack:Function = null, isTarget:int = 0, isDown:int = 0) : Effect
      {
         if(Boolean(this.effectDic[sourceID]))
         {
            return null;
         }
         var effect:Effect = Effect.getEffect();
         effect.init(sourceID);
         effect.totalTime = totalTime;
         effect.isLoop = isLoop;
         effect.px = px;
         effect.py = py;
         effect.count = count;
         effect.endCallBack = endCallBack;
         effect.direct = this.direction == Enum_Direct.SELF ? isTarget : (isTarget == 1 ? 0 : 1);
         this.effects.addEffect(effect,isDown);
         if(isLoop)
         {
            this.effectDic[sourceID] = effect;
         }
         return effect;
      }
      
      public function removeEffect(effect:Effect, recycle:Boolean = true) : void
      {
         var effid:String = null;
         for(effid in this.effectDic)
         {
            if(this.effectDic[effid] == effect)
            {
               delete this.effectDic[effid];
               break;
            }
         }
         this.effects.removeEffect(effect,recycle);
      }
      
      public function removeBuffByID(effid:int) : void
      {
         if(Boolean(this.effectDic[effid]))
         {
            this.effects.removeEffect(this.effectDic[effid]);
            delete this.effectDic[effid];
         }
      }
      
      public function addJianyu() : void
      {
         if(!this.jianyuEff)
         {
            this.jianyuEff = this.addEffect("32806",true,0,0,150);
         }
      }
      
      public function removeJianyu() : void
      {
         if(Boolean(this.jianyuEff))
         {
            this.removeEffect(this.jianyuEff);
            this.jianyuEff = null;
         }
      }
      
      public function say(text:String, data:Object = null) : void
      {
         var wds:SceneWords = null;
         var word:SceneWords = SceneWords.getWord();
         word.data = data;
         word.text = text;
         this.listWords.push(word);
         if(this.listWords.length > 3)
         {
            wds = this.listWords.shift();
            wds.remove();
         }
         this.sty = this.nameBar.y - word.height - 10;
         word.show(new Point(-word.width / 2,this.nameBar.y - word.height - 10),this);
         this.resize();
      }
      
      public function resize() : void
      {
         var words:SceneWords = null;
         var nowY:int = this.sty;
         var i:int = this.listWords.length - 1;
         while(i >= 0)
         {
            words = this.listWords[i];
            words.y = nowY;
            nowY -= words.height;
            i--;
         }
      }
      
      override public function dispose() : void
      {
         var effid:String = null;
         if(this.needGoBackDie)
         {
            this.needGoBackDie = false;
         }
         this.setNameHeight();
         this.state = State.LIFE;
         this.action = Action.STAND;
         this.weaponVisible = true;
         this.parts.dispose();
         this.removeJianyu();
         this.removeAngryEff();
         for(effid in this.effectDic)
         {
            if(Boolean(this.effectDic[effid]))
            {
               this.effects.removeEffect(this.effectDic[effid],true);
               delete this.effectDic[effid];
            }
         }
         this.effects.dispose();
         this.miJiComp.clearShenBing();
         this.miJiComp.clearBufIcon();
         filters = [];
         this._isDeadPlaying = false;
         this.hasEffBFBZ = false;
         this.hpBar.visible = true;
         this.hpBack.visible = true;
         this.nameBar.visible = true;
         this.babyId = 0;
         if(alpha != 1)
         {
            alpha = 1;
         }
         scaleX = 1;
         scaleY = 1;
         delete list[id];
         pool.push(this);
      }
   }
}

import com.yiTian.gameUnit.magic.Effect;
import com.yiTian.gameUnit.role.BattleUnit;
import com.yiTian.utils.Utils;

class Effects
{
   
   private var role:BattleUnit;
   
   public var list:Vector.<Effect> = new Vector.<Effect>();
   
   public function Effects(role:BattleUnit)
   {
      super();
      this.role = role;
   }
   
   public function addEffect(effect:Effect, isDown:int = 0) : void
   {
      this.list.push(effect);
      if(Boolean(isDown))
      {
         this.role.addChildAt(effect,this.role.getChildIndex(this.role.parts));
      }
      else
      {
         this.role.addChild(effect);
      }
   }
   
   public function removeEffect(effect:Effect, recycle:Boolean = true) : void
   {
      if(effect.endCallBack != null)
      {
         effect.endCallBack();
      }
      this.list.splice(this.list.indexOf(effect),1);
      if(Boolean(effect.parent))
      {
         effect.parent.removeChild(effect);
      }
      else
      {
         Utils.print("战斗特效： " + effect.url + " " + effect.totalTime + " " + effect.beginTime + " " + effect.current);
      }
      if(recycle)
      {
         effect.dispose();
      }
   }
   
   public function update(now:int) : void
   {
      var effect:Effect = null;
      var i:int = this.list.length - 1;
      while(i >= 0)
      {
         effect = this.list[i];
         if(now - effect.beginTime >= effect.totalTime)
         {
            if(effect.isLoop && (effect.count == -1 || effect.playedCount++ < effect.count))
            {
               effect.beginTime = now;
            }
            else
            {
               this.removeEffect(effect);
            }
         }
         effect.update(now - effect.beginTime,effect.totalTime,effect.direct);
         i--;
      }
   }
   
   public function dispose() : void
   {
      var i:int = this.list.length - 1;
      while(i >= 0)
      {
         this.removeEffect(this.list[i]);
         i--;
      }
   }
}
