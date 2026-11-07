package com.yiTian.gameUnit.role
{
   import com.utils.ComponentUtil;
   import com.utils.Util;
   import com.yiTian.Global;
   import com.yiTian.gameUnit.GameUnit;
   import com.yiTian.gameUnit.config.Action;
   import com.yiTian.gameUnit.config.State;
   import com.yiTian.gameUnit.config.Status;
   import com.yiTian.gameUnit.magic.Effect;
   import com.yiTian.manager.BattleStatusManager;
   import com.yiTian.manager.EffectManager;
   import com.yiTian.manager.GameUnitManager;
   import com.yiTian.manager.UIManager;
   import com.yiTian.utils.Utils;
   import com.yiTian.view.comp.SceneWords;
   import flash.display.Bitmap;
   import flash.geom.ColorTransform;
   import flash.geom.Point;
   import flash.utils.getTimer;
   
   public class Role extends GameUnit
   {
      
      private static var bModelInit:Boolean;
      
      protected static var MODEL_STATUS_SHOW_PARTS:Object = {};
      
      public static var a:Number = 1.414;
      
      public static var b:Number = 1;
      
      public var standTime:int = 1000;
      
      protected var _speed:int;
      
      private var nowSpeed:int;
      
      public var head:String;
      
      public var official:String;
      
      public var job:int;
      
      public var sex:int;
      
      public var level:int;
      
      public var hp:int;
      
      public var hpMax:int;
      
      public var mp:int;
      
      public var mpMax:int;
      
      public var ylDiaLvl:int;
      
      public var isYearDia:int;
      
      public var huangZuanLvl:int;
      
      public var isHuangZuanYear:int;
      
      public var isSuperHuang:int;
      
      public var isHuiyuan:int;
      
      public var isHuiyuanYear:int;
      
      public var superLan:int;
      
      public var superLanYear:int;
      
      public var xinYueType:int;
      
      public var xinYueLvl:int;
      
      public var isShow:int;
      
      public var xunZhangLv:int;
      
      public var sanLiu:int;
      
      protected var nameBarHeight:int = 25;
      
      public var buffs:Array = [];
      
      private var _way:int;
      
      protected var _action:int = 0;
      
      private var _status:int = 1;
      
      private var _route:Array;
      
      public var tempRoute:Array;
      
      protected var start_x:int;
      
      protected var start_y:int;
      
      public var end_x:int;
      
      public var end_y:int;
      
      private var dx:int;
      
      private var dy:int;
      
      private var lastTime:int;
      
      private var _allTime:int;
      
      public var parts:Parts;
      
      public var effects:Effects;
      
      public var partTem:Bitmap;
      
      protected var _shadow:String;
      
      protected var _body:String;
      
      protected var _weapon:String;
      
      protected var _horse:String;
      
      private var battleEff:Effect;
      
      private var lordEff:Effect;
      
      protected var MODEL_STATUS_VALUE:Object = {};
      
      private var _bodyLoaded:Boolean;
      
      private var rate:Number;
      
      public var isInBattle:Boolean = false;
      
      private var lightEffect:Effect;
      
      private var _lordEff:Effect;
      
      private var sty:int;
      
      public var listWords:Array = [];
      
      public function Role()
      {
         super();
         state = State.LIFE;
         this.parts = new Parts(this);
         this.parts.visible = false;
         addChild(this.parts);
         this.partTem = new Bitmap();
         this.partTem.x = -25;
         this.partTem.y = -115;
         addChild(this.partTem);
         nameBar = new NameBar(this);
         nameBar.y = -160;
         addChild(nameBar);
         this.effects = new Effects(this);
         this.initModel();
      }
      
      public function set allTime(value:int) : void
      {
         this._allTime = value;
      }
      
      public function get allTime() : int
      {
         return this._allTime;
      }
      
      protected function initModel() : void
      {
         if(!bModelInit)
         {
            MODEL_STATUS_SHOW_PARTS[Status.PA_TA] = [Parts.SHADOW,Parts.HORSE,Parts.WEAPON,Parts.BODY,Parts.HORSEHEAD,Parts.WING];
            MODEL_STATUS_SHOW_PARTS[Status.WU_LING] = [Parts.SHADOW,Parts.HORSE,Parts.WEAPON,Parts.BODY,Parts.HORSEHEAD,Parts.WING];
            MODEL_STATUS_SHOW_PARTS[Status.BANG_PAI] = [Parts.SHADOW,Parts.HORSE,Parts.WEAPON,Parts.BODY,Parts.HORSEHEAD,Parts.WING];
            MODEL_STATUS_SHOW_PARTS[Status.NOMAL] = [Parts.SHADOW,Parts.HORSE,Parts.WEAPON,Parts.BODY,Parts.HORSEHEAD,Parts.WING];
            MODEL_STATUS_SHOW_PARTS[Status.SIT] = [Parts.SHADOW,Parts.BODY,Parts.WING];
            MODEL_STATUS_SHOW_PARTS[Status.FISH] = [Parts.SHADOW,Parts.BODY];
            MODEL_STATUS_SHOW_PARTS[Status.KUN_LUN] = [Parts.SHADOW,Parts.WEAPON,Parts.BODY];
            MODEL_STATUS_SHOW_PARTS[Status.COLLECT] = [Parts.SHADOW,Parts.HORSE,Parts.WEAPON,Parts.BODY,Parts.HORSEHEAD,Parts.WING];
            MODEL_STATUS_SHOW_PARTS[Status.BZ_COLLECT] = [Parts.SHADOW,Parts.HORSE,Parts.WEAPON,Parts.BODY,Parts.HORSEHEAD,Parts.WING];
            MODEL_STATUS_SHOW_PARTS[Status.WANANSI] = [Parts.SHADOW,Parts.HORSE,Parts.WEAPON,Parts.BODY,Parts.HORSEHEAD,Parts.WING];
            MODEL_STATUS_SHOW_PARTS[Status.KEJU] = MODEL_STATUS_SHOW_PARTS[Status.NOMAL];
            MODEL_STATUS_SHOW_PARTS[Status.QJ] = MODEL_STATUS_SHOW_PARTS[Status.NOMAL];
            MODEL_STATUS_SHOW_PARTS[Status.GMD] = MODEL_STATUS_SHOW_PARTS[Status.NOMAL];
            MODEL_STATUS_SHOW_PARTS[Status.AiDeBaoBao] = [Parts.SHADOW,Parts.BODY];
            MODEL_STATUS_SHOW_PARTS[Status.AiDeBaoBao_Bao] = [Parts.SHADOW,Parts.BODY];
            MODEL_STATUS_SHOW_PARTS[Status.AiDeBaoBao_BeiBao] = [Parts.SHADOW,Parts.BODY];
            MODEL_STATUS_SHOW_PARTS[Status.KuaFuPaiDui_HIDE] = [Parts.SHADOW,Parts.BODY];
            MODEL_STATUS_SHOW_PARTS[Status.KuaFuPaiDui_18] = [Parts.SHADOW,Parts.BODY];
            MODEL_STATUS_SHOW_PARTS[Status.KuaFuPaiDui_19] = [Parts.SHADOW,Parts.BODY];
            MODEL_STATUS_SHOW_PARTS[Status.KuaFuPaiDui_20] = [Parts.SHADOW,Parts.BODY];
            MODEL_STATUS_SHOW_PARTS[Status.KuaFuPaiDui_21] = [Parts.SHADOW,Parts.BODY];
            MODEL_STATUS_SHOW_PARTS[Status.KuaFuPaiDui_22] = [Parts.SHADOW,Parts.BODY];
            MODEL_STATUS_SHOW_PARTS[Status.KuaFuPaiDui_23] = [Parts.SHADOW,Parts.BODY];
            MODEL_STATUS_SHOW_PARTS[Status.KuaFuPaiDui_24] = [Parts.SHADOW,Parts.BODY];
            MODEL_STATUS_SHOW_PARTS[Status.KuaFuPaiDui_25] = [Parts.SHADOW,Parts.BODY];
            MODEL_STATUS_SHOW_PARTS[Status.KFPAOBIAO_26] = [Parts.SHADOW,Parts.WEAPON,Parts.BODY];
            bModelInit = true;
         }
         this.resetModelStatus();
      }
      
      protected function resetModelStatus() : void
      {
         this.MODEL_STATUS_VALUE[Status.NOMAL] = {};
      }
      
      public function get status() : int
      {
         return this._status;
      }
      
      public function set status(value:int) : void
      {
         this._status = value;
         this.updateParts();
      }
      
      private function updateParts() : void
      {
         var partType:int = 0;
         this.parts.hideAll();
         var len:int = int(MODEL_STATUS_SHOW_PARTS[this.status].length);
         var i:int = 0;
         for(; i < len; i++)
         {
            partType = int(MODEL_STATUS_SHOW_PARTS[this.status][i]);
            if(partType == Parts.HORSEHEAD)
            {
               if(this._action == Action.SIT)
               {
                  continue;
               }
               if(this._action == Action.STAND)
               {
                  if(!(this._way == 4 && GameUnitManager.showHorseHead(this.action,this.MODEL_STATUS_VALUE[this.status][Parts.HORSE])))
                  {
                     continue;
                  }
               }
            }
            if(!(partType == Parts.HORSE && this._action == Action.SIT))
            {
               this.parts.setPart(partType,this.MODEL_STATUS_VALUE[this.status][partType]);
            }
         }
         this.parts.visible = this.bodyLoaded;
      }
      
      public function isHidePlayer() : Boolean
      {
         return false;
      }
      
      public function setPartValue(status:int, typePart:int, value:int) : void
      {
         if(MODEL_STATUS_SHOW_PARTS[status].indexOf(typePart) == -1)
         {
            return;
         }
         this.MODEL_STATUS_VALUE[status][typePart] = value;
      }
      
      public function getPartValue(status:int, typePart:int) : String
      {
         return this.MODEL_STATUS_VALUE[status][typePart];
      }
      
      public function setShadow(status:int, value:int) : void
      {
         if(MODEL_STATUS_SHOW_PARTS[status].indexOf(Parts.SHADOW) == -1)
         {
            return;
         }
         this.MODEL_STATUS_VALUE[status][Parts.SHADOW] = value;
      }
      
      public function setBody(status:int, value:int) : void
      {
         if(MODEL_STATUS_SHOW_PARTS[status].indexOf(Parts.BODY) == -1)
         {
            return;
         }
         var a:* = this.MODEL_STATUS_VALUE[status] as Array;
         trace(this.MODEL_STATUS_VALUE[status],this.MODEL_STATUS_VALUE[status][Parts.BODY]);
         this.MODEL_STATUS_VALUE[status][Parts.BODY] = value;
      }
      
      public function setWing(status:int, value:int) : void
      {
         if(MODEL_STATUS_SHOW_PARTS[status].indexOf(Parts.WING) == -1)
         {
            return;
         }
         this.MODEL_STATUS_VALUE[status][Parts.WING] = value;
      }
      
      public function setWeapon(status:int, value:int) : void
      {
         if(MODEL_STATUS_SHOW_PARTS[status].indexOf(Parts.WEAPON) == -1)
         {
            return;
         }
         this.MODEL_STATUS_VALUE[status][Parts.WEAPON] = value;
      }
      
      public function set isShw(value:int) : void
      {
         nameBar.isShw = value;
      }
      
      public function setHorse(status:int, value:int) : void
      {
         if(status == Status.KUN_LUN)
         {
            this.setShadow(status,11);
            nameBar.y = -160;
            return;
         }
         if(MODEL_STATUS_SHOW_PARTS[status].indexOf(Parts.HORSE) == -1)
         {
            return;
         }
         this.MODEL_STATUS_VALUE[status][Parts.HORSE] = value;
         this.MODEL_STATUS_VALUE[status][Parts.HORSEHEAD] = value;
         this.setShadow(status,Boolean(value) ? 12 : 11);
         if(Boolean(value))
         {
            this.setWeapon(status,0);
            nameBar.y = -190;
         }
         else
         {
            nameBar.y = -160;
         }
      }
      
      public function hasHorse() : Boolean
      {
         if((MODEL_STATUS_SHOW_PARTS[this._status] as Array).indexOf(Parts.HORSE) != -1)
         {
            return this.MODEL_STATUS_VALUE[this._status][Parts.HORSE] != null && this.MODEL_STATUS_VALUE[this._status][Parts.HORSE] != 0;
         }
         return false;
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
         if(Boolean(this._route) && this.action == Action.RUN)
         {
            this.parts.reset(this.action,this._speed);
            if(this.end_x != 0 && this.end_y != 0)
            {
               this._route.unshift([this.end_x,this.end_y]);
               this.route = this._route;
            }
         }
      }
      
      public function set bodyLoaded(value:Boolean) : void
      {
         if(value == this._bodyLoaded)
         {
            return;
         }
         if(Boolean(Global.UIdm) && !this.partTem.bitmapData)
         {
            this.partTem.bitmapData = ComponentUtil.getBitmapData("roleTemp");
         }
         this.partTem.visible = !value;
         this._bodyLoaded = value;
         if(value)
         {
            this.updateParts();
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
      
      override public function show() : void
      {
         super.show();
         nameBar.show();
         this.action = this.action;
      }
      
      override public function update(now:int) : void
      {
         this.effects.update(now);
         this.parts.update(now);
         this.move(now);
      }
      
      protected function move(now:int) : void
      {
         if(this.action == Action.RUN)
         {
            this.rate = (now - this.lastTime) / this.allTime;
            if(this.rate > 1)
            {
               if(Boolean(this._route) && Boolean(this._route.length))
               {
                  this.route = this._route;
               }
               else if(this.end_x != 0 && this.end_y != 0)
               {
                  global_x = this.end_x;
                  global_y = this.end_y;
                  align();
                  this.action = Action.STAND;
                  if(this == GameUnitManager.hero)
                  {
                     this.moveOver();
                     if(Boolean(GameUnitManager.hero.lockTarget))
                     {
                        GameUnitManager.hero.lockTarget.interaction();
                     }
                  }
               }
            }
            else
            {
               global_x = this.rate * this.dx + this.start_x;
               global_y = this.rate * this.dy + this.start_y;
               align();
               if(this != GameUnitManager.hero)
               {
                  UIManager.smallMap.refreshPoint(this);
               }
            }
         }
      }
      
      public function set route(path:Array) : void
      {
         var c:Number = NaN;
         var variable:Number = NaN;
         if(state == State.DEAD || this.action == Action.DEAD)
         {
            return;
         }
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
         var len:int = Math.ceil(Math.sqrt((this.end_y - this.start_y) * (this.end_y - this.start_y) + (this.end_x - this.start_x) * (this.end_x - this.start_x)));
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
            c = (this.end_y - this.start_y) / (this.end_x - this.start_x) * (this.end_y - this.start_y) / (this.end_x - this.start_x);
            variable = Math.sqrt((1 + c) / (1 / (a * a) + c / (b * b)));
            this.nowSpeed = this.speed * variable;
         }
         if(this.nowSpeed == 0)
         {
            this._route.length = 0;
            this.end_x = this.start_x = global_x;
            this.end_y = this.start_y = global_y;
            align();
         }
         this.allTime = len / this.nowSpeed * 1000;
         this.lastTime = getTimer();
         var nway:int = Utils.getWay(this.end_x,this.end_y,this.start_x,this.start_y);
         if(this.way != nway || this.action != Action.RUN)
         {
            this.way = nway;
            this.action = Action.RUN;
         }
         this.dx = this.end_x - this.start_x;
         this.dy = this.end_y - this.start_y;
      }
      
      public function get route() : Array
      {
         return this._route;
      }
      
      public function set action(value:int) : void
      {
         this._action = value;
         this.parts.reset(value,this.speed);
         this.updateParts();
      }
      
      public function get action() : int
      {
         return this._action;
      }
      
      protected function moveOver() : void
      {
         this.end_x = 0;
         this.end_y = 0;
      }
      
      public function set way(value:int) : void
      {
         this.parts.scaleX = value < 5 ? 1 : -1;
         this._way = value;
      }
      
      public function get way() : int
      {
         return this._way;
      }
      
      override public function mouseOver() : void
      {
         this.parts.getPart(Parts.BODY).transform.colorTransform = Util.colorGlow;
      }
      
      public function colorChange(value:ColorTransform) : void
      {
         this.parts.getPart(Parts.BODY).transform.colorTransform = value;
      }
      
      override public function mouseOut() : void
      {
         this.parts.getPart(Parts.BODY).transform.colorTransform = Util.colorNomal;
      }
      
      override public function get check() : Boolean
      {
         if(Boolean(this.parts.getPart(Parts.BODY).bitmapData))
         {
            return Utils.checkAlpha(this.parts.getPart(Parts.BODY));
         }
         return false;
      }
      
      public function addEffect(sourceID:String, isLoop:Boolean, px:int = 0, py:int = 0, totalTime:int = 1000, count:int = -1, endCallBack:Function = null, isDown:int = 0) : Effect
      {
         var effect:Effect = Effect.getEffect();
         effect.init(sourceID);
         effect.totalTime = totalTime;
         effect.isLoop = isLoop;
         effect.px = px;
         effect.py = py;
         effect.count = count;
         effect.endCallBack = endCallBack;
         this.effects.addEffect(effect,isDown);
         return effect;
      }
      
      public function removeEffect(effect:Effect, recycle:Boolean = true) : void
      {
         this.effects.removeEffect(effect,recycle);
      }
      
      public function addBattleEff() : void
      {
         this.isInBattle = true;
         if(!this.battleEff)
         {
            this.battleEff = this.addEffect("19001",true,0,-60,700);
         }
      }
      
      public function addWulinBattleEff() : void
      {
         this.lightEffect = this.addEffect("19003",false,10,-236,300);
      }
      
      public function removeLightEffect() : void
      {
         if(Boolean(this.lightEffect))
         {
            this.removeEffect(this.lightEffect);
            this.lightEffect = null;
         }
      }
      
      public function removeBattleEff() : void
      {
         this.isInBattle = false;
         if(Boolean(this.battleEff) && contains(this.battleEff))
         {
            this.removeEffect(this.battleEff);
            this.battleEff = null;
         }
      }
      
      public function set isLord(value:Boolean) : void
      {
         if(value)
         {
            if(!this._lordEff)
            {
               this._lordEff = EffectManager.addEffect("19002",nameBar,1000,0,-30,true);
            }
         }
         else if(Boolean(this._lordEff))
         {
            EffectManager.removeEffect(this._lordEff);
            this._lordEff = null;
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
         this.sty = nameBar.y - word.height - 10;
         word.show(new Point(-word.width / 2,nameBar.y - word.height - 10),this);
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
         super.dispose();
         this.resetModelStatus();
         if(GameUnitManager.overObj == this)
         {
            this.mouseOut();
         }
         state = State.LIFE;
         this.parts.dispose();
         this.isLord = false;
         this.effects.dispose();
         this._bodyLoaded = false;
         this.partTem.visible = true;
         this.isInBattle = false;
         this.isLord = false;
         BattleStatusManager.removeUnit(this);
      }
   }
}

import com.yiTian.gameUnit.magic.Effect;
import com.yiTian.gameUnit.role.Role;
import com.yiTian.utils.Utils;

class Effects
{
   
   private var role:Role;
   
   public var list:Vector.<Effect> = new Vector.<Effect>();
   
   public function Effects(role:Role)
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
      var effIndex:int = int(this.list.indexOf(effect));
      if(effIndex < 0)
      {
         return;
      }
      this.list.splice(effIndex,1);
      if(Boolean(effect.parent))
      {
         effect.parent.removeChild(effect);
      }
      else
      {
         Utils.print("ROLE特效： " + effect.url + " " + effect.totalTime + " " + effect.beginTime + " " + effect.current);
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
         effect.update(now - effect.beginTime,effect.totalTime,this.role.way);
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
