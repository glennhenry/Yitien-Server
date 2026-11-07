package net
{
   import com.utils.ComponentUtil;
   import flash.net.URLRequest;
   import flash.net.navigateToURL;
   import manager.SocketManager;
   import manager.Utils;
   import scene.CreateScene;
   import scene.CreateSceneNew;
   import scene.LoadingScene;
   import scene.SceneManager;
   import view.LogoLoading;
   import view.OffLineTip;
   
   public class LoginHandler
   {
      
      private static var mainContent:Object;
      
      public function LoginHandler()
      {
         super();
      }
      
      public static function GC_ASK_LOGIN(result:int) : void
      {
         switch(result)
         {
            case 1:
               LoginCGMessage.CG_ASK_CHARLIST();
         }
      }
      
      public static function GC_ASK_CHARLIST(result:int, heros:Array) : void
      {
         Global.key = result >> 8 & 0xFF;
         trace(Global.key);
         var rel:int = result & 0xFF;
         switch(rel)
         {
            case 1:
               if(Boolean(heros.length))
               {
                  Global.heroId = heros[0][0];
                  LogoLoading.instance.visible = true;
                  beginLoadBack();
                  break;
               }
               return;
         }
      }
      
      public static function GC_ASK_CHARLIST_NOROLE(randJob:int) : void
      {
         Global.randJob = randJob;
         if(Global.isUsingNewCreateScene)
         {
            LogoLoading.instance.load("lang/ch/child_creat.swf",Model_initStr.LOAD_CREATE,loadComp);
         }
         else
         {
            LogoLoading.instance.load("lang/ch/createNew.swf",Model_initStr.LOAD_CREATE,loadComp);
         }
      }
      
      private static function loadComp(info:Object) : void
      {
         Global.createDm = info.applicationDomain;
         ComponentUtil.domain = info.applicationDomain;
         if(Global.isUsingNewCreateScene)
         {
            SceneManager.showScene(CreateSceneNew);
         }
         else
         {
            SceneManager.showScene(CreateScene);
         }
         LogoLoading.instance.visible = false;
         beginLoadBack();
      }
      
      private static function beginLoadBack() : void
      {
         LogoLoading.instance.load(Global.loadBackUrl,Model_initStr.INIT_GAME,loadBackComp);
      }
      
      private static function loadBackComp(info:Object) : void
      {
         LogoLoading.instance.dispose();
         LogoLoading.instance.parent.removeChild(LogoLoading.instance);
         Global.loadBack = info.applicationDomain;
         if(SceneManager.nowScene == null)
         {
            SceneManager.showScene(LoadingScene);
         }
         loadMainFile();
         LoadingScene.start();
      }
      
      private static function loadMainFile() : void
      {
         var arr:Array = [];
         arr.push([Global.config.mainFile,loadMainComp,Model_initStr.LOAD_MAIN]);
         LoadingScene.instance.load(arr);
      }
      
      private static function loadMainComp(info:Object) : void
      {
         mainContent = info.content;
         mainContent["init"](Global.stage,LoadingScene,Global.heroId,SocketManager.socket,SocketManager.index,SocketManager.send,Utils.print,SocketManager.receive);
      }
      
      public static function GC_CREATE_ROLE(result:int, heros:Array) : void
      {
         switch(result)
         {
            case 1:
               if(Boolean(heros.length))
               {
                  if(Global.isUsingNewCreateScene)
                  {
                     CreateSceneNew.instance.dealShare();
                  }
                  else
                  {
                     CreateScene.instance.dealShare();
                  }
                  Global.heroId = heros[0][0];
                  if(Boolean(mainContent))
                  {
                     mainContent["sendEnterScene"](Global.heroId);
                  }
                  if(Boolean(Global.loadBack))
                  {
                     SceneManager.showScene(LoadingScene);
                     break;
                  }
                  SceneManager.clearCurScene();
                  LogoLoading.instance.visible = true;
               }
               break;
            case 2:
               if(Global.isUsingNewCreateScene)
               {
                  CreateSceneNew.instance.nameRepeat();
                  break;
               }
               CreateScene.instance.nameRepeat();
         }
      }
      
      public static function GC_OFF_LINE(offLineType:int) : void
      {
         if(offLineType == 1)
         {
            OffLineTip.getInstance().show(Model_initStr.OFFLINE_STR1);
         }
         else if(offLineType == 2)
         {
            OffLineTip.getInstance().show(Model_initStr.OFFLINE_STR2);
         }
         else if(offLineType == 4)
         {
            OffLineTip.getInstance().show(Model_initStr.VIEW_ALERT_STR1,function():void
            {
               navigateToURL(new URLRequest("http://bbs.open.qq.com/thread-2727651-1-1.html"),"_blank");
            });
            OffLineTip.isFengHao = true;
         }
      }
   }
}

