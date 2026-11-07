package com.yiTian.view.modules.loading
{
   import com.ui.controls.MyTextField;
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.command.Enum_MsgType;
   import com.yiTian.data.config.Enum_loaderType;
   import com.yiTian.data.config.Enum_resType;
   import com.yiTian.data.model.Model_initStr;
   import com.yiTian.manager.KeyboardManager;
   import com.yiTian.manager.SceneConfig;
   import com.yiTian.scene.GameScene;
   import com.yiTian.utils.MassLoader;
   import com.yiTian.utils.SingleLoader;
   import com.yiTian.utils.Utils;
   import flash.display.Shape;
   import flash.display.Sprite;
   import flash.events.ProgressEvent;
   import flash.utils.getTimer;
   
   public class View_loading extends Sprite
   {
      
      private static var _instance:View_loading = new View_loading();
      
      private var effBg:Shape;
      
      private var _tipTF:MyTextField;
      
      private var isPlaying:Boolean;
      
      private var list:Array = [];
      
      private var curListItem:LoadItem;
      
      private var _curLength:int;
      
      private var _totLength:int;
      
      private var _tipHead:String;
      
      public function View_loading()
      {
         super();
         this.effBg = ComponentUtil.getShape(2500,2000,0,0.5);
         addChild(this.effBg);
         addChild(LogoLoading.instance);
         this._tipTF = ComponentUtil.getTextField(Model_initStr.LOADINGSTR1,this,{
            "size":14,
            "bold":true
         });
      }
      
      public static function get instance() : View_loading
      {
         return _instance;
      }
      
      public function begin() : void
      {
         LogoLoading.instance.begin();
         KeyboardManager.isEnabled = false;
         this.resize();
         GameScene.loadingLayer.addChild(View_loading.instance);
         this.isPlaying = true;
         visible = true;
         Global.control.registerCallBack(Enum_MsgType.STAGE_RESIZE,this.resize);
      }
      
      public function end() : void
      {
         LogoLoading.instance.end();
         if(SceneConfig.getSceneType() == SceneConfig.KFBZ_BATTLE || SceneConfig.getSceneType() == SceneConfig.CROSS_CAMP_BATTLE || Global.sceneMap == 14401)
         {
            KeyboardManager.isEnabled = false;
         }
         else
         {
            KeyboardManager.isEnabled = true;
         }
         if(Boolean(parent))
         {
            parent.removeChild(this);
         }
         this.isPlaying = false;
         Global.control.removeCallBack(Enum_MsgType.STAGE_RESIZE,this.resize);
      }
      
      public function load(arr:Array, fun:Function = null, data:Object = null) : void
      {
         var listItem:LoadItem = new LoadItem();
         listItem.loaderList = arr;
         listItem.compFun = fun;
         listItem.data = data;
         this.list.push(listItem);
         if(!this.isPlaying)
         {
            this.begin();
            this._start();
         }
      }
      
      private function _start() : void
      {
         if(Boolean(this.list.length))
         {
            this.curListItem = this.list.shift();
            this._totLength = this.curListItem.loaderList.length;
            this._curLength = 1;
            this._load();
         }
         else
         {
            this.end();
         }
      }
      
      private function _load() : void
      {
         var res:Array = null;
         var resType:String = null;
         if(Boolean(this.curListItem.loaderList.length))
         {
            res = this.curListItem.loaderList.shift();
            Utils.print("view_loading 开始加载",res[0],res[2],getTimer());
            res[2] = (res[2] as String).replace("加载","");
            this._tipHead = Model_initStr.LOADINGSTR2 + res[2] + " ";
            this.setText();
            resType = Boolean(res[4]) ? res[4] : Enum_resType.RES_URL;
            if(int(res[3]) == Enum_loaderType.MASS)
            {
               MassLoader.add(res[0],function(info:Object):void
               {
                  info.obj[1](info);
                  Utils.print("view_loading 加载完毕:",info.url,getTimer());
                  ++_curLength;
                  _load();
               },this.progressEvent,MassLoader.LEVEL0,res,resType);
            }
            else
            {
               SingleLoader.add(res[0],function(info:Object):void
               {
                  info.obj[1](info);
                  Utils.print("view_loading 加载完毕:",info.url,getTimer());
                  ++_curLength;
                  _load();
               },this.progressEvent,res,resType);
            }
         }
         else
         {
            if(this.curListItem.compFun != null)
            {
               if(Boolean(this.curListItem.compFun.length))
               {
                  this.curListItem.compFun(this.curListItem.data);
               }
               else
               {
                  this.curListItem.compFun();
               }
            }
            this._start();
         }
      }
      
      private function progressEvent(e:ProgressEvent) : void
      {
         var progressNum:Number = e.bytesLoaded / e.bytesTotal;
         this.setText(progressNum);
      }
      
      private function setText(progressNum:Number = 0) : void
      {
         this._tipTF.text = this._tipHead + uint(progressNum * 100) + "% (" + this._curLength + "/" + this._totLength + ")";
         this._tipTF.x = (Global.stage.stageWidth - this._tipTF.textWidth) / 2 + 7;
      }
      
      public function resize() : void
      {
         LogoLoading.instance.resize();
         this._tipTF.x = (Global.stage.stageWidth - this._tipTF.textWidth) / 2 + 7;
         this._tipTF.y = Global.stage.stageHeight / 2 + 60;
      }
   }
}

class LoadItem
{
   
   public var loaderList:Array;
   
   public var compFun:Function;
   
   public var data:Object;
   
   public function LoadItem()
   {
      super();
   }
}
