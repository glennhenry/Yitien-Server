package com.yiTian.view.modules.roleHead
{
   import com.ui.controls.Button;
   import com.ui.controls.ScaleBitmap;
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.command.Enum_MsgType;
   import com.yiTian.manager.GameUnitManager;
   import com.yiTian.manager.LangConfig;
   import com.yiTian.manager.SceneConfig;
   import com.yiTian.manager.UIManager;
   import com.yiTian.net.handler.GuangMingDingCGMessage;
   import com.yiTian.net.message.cg.ChatCGMessage;
   import com.yiTian.net.message.cg.FriendCGMessage;
   import com.yiTian.net.message.cg.RoleCGMessage;
   import com.yiTian.net.message.cg.TeamCGMessage;
   import com.yiTian.scene.GameScene;
   import com.yiTian.utils.Utils;
   import com.yiTian.view.modules.KFHomeland.VoHome;
   import com.yiTian.view.modules.crossCampBattle.Model_CrossCampBattle;
   import com.yiTian.view.modules.crossClanBattle.Model_CrossClanBattle;
   import com.yiTian.view.modules.friends.Model_Friends;
   import com.yiTian.view.modules.newRolePan.ComparePan;
   import com.yiTian.view.modules.wuXing.WuXingMter;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import flash.system.System;
   
   public class PlayerMenu extends Sprite
   {
      
      private static var instance:PlayerMenu;
      
      public static const ckzl:String = LangConfig.getWord("10434",1);
      
      public static const fqjy:String = LangConfig.getWord("10435",1);
      
      public static const fsyj:String = LangConfig.getWord("10436",1);
      
      public static const fzmz:String = LangConfig.getWord("10437",1);
      
      public static const jhmd:String = LangConfig.getWord("1130",0);
      
      public static const jwhy:String = LangConfig.getWord("10439",1);
      
      public static const sl:String = LangConfig.getWord("10440",1);
      
      public static const yjdz:String = LangConfig.getWord("10441",1);
      
      public static const tcdw:String = LangConfig.getWord("10442",1);
      
      public static const zdqq:String = LangConfig.getWord("10443",1);
      
      public static const yqcc:String = LangConfig.getWord("10444",1);
      
      public static const gkzd:String = LangConfig.getWord("10445",1);
      
      public static const zsxh:String = LangConfig.getWord("10446",1);
      
      public static const fqlt:String = LangConfig.getWord("10447",1);
      
      public static var isSpecialCheck:Boolean = false;
      
      private static var pool:Array = [];
      
      private var back:ScaleBitmap;
      
      private var btnVec:Vector.<Button>;
      
      private var _point:Point;
      
      private var _data:Object;
      
      public function PlayerMenu()
      {
         super();
      }
      
      public static function getInstance() : PlayerMenu
      {
         if(!instance)
         {
            instance = new PlayerMenu();
            GameScene.popupLayer.addChild(instance);
            instance.init();
         }
         return instance;
      }
      
      public static function getBtn() : Button
      {
         var btn:Button = null;
         if(Boolean(pool.length))
         {
            btn = pool.pop();
            getInstance().addChild(btn);
            return btn;
         }
         return ComponentUtil.getButton("","ChannelButtonFour",getInstance(),null,ComponentUtil.domain);
      }
      
      private function init() : void
      {
         this.back = ComponentUtil.getScaleBitmap("Back_Floating",[8,9,4,2],this,{
            "x":0,
            "y":0,
            "width":87,
            "height":95
         },Global.Img_Cdm);
      }
      
      public function show(labelArr:Array, data:Object) : void
      {
         var btn:Button = null;
         var i:uint = 0;
         this.hide();
         if(SceneConfig.getSceneType() == SceneConfig.KFBZ_BATTLE || SceneConfig.getSceneType() == SceneConfig.CROSS_CAMP_BATTLE)
         {
            return;
         }
         this._data = data;
         if(Boolean(labelArr) && Boolean(this._data))
         {
            this.btnVec = new Vector.<Button>();
            i = 0;
            while(i < labelArr.length)
            {
               btn = getBtn();
               btn.label = labelArr[i];
               btn.x = (this.back.width - btn.width) / 2;
               btn.y = 2 + (btn.height + 2) * i;
               this.btnVec[i] = btn;
               btn.addEventListener(MouseEvent.CLICK,this.btnClick);
               i++;
            }
            this.back.height = btn.y + btn.height + 3;
            this._point = new Point(Global.stage.mouseX,Global.stage.mouseY);
            this.resetPosition();
            this.visible = true;
            Global.stage.addEventListener(MouseEvent.CLICK,this.setMenuVisible);
         }
      }
      
      protected function setMenuVisible(event:MouseEvent) : void
      {
         Global.stage.removeEventListener(MouseEvent.CLICK,this.setMenuVisible);
         this.hide();
      }
      
      protected function btnClick(event:MouseEvent) : void
      {
         var btn:Button = event.target as Button;
         switch(btn.label)
         {
            case LangConfig.getWord("10434",1):
               if(isSpecialCheck)
               {
                  WuXingMter.getPan(ComparePan,function(pan:ComparePan):void
                  {
                     pan.showTitle(-1);
                  });
                  RoleCGMessage.CG_CHECK_OTHERROLE(this._data.id);
                  RoleCGMessage.CG_CHECK_OTHER_NEW(this._data.id);
                  break;
               }
               RoleCGMessage.CG_CHECK_OTHERROLE(this._data.id);
               break;
            case LangConfig.getWord("10435",1):
               UIManager.trans_panel.show_trans_send(this._data.name);
               break;
            case LangConfig.getWord("10436",1):
               Global.control.sendNotification(Enum_MsgType.MSG_SENDMAIL,this._data.name);
               break;
            case LangConfig.getWord("10437",1):
               System.setClipboard(this._data.name.toString());
               break;
            case LangConfig.getWord("1130",0):
               if(Model_Friends.getHeatVoById(this._data.id) != null)
               {
                  UIManager.centerBroadcast.addMsg(LangConfig.getWord("1131",0));
                  return;
               }
               UIManager.centerBroadcast.addMsg(LangConfig.getWord("1132",0));
               FriendCGMessage.CG_ADD_CONTACT_BY_TYPE(2,this._data.name);
               break;
            case LangConfig.getWord("10439",1):
               FriendCGMessage.CG_ADD_FRIEND(this._data.name);
               break;
            case LangConfig.getWord("10440",1):
               if(GameUnitManager.hero.level < 30)
               {
                  UIManager.centerBroadcast.addMsg("亲，您还未到30级不能私聊");
                  return;
               }
               ChatCGMessage.CG_SID_CHAT(this._data.id);
               break;
            case LangConfig.getWord("10441",1):
               TeamCGMessage.CG_CHANGE_CAP(this._data.id);
               break;
            case LangConfig.getWord("10442",1):
               if(SceneConfig.getSceneType() == SceneConfig.GMD)
               {
                  GuangMingDingCGMessage.CG_GMD_KICK_TEAMMEMBER(this._data.id);
                  break;
               }
               TeamCGMessage.CG_KICK_OUT(this._data.id);
               break;
            case LangConfig.getWord("10443",1):
               if(SceneConfig.getSceneType() == SceneConfig.KFBZ_BATTLE)
               {
                  if(Utils.dist(GameUnitManager.hero.global_x,GameUnitManager.hero.global_y,Model_CrossClanBattle.selfPoint.x,Model_CrossClanBattle.selfPoint.y) >= Model_CrossClanBattle.selfR * Model_CrossClanBattle.selfR || Utils.dist(this._data.x,this._data.y,Model_CrossClanBattle.selfPoint.x,Model_CrossClanBattle.selfPoint.y) >= Model_CrossClanBattle.selfR * Model_CrossClanBattle.selfR)
                  {
                     UIManager.centerBroadcast.addMsg("只能在帮会基地里进行组队");
                     break;
                  }
                  this.onTeam();
                  break;
               }
               if(SceneConfig.getSceneType() == SceneConfig.CROSS_CAMP_BATTLE)
               {
                  if(Utils.dist(GameUnitManager.hero.global_x,GameUnitManager.hero.global_y,Model_CrossCampBattle.selfPoint.x,Model_CrossCampBattle.selfPoint.y) >= Model_CrossCampBattle.selfR * Model_CrossCampBattle.selfR || Utils.dist(this._data.x,this._data.y,Model_CrossCampBattle.selfPoint.x,Model_CrossCampBattle.selfPoint.y) >= Model_CrossCampBattle.selfR * Model_CrossCampBattle.selfR)
                  {
                     UIManager.centerBroadcast.addMsg("只能在复活点内进行组队");
                     break;
                  }
                  this.onTeam();
                  break;
               }
               this.onTeam();
               break;
            case LangConfig.getWord("10447",1):
               ChatCGMessage.CG_SID_CHAT(this._data.id);
         }
         this.hide();
      }
      
      private function onTeam() : void
      {
         var zone:int = 0;
         var index:int = 0;
         if(Global.isInHome)
         {
            index = int(this._data.name.indexOf(".S"));
            if(index != -1)
            {
               zone = int(this._data.name.slice(index + 2,this._data.name.length));
            }
            else
            {
               zone = VoHome.heroS;
            }
            TeamCGMessage.CG_DIRECT_TEAM_STATE(0,this._data.id.toString(),zone);
         }
         else
         {
            TeamCGMessage.CG_DIRECT_TEAM_STATE(0,this._data.id.toString());
         }
      }
      
      private function hide() : void
      {
         var i:uint = 0;
         this.visible = false;
         false;
         if(Boolean(this.btnVec))
         {
            i = 0;
            while(i < this.btnVec.length)
            {
               if(this.contains(this.btnVec[i]))
               {
                  pool.push(this.btnVec[i]);
                  this.removeChild(this.btnVec[i]);
               }
               i++;
            }
         }
      }
      
      private function resetPosition() : void
      {
         if(Global.stage.stageWidth - this._point.x < width)
         {
            x = this._point.x - width;
         }
         else
         {
            x = this._point.x;
         }
         if(Global.stage.stageHeight - this._point.y < height)
         {
            y = this._point.y - height;
         }
         else
         {
            y = this._point.y;
         }
      }
   }
}

