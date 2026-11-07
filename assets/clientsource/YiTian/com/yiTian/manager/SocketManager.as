package com.yiTian.manager
{
   import com.debug.LocalServer;
   import com.yiTian.Global;
   import com.yiTian.net.message.cg.LoginCGMessage;
   import com.yiTian.net.message.gc.ActionsGCMessage;
   import com.yiTian.net.message.gc.ActivityGCMessage;
   import com.yiTian.net.message.gc.AiDeBaoBaoGCMessage;
   import com.yiTian.net.message.gc.AwardOnLineGCMessage;
   import com.yiTian.net.message.gc.BabyGCMessage;
   import com.yiTian.net.message.gc.BabyGiftGCMessage;
   import com.yiTian.net.message.gc.BagGCMessage;
   import com.yiTian.net.message.gc.BangBattleGCMessage;
   import com.yiTian.net.message.gc.BangGCMessage;
   import com.yiTian.net.message.gc.BattleGCMessage;
   import com.yiTian.net.message.gc.BianXingGaiMingGCMessage;
   import com.yiTian.net.message.gc.BlueDiamondFuLiGCMessage;
   import com.yiTian.net.message.gc.BlueDiamondNDGCMessage;
   import com.yiTian.net.message.gc.BoatGCMessage;
   import com.yiTian.net.message.gc.BqzyGCMessage;
   import com.yiTian.net.message.gc.BroadCastGCMessage;
   import com.yiTian.net.message.gc.BufferGCMessage;
   import com.yiTian.net.message.gc.CaiDengMiGCMessage;
   import com.yiTian.net.message.gc.CangGaoGCMessage;
   import com.yiTian.net.message.gc.CardGCMessage;
   import com.yiTian.net.message.gc.CastGCMessage;
   import com.yiTian.net.message.gc.ChargeGuideGCMessage;
   import com.yiTian.net.message.gc.ChatGCMessage;
   import com.yiTian.net.message.gc.CheckGCMessage;
   import com.yiTian.net.message.gc.ChongChuJinagHuGCMessage;
   import com.yiTian.net.message.gc.ChongZhiPaiHangGCMessage;
   import com.yiTian.net.message.gc.ChristmasGCMessage;
   import com.yiTian.net.message.gc.ChristmasWishGCMessage;
   import com.yiTian.net.message.gc.ChunJieNianGaoGCMessage;
   import com.yiTian.net.message.gc.ChunJieQianDaoGCMessage;
   import com.yiTian.net.message.gc.CrossCampBattleGCMessage;
   import com.yiTian.net.message.gc.CrossClanBattleGCMessage;
   import com.yiTian.net.message.gc.CrossDartGCMessage;
   import com.yiTian.net.message.gc.DAUGCMessage;
   import com.yiTian.net.message.gc.DaTingHuiGuiGCMessage;
   import com.yiTian.net.message.gc.DailyActGCMessage;
   import com.yiTian.net.message.gc.DailyBtnGCMessage;
   import com.yiTian.net.message.gc.DepotGCMessage;
   import com.yiTian.net.message.gc.FangChenMiGCMessage;
   import com.yiTian.net.message.gc.FangXinHuiJiaGCMessage;
   import com.yiTian.net.message.gc.FarmGCMessage;
   import com.yiTian.net.message.gc.FeiXingQiGCMessage;
   import com.yiTian.net.message.gc.FireworkGCMessage;
   import com.yiTian.net.message.gc.FishingGCMessage;
   import com.yiTian.net.message.gc.FriendGCMessage;
   import com.yiTian.net.message.gc.FruitShopGCMessage;
   import com.yiTian.net.message.gc.FundGCMessage;
   import com.yiTian.net.message.gc.GengXinGCMessage;
   import com.yiTian.net.message.gc.GoldCJGCMessage;
   import com.yiTian.net.message.gc.GongCeGCMessage;
   import com.yiTian.net.message.gc.GongCeJiShiGCMessage;
   import com.yiTian.net.message.gc.GuaJiGCMessage;
   import com.yiTian.net.message.gc.GuangMingDingGCMessage;
   import com.yiTian.net.message.gc.GuideGCMessage;
   import com.yiTian.net.message.gc.HZXianGouGCMessage;
   import com.yiTian.net.message.gc.HapStoneGCMessage;
   import com.yiTian.net.message.gc.HeFuHuoDongGCMessage;
   import com.yiTian.net.message.gc.HorseGCMessage;
   import com.yiTian.net.message.gc.HuaShanGCMessage;
   import com.yiTian.net.message.gc.HuangZuanCWGCMessage;
   import com.yiTian.net.message.gc.HuangbangGCMessage;
   import com.yiTian.net.message.gc.HuangzhuanZPGCMessage;
   import com.yiTian.net.message.gc.HumanGCMessage;
   import com.yiTian.net.message.gc.InviteFriendNewGCMessage;
   import com.yiTian.net.message.gc.JiaNianHuaGCMessage;
   import com.yiTian.net.message.gc.JianghulixianGCMessage;
   import com.yiTian.net.message.gc.JiaoYiGCMessage;
   import com.yiTian.net.message.gc.JinDanGCMessage;
   import com.yiTian.net.message.gc.JingJiChangGCMessage;
   import com.yiTian.net.message.gc.JvHuaSuanGCMessage;
   import com.yiTian.net.message.gc.KLMountianGCMessage;
   import com.yiTian.net.message.gc.KaiFuDiscountGCMessage;
   import com.yiTian.net.message.gc.KejuGCMessage;
   import com.yiTian.net.message.gc.KongJianGCMessage;
   import com.yiTian.net.message.gc.KuPaoGCMessage;
   import com.yiTian.net.message.gc.KuaFuJingJiChangGCMessage;
   import com.yiTian.net.message.gc.KuaFuPaiDuiGCMessage;
   import com.yiTian.net.message.gc.LFlowerGCMessage;
   import com.yiTian.net.message.gc.LayInPillGcMessage;
   import com.yiTian.net.message.gc.LeiJiChongZhiGCMessage;
   import com.yiTian.net.message.gc.LetterGCMessage;
   import com.yiTian.net.message.gc.LingQiWuHunGCMessage;
   import com.yiTian.net.message.gc.Little_system_GCMessage;
   import com.yiTian.net.message.gc.LiuShiBackGCMessage;
   import com.yiTian.net.message.gc.LiuShiWanJiaZhaoHuiGCMessage;
   import com.yiTian.net.message.gc.LoginGCMessage;
   import com.yiTian.net.message.gc.MarriageGCMessage;
   import com.yiTian.net.message.gc.MartGCMessage;
   import com.yiTian.net.message.gc.MasterSkillGCMessage;
   import com.yiTian.net.message.gc.MeiRiXianGouGCMessage;
   import com.yiTian.net.message.gc.MidAutumnGCMessage;
   import com.yiTian.net.message.gc.MoneyTreeGCMessage;
   import com.yiTian.net.message.gc.NationalTreasureGCMessage;
   import com.yiTian.net.message.gc.NewPlayerLimitGCMessage;
   import com.yiTian.net.message.gc.NewRechargeFeedbackGCMessage;
   import com.yiTian.net.message.gc.NewYearGCMessage;
   import com.yiTian.net.message.gc.OlympicGCMessage;
   import com.yiTian.net.message.gc.OnLineAwardGCMessage;
   import com.yiTian.net.message.gc.PaiHangGCMessage;
   import com.yiTian.net.message.gc.PaoBiaoGCMessage;
   import com.yiTian.net.message.gc.PataGCMessage;
   import com.yiTian.net.message.gc.PetGCMessage;
   import com.yiTian.net.message.gc.QQClockGCMessage;
   import com.yiTian.net.message.gc.QTSignGCMessage;
   import com.yiTian.net.message.gc.QiJuGCMessage;
   import com.yiTian.net.message.gc.QifuGCMessage;
   import com.yiTian.net.message.gc.QingmingGCMessage;
   import com.yiTian.net.message.gc.QplusShareGCMessage;
   import com.yiTian.net.message.gc.QqHallNationalDayGCMessage;
   import com.yiTian.net.message.gc.QuestGCMessage;
   import com.yiTian.net.message.gc.RechargeFeedbackGCMessage;
   import com.yiTian.net.message.gc.RetrieExpGCMessage;
   import com.yiTian.net.message.gc.RoleGCMessage;
   import com.yiTian.net.message.gc.SMSGCMessage;
   import com.yiTian.net.message.gc.SaoDangGCMessage;
   import com.yiTian.net.message.gc.SceneGCMessage;
   import com.yiTian.net.message.gc.ShenBingGCMessage;
   import com.yiTian.net.message.gc.ShengDanGCMessage;
   import com.yiTian.net.message.gc.ShenshouGCMessage;
   import com.yiTian.net.message.gc.ShiZhuangSuiPianGCMessage;
   import com.yiTian.net.message.gc.ShouChongGCMessage;
   import com.yiTian.net.message.gc.ShouChongTiaoZhengGCMessage;
   import com.yiTian.net.message.gc.ShouchangGCMessage;
   import com.yiTian.net.message.gc.SignGCMessage;
   import com.yiTian.net.message.gc.SkillGCMessage;
   import com.yiTian.net.message.gc.SpecialDillGCMessage;
   import com.yiTian.net.message.gc.StoreGCMessage;
   import com.yiTian.net.message.gc.TeamGCMessage;
   import com.yiTian.net.message.gc.TiLiGCMessage;
   import com.yiTian.net.message.gc.TianMingGCMessage;
   import com.yiTian.net.message.gc.TianTiGCMessage;
   import com.yiTian.net.message.gc.TianmingJJGCMessage;
   import com.yiTian.net.message.gc.TouZiJiJinGCMessage;
   import com.yiTian.net.message.gc.TreasureChestGCMssage;
   import com.yiTian.net.message.gc.TreasureGCMessage;
   import com.yiTian.net.message.gc.TreeDownCLGCMessage;
   import com.yiTian.net.message.gc.TuanGouGCMessage;
   import com.yiTian.net.message.gc.VIPGCMessage;
   import com.yiTian.net.message.gc.VipBGiftGCMessage;
   import com.yiTian.net.message.gc.WanAnSiGCMessage;
   import com.yiTian.net.message.gc.WanJiaZhaoHuiGCMessage;
   import com.yiTian.net.message.gc.WeiLieGCMessage;
   import com.yiTian.net.message.gc.WingGCMessage;
   import com.yiTian.net.message.gc.WorldBossGCMessage;
   import com.yiTian.net.message.gc.WorldLevGCMessage;
   import com.yiTian.net.message.gc.WuLinDuoBaoGCMessage;
   import com.yiTian.net.message.gc.WuYiGCMessage;
   import com.yiTian.net.message.gc.WulinPartyGCMessage;
   import com.yiTian.net.message.gc.WulinmixinGCMessage;
   import com.yiTian.net.message.gc.WuxingGCMessage;
   import com.yiTian.net.message.gc.XianGouGCMessage;
   import com.yiTian.net.message.gc.XiaoFeiPaiHangGCMessage;
   import com.yiTian.net.message.gc.XiaoFeiTuanGouGCMessage;
   import com.yiTian.net.message.gc.XiaoZhaoGCMessage;
   import com.yiTian.net.message.gc.XuYuanShuGCMessage;
   import com.yiTian.net.message.gc.XunZhangGCMessage;
   import com.yiTian.net.message.gc.XxlGCMessage;
   import com.yiTian.net.message.gc.YelloDiaGCMessage;
   import com.yiTian.net.message.gc.YellowDiamondNDGCMessage;
   import com.yiTian.net.message.gc.ZaHuoDianGCMessage;
   import com.yiTian.net.message.gc.ZaiZhanJiangHuGCMessage;
   import com.yiTian.net.message.gc.ZhaoCaiMaoGCMessage;
   import com.yiTian.net.message.gc.ZhuTiZhouGCMessage;
   import com.yiTian.net.message.gc.ZhuanZhiGCMessage;
   import com.yiTian.scene.GameScene;
   import com.yiTian.utils.Utils;
   import com.yiTian.view.modules.KFHomeland.HomeLandGCMessage;
   import com.yiTian.view.modules.QShow.QShowSkinGCMessage;
   import com.yiTian.view.modules.crossClanBattle.CrossClanBattleSocket;
   import com.yiTian.view.modules.loading.View_loading;
   import com.yiTian.view.modules.tip.tips.OffLineTip;
   import flash.events.Event;
   import flash.events.IOErrorEvent;
   import flash.events.ProgressEvent;
   import flash.events.SecurityErrorEvent;
   import flash.net.Socket;
   import flash.net.URLRequest;
   import flash.net.navigateToURL;
   import flash.utils.ByteArray;
   import flash.utils.getTimer;
   
   public class SocketManager
   {
      
      public static var tempSocket:Socket;
      
      public static var tempSend:Function;
      
      public static var socket:Socket;
      
      private static var connectHandler:Function;
      
      private static var _localMode:Boolean;
      
      public static var index:Array;
      
      private static var _lastRandValue:int;
      
      private static var recvCache:ByteArray = new ByteArray();
      
      private static var recvArray:ByteArray = new ByteArray();
      
      private static var data:ByteArray = new ByteArray();
      
      public static var send:Function = sendServer;
      
      public static var receive:Function = connectStateHandler;
      
      public function SocketManager()
      {
         super();
      }
      
      public static function init() : void
      {
         socket = new Socket();
         socket.addEventListener(Event.CONNECT,connectStateHandler);
         socket.addEventListener(Event.CLOSE,connectStateHandler);
         socket.addEventListener(IOErrorEvent.IO_ERROR,errorHandler);
         socket.addEventListener(ProgressEvent.SOCKET_DATA,socketDataHandler);
         socket.addEventListener(SecurityErrorEvent.SECURITY_ERROR,securityErrorHandler);
         connectHandler = loginLoginServer;
         registerMessage();
      }
      
      public static function registerMessage() : void
      {
         new LoginGCMessage(index);
         new SceneGCMessage(index);
         new HumanGCMessage(index);
         new BagGCMessage(index);
         new DepotGCMessage(index);
         new CastGCMessage(index);
         new Little_system_GCMessage(index);
         new RoleGCMessage(index);
         new SkillGCMessage(index);
         new BattleGCMessage(index);
         new ChatGCMessage(index);
         new TeamGCMessage(index);
         new ZaHuoDianGCMessage(index);
         new JiaoYiGCMessage(index);
         new MartGCMessage(index);
         new LetterGCMessage(index);
         new StoreGCMessage(index);
         new JingJiChangGCMessage(index);
         new FangChenMiGCMessage(index);
         new FriendGCMessage(index);
         new StoreGCMessage(index);
         new PataGCMessage(index);
         new AwardOnLineGCMessage(index);
         new QuestGCMessage(index);
         new GuaJiGCMessage(index);
         new PetGCMessage(index);
         new VIPGCMessage(index);
         new FishingGCMessage(index);
         new BangGCMessage(index);
         new KLMountianGCMessage(index);
         new PaiHangGCMessage(index);
         new BufferGCMessage(index);
         new DailyActGCMessage(index);
         new SMSGCMessage(index);
         new RetrieExpGCMessage(index);
         new BroadCastGCMessage(index);
         new GuideGCMessage(index);
         new WuLinDuoBaoGCMessage(index);
         new LingQiWuHunGCMessage(index);
         new BangBattleGCMessage(index);
         new WulinPartyGCMessage(index);
         new YelloDiaGCMessage(index);
         new TianTiGCMessage(index);
         new ShouChongGCMessage(index);
         new TiLiGCMessage(index);
         new SaoDangGCMessage(index);
         new FeiXingQiGCMessage(index);
         new PaoBiaoGCMessage(index);
         new WanAnSiGCMessage(index);
         new OlympicGCMessage(index);
         new MarriageGCMessage(index);
         new ChargeGuideGCMessage(index);
         new TuanGouGCMessage(index);
         new KejuGCMessage(index);
         new WorldLevGCMessage(index);
         new BianXingGaiMingGCMessage(index);
         new TuanGouGCMessage(index);
         new YellowDiamondNDGCMessage(index);
         new BlueDiamondNDGCMessage(index);
         new QqHallNationalDayGCMessage(index);
         new TreasureGCMessage(index);
         new MidAutumnGCMessage(index);
         new HuaShanGCMessage(index);
         new ShenshouGCMessage(index);
         new CheckGCMessage(index);
         new TianMingGCMessage(index);
         new TreasureChestGCMssage(index);
         new FarmGCMessage(index);
         new QplusShareGCMessage(index);
         new LayInPillGcMessage(index);
         new KongJianGCMessage(index);
         new QiJuGCMessage(index);
         new ShengDanGCMessage(index);
         new JinDanGCMessage(index);
         new ChristmasGCMessage(index);
         new ChristmasWishGCMessage(index);
         new KuaFuJingJiChangGCMessage(index);
         new ZhuanZhiGCMessage(index);
         new RechargeFeedbackGCMessage(index);
         new CangGaoGCMessage(index);
         new NewYearGCMessage(index);
         new ActionsGCMessage(index);
         new FundGCMessage(index);
         new HorseGCMessage(index);
         new OnLineAwardGCMessage(index);
         new WuxingGCMessage(index);
         new QifuGCMessage(index);
         new WulinmixinGCMessage(index);
         new GengXinGCMessage(index);
         new JianghulixianGCMessage(index);
         new QQClockGCMessage(index);
         new ShouchangGCMessage(index);
         new XianGouGCMessage(index);
         new NewRechargeFeedbackGCMessage(index);
         new XunZhangGCMessage(index);
         new QingmingGCMessage(index);
         new NationalTreasureGCMessage(index);
         new GongCeGCMessage(index);
         new ChongChuJinagHuGCMessage(index);
         new DailyBtnGCMessage(index);
         new ChongZhiPaiHangGCMessage(index);
         new WuYiGCMessage(index);
         new GuangMingDingGCMessage(index);
         new ShiZhuangSuiPianGCMessage(index);
         new CrossClanBattleGCMessage(index);
         new HeFuHuoDongGCMessage(index);
         new XiaoFeiPaiHangGCMessage(index);
         new WorldBossGCMessage(index);
         new SignGCMessage(index);
         new InviteFriendNewGCMessage(index);
         new AiDeBaoBaoGCMessage(index);
         new DAUGCMessage(index);
         new DaTingHuiGuiGCMessage(index);
         new TreeDownCLGCMessage(index);
         new FruitShopGCMessage(index);
         new GoldCJGCMessage(index);
         new HuangbangGCMessage(index);
         new ShenBingGCMessage(index);
         new LiuShiBackGCMessage(index);
         new LiuShiWanJiaZhaoHuiGCMessage(index);
         new KuaFuPaiDuiGCMessage(index);
         new SpecialDillGCMessage(index);
         new QShowSkinGCMessage(index);
         new HomeLandGCMessage(index);
         new WingGCMessage(index);
         new VipBGiftGCMessage(index);
         new ActivityGCMessage(index);
         new CrossCampBattleGCMessage(index);
         new XxlGCMessage(index);
         new ZaiZhanJiangHuGCMessage(index);
         new BabyGCMessage(index);
         new HapStoneGCMessage(index);
         new HZXianGouGCMessage(index);
         new ShouChongTiaoZhengGCMessage(index);
         new LeiJiChongZhiGCMessage(index);
         new TianmingJJGCMessage(index);
         new MasterSkillGCMessage(index);
         new ChunJieQianDaoGCMessage(index);
         new FangXinHuiJiaGCMessage(index);
         new ZhuTiZhouGCMessage(index);
         new BqzyGCMessage(index);
         new XiaoZhaoGCMessage(index);
         new ChunJieNianGaoGCMessage(index);
         new FireworkGCMessage(index);
         new ZhaoCaiMaoGCMessage(index);
         new LFlowerGCMessage(index);
         new CaiDengMiGCMessage(index);
         new HuangzhuanZPGCMessage(index);
         new MoneyTreeGCMessage(index);
         new TouZiJiJinGCMessage(index);
         new JiaNianHuaGCMessage(index);
         new KaiFuDiscountGCMessage(index);
         new MeiRiXianGouGCMessage(index);
         new XuYuanShuGCMessage(index);
         new JvHuaSuanGCMessage(index);
         new NewPlayerLimitGCMessage(index);
         new QTSignGCMessage(index);
         new BlueDiamondFuLiGCMessage(index);
         new HuangZuanCWGCMessage(index);
         new CrossDartGCMessage(index);
         new CardGCMessage(index);
         new BoatGCMessage(index);
         new GongCeJiShiGCMessage(index);
         new WanJiaZhaoHuiGCMessage(index);
         new KuPaoGCMessage(index);
         new WeiLieGCMessage(index);
         new BabyGiftGCMessage(index);
         new XiaoFeiTuanGouGCMessage(index);
      }
      
      public static function connect(host:String, port:int, isClose:Boolean = true) : void
      {
         var data:Date = null;
         View_loading.instance.begin();
         GameScene.instance.preFrameTime = getTimer();
         Utils.print("开始连接");
         if(!socket)
         {
            init();
         }
         if(_localMode)
         {
            connectHandler();
         }
         else
         {
            if(socket.connected && isClose)
            {
               socket.close();
            }
            else
            {
               connectHandler = loginLoginServer;
            }
            socket.connect(host,port);
            data = new Date();
            if(Global.lastTime == 0)
            {
               Global.lastTime = data.time;
            }
            Global.loginTime += "connect:" + (data.time - Global.lastTime) + "|";
            Global.lastTime = data.time;
         }
      }
      
      public static function setChangeSocketFun(value:Boolean) : void
      {
         if(value == true)
         {
            if(Boolean(socket) && socket.hasEventListener(ProgressEvent.SOCKET_DATA))
            {
               socket.removeEventListener(ProgressEvent.SOCKET_DATA,receive);
            }
            tempSocket = socket;
            socket = CrossClanBattleSocket.socket;
         }
         else if(Boolean(tempSocket))
         {
            socket = tempSocket;
            if(!socket.hasEventListener(ProgressEvent.SOCKET_DATA))
            {
               socket.addEventListener(ProgressEvent.SOCKET_DATA,receive);
            }
         }
      }
      
      public static function setKuafuSocketFun(value:Boolean) : void
      {
         if(value == true)
         {
            tempSend = send;
            send = sendServer;
         }
         else if(tempSend != null)
         {
            send = tempSend;
         }
      }
      
      public static function set localMode(value:Boolean) : void
      {
         if(value)
         {
            send = sendLocal;
         }
         else
         {
            send = sendServer;
         }
         _localMode = value;
      }
      
      public static function get localMode() : Boolean
      {
         return _localMode;
      }
      
      private static function sendLocal(cmd:int, body:ByteArray) : void
      {
         body.position = 0;
         LocalServer.doMessage(cmd,body);
      }
      
      private static function getRamdon() : int
      {
         _lastRandValue += 1;
         if(_lastRandValue > 127)
         {
            _lastRandValue = 0;
         }
         return _lastRandValue;
      }
      
      private static function sendServer(cmd:int, body:ByteArray) : void
      {
         var answer:int = 0;
         var random:int = 0;
         var rel:int = 0;
         var i:int = 0;
         var answer2:int = 0;
         var cmdAndKey:int = 0;
         var moveKey:int = 0;
         var moveAbs:int = 0;
         var relIt:int = 0;
         var randomItem:int = 0;
         var last:int = 0;
         var cmdIt:int = 0;
         var keyIt:int = 0;
         var ranIt:int = 0;
         var cmdkeyIt:int = 0;
         if(socket.connected)
         {
            socket.writeInt(body.length + 12);
            random = getRamdon();
            rel = (cmd << 5) + Global.key;
            i = 0;
            while(i < 8)
            {
               relIt = rel >> 3 * i & 7;
               randomItem = random >> i & 1;
               last = (randomItem << 3) + relIt << 4 * i;
               answer += last;
               i++;
            }
            i = 0;
            while(i < 5)
            {
               cmdIt = cmd >> 3 * i & 7;
               keyIt = Global.key >> i & 1;
               ranIt = random >> i & 1;
               if(Boolean(ranIt))
               {
                  cmdkeyIt = (keyIt << 3) + cmdIt << 4 * i;
               }
               else
               {
                  cmdkeyIt = (cmdIt << 1) + keyIt << 4 * i;
               }
               cmdAndKey += cmdkeyIt;
               i++;
            }
            cmdAndKey += cmd >> 15 << 20;
            moveKey = random >> 5;
            moveAbs = 32 - moveKey;
            answer2 = (cmdAndKey << moveKey) + (random << moveAbs >> moveAbs) + (random >> moveKey << 24 + moveKey);
            socket.writeInt(answer2);
            socket.writeInt(answer);
            if(cmd != 5027 && cmd != 5008)
            {
               Utils.print("sendServer",cmd);
            }
            socket.writeBytes(body);
            socket.flush();
         }
      }
      
      private static function loginLoginServer() : void
      {
         var data:Date = null;
         var time:int = 0;
         var key:String = null;
         connectHandler = loginGameServer;
         if(!localMode)
         {
            socket.writeMultiByte("GET / HTTP/1.1\r\nHost: " + Global.config.ip + ":" + Global.config.port + "\r\n\r\n","GBK");
            socket.flush();
         }
         if(Global.config.key == null)
         {
            data = new Date();
            time = data.time / 1000;
            key = Global.account + time.toString() + Global.config.fcm.toString() + "bx32017616e8396cbfae965ba2162f32";
            LoginCGMessage.CG_ASK_LOGIN(Global.account,Global.fcm,Global.openkey,Global.invkey,Global.itime,Global.iopenid,Global.zoneid,Global._pf,Global.fpkey,Global.user_source,Global.contract_id,Global.app_custom,Global.fd,Global.via,Global.seqid,Global.adtag);
         }
         else
         {
            LoginCGMessage.CG_ASK_LOGIN(Global.account,Global.fcm,Global.openkey,Global.invkey,Global.itime,Global.iopenid,Global.zoneid,Global._pf,Global.fpkey,Global.user_source,Global.contract_id,Global.app_custom,Global.fd,Global.via,Global.seqid,Global.adtag);
         }
      }
      
      private static function loginGameServer() : void
      {
      }
      
      public static function connectStateHandler(e:Event) : void
      {
         if(e.type == Event.CONNECT)
         {
            View_loading.instance.end();
            Utils.print("连接成功");
            connectHandler();
         }
         else if(e.type == Event.CLOSE)
         {
            connectHandler = loginLoginServer;
            socket.close();
            OffLineTip.getInstance().show();
         }
      }
      
      public static function socketDataHandler(e:ProgressEvent) : void
      {
         recvCache.length = 0;
         socket.readBytes(recvCache);
         recvCache.position = 0;
         if(recvArray.position == 0)
         {
            doMessage(recvCache);
            if(recvCache.bytesAvailable > 0)
            {
               recvArray.length = 0;
               recvArray.writeBytes(recvCache,recvCache.position,recvCache.bytesAvailable);
            }
         }
         else
         {
            recvCache.readBytes(recvArray,recvArray.length,recvCache.length);
            recvArray.position = 0;
            doMessage(recvArray);
            if(recvArray.bytesAvailable > 0)
            {
               data.length = 0;
               data.writeBytes(recvArray,recvArray.position,recvArray.bytesAvailable);
               recvArray.length = 0;
               recvArray.writeBytes(data);
            }
            else
            {
               recvArray.length = 0;
            }
         }
      }
      
      private static function doMessage(recv:ByteArray) : void
      {
         var len:int = 0;
         var cmd:int = 0;
         if(recv.bytesAvailable > 0 && recv.toString().indexOf("<?xml") == 0)
         {
            recv.length = 0;
         }
         while(recv.bytesAvailable >= 4)
         {
            len = recv.readInt();
            if(recv.bytesAvailable < len - 4)
            {
               recv.position -= 4;
               break;
            }
            cmd = recv.readInt();
            if(cmd != 5009 && cmd != 88888 && cmd != 11002 && cmd != 5004 && cmd != 5007 && cmd != 6007 && cmd != 6050 && cmd != 5035 && cmd != 5030 && cmd != 6672)
            {
               Utils.print("receive",cmd);
            }
            data.length = 0;
            data.writeBytes(recv,recv.position,len - 8);
            recv.position += len - 8;
            data.position = 0;
            if(Boolean(index[cmd]))
            {
               index[cmd](data);
            }
         }
      }
      
      public static function close() : void
      {
         socket.close();
      }
      
      public static function errorHandler(e:IOErrorEvent) : void
      {
         Utils.print("IOERROR");
         socket.close();
      }
      
      public static function securityErrorHandler(e:SecurityErrorEvent) : void
      {
         Utils.print("SUCURITY_ERROR");
         socket.close();
         SocketManager.connect(Global.config.ip,Global.config.port);
      }
      
      public static function linkToOfficialWebsite() : void
      {
         var request:URLRequest = new URLRequest(Global.config.officialWebsite);
         navigateToURL(request,"_self");
      }
      
      public static function linkToChongzhiWebsite() : void
      {
         var request:URLRequest = new URLRequest(Global.config.officialWebsite);
         navigateToURL(request,"_self");
      }
      
      public static function linkToLunTanForumWebsite() : void
      {
         var request:URLRequest = new URLRequest(Global.config.officialWebsite);
         navigateToURL(request,"_self");
      }
   }
}

