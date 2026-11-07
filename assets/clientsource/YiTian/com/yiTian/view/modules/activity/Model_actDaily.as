package com.yiTian.view.modules.activity
{
   import com.yiTian.Global;
   import com.yiTian.command.BindObj;
   import com.yiTian.command.Enum_MsgType;
   import com.yiTian.data.Data_lib;
   import com.yiTian.data.model.Model_bang;
   import com.yiTian.data.model.Model_team;
   import com.yiTian.data.vo.Vo_KFBP;
   import com.yiTian.data.vo.Vo_KFLevel;
   import com.yiTian.data.vo.Vo_KFWL;
   import com.yiTian.gameUnit.config.Status;
   import com.yiTian.manager.GameUnitManager;
   import com.yiTian.manager.LangConfig;
   import com.yiTian.manager.SceneConfig;
   import com.yiTian.manager.UIManager;
   import com.yiTian.net.message.cg.BangBattleCGMessage;
   import com.yiTian.net.message.cg.FishingCGMessage;
   import com.yiTian.net.message.cg.KLMountianCGMessage;
   import com.yiTian.net.message.cg.SceneCGMessage;
   import com.yiTian.net.message.cg.WulinPartyCGMessage;
   import com.yiTian.view.modules.AiDeBaoBao.View_AiDeBaoBao_joinMenu;
   import com.yiTian.view.modules.Kunlun.View_klTipBtn;
   import com.yiTian.view.modules.banhui.View_BangTipBtn;
   import com.yiTian.view.modules.fishing.View_FishTipBtn;
   import com.yiTian.view.modules.mainUIBtnContainer.Enum_mainUIBtn_hide;
   import com.yiTian.view.modules.worldBoss.WorldBossUtil;
   import flash.utils.Dictionary;
   
   public class Model_actDaily
   {
      
      public static var data_chongji:Vector.<Vo_KFLevel>;
      
      public static var data_bangpai:Vector.<Vo_KFBP>;
      
      public static var data_wulin:Vector.<Vo_KFWL>;
      
      private static var _instance:Model_actDaily;
      
      public static var KF_day:int = -1;
      
      public static var kf_horse_data:Array = [];
      
      public static var kf_zl_data:Array = [];
      
      public static var kf_sc_data:Array = [];
      
      public static var kf_newTipArr:Array = [];
      
      public var retExpArr:Array;
      
      public var kfTime:int;
      
      public var curTime:int;
      
      public var specObj:Object = {};
      
      public var speBtnCn:Array;
      
      public var zmrTimes:int;
      
      private var _kfhdDic:Dictionary;
      
      public var kfhdFinishArr:Array;
      
      private var _rcrwArr:BindObj;
      
      private var _rchdArr:BindObj;
      
      public function Model_actDaily()
      {
         super();
         if(Boolean(_instance))
         {
            throw new Error("singtlon error");
         }
         this.init();
         _instance = this;
      }
      
      public static function getInstance() : Model_actDaily
      {
         if(_instance)
         {
         }
         return _instance;
      }
      
      public static function getSub(_id:int, index:int) : Object
      {
         var obj:Object = null;
         switch(_id)
         {
            case Enum_KF.ID_HORSE:
               if(!kf_horse_data.length)
               {
                  return null;
               }
               obj = new Object();
               obj.name = kf_horse_data[index].name;
               obj.status = kf_horse_data[index].status;
               obj.reamain = kf_horse_data[index].reamain;
               break;
            case Enum_KF.ID_BB:
               if(!kf_sc_data.length)
               {
                  return null;
               }
               obj = new Object();
               obj.name = kf_sc_data[index].name;
               obj.status = kf_sc_data[index].status;
               obj.reamain = kf_sc_data[index].reamain;
               break;
            case Enum_KF.ID_ZL:
               if(!kf_zl_data.length)
               {
                  return null;
               }
               obj = new Object();
               obj.name = kf_zl_data[index].name;
               obj.status = kf_zl_data[index].status;
               obj.reamain = kf_zl_data[index].reamain;
         }
         return obj;
      }
      
      public function get kfhdDic() : Dictionary
      {
         var key:String = null;
         var infos:Array = null;
         var i:int = 0;
         var id:int = 0;
         if(!this._kfhdDic)
         {
            this._kfhdDic = new Dictionary();
            for(key in Data_lib.kfhd)
            {
               infos = Data_lib.kfhd[key];
               i = 10;
               while(i < infos.length)
               {
                  id = int(infos[i]);
                  if(id > 0)
                  {
                     this._kfhdDic[id] = int(key);
                  }
                  i += 3;
               }
            }
         }
         return this._kfhdDic;
      }
      
      public function get rcrwArr() : BindObj
      {
         return this._rcrwArr;
      }
      
      public function updateAct(... param) : void
      {
         var i:int = 0;
         while(i < param.length)
         {
            this.rchdArr.getData()[param[i]] = param[i + 1];
            i += 2;
         }
         this.rchdArr.setData(this.rchdArr.getData());
      }
      
      public function get rchdArr() : BindObj
      {
         return this._rchdArr;
      }
      
      private function init() : void
      {
         this._rcrwArr = new BindObj();
         this._rcrwArr.setBindViewer(UIManager.amPanel.mrrw);
         this._rchdArr = new BindObj();
         this._rchdArr.setBindViewer(UIManager.amPanel.mrhd);
         this.rchdArr.setData([]);
      }
      
      public function hasAct() : Boolean
      {
         var b:Boolean = false;
         for each(b in this.rchdArr.getData())
         {
            if(b)
            {
               return true;
            }
         }
         return false;
      }
      
      public function joinWorldBoss() : void
      {
         WorldBossUtil.TRY_ENTERFUBEN();
      }
      
      public function joinLoveHug() : void
      {
         Global.delegate.dosomething(View_AiDeBaoBao_joinMenu.instance,function():void
         {
            View_AiDeBaoBao_joinMenu.instance.visible = !View_AiDeBaoBao_joinMenu.instance.visible;
         });
      }
      
      public function joinKeJuTest() : void
      {
         GameUnitManager.hero.autoMove(51096);
      }
      
      public function toFish() : void
      {
         if(GameUnitManager.hero.level < 30)
         {
            UIManager.centerBroadcast.addMsg(LangConfig.getWord("23330",2));
            return;
         }
         if(Model_team.teamMumberInfo_data_save.length > 0)
         {
            UIManager.centerBroadcast.addMsg(LangConfig.getWord("23331",2));
            return;
         }
         if(SceneConfig.getSceneType() != SceneConfig.COMMON)
         {
            UIManager.centerBroadcast.addMsg(LangConfig.getWord("23332",2));
            return;
         }
         if(GameUnitManager.hero.status == Status.SIT)
         {
            UIManager.centerBroadcast.addMsg(LangConfig.getWord("1142",0));
            return;
         }
         FishingCGMessage.CG_ENTER_RIVER(-1);
      }
      
      public function toKunLun() : void
      {
         if(GameUnitManager.hero.level < 30)
         {
            UIManager.centerBroadcast.addMsg(LangConfig.getWord("22343",2));
            return;
         }
         if(SceneConfig.getSceneType() != SceneConfig.COMMON)
         {
            UIManager.centerBroadcast.addMsg(LangConfig.getWord("22344",2));
            return;
         }
         if(Model_team.hasTeam())
         {
            UIManager.centerBroadcast.addMsg(LangConfig.getWord("22358",2));
            return;
         }
         KLMountianCGMessage.CG_ENTER_KL_MOUNTIAN();
      }
      
      public function toBangBattle() : void
      {
         if(GameUnitManager.hero.level < 35)
         {
            UIManager.centerBroadcast.addMsg(LangConfig.getWord("22503",2));
            return;
         }
         if(Model_bang.partyType == 1)
         {
            UIManager.centerBroadcast.addMsg("公共帮会不能参与帮会战");
            return;
         }
         if(GameUnitManager.hero.partyId == 0)
         {
            UIManager.centerBroadcast.addMsg(LangConfig.getWord("22523",2));
            return;
         }
         if(Model_team.teamMumberInfo_data_save.length > 0)
         {
            UIManager.centerBroadcast.addMsg(LangConfig.getWord("22524",2));
            return;
         }
         if(SceneConfig.getSceneType() != SceneConfig.COMMON)
         {
            UIManager.centerBroadcast.addMsg(LangConfig.getWord("22525",2));
            return;
         }
         BangBattleCGMessage.CG_ENTER_BANG_BATTLE();
      }
      
      public function toBaoXiang() : void
      {
         if(GameUnitManager.hero.level < 30)
         {
            UIManager.centerBroadcast.addMsg(LangConfig.getWord("10329",1));
            return;
         }
         if(Model_team.teamMumberInfo_data_save.length > 0)
         {
            UIManager.centerBroadcast.addMsg(LangConfig.getWord("29139",2));
            return;
         }
         SceneCGMessage.CG_TO_NPC(5);
      }
      
      public function toWuLin() : void
      {
         WulinPartyCGMessage.CG_ENTER_WULIN_DAHUI();
      }
      
      public function kunlun(v:Boolean) : void
      {
         if(v)
         {
            if(GameUnitManager.hero.level < 30)
            {
               Global.control.registerCallBack(Enum_MsgType.MSG_LV_UP,this.kunlunFun);
            }
            else
            {
               this.kunlunFun();
            }
         }
         else
         {
            Global.control.removeCallBack(Enum_MsgType.MSG_LV_UP,this.kunlunFun);
            if(View_klTipBtn.isInstance())
            {
               UIManager.mainUiBtnContainer.removeBTN(View_klTipBtn.instance);
               View_klTipBtn.instance.dispose();
               UIManager.kunlun_prompt.visible = false;
            }
            Global.control.sendNotification(Enum_mainUIBtn_hide.CHANGE_STATUS,[Enum_mainUIBtn_hide.KunLunShan,2]);
         }
      }
      
      public function bangzhan(v:Boolean) : void
      {
         if(v)
         {
            if(GameUnitManager.hero.level < 35)
            {
               Global.control.registerCallBack(Enum_MsgType.MSG_LV_UP,this.bangzhanFun);
            }
            else
            {
               this.bangzhanFun();
            }
         }
         else
         {
            Global.control.removeCallBack(Enum_MsgType.MSG_LV_UP,this.bangzhanFun);
            if(View_BangTipBtn.isInstance())
            {
               UIManager.mainUiBtnContainer.removeBTN(View_BangTipBtn.instance);
               View_BangTipBtn.instance.dispose();
            }
            Global.control.sendNotification(Enum_mainUIBtn_hide.CHANGE_STATUS,[Enum_mainUIBtn_hide.BangHuiZhan,2]);
         }
      }
      
      private function kunlunFun() : void
      {
         if(GameUnitManager.hero.level < 30)
         {
            return;
         }
         Global.control.removeCallBack(Enum_MsgType.MSG_LV_UP,this.kunlunFun);
         var klTipBtn:View_klTipBtn = View_klTipBtn.instance;
         UIManager.mainUiBtnContainer.addBTN(klTipBtn);
         Global.control.sendNotification(Enum_mainUIBtn_hide.CHANGE_STATUS,[Enum_mainUIBtn_hide.KunLunShan,1]);
         if(GameUnitManager.hero.level >= 30)
         {
            UIManager.kunlun_prompt.visible = true;
         }
         Model_actDaily.getInstance().updateAct(2,true);
      }
      
      private function bangzhanFun() : void
      {
         if(GameUnitManager.hero.level < 35)
         {
            return;
         }
         Global.control.removeCallBack(Enum_MsgType.MSG_LV_UP,this.bangzhanFun);
         var bbTipBtn:View_BangTipBtn = View_BangTipBtn.instance;
         UIManager.mainUiBtnContainer.addBTN(bbTipBtn);
         Global.control.sendNotification(Enum_mainUIBtn_hide.CHANGE_STATUS,[Enum_mainUIBtn_hide.BangHuiZhan,1]);
      }
      
      public function diaoyu(v:Boolean) : void
      {
         if(v)
         {
            if(GameUnitManager.hero.level < 30)
            {
               Global.control.registerCallBack(Enum_MsgType.MSG_LV_UP,this.diaoyuFun);
            }
            else
            {
               this.diaoyuFun();
            }
            Global.control.sendNotification(Enum_mainUIBtn_hide.CHANGE_STATUS,[Enum_mainUIBtn_hide.DiaoYu,1]);
         }
         else
         {
            Global.control.removeCallBack(Enum_MsgType.MSG_LV_UP,this.diaoyuFun);
            if(View_FishTipBtn.isInstance())
            {
               UIManager.mainUiBtnContainer.removeBTN(View_FishTipBtn.instance);
               View_FishTipBtn.instance.dispose();
            }
            Global.control.sendNotification(Enum_mainUIBtn_hide.CHANGE_STATUS,[Enum_mainUIBtn_hide.DiaoYu,2]);
         }
      }
      
      private function diaoyuFun() : void
      {
         var fishTipBtn:View_FishTipBtn = View_FishTipBtn.instance;
         UIManager.mainUiBtnContainer.addBTN(fishTipBtn);
      }
   }
}

