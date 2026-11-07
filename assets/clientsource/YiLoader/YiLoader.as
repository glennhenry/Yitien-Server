package
{
   import com.utils.ComponentUtil;
   import com.utils.Util;
   import flash.display.Sprite;
   import flash.display.Stage;
   import flash.display.StageAlign;
   import flash.display.StageScaleMode;
   import flash.events.Event;
   import flash.events.KeyboardEvent;
   import flash.system.Security;
   import flash.system.System;
   import flash.ui.Keyboard;
   import flash.utils.getTimer;
   import manager.FrameManager;
   import manager.KeyBoardConst;
   import manager.ResourceManager;
   import manager.ResourceVersionConfig;
   import manager.SocketManager;
   import manager.Utils;
   import scene.SceneManager;
   import view.LogoLoading;
   import view.OffLineTip;
   
   [SWF(width="500", height="375", backgroundColor="#000000", frameRate="24")]
   [SWF(backgroundColor="#000000")]
   public class YiLoader extends Sprite
   {
      
      private var lastTime:int;
      
      private var count:int = 0;
      
      private var startTime:Number;
      
      private var framesNumber:Number = 0;
      
      public function YiLoader()
      {
         super();
         if(!stage)
         {
            return;
         }
         this.init(stage);
      }
      
      public function init(stage:Stage) : void
      {
         stage.frameRate = 30;
         stage.tabChildren = false;
         stage.align = StageAlign.TOP_LEFT;
         stage.scaleMode = StageScaleMode.NO_SCALE;
         stage.stageFocusRect = false;
         stage.addEventListener(Event.RESIZE,this.resize);
         Security.allowDomain("*");
         ResourceManager.resourceIndex = Util.resourcePool;
         Global.stage = stage;
         FrameManager.beginRun();
         Global.config.txtErr = ComponentUtil.getTextField("",null,{
            "y":155,
            "realWidth":700,
            "height":400,
            "selectable":true,
            "mouseEnabled":true
         });
         Global.config.arrErr = new Array();
         stage.addEventListener(KeyboardEvent.KEY_DOWN,this.testInfoShow);
         Global.config.memoryTF = ComponentUtil.getTextField("",null,{
            "x":300,
            "y":20,
            "realWidth":150,
            "color":16711680,
            "bold":true
         });
         Global.config.frameTF = ComponentUtil.getTextField("",null,{
            "x":300,
            "y":45,
            "realWidth":150,
            "color":16773120,
            "bold":true
         });
         var parameters:Object = Global.stage.loaderInfo.parameters;
         Global.account = parameters["account"];
         Global.fcm = parameters["fcm"];
         Global.openkey = Boolean(parameters["openkey"]) ? parameters["openkey"] : "";
         Global.pf = Boolean(parameters["pf"]) ? parameters["pf"] : "";
         if(Enum_SPStr.isUnion(Global.pf))
         {
            Global.pf = Enum_SPStr.QZONE;
         }
         Global.fpkey = Boolean(parameters["fpkey"]) ? parameters["fpkey"] : "";
         Global.invkey = Boolean(parameters["invkey"]) ? parameters["invkey"] : "";
         Global.itime = Boolean(parameters["itime"]) ? parameters["itime"] : "";
         Global.iopenid = Boolean(parameters["iopenid"]) ? parameters["iopenid"] : "";
         Global.app_custom = Boolean(parameters["app_custom"]) ? parameters["app_custom"] : "";
         Global.zoneid = Boolean(parameters["zoneid"]) ? parameters["zoneid"] : "";
         Global.via = Boolean(parameters["via"]) ? parameters["via"] : "";
         Global.adtag = Boolean(parameters["adtag"]) ? parameters["adtag"] : "";
         Global.user_source = Boolean(parameters["user_source"]) ? parameters["user_source"] : "";
         Global.contract_id = Boolean(parameters["contract_id"]) ? parameters["contract_id"] : "";
         Global.fd = Boolean(parameters["fd"]) ? parameters["fd"] : "";
         Global.seqid = Boolean(parameters["seqid"]) ? parameters["seqid"] : "";
         Global.dengluQuHao = Boolean(parameters["dengluQuHao"]) ? int(parameters["dengluQuHao"]) : 0;
         Global.config.resUrl = parameters["resourceHost"];
         Global.config.mapUrl = parameters["mapHost"];
         Global.config.modelUrl = parameters["modelHost"];
         Global.config.ip = parameters["ip"];
         Global.config.port = parameters["port"];
         Global.config.tstamp = Boolean(parameters["tstamp"]) ? parameters["tstamp"] : "1";
         Global.config.officialWebsite = Boolean(parameters["officialWebsite"]) ? parameters["officialWebsite"] : "";
         Global.config.lunWebsite = Boolean(parameters["lunWebsite"]) ? parameters["lunWebsite"] : "";
         Global.config.playerQQGroup = parameters["playerQQGroup"];
         Global.config.fcm = Boolean(parameters["fcm"]) ? parameters["fcm"] : "1";
         Global.config.key = Boolean(parameters["ticket"]) ? parameters["ticket"] : null;
         Global.config.smallTip = Boolean(parameters["smallTip"]) ? parameters["smallTip"].splice(",") : null;
         if(Boolean(parameters["binVersion"]))
         {
            Version.VERSION = parameters["binVersion"];
         }
         if(Boolean(parameters["loadBackUrl"]))
         {
            Global.loadBackUrl = parameters["loadBackUrl"];
         }
         Global.config.mainFile = Boolean(parameters["binVersion"]) ? "bin" + parameters["binVersion"] + ".jpg" : "YiTian.swf";
         Utils.print("ip",Global.config.ip,"port",Global.config.port);
         Model_initStr.initStr();
         if(Boolean(parameters["isRelease"]))
         {
            ResourceVersionConfig.isRelease = false;
         }
         ResourceVersionConfig.initialize();
         stage.addChild(LogoLoading.instance);
         SocketManager.connect(Global.config.ip,Global.config.port);
         this.resize(null);
      }
      
      private function testInfoShow(e:KeyboardEvent) : void
      {
         if(e.altKey && e.shiftKey && e.ctrlKey && e.keyCode == KeyBoardConst.S)
         {
            Utils.print();
            return;
         }
         if(e.altKey && e.ctrlKey && e.keyCode == Keyboard.BACKSPACE)
         {
            if(Global.stage.contains(Global.config.memoryTF))
            {
               Global.stage.removeChild(Global.config.memoryTF);
               Global.stage.removeChild(Global.config.frameTF);
               Global.stage.removeEventListener(Event.ENTER_FRAME,this.memoryShow);
            }
            else
            {
               Global.stage.addChild(Global.config.memoryTF);
               Global.stage.addChild(Global.config.frameTF);
               this.startTime = getTimer();
               this.framesNumber = 0;
               Global.stage.addEventListener(Event.ENTER_FRAME,this.memoryShow);
            }
            return;
         }
      }
      
      private function memoryShow(e:Event) : void
      {
         this.checkFPS();
         if(getTimer() - this.lastTime < 300)
         {
            return;
         }
         this.count = 0;
         var memory:String = System.totalMemory.toString();
         Global.config.memoryTF.text = memory;
         var i:int = memory.length - 1;
         while(i >= 0)
         {
            ++this.count;
            if(this.count == 3)
            {
               if(Boolean(i))
               {
                  Global.config.memoryTF.replaceText(i,i,",");
               }
               this.count = 0;
            }
            i--;
         }
         this.lastTime = getTimer();
      }
      
      private function checkFPS() : void
      {
         var currentTime:Number = (getTimer() - this.startTime) / 1000;
         ++this.framesNumber;
         if(currentTime > 1)
         {
            Global.config.frameTF.text = "FPS: " + Math.floor(this.framesNumber / currentTime * 10) / 10;
            this.startTime = getTimer();
            this.framesNumber = 0;
         }
      }
      
      private function resize(e:Event) : void
      {
         if(LogoLoading.isInit)
         {
            LogoLoading.instance.resize();
         }
         if(OffLineTip.isInit)
         {
            OffLineTip.getInstance().resize();
         }
         SceneManager.reSize();
      }
   }
}

