package com.yiTian.view.modules.tianTi
{
   import com.utils.DisplayData;
   import com.utils.ResObj;
   import com.utils.Util;
   import com.yiTian.Global;
   import com.yiTian.command.Enum_MsgType;
   import com.yiTian.data.Data_lib;
   import com.yiTian.data.config.Enum_job;
   import com.yiTian.gameUnit.role.Hero;
   import com.yiTian.manager.GameUnitManager;
   import com.yiTian.manager.LangConfig;
   import com.yiTian.manager.ResourceManager;
   import com.yiTian.manager.SceneConfig;
   import com.yiTian.manager.UIManager;
   import com.yiTian.utils.Tween;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.utils.getTimer;
   
   public class Child_tianTiUnit extends Sprite
   {
      
      public static const PLAYER:int = 1;
      
      public static const MONSTER:int = 2;
      
      public static const HORSE:int = 3;
      
      public static const GHOST:int = 4;
      
      public static const SPEC:int = 100;
      
      public static const DefaultRates:Array = [350,250,200,200,350];
      
      public static const STAND:int = 0;
      
      public static const RUN:int = 1;
      
      public static const SIT:int = 2;
      
      public static const JUMPUP:int = 3;
      
      public static const JUMPDOWN:int = 4;
      
      public static const ROTATE:int = 5;
      
      private static var pool:Array = [];
      
      private var _modelId:int;
      
      public var job:int;
      
      public var sex:int;
      
      public var type:int = 0;
      
      private var bm_body:Bitmap;
      
      private var bm_weapon:Bitmap;
      
      private var bm_shadow:Bitmap;
      
      private var bm_horseBody:Bitmap;
      
      private var bm_horseHead:Bitmap;
      
      private var _shadowIdx:int;
      
      private var _horseIdx:int;
      
      private var _wing:int;
      
      private var bm_wing:Bitmap;
      
      private var _weaponDir:String = "";
      
      public var _state:int = 0;
      
      public var _way:int = 1;
      
      private var _frameInterval:int = -1;
      
      private var index:int;
      
      private var current:int = 0;
      
      private var arr:Array = ["stand","run","sit","jumpUp","jumpDown","rotate"];
      
      private var timeFlag:int;
      
      private var lastTime:int;
      
      public var jumpPixel:Number = 100;
      
      public var jumpBindY:Number = -3737;
      
      public var jumpDuration:int = 1000;
      
      public var zhuanShenStepTime:int = -1;
      
      private var _lastZhuanShenTime:int;
      
      public var invalidateView:Boolean = false;
      
      public var isTween:Boolean = false;
      
      private var warr:Array = [90100,90200,90300,90400];
      
      public function Child_tianTiUnit()
      {
         super();
         this.bm_body = new Bitmap();
         addChild(this.bm_body);
         this.bm_weapon = new Bitmap();
         addChild(this.bm_weapon);
         this.bm_wing = new Bitmap();
         addChild(this.bm_wing);
      }
      
      public static function pop() : Child_tianTiUnit
      {
         var unit:Child_tianTiUnit = null;
         unit = pool.length > 0 ? pool.pop() : new Child_tianTiUnit();
         unit.init();
         var _temp_1:* = unit;
         unit.scaleY = 0.65;
         _temp_1.scaleX = 0.65;
         return unit;
      }
      
      public function set horse(v:int) : void
      {
         this.bm_horseHead = this.bm_horseHead || new Bitmap();
         this.bm_horseBody = this.bm_horseBody || new Bitmap();
         if(v == 0)
         {
            var _temp_3:* = this.bm_horseBody;
            this.bm_horseHead.bitmapData = null;
            _temp_3.bitmapData = null;
         }
         this._horseIdx = v;
         this.bm_weapon.visible = v == 0;
      }
      
      public function get horse() : int
      {
         return this._horseIdx;
      }
      
      public function set shadow(v:int) : void
      {
         this.bm_shadow || addChildAt(this.bm_shadow = new Bitmap(),0);
         this._shadowIdx = v;
      }
      
      public function get shadow() : int
      {
         return this._shadowIdx;
      }
      
      public function set way(v:int) : void
      {
         this._way = v % 8;
      }
      
      public function get way() : int
      {
         return this._way;
      }
      
      public function getCurrentFrame() : int
      {
         return this.current;
      }
      
      public function set state(value:int) : void
      {
         this._state = value;
         this.updateViewer();
      }
      
      public function get state() : int
      {
         return this._state;
      }
      
      public function updateLayer() : void
      {
         var index:int = 0;
         var isWeaponDown:int = 0;
         var bodyIndex:int = 0;
         var weaponIndex:int = 0;
         var wingIndex:int = 0;
         var wingLayer:int = 0;
         var smallIndex:int = 0;
         var bigIndex:int = 0;
         if(this.type != PLAYER)
         {
            return;
         }
         var data:Array = Data_lib.avater[Enum_job.getBaseJob(this.job) + "" + this.sex];
         if(Boolean(data))
         {
            index = this.state * 5 + (this.way < 5 ? this.way : 8 - this.way);
            isWeaponDown = int(data[this.state * 5 + (this.way < 5 ? this.way : 8 - this.way)]);
            bodyIndex = getChildIndex(this.bm_body);
            weaponIndex = getChildIndex(this.bm_weapon);
            wingIndex = getChildIndex(this.bm_wing);
            if(isWeaponDown == 0)
            {
               if(bodyIndex > weaponIndex)
               {
                  setChildIndex(this.bm_weapon,bodyIndex);
               }
            }
            else if(weaponIndex > bodyIndex)
            {
               setChildIndex(this.bm_body,weaponIndex);
            }
         }
         var wingLayerData:Array = Data_lib.wingLayer[Enum_job.getBaseJob(this.job) + "" + this.sex];
         if(Boolean(wingLayerData))
         {
            if(!this.bm_horseBody || this.bm_horseBody.bitmapData == null || this.bm_horseBody.visible == false)
            {
               wingLayer = int(wingLayerData[this._state * 5 + (this.way < 5 ? this.way : 8 - this.way)]);
            }
            else
            {
               wingLayer = int(wingLayerData[this._state * 5 + 10 + (this.way < 5 ? this.way : 8 - this.way)]);
            }
            if(wingLayer == 1)
            {
               smallIndex = Math.min(getChildIndex(this.bm_weapon),getChildIndex(this.bm_body));
               if(getChildIndex(this.bm_wing) > smallIndex)
               {
                  setChildIndex(this.bm_wing,smallIndex);
               }
            }
            else
            {
               bigIndex = Math.max(getChildIndex(this.bm_weapon),getChildIndex(this.bm_body));
               if(getChildIndex(this.bm_wing) < bigIndex)
               {
                  setChildIndex(this.bm_wing,bigIndex);
               }
            }
         }
      }
      
      public function set weaponDir(value:String) : void
      {
         this._weaponDir = value;
      }
      
      public function set modelId(value:int) : void
      {
         this._modelId = value;
         this.goto(this.current);
      }
      
      public function get modelId() : int
      {
         return this._modelId;
      }
      
      public function set wing(value:int) : void
      {
         if(value == 0)
         {
            this.bm_wing.bitmapData = null;
         }
         this._wing = value;
         this.goto(this.current);
      }
      
      public function get wing() : int
      {
         return this._wing;
      }
      
      public function updateHorseLayer() : void
      {
         if(Boolean(this.bm_horseBody) && (this._way == 3 || this._way == 5 || this._way == 2 || this._way == 7))
         {
            addChildAt(this.bm_horseBody,0);
            addChild(this.bm_horseHead);
         }
         else
         {
            addChildAt(this.bm_horseHead,0);
            addChild(this.bm_horseBody);
         }
      }
      
      public function setWeanponIndex(v:int) : void
      {
         setChildIndex(this.bm_weapon,v);
      }
      
      public function getModelUrl() : String
      {
         return "modelRes/role/body/" + this.arr[this.state] + "/" + this._modelId.toString() + ".swf";
      }
      
      public function setFrameInterval(v:int) : void
      {
         this._frameInterval = v;
      }
      
      public function getFrameInterval() : int
      {
         return this._frameInterval;
      }
      
      public function getNode() : Child_tianTiNode
      {
         return parent as Child_tianTiNode;
      }
      
      public function play() : void
      {
         Global.control.registerCallBack(Enum_MsgType.TIANTI_FRAME,this.onFrame);
      }
      
      public function stop() : void
      {
         Global.control.removeCallBack(Enum_MsgType.TIANTI_FRAME,this.onFrame);
      }
      
      public function goto(index:int) : void
      {
         this.current = index;
      }
      
      public function updateViewer() : void
      {
         var url:String = null;
         if(this.type == HORSE)
         {
            url = "modelRes/role/horse/" + this.arr[this.state] + "/" + this._modelId.toString() + ".swf";
         }
         else if(this.type == SPEC)
         {
            url = "modelRes/role/body/" + this.arr[this.state] + "/" + this._modelId.toString() + ".swf";
         }
         else
         {
            url = this._horseIdx == 0 ? "modelRes/role/body/" + this.arr[this.state] + "/" + this._modelId.toString() + ".swf" : "modelRes/role/body/h" + this.arr[this.state] + "/" + this._modelId.toString() + ".swf";
         }
         this.playImg(url);
      }
      
      private function clickHd(evt:MouseEvent) : void
      {
         var curLv:int = 0;
         var hero:Hero = null;
         var needLv:int = 0;
         var index:int = 0;
         var str:String = null;
         if(this.type == MONSTER)
         {
            if(SceneConfig.getSceneType() != SceneConfig.COMMON)
            {
               str = LangConfig.getWord("21013",2);
               UIManager.centerBroadcast.addMsg(str);
               return;
            }
            curLv = TianTiManager.curLv;
            if(curLv < 0 && curLv >= TianTiManager.maxLv)
            {
               return;
            }
            if(TianTiManager.refreshCGFlag == true)
            {
               return;
            }
            hero = GameUnitManager.hero;
            needLv = int(Data_lib.tianTi[curLv + 1][2]);
            index = (parent as Child_tianTiNode).lv;
            if(curLv + 1 < index)
            {
               UIManager.centerBroadcast.addMsg(LangConfig.getWord("21014",2));
               return;
            }
            if(hero.level < needLv)
            {
               UIManager.centerBroadcast.addMsg(LangConfig.getWord("21015",2));
               return;
            }
            UIManager.tianTiPanel.tianTi.attToNxt();
         }
      }
      
      private function onOver(evt:MouseEvent) : void
      {
         if(this.type == MONSTER)
         {
            transform.colorTransform = Util.colorGlow;
         }
      }
      
      private function onOut(evt:MouseEvent) : void
      {
         if(this.type == MONSTER)
         {
            transform.colorTransform = Util.colorNomal;
         }
      }
      
      public function maimengDefault() : void
      {
         this.zhuanshen(this.jump);
      }
      
      public function zhuanshen(cb:Function = null, time:int = 800, numStep:int = 8) : void
      {
         Tween.to(this,time,{"way":[this._way,this._way + numStep]},cb,this.zhuanShenStepTime > 0 ? this.zhuanshenStep : null);
      }
      
      public function jump() : void
      {
         var sy:Number = this.jumpBindY != -3737 ? this.jumpBindY : y;
         Tween.to(this,this.jumpDuration,{"y":[sy,sy - this.jumpPixel]},null,null,this.sin1);
      }
      
      public function sin1(p:Number) : Number
      {
         return Math.sin(p * Math.PI);
      }
      
      private function zhuanshenStep(p:Object) : void
      {
         var now:int = getTimer();
         if(now - this._lastZhuanShenTime > this.zhuanShenStepTime)
         {
            this.updateViewer();
            this._lastZhuanShenTime = now;
         }
      }
      
      protected function init() : void
      {
         this.play();
         graphics.beginFill(0,0.5);
         graphics.drawEllipse(-20,-10,40,20);
         graphics.endFill();
         addEventListener(MouseEvent.ROLL_OVER,this.onOver);
         addEventListener(MouseEvent.ROLL_OUT,this.onOut);
         addEventListener(MouseEvent.CLICK,this.clickHd);
      }
      
      public function dispose() : void
      {
         this.stop();
         graphics.clear();
         removeEventListener(MouseEvent.ROLL_OVER,this.onOver);
         removeEventListener(MouseEvent.ROLL_OUT,this.onOut);
         removeEventListener(MouseEvent.CLICK,this.clickHd);
         pool.push(this);
      }
      
      public function onFrame(interval:int) : void
      {
         var url:String = null;
         this.timeFlag += interval;
         if(this.invalidateView || this.timeFlag - this.lastTime >= (this._frameInterval > 0 ? this._frameInterval : DefaultRates[this._state]))
         {
            this.invalidateView = false;
            this.lastTime = this.timeFlag;
            if(this.type == HORSE)
            {
               url = "modelRes/role/horse/" + this.arr[this.state] + "/" + this._modelId.toString() + ".swf";
            }
            else if(this.type == SPEC)
            {
               url = "modelRes/role/body/" + this.arr[this.state] + "/" + this._modelId.toString() + ".swf";
            }
            else
            {
               url = this._horseIdx == 0 ? "modelRes/role/body/" + this.arr[this.state] + "/" + this._modelId.toString() + ".swf" : "modelRes/role/body/h" + this.arr[this.state] + "/" + this._modelId.toString() + ".swf";
            }
            this.playImg(url);
         }
      }
      
      public function playImg(url:String) : void
      {
         var res:ResObj = null;
         var data:DisplayData = null;
         var nowIndex:int = 0;
         var temp_i:int = 0;
         var percent:Number = NaN;
         var dir:String = null;
         var dirh:String = null;
         var wingPath:String = null;
         var curTime:int = getTimer();
         res = ResourceManager.resourceIndex[url];
         if(Boolean(res))
         {
            res.lastUseTime = curTime;
         }
         else
         {
            ResourceManager.load(url);
         }
         if(Boolean(res) && res.isLoad)
         {
            nowIndex = this.current + 1;
            nowIndex %= res.actionFrame;
            percent = (nowIndex + 1) / res.actionFrame;
            if(nowIndex == this.current)
            {
               return;
            }
            this.current = nowIndex;
            if(res.way == 5)
            {
               temp_i = (this.way < 5 ? this.way : 8 - this.way) * res.actionFrame + this.current;
            }
            else if(res.way == 2)
            {
               if(this.way >= 2 && this.way <= 6)
               {
                  temp_i = res.actionFrame + this.current;
               }
               else
               {
                  temp_i = this.current;
               }
            }
            else
            {
               temp_i = this.current;
            }
            data = ResourceManager.find(res,temp_i);
            this.bm_body.bitmapData = data.p;
            this.bm_body.y = data.y;
            if(this.way <= 4)
            {
               this.bm_body.x = data.x;
               this.bm_body.scaleX = 1;
            }
            else
            {
               this.bm_body.x = -data.x;
               this.bm_body.scaleX = -1;
            }
         }
         if(this._weaponDir != "" && this._weaponDir != null)
         {
            dir = "modelRes/role/weapon" + this.sex.toString() + "/" + this.arr[this.state].toString() + "/" + this._weaponDir + ".swf";
            res = ResourceManager.resourceIndex[dir];
            if(Boolean(res))
            {
               res.lastUseTime = curTime;
            }
            else
            {
               ResourceManager.load(dir);
            }
            if(Boolean(res) && res.isLoad)
            {
               if(res.way == 5)
               {
                  temp_i = (this.way < 5 ? this.way : 8 - this.way) * res.actionFrame + int(res.actionFrame * percent * 0.99);
               }
               else if(res.way == 2)
               {
                  if(this.way >= 2 && this.way <= 6)
                  {
                     temp_i = res.actionFrame + this.current;
                  }
                  else
                  {
                     temp_i = this.current;
                  }
               }
               else
               {
                  temp_i = this.current;
               }
               data = ResourceManager.find(res,temp_i);
               this.bm_weapon.bitmapData = data.p;
               this.bm_weapon.y = data.y;
               if(this.way <= 4)
               {
                  this.bm_weapon.x = data.x;
                  this.bm_weapon.scaleX = 1;
               }
               else
               {
                  this.bm_weapon.x = -data.x;
                  this.bm_weapon.scaleX = -1;
               }
            }
         }
         if(this._horseIdx != 0 && Boolean(this.bm_horseBody))
         {
            dirh = "modelRes/role/horse/" + this.arr[this.state].toString() + "/" + this._horseIdx + ".swf";
            res = ResourceManager.resourceIndex[dirh];
            if(Boolean(res))
            {
               res.lastUseTime = curTime;
            }
            else
            {
               ResourceManager.load(dirh);
            }
            if(Boolean(res) && res.isLoad)
            {
               if(res.way == 5)
               {
                  temp_i = (this.way < 5 ? this.way : 8 - this.way) * res.actionFrame + int(res.actionFrame * percent * 0.99);
               }
               else if(res.way == 2)
               {
                  if(this.way >= 2 && this.way <= 6)
                  {
                     temp_i = res.actionFrame + this.current;
                  }
                  else
                  {
                     temp_i = this.current;
                  }
               }
               else
               {
                  temp_i = this.current;
               }
               data = ResourceManager.find(res,temp_i);
               this.bm_horseBody.bitmapData = data.p;
               this.bm_horseBody.y = data.y;
               if(this.way <= 4)
               {
                  this.bm_horseBody.x = data.x;
                  this.bm_horseBody.scaleX = 1;
               }
               else
               {
                  this.bm_horseBody.x = -data.x;
                  this.bm_horseBody.scaleX = -1;
               }
            }
         }
         if(this._wing != 0 && Boolean(this.bm_wing))
         {
            wingPath = (this._horseIdx == 0 ? "modelRes/role/wing/" : "modelRes/role/wing/h") + this.arr[this.state].toString() + "/" + this._wing + ".swf";
            res = ResourceManager.resourceIndex[wingPath];
            if(Boolean(res))
            {
               res.lastUseTime = curTime;
            }
            else
            {
               ResourceManager.load(wingPath);
            }
            if(Boolean(res) && res.isLoad)
            {
               if(res.way == 5)
               {
                  temp_i = (this.way < 5 ? this.way : 8 - this.way) * res.actionFrame + int(res.actionFrame * percent * 0.99);
               }
               else if(res.way == 2)
               {
                  if(this.way >= 2 && this.way <= 6)
                  {
                     temp_i = res.actionFrame + this.current;
                  }
                  else
                  {
                     temp_i = this.current;
                  }
               }
               else
               {
                  temp_i = this.current;
               }
               data = ResourceManager.find(res,temp_i);
               this.bm_wing.bitmapData = data.p;
               this.bm_wing.y = data.y;
               if(this.way <= 4)
               {
                  this.bm_wing.x = data.x;
                  this.bm_wing.scaleX = 1;
               }
               else
               {
                  this.bm_wing.x = -data.x;
                  this.bm_wing.scaleX = -1;
               }
            }
         }
      }
   }
}

