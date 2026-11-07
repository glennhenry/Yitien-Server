package com.yiTian.manager
{
   import com.yiTian.Global;
   import com.yiTian.command.Enum_MsgType;
   import com.yiTian.data.config.Enum_npc_type;
   import com.yiTian.data.config.Enum_thing_type;
   import com.yiTian.data.model.ModelChristmas;
   import com.yiTian.data.model.Model_npc;
   import com.yiTian.data.vo.Vo_item;
   import com.yiTian.gameUnit.role.Npc;
   import com.yiTian.net.message.cg.BangBattleCGMessage;
   import com.yiTian.net.message.cg.BangCGMessage;
   import com.yiTian.net.message.cg.ChristmasCGMessage;
   import com.yiTian.net.message.cg.KejuCGMessage;
   import com.yiTian.net.message.cg.SceneCGMessage;
   import com.yiTian.net.message.cg.ShenshouCGMessage;
   import com.yiTian.net.message.cg.WorldBossCGMessage;
   import com.yiTian.scene.GameScene;
   import com.yiTian.utils.Tween;
   import com.yiTian.view.modules.banhui.shenshou.ShenShouPaiHang;
   import com.yiTian.view.modules.crossCampBattle.Model_CrossCampBattle;
   import com.yiTian.view.modules.crossClanBattle.Model_CrossClanBattle;
   import com.yiTian.view.modules.marriage.Model_Marriage;
   import flash.geom.Point;
   import flash.utils.getTimer;
   
   public class CollectManager
   {
      
      private static var _npc:Npc;
      
      private static var beginTime:int;
      
      private static var _callBack:Function;
      
      private static var _obj:Object;
      
      private static var _isFinish:Boolean;
      
      private static var _curPoint:Point;
      
      private static var NEED_TIME:Number = 5000;
      
      private static var _isCollecting:Boolean = false;
      
      public function CollectManager()
      {
         super();
      }
      
      public static function get isCollecting() : Boolean
      {
         return _isCollecting;
      }
      
      public static function get npc() : Npc
      {
         return _npc;
      }
      
      private static function bcb(bid:int) : void
      {
         var sId:int = Global.sceneID;
         _obj = null;
         _callBack = null;
         if(!_isCollecting)
         {
            return;
         }
         _isCollecting = false;
         _npc.isCollect = false;
         GameScene.instance.removeFrameCallBack(run);
         Global.control.removeCallBack(Enum_MsgType.BATTLE_PLAY_START,bcb);
      }
      
      public static function begin(npc:Npc, needTime:Number = 5000, callBack:Function = null, obj:Object = null, label:String = "") : void
      {
         if(isCollecting)
         {
            return;
         }
         _isFinish = false;
         if(label == "" && Global.sceneID != 12304)
         {
            label = LangConfig.getWord("10547",1);
         }
         else if(label == "" && Global.sceneID == 12304)
         {
            label = LangConfig.getWord("1086",0);
         }
         var sId:int = Global.sceneID;
         if(sId >= 12401 && sId <= 12406)
         {
            Global.control.registerCallBack(Enum_MsgType.BATTLE_PLAY_START,bcb);
         }
         NEED_TIME = needTime;
         if(Boolean(obj))
         {
            _obj = obj;
            _obj.npc = npc;
         }
         _callBack = callBack;
         if(_isCollecting)
         {
            return;
         }
         _isCollecting = true;
         _npc = npc;
         Npc.setCollectViewLabel(label);
         beginTime = getTimer();
         _npc.isCollect = true;
         GameScene.instance.addFrameCallBack(run);
      }
      
      public static function end() : void
      {
         var sId:int = Global.sceneID;
         var st:int = SceneConfig.getSceneType();
         if(sId == 12305 && _npc.sysId >= 56957 && _npc.sysId <= 56976)
         {
            if(!_isFinish)
            {
               KejuCGMessage.CG_QUITCATCH(_npc.sysId);
            }
            else
            {
               KejuCGMessage.CG_CATCHEND(_npc.sysId);
            }
         }
         if(ModelChristmas.isChristmasSnowmanScene(sId) && _npc.npcType == Enum_npc_type.christmas_snowman)
         {
            if(_isFinish)
            {
               ChristmasCGMessage.cg_christmas_collect_result(Global.sceneID,_npc.id,1,_npc.global_x,_npc.global_y);
            }
            else
            {
               ChristmasCGMessage.cg_christmas_collect_result(Global.sceneID,_npc.id,2,_npc.global_x,_npc.global_y);
            }
         }
         if(st == SceneConfig.BZ_BATTLE || st == SceneConfig.BZ_READY)
         {
            BangBattleCGMessage.CG_JK_COLLECT_INTERRUPT();
            _obj = null;
            _callBack = null;
         }
         else if(st == SceneConfig.BANGPLANT)
         {
            if(!_isFinish)
            {
               BangCGMessage.CG_BANG_PLANT_CAIJI(2,Model_npc._npc.id);
            }
            _obj = null;
            _callBack = null;
         }
         if(SceneConfig.getSceneType() == SceneConfig.KFBZ_BATTLE)
         {
            if(_isFinish == false)
            {
               Model_CrossClanBattle.breakCollect();
            }
            _obj = null;
            _callBack = null;
         }
         if(SceneConfig.getSceneType() == SceneConfig.CROSS_CAMP_BATTLE)
         {
            if(_isFinish == false)
            {
               Model_CrossCampBattle.breakCollect();
            }
            _obj = null;
            _callBack = null;
         }
         if(ShenShouPaiHang.vecTianMing.indexOf(_npc.sysId) >= 0 || ShenShouPaiHang.qiuYaoBaoXiang == _npc.sysId)
         {
            if(_isFinish)
            {
               ShenshouCGMessage.CG_SSBX_END_COLLECT(_npc.id);
            }
            else
            {
               ShenshouCGMessage.CG_SSBX_BREAK_COLLECT(_npc.id);
            }
         }
         if(st == SceneConfig.WORLDBOSS)
         {
            if(_isFinish)
            {
               WorldBossCGMessage.CG_WB_COLLECT(CollectManager.npc.id,3);
            }
            else
            {
               WorldBossCGMessage.CG_WB_COLLECT(CollectManager.npc.id,2);
            }
         }
         if(!_isCollecting)
         {
            return;
         }
         _isCollecting = false;
         _npc.isCollect = false;
         GameScene.instance.removeFrameCallBack(run);
      }
      
      public static function endNoReason() : void
      {
         if(!_isCollecting)
         {
            return;
         }
         _isCollecting = false;
         _isCollecting = false;
         if(Boolean(_npc))
         {
            _npc.isCollect = false;
         }
         _npc = null;
         GameScene.instance.removeFrameCallBack(run);
      }
      
      public static function run(interval:int) : void
      {
         var sId:int = 0;
         var now:int = getTimer();
         var rate:Number = (now - beginTime) / NEED_TIME;
         _npc.updateCollectPro(rate);
         if(rate >= 1)
         {
            _isFinish = true;
            sId = Global.sceneID;
            if(sId == 12305)
            {
               if(!_isCollecting)
               {
                  return;
               }
               _isCollecting = false;
               _npc.isCollect = false;
               GameScene.instance.removeFrameCallBack(run);
               end();
               return;
            }
            if(ModelChristmas.isChristmasSnowmanScene(sId) && _npc.npcType == Enum_npc_type.christmas_snowman)
            {
               if(!_isCollecting)
               {
                  return;
               }
               _isCollecting = false;
               _npc.isCollect = false;
               GameScene.instance.removeFrameCallBack(run);
               end();
               return;
            }
            if(sId == 12304)
            {
               if(!_isCollecting)
               {
                  return;
               }
               _isCollecting = false;
               _npc.isCollect = false;
               Model_Marriage.endCollect(_npc);
               GameScene.instance.removeFrameCallBack(run);
               end();
               _curPoint = new Point(_npc.global_x - CameraManager.sightX - 34,_npc.global_y - CameraManager.sightY - 34);
               return;
            }
            if(sId >= 12402 && sId <= 12406 && _callBack != null)
            {
               _callBack(_obj);
               _callBack = null;
               _obj = null;
               if(!_isCollecting)
               {
                  return;
               }
               _isCollecting = false;
               _npc.isCollect = false;
               GameScene.instance.removeFrameCallBack(run);
               return;
            }
            if(ShenShouPaiHang.vecTianMing.indexOf(_npc.sysId) >= 0 || ShenShouPaiHang.qiuYaoBaoXiang == _npc.sysId)
            {
               end();
               return;
            }
            if(SceneConfig.getSceneType() == SceneConfig.WORLDBOSS)
            {
               end();
               return;
            }
            if(_callBack != null)
            {
               if(Boolean(_callBack.length))
               {
                  _callBack(_obj);
               }
               else
               {
                  _callBack();
               }
            }
            else
            {
               SceneCGMessage.CG_COLLECT(_npc.sysId);
            }
            end();
            _curPoint = new Point(_npc.global_x - CameraManager.sightX - 34,_npc.global_y - CameraManager.sightY - 34);
         }
      }
      
      public static function showEff(thing:Array) : void
      {
         var type:int = 0;
         var vo:Vo_item = null;
         var len:int = int(thing.length);
         var i:uint = 0;
         while(i < len)
         {
            type = int(thing[i][0]);
            if(type == Enum_thing_type.ITEM)
            {
               vo = new Vo_item();
               vo.id = thing[i][1];
               vo.Init_lib();
               Tween.gridToBagBezierFuncDef(vo,-1,_curPoint.x,_curPoint.y);
            }
            i++;
         }
      }
   }
}

