package com.yiTian.gameUnit.role
{
   import com.ui.controls.MyTextField;
   import com.utils.ComponentUtil;
   import com.utils.Util;
   import com.yiTian.data.Data_lib;
   import com.yiTian.data.config.Enum_CursorType;
   import com.yiTian.data.config.Enum_job;
   import com.yiTian.gameUnit.config.Action;
   import com.yiTian.gameUnit.config.State;
   import com.yiTian.gameUnit.config.Status;
   import com.yiTian.gameUnit.config.UnitType;
   import com.yiTian.gameUnit.magic.Effect;
   import com.yiTian.manager.CursorManager;
   import com.yiTian.manager.EffectManager;
   import com.yiTian.manager.GameUnitManager;
   import com.yiTian.manager.LangConfig;
   import com.yiTian.manager.SceneConfig;
   import com.yiTian.manager.UIManager;
   import com.yiTian.net.message.cg.BangBattleCGMessage;
   import com.yiTian.net.message.cg.BattleCGMessage;
   import com.yiTian.net.message.cg.CrossCampBattleCGMessage;
   import com.yiTian.net.message.cg.CrossClanBattleCGMessage;
   import com.yiTian.net.message.cg.PaoBiaoCGMessage;
   import com.yiTian.net.message.cg.WulinPartyCGMessage;
   import com.yiTian.scene.GameScene;
   import com.yiTian.utils.MassLoader;
   import com.yiTian.utils.Tween;
   import com.yiTian.utils.Utils;
   import com.yiTian.view.modules.crossCampBattle.Enum_CrossCampBattle;
   import com.yiTian.view.modules.crossCampBattle.Model_CrossCampBattle;
   import flash.display.Bitmap;
   import flash.events.Event;
   import flash.utils.Dictionary;
   
   public class Player extends Role
   {
      
      public static var list:Dictionary = new Dictionary();
      
      public static var pool:Array = [];
      
      public static const horseEffDic:Dictionary = (function():Dictionary
      {
         var dic:* = new Dictionary();
         dic[24552] = "35337";
         dic[24550] = "35338";
         dic[24551] = "35339";
         dic[24553] = "35340";
         dic[24554] = "35345";
         dic[24555] = "35344";
         dic[24558] = "35346";
         dic[24559] = "35347";
         dic[24560] = "35348";
         dic[24563] = "35362";
         return dic;
      })();
      
      public static const OFFSET_POINTS:Array = [-16,0,16,0,-10,-10,10,10,0,-16,0,16,10,-10,-10,10,16,0,-16,0,10,10,-10,-10,0,16,0,-16,-10,10,10,-10];
      
      private static const vecEff:Vector.<String> = new <String>["35077","35078","35079"];
      
      public static var paoBiaoName:String = "paoBiaoName";
      
      private static const arr:Array = [null,"35080","35081","35082","35098","35099","35100","35103","35104","35105","35198","35199","35200","35201","35202","35203","35124","35127","35130","35133","35136","35139","35125","35128","35131","35134","35137","35140","35126","35129","35132","35135","35138","35141","35250","35249","35251","35248","35252",null,"35126","35129","35132","35135","35138","35141","35126","35129","35132","35135","35138","35141","35126","35129","35132","35135","35138","35141","35126","35129","35132","35135","35138","35141","35126","35129","35132","35135","35138","35141","35126","35129","35132","35135","35138","35141"];
      
      private static const chengHaoDic:Dictionary = (function():Dictionary
      {
         var dic:* = new Dictionary();
         dic[101] = "35267";
         dic[102] = "35265";
         dic[103] = "35266";
         dic[150] = "35279";
         dic[151] = "35293";
         dic[152] = "35292";
         dic[153] = "35291";
         dic[154] = "35294";
         dic[155] = "35301";
         dic[156] = "35302";
         dic[157] = "35303";
         dic[158] = "35313";
         return dic;
      })();
      
      private var _vip:int;
      
      public var captainId:Number = 0;
      
      public var teamPosition:int;
      
      public var partyId:Number = 0;
      
      private var _party:String = "";
      
      private var _lqColor:int = 0;
      
      public var AiDeBaoBao_partner:Number;
      
      public var AiDeBaoBao_buff:Array;
      
      protected var _shenBingLv:int = 0;
      
      public var zoneId:int = -1;
      
      public var campId:String;
      
      private var _act:int;
      
      private var sitEff:Effect;
      
      private var tf:MyTextField;
      
      private var isInit:Boolean = false;
      
      private var _lastCr:int;
      
      private var _flag:int;
      
      public var _horseEffID:String;
      
      private var _qhtzEff:Effect;
      
      private var _qhtz:int;
      
      private var _paoBiao:int;
      
      private var _paoBiaoBM:Bitmap;
      
      private var _mineBM:Bitmap;
      
      private var vecPaoBiaoColor:Vector.<String> = new <String>["白色","绿色","蓝色","紫色"];
      
      private var _buffBM:Bitmap;
      
      private var _crossCampBattleBuff:int;
      
      private var _chengHao:int;
      
      private var _wulinChengHao:String = "";
      
      private var _wulinChengHaoShowIng:String;
      
      private var _value:int;
      
      public var sb:ShenBingUnit;
      
      private var campWarCarEffect:Effect;
      
      private var _invList:Array = [];
      
      protected var _needUpgradeWLCH:Boolean = false;
      
      public function Player()
      {
         super();
         nameBarHeight = 40;
      }
      
      public function init(SID:Number, status:int, Name:String, GlobalX:int, GlobalY:int, Speed:int, Hp:int, Hp_max:int, Mp:int, Mp_max:int, Level:int, Direction:int, Sex:int, Body:int, Hair:int, Weapon:int, Horse:int, Job:int, vip:int, partyId:Number, party:String, _YLDiaLvl:int, _isYearDia:int, _huangZuanLvl:int, _isHuangZuanYear:int, huiYuan:int, huiYuanYear:int, superLan:int, superLanYear:int, xinYueType:int, xinLvl:int, isShow:int, _isSuperHuang:int, wingId:int) : void
      {
         id = SID;
         name = Name;
         global_x = GlobalX;
         global_y = GlobalY;
         type = UnitType.PLAYER;
         speed = Speed;
         hp = Hp;
         hpMax = Hp_max;
         mp = Mp;
         mpMax = Mp_max;
         level = Level;
         sex = Sex;
         job = Job;
         head = "head" + Job + "_" + Sex;
         ylDiaLvl = _YLDiaLvl;
         isYearDia = _isYearDia;
         huangZuanLvl = _huangZuanLvl;
         isHuangZuanYear = _isHuangZuanYear;
         isHuiyuan = huiYuan;
         isHuiyuanYear = huiYuanYear;
         isSuperHuang = _isSuperHuang;
         this.xinYueType = xinYueType;
         this.xinYueLvl = xinLvl;
         this.isShow = isShow;
         super.superLan = superLan;
         super.superLanYear = superLanYear;
         this.vip = vip;
         this.partyId = partyId;
         this.party = party;
         if(Hp > 0)
         {
            this.state = State.LIFE;
         }
         else
         {
            this.state = State.DEAD;
            _action = Action.DEAD;
         }
         setShadow(status,11);
         setBody(status,Body);
         setWeapon(status,Weapon);
         this.setHorse(status,Horse);
         setWing(status,wingId);
         this.way = Direction;
         this.status = status;
      }
      
      override protected function resetModelStatus() : void
      {
         super.resetModelStatus();
         MODEL_STATUS_VALUE[Status.COLLECT] = {};
         MODEL_STATUS_VALUE[Status.SIT] = {};
         MODEL_STATUS_VALUE[Status.FISH] = {};
         MODEL_STATUS_VALUE[Status.KUN_LUN] = {};
         MODEL_STATUS_VALUE[Status.PA_TA] = {};
         MODEL_STATUS_VALUE[Status.WU_LING] = {};
         MODEL_STATUS_VALUE[Status.BANG_PAI] = {};
         MODEL_STATUS_VALUE[Status.BZ_COLLECT] = {};
         MODEL_STATUS_VALUE[Status.WANANSI] = {};
         MODEL_STATUS_VALUE[Status.KEJU] = {};
         MODEL_STATUS_VALUE[Status.QJ] = {};
         MODEL_STATUS_VALUE[Status.GMD] = {};
         MODEL_STATUS_VALUE[Status.AiDeBaoBao] = {};
         MODEL_STATUS_VALUE[Status.AiDeBaoBao_Bao] = {};
         MODEL_STATUS_VALUE[Status.AiDeBaoBao_BeiBao] = {};
         MODEL_STATUS_VALUE[Status.KuaFuPaiDui_HIDE] = {};
         MODEL_STATUS_VALUE[Status.KuaFuPaiDui_18] = {};
         MODEL_STATUS_VALUE[Status.KuaFuPaiDui_19] = {};
         MODEL_STATUS_VALUE[Status.KuaFuPaiDui_20] = {};
         MODEL_STATUS_VALUE[Status.KuaFuPaiDui_21] = {};
         MODEL_STATUS_VALUE[Status.KuaFuPaiDui_22] = {};
         MODEL_STATUS_VALUE[Status.KuaFuPaiDui_23] = {};
         MODEL_STATUS_VALUE[Status.KuaFuPaiDui_24] = {};
         MODEL_STATUS_VALUE[Status.KuaFuPaiDui_25] = {};
         MODEL_STATUS_VALUE[Status.KFPAOBIAO_26] = {};
      }
      
      override public function show() : void
      {
         super.show();
         list[id] = this;
      }
      
      public function set vip(value:int) : void
      {
         this._vip = value;
         nameBar.show();
      }
      
      public function get vip() : int
      {
         return this._vip;
      }
      
      override public function isHidePlayer() : Boolean
      {
         return true;
      }
      
      override public function set way(value:int) : void
      {
         super.way = value;
         this.setLayerSwap();
         this.setHorseHeadVisible();
      }
      
      override public function set action(value:int) : void
      {
         this._act = value;
         super.action = value;
         this.setLayerSwap();
         this.setHorseHeadVisible();
         if(value == Action.SIT)
         {
            nameBar.y = -120;
         }
         else if(hasHorse())
         {
            nameBar.y = -190;
         }
         else
         {
            nameBar.y = -160;
         }
         var chenghaoY:Number = nameBar.y - 13;
         if(this._value >= 7 && this._value <= 9)
         {
            chenghaoY = nameBar.y - 23;
         }
         this.setQhtzEffPy();
      }
      
      override public function set status(value:int) : void
      {
         var partType:int = 0;
         super.status = value;
         if(Boolean(this.sitEff))
         {
            removeEffect(this.sitEff);
            this.sitEff = null;
         }
         this.showQhtz();
         var i:int = 0;
         switch(value)
         {
            case Status.NOMAL:
               if(action == Action.SIT || action == Action.FISH)
               {
                  this.action = Action.STAND;
               }
               break;
            case Status.COLLECT:
               i = 0;
               while(i < MODEL_STATUS_SHOW_PARTS[Status.NOMAL].length)
               {
                  partType = int(MODEL_STATUS_SHOW_PARTS[Status.NOMAL][i]);
                  MODEL_STATUS_VALUE[value][partType] = MODEL_STATUS_VALUE[Status.NOMAL][partType];
                  i++;
               }
               this.action = Action.STAND;
               break;
            case Status.SIT:
               setShadow(status,11);
               this.action = Action.SIT;
               if(Boolean(this.lqColor))
               {
                  this.sitEff = addEffect("3501" + (4 - this.lqColor),true);
               }
               break;
            case Status.FISH:
               setShadow(status,11);
               this.action = Action.FISH;
               if(way >= 1 && way <= 4)
               {
                  this.way = 3;
                  break;
               }
               this.way = 7;
         }
      }
      
      public function addWordsEff(str:String) : void
      {
         if(!this.isInit)
         {
            this.tf = ComponentUtil.getTextField("",this,{
               "x":-40,
               "y":-178
            });
         }
         this.tf.htmlText = str;
         Tween.to(this.tf,1200,{
            "y":[-178,-278],
            "alpha":[1,0]
         },function():void
         {
            isInit = true;
         });
      }
      
      override public function set state(value:int) : void
      {
         super.state = value;
         if(value == State.DEAD)
         {
            if(filters == Util.disabled)
            {
               return;
            }
            filters = Util.disabled;
         }
         else
         {
            if(!filters.length)
            {
               return;
            }
            filters = [];
         }
      }
      
      private function setQhtzEffPy() : void
      {
         if(Boolean(this._qhtzEff))
         {
            if(_action == Action.SIT)
            {
               this._qhtzEff.py = 40;
            }
            else if(hasHorse())
            {
               this._qhtzEff.py = -30;
            }
            else
            {
               this._qhtzEff.py = 0;
            }
         }
      }
      
      override public function setHorse(status:int, value:int) : void
      {
         super.setHorse(status,value);
         this.setQhtzEffPy();
         this._horseEffID = horseEffDic[value];
         this.setQhtzEffPy();
      }
      
      override public function update(now:int) : void
      {
         var indexx:int = 0;
         var xx:int = 0;
         var yy:int = 0;
         if(this._horseEffID != null && action == Action.RUN && now - this._lastCr >= 250 && visible)
         {
            this._flag ^= 1;
            this._lastCr = now;
            indexx = (way << 2) + (this._flag << 1);
            xx = global_x + OFFSET_POINTS[indexx];
            yy = global_y + OFFSET_POINTS[indexx + 1];
            EffectManager.addEffect(this._horseEffID,GameScene.gridLayer,1300,xx,yy,false,MassLoader.LEVEL7);
         }
         super.update(now);
      }
      
      public function set lqColor(value:int) : void
      {
         this._lqColor = value;
      }
      
      public function get lqColor() : int
      {
         return this._lqColor;
      }
      
      public function set qhtz(value:int) : void
      {
         this._qhtz = value;
         this.showQhtz();
      }
      
      private function showQhtz() : void
      {
         if(this._qhtz > 0)
         {
            this.removeQhtzEff();
            if(status != Status.FISH && status != Status.SIT && !(status >= Status.KuaFuPaiDui_HIDE && status <= Status.KuaFuPaiDui_25))
            {
               this._qhtzEff = addEffect(vecEff[this._qhtz - 1],true,0,0,700,-1,null,0);
               this.setQhtzEffPy();
            }
         }
         else
         {
            this.removeQhtzEff();
         }
      }
      
      private function removeQhtzEff() : void
      {
         if(Boolean(this._qhtzEff))
         {
            removeEffect(this._qhtzEff);
            this._qhtzEff = null;
         }
      }
      
      public function set paoBiao(value:int) : void
      {
         this._paoBiao = value;
         if(Boolean(value))
         {
            if(!this._paoBiaoBM)
            {
               this._paoBiaoBM = new Bitmap();
               this._paoBiaoBM.name = paoBiaoName;
               nameBar.addChild(this._paoBiaoBM);
               this._paoBiaoBM.x = -30;
            }
            this._paoBiaoBM.y = -80;
            Utils.getLoadBitmap("resource/image/paobiao/biaoqi0" + this._paoBiao + ".png",this._paoBiaoBM);
         }
         else if(Boolean(this._paoBiaoBM))
         {
            if(nameBar.contains(this._paoBiaoBM))
            {
               nameBar.removeChild(this._paoBiaoBM);
            }
            this._paoBiaoBM = null;
         }
      }
      
      public function set crossClanBattleMine(value:Boolean) : void
      {
         if(value)
         {
            if(!this._mineBM)
            {
               this._mineBM = new Bitmap();
               nameBar.addChild(this._mineBM);
               this._mineBM.x = -30;
            }
            this._mineBM.y = -80;
            Utils.getLoadBitmap("resource/image/kuafubangzhan/mine.png",this._mineBM);
         }
         else if(Boolean(this._mineBM))
         {
            if(nameBar.contains(this._mineBM))
            {
               nameBar.removeChild(this._mineBM);
            }
            this._mineBM = null;
         }
      }
      
      public function set crossCampBattleBuff(value:int) : void
      {
         this._crossCampBattleBuff = value;
         if(Boolean(value))
         {
            if(!this._buffBM)
            {
               this._buffBM = new Bitmap();
               nameBar.addChild(this._buffBM);
               this._buffBM.x = -50;
            }
            this._buffBM.y = -101;
            Utils.getLoadBitmap("resource/image/crossCampBattle/" + value + ".png",this._buffBM);
         }
         else if(Boolean(this._buffBM))
         {
            if(nameBar.contains(this._buffBM))
            {
               nameBar.removeChild(this._buffBM);
            }
            this._buffBM = null;
         }
      }
      
      public function get crossCampBattleBuff() : int
      {
         return this._crossCampBattleBuff;
      }
      
      public function get paoBiao() : int
      {
         return this._paoBiao;
      }
      
      public function set chengHao(value:int) : void
      {
         this._chengHao = value;
         nameBar.show();
      }
      
      public function set wulinChengHao(value:String) : void
      {
         if(value == this._wulinChengHaoShowIng)
         {
            return;
         }
         this._wulinChengHao = value;
         this.invalidateChengHao();
         this.paoBiao = this._paoBiao;
         this.action = this._act;
      }
      
      public function setChengHaoEffect(e:Event) : void
      {
         var effID:String = null;
         nameBar.groupClear();
         if(SceneConfig.getSceneType() != SceneConfig.COMMON && SceneConfig.getSceneType() != SceneConfig.HUANGBANG)
         {
            this._wulinChengHaoShowIng = null;
            return;
         }
         if(this._paoBiao > 0)
         {
            this._wulinChengHaoShowIng = null;
            return;
         }
         var t:Array = Util.splicObj(this._wulinChengHao,"_") as Array;
         var i:int = 0;
         while(i < t.length)
         {
            if(t[i] != "0")
            {
               if(Boolean(chengHaoDic[t[i]]))
               {
                  effID = chengHaoDic[t[i]];
               }
               else
               {
                  effID = arr[int(t[i])];
               }
               nameBar.addChengHaoEff(effID);
            }
            i += 1;
         }
         nameBar.groupAlign();
         this._needUpgradeWLCH = false;
      }
      
      public function get chengHao() : int
      {
         return this._chengHao;
      }
      
      public function set party(value:String) : void
      {
         this._party = value;
         nameBar.show();
      }
      
      public function get party() : String
      {
         return this._party;
      }
      
      public function set shenBingLv(v:int) : void
      {
         this._shenBingLv = v;
         if(v == 0)
         {
            if(Boolean(this.sb))
            {
               this.sb.dispose();
            }
            return;
         }
         if(!this.sb || !this.sb.shenBingOwner)
         {
            this.sb = GameUnitManager.getUnit(UnitType.SHEN_BING) as ShenBingUnit;
            if(Boolean(this.sb))
            {
               GameUnitManager.addUnit(this.sb);
            }
         }
         if(Boolean(this.sb))
         {
            this.sb.initSb(v,this);
         }
      }
      
      public function get shenBingLv() : int
      {
         return this._shenBingLv;
      }
      
      private function setLayerSwap() : void
      {
         var isWeaponDown:int = 0;
         var wingLayer:int = 0;
         var data:Array = Data_lib.avater[Enum_job.getBaseJob(job) + "" + sex];
         if(Boolean(data))
         {
            isWeaponDown = int(data[action * 5 + (way < 5 ? way : 8 - way)]);
            parts.changePart(isWeaponDown);
         }
         var wingLayerData:Array = Data_lib.wingLayer[Enum_job.getBaseJob(job) + "" + sex];
         if(Boolean(wingLayerData))
         {
            if(hasHorse())
            {
               wingLayer = int(wingLayerData[action * 5 + 10 + (way < 5 ? way : 8 - way)]);
            }
            else
            {
               wingLayer = int(wingLayerData[action * 5 + (way < 5 ? way : 8 - way)]);
            }
            parts.changeWingLayer(wingLayer);
         }
      }
      
      private function setHorseHeadVisible() : void
      {
         if(way == 4 && hasHorse())
         {
            if(action == Action.RUN || action == Action.STAND && GameUnitManager.showHorseHead(action,MODEL_STATUS_VALUE[status][Parts.HORSE]))
            {
               if(parts.getPart(Parts.HORSEHEAD).visible == false)
               {
                  parts.getPart(Parts.HORSEHEAD).visible = true;
               }
            }
         }
         else if(parts.getPart(Parts.HORSEHEAD).visible == true)
         {
            parts.getPart(Parts.HORSEHEAD).visible = false;
         }
      }
      
      override public function interaction(mode:int = 0) : void
      {
         if(isInBattle == true && SceneConfig.getSceneType() != SceneConfig.COMMON)
         {
            UIManager.centerBroadcast.addMsg(LangConfig.getWord("10542",1));
            return;
         }
         if(SceneConfig.getSceneType() == SceneConfig.BZ_BATTLE)
         {
            if(this.party != GameUnitManager.hero.party)
            {
               BangBattleCGMessage.CG_QUEST_BANG_BATTLE(UnitType.PLAYER,id,0);
            }
         }
         if(SceneConfig.getSceneType() == SceneConfig.KFBZ_BATTLE)
         {
            if(this.party != GameUnitManager.hero.party)
            {
               CrossClanBattleCGMessage.CG_CLICK_PLAYER(id);
            }
         }
         if(SceneConfig.getSceneType() == SceneConfig.CROSS_CAMP_BATTLE)
         {
            if(Model_CrossCampBattle.ownCampId != this.campId)
            {
               if(Utils.dist(this.global_x,this.global_y,Model_CrossCampBattle.enemyPoint.x,Model_CrossCampBattle.enemyPoint.y) < Model_CrossCampBattle.enemyR * Model_CrossCampBattle.enemyR)
               {
                  UIManager.centerBroadcast.addMsg("不能攻击安全区里的玩家",1);
               }
               else
               {
                  CrossCampBattleCGMessage.CG_CAMP_ATTACK_PLAYER(id,Enum_CrossCampBattle.PK_PLAYER,this.zoneId);
               }
            }
         }
         if(GameUnitManager.hero.status == Status.WU_LING)
         {
            WulinPartyCGMessage.CG_BATTLE_WULIN(UnitType.PLAYER,id,0);
         }
         if(GameUnitManager.hero.status == Status.KUN_LUN)
         {
            BattleCGMessage.CG_BATTLE(id,UnitType.PLAYER,0);
         }
         if(Boolean(this._paoBiao))
         {
            PaoBiaoCGMessage.CG_JIE_BIAO_BEFORE(this);
         }
         GameUnitManager.hero.lockTarget = null;
      }
      
      public function addCampWarCarEff() : void
      {
         if(!this.campWarCarEffect)
         {
            this.campWarCarEffect = addEffect("35314",true,10,-216,300);
         }
      }
      
      public function removeCampWarCarEffect() : void
      {
         if(Boolean(this.campWarCarEffect) && contains(this.campWarCarEffect))
         {
            removeEffect(this.campWarCarEffect);
            this.campWarCarEffect = null;
         }
      }
      
      override public function get check() : Boolean
      {
         if(Boolean(parts.getPart(Parts.BODY).bitmapData))
         {
            return Utils.checkAlpha(parts.getPart(Parts.BODY));
         }
         return false;
      }
      
      override public function mouseOver() : void
      {
         super.mouseOver();
         var st:int = SceneConfig.getSceneType();
         if(st == SceneConfig.KUNLUN || st == SceneConfig.WULIN)
         {
            CursorManager.show(Enum_CursorType.MONSTER);
            return;
         }
         if(st == SceneConfig.BZ_BATTLE || st == SceneConfig.KFBZ_BATTLE)
         {
            if(GameUnitManager.hero.partyId != this.partyId)
            {
               CursorManager.show(Enum_CursorType.MONSTER);
               return;
            }
         }
         if(st == SceneConfig.CROSS_CAMP_BATTLE)
         {
            if(Model_CrossCampBattle.ownCampId != this.campId)
            {
               CursorManager.show(Enum_CursorType.MONSTER);
               return;
            }
         }
         if(Boolean(this._paoBiao))
         {
            CursorManager.show(Enum_CursorType.MONSTER);
         }
      }
      
      override public function mouseOut() : void
      {
         super.mouseOut();
         var st:int = SceneConfig.getSceneType();
         if(st == SceneConfig.KUNLUN || st == SceneConfig.BZ_BATTLE || st == SceneConfig.KFBZ_BATTLE || st == SceneConfig.CROSS_CAMP_BATTLE || st == SceneConfig.WULIN || Boolean(this._paoBiao))
         {
            CursorManager.hide();
         }
      }
      
      override public function dispose() : void
      {
         nameBar.groupClear();
         this._wulinChengHao = "";
         this._wulinChengHaoShowIng = null;
         this._shenBingLv = 0;
         if(Boolean(this.sb))
         {
            this.sb.dispose();
            this.sb = null;
         }
         removeEventListener(Event.ENTER_FRAME,this._render);
         this._needUpgradeWLCH = false;
         if(Boolean(this.tf))
         {
            this.tf = null;
         }
         this.qhtz = 0;
         this.paoBiao = 0;
         this.crossClanBattleMine = false;
         this.crossCampBattleBuff = 0;
         super.dispose();
         UIManager.smallMap.delPoint(id);
         delete list[id];
         filters = [];
         if(Boolean(this.sitEff))
         {
            this.sitEff = null;
         }
         this.lqColor = 0;
         pool.push(this);
         this.status = Status.NOMAL;
         this.action = Action.STAND;
         visible = true;
      }
      
      public function invalidateChengHao() : void
      {
         this._needUpgradeWLCH = true;
         addEventListener(Event.ENTER_FRAME,this._render);
      }
      
      protected function _render(e:Event) : void
      {
         removeEventListener(Event.ENTER_FRAME,this._render);
         if(this._needUpgradeWLCH)
         {
            this.setChengHaoEffect(e);
         }
      }
   }
}

