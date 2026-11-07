package com.yiTian.net.handler
{
   import com.ui.controls.MyTextField;
   import com.utils.ComponentUtil;
   import com.utils.DmManager;
   import com.yiTian.Global;
   import com.yiTian.data.Data_lib;
   import com.yiTian.data.model.Model_initStr;
   import com.yiTian.manager.DailyRemainManager;
   import com.yiTian.manager.LangConfig;
   import com.yiTian.manager.SceneManager;
   import com.yiTian.manager.UIManager;
   import com.yiTian.net.message.cg.SceneCGMessage;
   import com.yiTian.scene.CreateScene;
   import com.yiTian.scene.LoadingScene;
   import com.yiTian.utils.Tween;
   import com.yiTian.utils.WorldConfig;
   import com.yiTian.view.comp.View_Alert;
   import com.yiTian.view.modules.FeiXingQi.Model_FeiXingQi;
   import com.yiTian.view.modules.loading.View_loading;
   import com.yiTian.view.modules.onlineValidate.OnlineValidate;
   import com.yiTian.view.modules.tip.tips.OffLineTip;
   import flash.net.URLRequest;
   import flash.net.navigateToURL;
   import flash.utils.setTimeout;
   
   public class LoginHandler
   {
      
      public static var heroId:Number;
      
      public function LoginHandler()
      {
         super();
      }
      
      public static function loadResource() : void
      {
         var arr:Array = [];
         arr.push(["resource/config/config.xml",Data_lib.init,Model_initStr.LOGINSTR3]);
         if(Boolean(Global.HD2VarsionCrl))
         {
            arr.push(["resource/config/config2.xml",Data_lib.init,Model_initStr.LOGINSTR3]);
         }
         arr.push(["resource/config/worldConfig.xml",WorldConfig.init,Model_initStr.LOGINSTR4]);
         arr.push(["lang/" + Global.config.lang + "/NpcTalk_.swf",function(info:Object):void
         {
            Global.npcTalk = info.applicationDomain;
         },Model_initStr.LOGINSTR5]);
         arr.push(["lang/" + Global.config.lang + "/effectWord.swf",function(info:Object):void
         {
            Global.effectWord = info.applicationDomain;
         },Model_initStr.LOGINSTR5]);
         arr.push(["lang/" + Global.config.lang + "/Scene.swf",function(info:Object):void
         {
            DmManager.Scenedm = info.applicationDomain;
            Global.Scenedm = info.applicationDomain;
         },Model_initStr.LOGINSTR5]);
         arr.push(["lang/" + Global.config.lang + "/Img_C.swf",function(info:Object):void
         {
            DmManager.Img_Cdm = info.applicationDomain;
            Global.Img_Cdm = info.applicationDomain;
         },Model_initStr.LOGINSTR5]);
         arr.push(["lang/ch/newRe.swf",function(info:Object):void
         {
            DmManager.New_Imgsdm = info.applicationDomain;
            Global.New_Imgsdm = info.applicationDomain;
         },Model_initStr.LOGINSTR5]);
         arr.push(["lang/ch/chatTest.swf",function(info:Object):void
         {
            Global.chat_testdm = info.applicationDomain;
         },Model_initStr.LOGINSTR5]);
         arr.push(["lang/" + Global.config.lang + "/newUI.swf",UIManager.createUI,Model_initStr.LOGINSTR5]);
         LoadingScene.load(arr,function():void
         {
            if(Boolean(heroId))
            {
               SceneCGMessage.CG_ENTER_SCENE(heroId);
            }
         });
      }
      
      private static function loadComp(info:Object) : void
      {
         Global.createDm = info.applicationDomain;
         ComponentUtil.domain = info.applicationDomain;
         SceneManager.showScene(CreateScene);
      }
      
      public static function GC_CREATE_ROLE(result:int, heros:Array) : void
      {
         switch(result)
         {
            case 1:
               if(Boolean(heros.length))
               {
                  CreateScene.instance.dealShare();
                  SceneCGMessage.CG_ENTER_SCENE(heros[0][0]);
                  if(Boolean(Global.loadBack))
                  {
                     SceneManager.showScene(LoadingScene);
                     break;
                  }
                  SceneManager.clearCurScene();
                  View_loading.instance.visible = true;
               }
               break;
            case 2:
               CreateScene.instance.nameRepeat();
         }
      }
      
      public static function GC_OFF_LINE(offLineType:int) : void
      {
         if(offLineType == 1)
         {
            View_Alert.show(LangConfig.getWord("648",0),View_Alert.OK);
         }
         else if(offLineType == 2)
         {
            View_Alert.show(LangConfig.getWord("649",0),View_Alert.OK);
         }
         else if(offLineType == 3)
         {
            View_Alert.show(LangConfig.getWord("650",0),View_Alert.OK);
         }
         else if(offLineType == 4)
         {
            OffLineTip.isFengHao = true;
            View_Alert.show(Model_initStr.VIEW_ALERT_STR1,View_Alert.OK,null,null,null,function():void
            {
               navigateToURL(new URLRequest("http://bbs.open.qq.com/thread-2727651-1-1.html"),"_blank");
            });
         }
      }
      
      public static function GC_DAILY_REMAIN(JJC:int, DAILY_QUEST:int, LIN_QI:int, PA_TA:int, ZHANG_MEN_REN:int, CHUANG_GUAN:int, PAO_BIAO:int) : void
      {
         DailyRemainManager.setCount(DailyRemainManager.JJC,JJC);
         DailyRemainManager.setCount(DailyRemainManager.DAILY_QUEST,DAILY_QUEST);
         DailyRemainManager.setCount(DailyRemainManager.LIN_QI,LIN_QI);
         DailyRemainManager.setCount(DailyRemainManager.PA_TA,PA_TA);
         DailyRemainManager.setCount(DailyRemainManager.ZHANG_MEN_REN,ZHANG_MEN_REN);
         DailyRemainManager.setCount(DailyRemainManager.CG,CHUANG_GUAN);
         DailyRemainManager.setCount(DailyRemainManager.PAO_BIAO,PAO_BIAO);
         Model_FeiXingQi.countTimes(CHUANG_GUAN);
      }
      
      public static function GC_VALIDATE(info:int) : void
      {
         OnlineValidate.getInstance().show(info);
      }
      
      public static function GC_VALIDATE_REWARD(type:int, value:int) : void
      {
         var word:String = null;
         if(type == 1)
         {
            word = LangConfig.getWord("30011",3,value);
         }
         else if(type == 2)
         {
            word = LangConfig.getWord("30012",3,value);
         }
         UIManager.selfBroadcast.addMsg(word);
         UIManager.centerBroadcast.addMsg(word);
      }
      
      public static function GC_VALIDATING_TIP() : void
      {
         UIManager.centerBroadcast.addMsg(LangConfig.getWord("30013",3));
      }
      
      public static function GC_SHUT_UP() : void
      {
         View_Alert.show(LangConfig.getWord("650",0),View_Alert.OK);
      }
      
      public static function GC_SAVE_DATA() : void
      {
         var tf:MyTextField = null;
         tf = ComponentUtil.getTextField("正在加载数据，请稍等...",null,{
            "size":16,
            "color":65535,
            "bold":true
         });
         Global.stage.addChild(tf);
         tf.x = (Global.stage.stageWidth - tf.width) / 2;
         tf.y = (Global.stage.stageHeight - tf.height) / 2;
         Tween.to(tf,4800,{"y":[tf.y,tf.y - 50]},function():void
         {
            tf.parent.removeChild(tf);
         });
         setTimeout(function():void
         {
            SceneCGMessage.CG_ENTER_SCENE(heroId);
         },5000);
      }
   }
}

