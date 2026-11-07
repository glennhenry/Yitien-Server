package com.yiTian.utils
{
   import com.ui.controls.Button;
   import com.utils.ComponentUtil;
   import com.utils.Util;
   import com.yiTian.Global;
   import com.yiTian.command.Enum_MsgType;
   import com.yiTian.gameUnit.config.Action;
   import com.yiTian.gameUnit.magic.Effect;
   import com.yiTian.gameUnit.role.HunLi;
   import com.yiTian.manager.CameraManager;
   import com.yiTian.manager.GameUnitManager;
   import com.yiTian.scene.GameScene;
   import com.yiTian.view.modules.chat.TweenRichTF;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.events.MouseEvent;
   import flash.utils.Dictionary;
   import flash.utils.clearTimeout;
   import flash.utils.getTimer;
   import flash.utils.setTimeout;
   
   public class TimeLineLL extends EventDispatcher
   {
      
      private static var idCounter:int = -30000;
      
      private static const reg:RegExp = /\((.*)\)/;
      
      private static const regParam:RegExp = /\(|\)/g;
      
      public static const FINISH:String = "play_complete";
      
      private var _queue:Array;
      
      private var objDic:Dictionary;
      
      private var _curIndex:int;
      
      private var _isPlay:Boolean = false;
      
      public var _btnSkip:Button;
      
      private var _pSceneID:int;
      
      private var _isSleep:Boolean = false;
      
      private var _lastTime:int;
      
      private var _playTime:int;
      
      private var _isSkipBtnShow:Boolean = false;
      
      public function TimeLineLL()
      {
         super();
         this.init();
      }
      
      protected function init() : void
      {
         this.objDic = new Dictionary();
         this._queue = [];
      }
      
      public function playScript(scriptStr:String) : void
      {
         var tmpStr:String = null;
         var tmpArr:Array = null;
         var funInfoArr:Array = null;
         var funNameStr:String = null;
         var funParamStr:String = null;
         var funParamArr:Array = null;
         var ss:ScriptStep = null;
         this._curIndex = 0;
         scriptStr = scriptStr.replace("\n\r");
         var scriptStrArr:Array = scriptStr.split(";");
         var len:int = int(scriptStrArr.length);
         var i:uint = 0;
         while(i < len)
         {
            tmpStr = scriptStrArr[i];
            if(tmpStr != "")
            {
               tmpArr = tmpStr.split("||",2);
               funInfoArr = (tmpArr[1] as String).split(reg,2);
               funNameStr = funInfoArr[0];
               funParamStr = funInfoArr[1].replace(regParam,"");
               funParamArr = funParamStr.split("|");
               ss = new ScriptStep();
               ss.actionTime = int(tmpArr[0]);
               ss.funName = funNameStr;
               ss.param = funParamArr;
               this._queue.push(ss);
            }
            i += 1;
         }
         this.bubbleSortQue();
         this.play();
         this._pSceneID = Global.sceneID;
         Global.control.registerCallBack(Enum_MsgType.MSG_ASK_CHANGE_SCENE_OK,this.onSceneChangeOK);
         this._playTime = 0;
         this._lastTime = getTimer();
      }
      
      private function play() : void
      {
         if(this._isPlay)
         {
            return;
         }
         this._isPlay = true;
         Global.stage.addEventListener(Event.ENTER_FRAME,this.onFrame);
      }
      
      private function finish() : void
      {
         if(!this._isPlay)
         {
            return;
         }
         this._isPlay = false;
         Global.stage.removeEventListener(Event.ENTER_FRAME,this.onFrame);
         dispatchEvent(new Event(TimeLineLL.FINISH));
         CameraManager.stopCameraMove();
         Global.isPlayingMarriageEffect = false;
         this.hideSkipBtn(null);
      }
      
      private function bubbleSortQue() : void
      {
         var j:int = 0;
         var ss_i:ScriptStep = null;
         var ss_j:ScriptStep = null;
         var len:int = int(this._queue.length);
         var i:int = 0;
         while(i < len - 1)
         {
            j = i;
            while(j < len)
            {
               ss_i = this._queue[i];
               ss_j = this._queue[j];
               if(ss_i.actionTime > ss_j.actionTime)
               {
                  this._queue[i] = ss_j;
                  this._queue[j] = ss_i;
               }
               j += 1;
            }
            i += 1;
         }
      }
      
      private function onFrame(event:Event) : void
      {
         var len:int = 0;
         var funName:String = null;
         var funParam:Array = null;
         var now:int = getTimer();
         var duration:uint = now - this._lastTime;
         if(!this._isSleep)
         {
            len = int(this._queue.length);
            while(this._playTime >= this._queue[this._curIndex].actionTime)
            {
               funName = this._queue[this._curIndex].funName;
               funParam = this._queue[this._curIndex].param;
               this[funName](funParam);
               this._curIndex += 1;
               if(this._curIndex >= len)
               {
                  this.finish();
                  break;
               }
            }
            this._playTime += duration;
         }
         this._lastTime = getTimer();
      }
      
      private function createUnit(param:Array) : void
      {
         var uName:String = param[0];
         var roleModelID:int = int(param[1]);
         var dir:int = int(param[2]);
         var state:int = int(param[3]);
         var global_x:Number = Number(param[4]);
         var global_y:Number = Number(param[5]);
         var alphaTime:int = Boolean(param[6]) ? int(Number(param[6])) : 0;
         var len:int = int(HunLi.pool.length);
         var unit:HunLi = Boolean(HunLi.pool.length) ? HunLi.pool.pop() : new HunLi();
         unit.init(idCounter,roleModelID,global_x,global_y,dir,state,[],[],true);
         unit.name = uName;
         unit.setBody(state,roleModelID);
         this.objDic[uName] = unit;
         GameUnitManager.addUnit(unit);
         unit.show();
         if(alphaTime != 0)
         {
            Tween.to(unit,alphaTime,{"alpha":[0.2,1]});
         }
         else
         {
            unit.alpha = 1;
         }
      }
      
      private function unitMove(param:Array) : void
      {
         var costTime:int = 0;
         var role:HunLi = null;
         var sy:Number = NaN;
         var moveEnd:Function = null;
         moveEnd = function():void
         {
            role.action = Action.STAND;
            role.show();
         };
         var uName:String = param[0];
         costTime = int(param[1]);
         var dx:Number = Number(param[2]);
         var dy:Number = Number(param[3]);
         role = this.objDic[uName];
         var sx:Number = role.x;
         sy = role.y;
         var way:int = Util.getWay(dx,dy,sx,sy);
         role.action = Action.RUN;
         role.way = way;
         role.show();
         Tween.to(role,costTime,{
            "x":[sx,dx],
            "y":[sy,dy],
            "global_x":[sx,dx],
            "global_y":[sy,dy]
         },moveEnd);
      }
      
      private function setUnitAction(param:Array) : void
      {
         var role:HunLi = null;
         var uName:String = param[0];
         var action:int = int(param[1]);
         role = this.objDic[uName];
         role.action = action;
         role.show();
      }
      
      private function setUnitAtt(param:Array) : void
      {
         var uName:String = param[0];
         var attType:int = int(param[1]);
         var role:HunLi = this.objDic[uName];
         role.show();
      }
      
      private function setUnitWay(param:Array) : void
      {
         var uName:String = param[0];
         var way:int = int(param[1]);
         var role:HunLi = this.objDic[uName];
         role.way = way;
         role.show();
      }
      
      private function setUnitTalk(param:Array) : void
      {
         var contentStr:String = null;
         var costTime:int = 0;
         var stanTime:int = 0;
         var unit:HunLi = null;
         var tf:TweenRichTF = null;
         var tfPercentComplete:Function = null;
         tfPercentComplete = function():void
         {
            Tween.to(tf,stanTime,{},function():void
            {
               Tween.to(tf,1500,{"alpha":[1,0]},function():void
               {
                  unit.removeChild(tf);
                  tf.dispose();
                  delete objDic[tf.name];
                  Pool.saveObject(tf);
               });
            });
         };
         var uName:String = param[0];
         contentStr = param[1];
         costTime = int(param[2]);
         stanTime = int(param[3]);
         var dieTime:int = int(param[4]);
         unit = this.objDic[uName];
         tf = Pool.getObject(TweenRichTF) as TweenRichTF;
         this.objDic[tf.name] = tf;
         tf.x = -80;
         tf.y = -220;
         tf.content = contentStr;
         tf.alpha = 1;
         unit.addChild(tf);
         Tween.to(tf,costTime,{"percent":[0,1]},tfPercentComplete);
      }
      
      private function removeUnit(param:Array) : void
      {
         var uName:String = param[0];
         var costTime:int = Boolean(param[1]) ? int(param[1]) : 0;
         var role:HunLi = this.objDic[uName];
         if(costTime == 0)
         {
            this.removeUnitIm(role);
         }
         else
         {
            Tween.curTo(role,costTime,{"alpha":0.2},this.removeUnitIm);
         }
      }
      
      private function removeUnitIm(u:HunLi) : void
      {
         GameUnitManager.removeUnit(u);
         u.dispose();
         u.alpha = 1;
         delete this.objDic[u.name];
      }
      
      private function cameraFormTo(param:Array) : void
      {
         var sx:Number = Number(param[0]);
         var sy:Number = Number(param[1]);
         var ex:Number = Number(param[2]);
         var ey:Number = Number(param[3]);
         var coseTime:int = int(param[4]);
         CameraManager.cameraFromTo(sx,sy,ex,ey,coseTime);
      }
      
      private function cameraTo(param:Array) : void
      {
         var ex:Number = Number(param[0]);
         var ey:Number = Number(param[1]);
         var costTime:int = int(param[2]);
         CameraManager.cameraFromTo(CameraManager.sightX,CameraManager.sightY,ex,ey,costTime);
      }
      
      private function lockCamera(param:Array) : void
      {
         Global.isPlayingMarriageEffect = true;
      }
      
      private function unlockCamera(param:Array) : void
      {
         Global.isPlayingMarriageEffect = false;
      }
      
      private function hideMe(param:Array) : void
      {
         GameUnitManager.hero.visible = false;
      }
      
      private function showME(param:Array) : void
      {
         GameUnitManager.hero.visible = true;
      }
      
      private function addEffAtRole(param:Array) : void
      {
         var role:HunLi = null;
         var eff:Effect = null;
         var tID:int = 0;
         var uName:String = param[0];
         var effID:String = param[1];
         var singleTime:int = int(param[2]);
         var px:Number = Number(param[3]);
         var py:Number = Number(param[4]);
         var totalTime:int = int(param[5]);
         role = this.objDic[uName];
         eff = role.addEffect(effID,true,px,py,singleTime);
         if(totalTime > 0)
         {
            tID = int(setTimeout(function():void
            {
               clearTimeout(tID);
               role.removeEffect(eff);
            },totalTime));
         }
      }
      
      private function onSceneChangeOK() : void
      {
         this.clearInfo();
      }
      
      public function clearInfo() : void
      {
         var key:String = null;
         var curSceneID:int = 0;
         var tf:TweenRichTF = null;
         var role:HunLi = null;
         this._queue.splice(0);
         for(key in this.objDic)
         {
            if(this.objDic[key] is TweenRichTF)
            {
               tf = this.objDic[key];
               if(Boolean(tf.parent))
               {
                  tf.parent.removeChild(tf);
               }
               Tween.stop(tf);
               tf.dispose();
               Pool.saveObject(tf);
            }
            if(this.objDic[key] is HunLi)
            {
               role = this.objDic[key];
               GameUnitManager.removeUnit(role);
            }
            delete this.objDic[key];
         }
         this._curIndex = 0;
         this.finish();
         curSceneID = Global.sceneID;
         Global.control.removeCallBack(Enum_MsgType.MSG_ASK_CHANGE_SCENE_OK,this.onSceneChangeOK);
         CameraManager.stopCameraMove();
         Global.isPlayingMarriageEffect = false;
         if(curSceneID == this._pSceneID)
         {
            CameraManager.wacth(GameUnitManager.hero.global_x,GameUnitManager.hero.global_y);
         }
         GameScene.uiLayer.visible = GameScene.uiLayer.visible || true;
      }
      
      public function sleep(param:Array = null) : void
      {
         this._isPlay = false;
      }
      
      public function wake(param:Array = null) : void
      {
         this._isPlay = true;
      }
      
      public function setObjProperity(param:Array) : void
      {
         var k:String = null;
         var v:Object = null;
         var objName:String = param[0];
         var i:int = 1;
         while(i < param.length)
         {
            k = param[i];
            v = param[i + 1];
            this.objDic[objName][k] = v;
            i += 2;
         }
      }
      
      public function uiLayerVis(param:Array) : void
      {
         var duration:int = 0;
         if(param[0] == "true")
         {
            GameScene.uiLayer.visible = true;
            if(Boolean(param[1]))
            {
               duration = int(param[1]);
               GameScene.uiLayer.alpha = 0.2;
               Tween.to(GameScene.uiLayer,duration,{"alpha":[0.2,1]});
            }
         }
         else
         {
            GameScene.uiLayer.visible = param[0] == false;
         }
      }
      
      public function showSkipBtn(param:Array) : void
      {
         this._btnSkip = this._btnSkip || ComponentUtil.getButton("跳过剧情","Button_Four",null,{"callBack":this.btnSkilClickHd},Global.Img_Cdm);
         GameScene.sysLayer.addChild(this._btnSkip);
         this.resetCompPos();
         Global.control.registerCallBack(Enum_MsgType.STAGE_RESIZE,this.resetCompPos);
      }
      
      public function hideSkipBtn(param:Array) : void
      {
         if(Boolean(this._btnSkip) && Boolean(this._btnSkip.parent))
         {
            this._btnSkip.parent.removeChild(this._btnSkip);
         }
         Global.control.removeCallBack(Enum_MsgType.STAGE_RESIZE,this.resetCompPos);
      }
      
      private function resetCompPos() : void
      {
         if(!this._isPlay)
         {
            return;
         }
         this._btnSkip.x = Global.stage.stageWidth - 100;
         this._btnSkip.y = 100;
      }
      
      private function btnSkilClickHd(e:MouseEvent) : void
      {
         this.finish();
         this.clearInfo();
      }
   }
}

