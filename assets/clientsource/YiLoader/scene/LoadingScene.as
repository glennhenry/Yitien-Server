package scene
{
   import com.ui.controls.MyTextField;
   import com.utils.ComponentUtil;
   import flash.display.Bitmap;
   import flash.display.Shape;
   import flash.display.Sprite;
   import flash.events.ProgressEvent;
   import flash.utils.getTimer;
   import manager.EffectManager;
   import manager.FrameManager;
   import manager.MassLoader;
   import manager.Utils;
   import view.Effect;
   
   public class LoadingScene extends IScene
   {
      
      private static var container1:Sprite;
      
      public static var temBG:Bitmap;
      
      public static var temBar:Bitmap;
      
      public static var temBarBg:Bitmap;
      
      public static var partProgress:MyTextField;
      
      public static var totalProgress:MyTextField;
      
      public static var loadEff:Effect;
      
      private static var _instance:LoadingScene;
      
      private static var mskShap:Shape;
      
      private static var curListItem:LoadItem;
      
      private static var _curLength:int;
      
      private static var _totLength:int;
      
      private static var lastLoad:int;
      
      private static var lastTime:int;
      
      private static var loadSpeed:Number;
      
      private static var list:Array = [];
      
      public static var canLoad:Boolean = false;
      
      private static var isLoading:Boolean = false;
      
      public function LoadingScene()
      {
         super();
         container1 = new Sprite();
         addChild(container1);
         temBG = ComponentUtil.getBitmap("loading",container1,null,Global.loadBack);
         temBar = ComponentUtil.getBitmap("bar",container1,{
            "x":300,
            "y":547,
            "scaleX":0
         },Global.loadBack);
         mskShap = ComponentUtil.getShape(430,13);
         container1.addChild(mskShap);
         ComponentUtil.setPropertie(mskShap,{
            "x":300,
            "y":547
         });
         temBar.mask = mskShap;
         mskShap.width = 0;
         temBarBg = ComponentUtil.getBitmap("barBG",container1,{
            "x":200,
            "y":523
         },Global.loadBack);
         partProgress = ComponentUtil.getTextField("0%",container1,{
            "x":465,
            "y":545,
            "color":16777215
         });
         totalProgress = ComponentUtil.getTextField(Model_initStr.LOAD_MAIN,container1,{
            "x":430,
            "y":510,
            "color":16777215
         });
         loadEff = EffectManager.addEffect("35050",container1,300,temBar.x + temBar.width + 5,temBar.y + 7,true);
      }
      
      public static function get instance() : LoadingScene
      {
         if(!_instance)
         {
            _instance = new LoadingScene();
         }
         return _instance;
      }
      
      public static function start() : void
      {
         canLoad = true;
         isLoading = true;
         _start();
      }
      
      private static function _start() : void
      {
         if(Boolean(list.length))
         {
            curListItem = list.shift();
            _totLength = curListItem.loaderList.length;
            _curLength = 0;
            _load();
         }
         else
         {
            isLoading = false;
         }
      }
      
      private static function _load() : void
      {
         var res:Array = null;
         var resType:String = null;
         if(Boolean(curListItem.loaderList.length))
         {
            res = curListItem.loaderList.shift();
            if(Boolean(totalProgress))
            {
               totalProgress.text = res[2];
            }
            Utils.print("开始加载资源:[" + res[0] + "]" + getTimer() + "|");
            if(res[0] != "")
            {
               resType = Boolean(res[4]) ? res[4] : "resUrl";
               MassLoader.add(res[0],function(info:Object):void
               {
                  Utils.print("资源加载完毕:[" + info.url + "]" + getTimer() + "|");
                  info.obj[1](info);
                  ++_curLength;
                  _load();
               },progressEvent,MassLoader.LEVEL0,res,resType);
               lastTime = getTimer();
               lastLoad = 0;
            }
            else
            {
               res[1]();
               ++_curLength;
               _load();
            }
         }
         else
         {
            if(curListItem.compFun != null)
            {
               curListItem.compFun();
            }
            _start();
         }
      }
      
      private static function progressEvent(e:ProgressEvent) : void
      {
         if(lastLoad != 0)
         {
            loadSpeed = e.bytesLoaded / (getTimer() - lastTime);
         }
         var speedStr:String = Boolean(loadSpeed) ? loadSpeed.toFixed(1) + "kb/s" : "";
         lastLoad = e.bytesLoaded;
         var progressNum:Number = e.bytesLoaded / e.bytesTotal;
         mskShap.width = 430 * progressNum;
         if(Boolean(partProgress))
         {
            partProgress.text = uint(progressNum * 100) + "%";
         }
         if(Boolean(loadEff))
         {
            loadEff.px = mskShap.x + mskShap.width + 5;
            loadEff.py = mskShap.y + 7;
         }
      }
      
      override public function show() : void
      {
         super.show();
      }
      
      public function load(arr:Array, fun:Function = null, data:Object = null) : void
      {
         var listItem:LoadItem = new LoadItem();
         listItem.loaderList = arr;
         listItem.compFun = fun;
         listItem.data = data;
         list.push(listItem);
         if(canLoad && !isLoading)
         {
            start();
         }
      }
      
      override public function dispose() : void
      {
         if(Boolean(loadEff))
         {
            EffectManager.removeEffect(loadEff);
            loadEff = null;
         }
         super.dispose();
         FrameManager.endRun();
         SceneManager.nowScene = null;
      }
      
      override public function resize() : void
      {
         container1.x = (Global.stage.stageWidth - temBG.width) / 2;
         container1.y = (Global.stage.stageHeight - temBG.height) / 2;
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
