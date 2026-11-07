package com.yiTian
{
   import com.yiTian.command.Control;
   import com.yiTian.data.Enum_SPStr;
   import com.yiTian.manager.UpdateTimeManager;
   import com.yiTian.utils.Singleton;
   import com.yiTian.utils.call.Delegate123;
   import flash.display.InteractiveObject;
   import flash.display.Stage;
   import flash.geom.Point;
   import flash.system.ApplicationDomain;
   
   public class Global
   {
      
      public static var heroName:String;
      
      public static var account:String;
      
      public static var fcm:int;
      
      public static var openkey:String;
      
      public static var _pf:String;
      
      public static var fpkey:String;
      
      public static var invkey:String;
      
      public static var itime:String;
      
      public static var iopenid:String;
      
      public static var zoneid:String;
      
      public static var via:String;
      
      public static var adtag:String;
      
      public static var user_source:String;
      
      public static var contract_id:String;
      
      public static var app_custom:String;
      
      public static var fd:String;
      
      public static var seqid:String;
      
      public static var dengluQuHao:int;
      
      public static var QQGameZKJ:Boolean;
      
      public static var jinJuanStore:Boolean;
      
      public static var huiYuanLibao:Boolean;
      
      public static var QQGameIcon:Boolean;
      
      public static var ShengDanTimes:String;
      
      public static var merriIcon:Boolean;
      
      public static var twoEggs:Boolean;
      
      public static var baoshiQingYuan:Boolean;
      
      public static var huiYuanIconCtrl:Boolean;
      
      public static var iconCanHide:Boolean;
      
      public static var huangZAct:Boolean;
      
      public static var AiXin:Boolean;
      
      public static var changxiang:Boolean;
      
      public static var conSumBackCtrl:Boolean;
      
      public static var xianShiGiftCtrl:Boolean;
      
      public static var WXIconCtrl:Boolean;
      
      public static var QTIconCtrl:Boolean;
      
      public static var tx_action_assitant_H:Boolean;
      
      public static var tx_action_assitant_L:Boolean;
      
      public static var tx_action_assitant_HY:Boolean;
      
      public static var redDiamond:Boolean;
      
      public static var YiAiZhiMing:Boolean;
      
      public static var JiangHuMiLing:Boolean;
      
      public static var fcmBoolean:Boolean;
      
      public static var JiaoShiJieZhuFu:Boolean;
      
      public static var QuWeiZhongQiu:Boolean;
      
      public static var GuoQingKuangHuan:Boolean;
      
      public static var ShiZhuangTouPiao:Boolean;
      
      public static var festivalActs:Boolean;
      
      public static var qingrenjieActs:Boolean;
      
      public static var session:String;
      
      public static var sceneID:int;
      
      public static var sceneType:int;
      
      private static var _sceneMap:int;
      
      public static var crossType:String;
      
      public static var targetSceneId:int;
      
      public static var targetJumpType:int;
      
      public static var key:int;
      
      public static var timestamp:int;
      
      public static var roleID:int;
      
      public static var server_Ip:String;
      
      public static var server_Port:int;
      
      public static var toX:int;
      
      public static var toY:int;
      
      public static var isGuest:int;
      
      public static var objPan:Object;
      
      public static var isSendUseYB:int;
      
      public static var kuafuzhanCenterServAddress:String;
      
      public static var stage:Stage;
      
      public static var loadScene:Object;
      
      public static var loadBack:ApplicationDomain;
      
      public static var guideMM:ApplicationDomain;
      
      public static var guideBtn:ApplicationDomain;
      
      public static var createDm:ApplicationDomain;
      
      public static var UIdm:ApplicationDomain;
      
      public static var thumbdm:ApplicationDomain;
      
      public static var faceDm:ApplicationDomain;
      
      public static var battleDm:ApplicationDomain;
      
      public static var zhengfaDm:ApplicationDomain;
      
      public static var musicDm:ApplicationDomain;
      
      public static var npcTalk:ApplicationDomain;
      
      public static var effectWord:ApplicationDomain;
      
      public static var wordEffect:ApplicationDomain;
      
      public static var skillEffect:ApplicationDomain;
      
      public static var FriendShip_Imgsdm:ApplicationDomain;
      
      public static var Invite_Imgsdm:ApplicationDomain;
      
      public static var KFHuoDong_Imgsdm:ApplicationDomain;
      
      public static var KunLun_Imgsdm:ApplicationDomain;
      
      public static var Target_Imgsdm:ApplicationDomain;
      
      public static var kuafuzhan_Imgsdm:ApplicationDomain;
      
      public static var YiDaodm:ApplicationDomain;
      
      public static var bangzhan_Imsdm:ApplicationDomain;
      
      public static var ChuangGuan_Imgsdm:ApplicationDomain;
      
      public static var Fishing_Imgsdm:ApplicationDomain;
      
      public static var GuaJi_Imgsdm:ApplicationDomain;
      
      public static var JYZH_Imgsdm:ApplicationDomain;
      
      public static var KeJu_Imgsdm:ApplicationDomain;
      
      public static var VIP_Imgsdm:ApplicationDomain;
      
      public static var QQZone_Imgsdm:ApplicationDomain;
      
      public static var Scenedm:ApplicationDomain;
      
      public static var Img_Cdm:ApplicationDomain;
      
      public static var Pet_Imgsdm:ApplicationDomain;
      
      public static var ZDJXdm:ApplicationDomain;
      
      public static var Rank_Imgsdm:ApplicationDomain;
      
      public static var Bang_Imgsdm:ApplicationDomain;
      
      public static var Bag_Imgsdm:ApplicationDomain;
      
      public static var Forging_Imgsdm:ApplicationDomain;
      
      public static var Mart_Imgsdm:ApplicationDomain;
      
      public static var SMShop_Imgsdm:ApplicationDomain;
      
      public static var Map_Imgsdm:ApplicationDomain;
      
      public static var ChouJiang_Imgsdm:ApplicationDomain;
      
      public static var NPC_Imgsdm:ApplicationDomain;
      
      public static var QQGame_Imgsdm:ApplicationDomain;
      
      public static var Guid_vipdm:ApplicationDomain;
      
      public static var TiLiStoreImgsdm:ApplicationDomain;
      
      public static var Zhuangbei_Imgsdm:ApplicationDomain;
      
      public static var WLDaHui_Imgsdm:ApplicationDomain;
      
      public static var Award_Imgsdm:ApplicationDomain;
      
      public static var New_Imgsdm:ApplicationDomain;
      
      public static var LingQi_Imgsdm:ApplicationDomain;
      
      public static var Marry_Imgsdm:ApplicationDomain;
      
      public static var HunLi_Imgs:ApplicationDomain;
      
      public static var Guide_Cloth_Itemdm:ApplicationDomain;
      
      public static var Diamond_Imgsdm:ApplicationDomain;
      
      public static var ReLife_Imgsdm:ApplicationDomain;
      
      public static var ShouChong_Imgsdm:ApplicationDomain;
      
      public static var tuanGou_Imgsdm:ApplicationDomain;
      
      public static var TianMing_Imgsdm:ApplicationDomain;
      
      public static var HZXianLidm:ApplicationDomain;
      
      public static var ShiZhuangdm:ApplicationDomain;
      
      public static var Challenge_Imgsdm:ApplicationDomain;
      
      public static var ShanZhuang_Imgsdm:ApplicationDomain;
      
      public static var YTHZDaLiBaodm:ApplicationDomain;
      
      public static var XSYinDaodm:ApplicationDomain;
      
      public static var Store_Imgsdm:ApplicationDomain;
      
      public static var ZLQiJundm:ApplicationDomain;
      
      public static var XSGIFT3366_Imgsdm:ApplicationDomain;
      
      public static var DaXianLi:ApplicationDomain;
      
      public static var TwoEgg_Imgsdm:ApplicationDomain;
      
      public static var FengXiang_Imgsdm:ApplicationDomain;
      
      public static var shareType:int;
      
      public static var sharePoint:Point;
      
      public static var ShengDan_Imgsdm:ApplicationDomain;
      
      public static var Egg_Imgsdm:ApplicationDomain;
      
      public static var DXuRendm:ApplicationDomain;
      
      public static var XuYuan_Imgsdm:ApplicationDomain;
      
      public static var ZhuanZhi_Imgsdm:ApplicationDomain;
      
      public static var Arena_Imgsdm:ApplicationDomain;
      
      public static var DiamondGain_Imgsdm:ApplicationDomain;
      
      public static var HuiKui_Imgsdm:ApplicationDomain;
      
      public static var DuoRenKuaFu_Imgsdm:ApplicationDomain;
      
      public static var DRKF_Imgsdm:ApplicationDomain;
      
      public static var NewYear01_Imgdm:ApplicationDomain;
      
      public static var ChunJie_Imgsdm:ApplicationDomain;
      
      public static var NianShou_Imgsdm:ApplicationDomain;
      
      public static var new_yeardm:ApplicationDomain;
      
      public static var LeiTai_Imgsdm:ApplicationDomain;
      
      public static var chat_testdm:ApplicationDomain;
      
      public static var HuiGuidm:ApplicationDomain;
      
      public static var QQXuanFengdm:ApplicationDomain;
      
      public static var JinQuan_Imgsdm:ApplicationDomain;
      
      public static var NianGao_Imgsdm:ApplicationDomain;
      
      public static var CiRiLiBao_Imgsdm:ApplicationDomain;
      
      public static var DLYLdm:ApplicationDomain;
      
      public static var HuoYue_Imgsdm:ApplicationDomain;
      
      public static var JiJin_Imgsdm:ApplicationDomain;
      
      public static var PCU_Imgsdm:ApplicationDomain;
      
      public static var ZuoQi_c01_Imgsdm:ApplicationDomain;
      
      public static var WLMiXindm:ApplicationDomain;
      
      public static var QiFudm:ApplicationDomain;
      
      public static var LiXian_Imgsdm:ApplicationDomain;
      
      public static var WuXing_Imgsdm:ApplicationDomain;
      
      public static var GXGGdm:ApplicationDomain;
      
      public static var Card_Imgsdm:ApplicationDomain;
      
      public static var QingMing_Imgsdm:ApplicationDomain;
      
      public static var XJueSedm:ApplicationDomain;
      
      public static var XianGoudm:ApplicationDomain;
      
      public static var ZhuaGuidm:ApplicationDomain;
      
      public static var XunZhangdm:ApplicationDomain;
      
      public static var WaBaodm:ApplicationDomain;
      
      public static var WaBaodm2:ApplicationDomain;
      
      public static var JFDHdm:ApplicationDomain;
      
      public static var GongCe_Imgsdm:ApplicationDomain;
      
      public static var CCJH_Imgsdm:ApplicationDomain;
      
      public static var jumpCG_dm:ApplicationDomain;
      
      public static var newPush:ApplicationDomain;
      
      public static var ChongZhiRankdm:ApplicationDomain;
      
      public static var WuYidm:ApplicationDomain;
      
      public static var NewHuiKui_Imgsdm:ApplicationDomain;
      
      public static var TargetPromptdm:ApplicationDomain;
      
      public static var YaAndm:ApplicationDomain;
      
      public static var GuangMingDing_Imgdm:ApplicationDomain;
      
      public static var Fight_Imgsdm:ApplicationDomain;
      
      public static var KFBang_CCdm:ApplicationDomain;
      
      public static var KFBang_CCdm2:ApplicationDomain;
      
      public static var WuYue_Imgsdm:ApplicationDomain;
      
      public static var SHDdm:ApplicationDomain;
      
      public static var FCMPromptdm:ApplicationDomain;
      
      public static var SuiPian_Imgsdm:ApplicationDomain;
      
      public static var HeFu_Imgsdm:ApplicationDomain;
      
      public static var ZaiXian_Imgsdm:ApplicationDomain;
      
      public static var MiJingCangZong_Imgs:ApplicationDomain;
      
      public static var BagBuy_Imgsdm:ApplicationDomain;
      
      public static var EJiMiMa_Imgsdm:ApplicationDomain;
      
      public static var DAU_Imgsdm:ApplicationDomain;
      
      public static var ShenBingdm:ApplicationDomain;
      
      public static var ADBB_Imgsdm:ApplicationDomain;
      
      public static var QQGameImg:ApplicationDomain;
      
      public static var DaShu_Imgsdm:ApplicationDomain;
      
      public static var BJWHdm:ApplicationDomain;
      
      public static var KFSH_Imgsdm:ApplicationDomain;
      
      public static var HZXuFei_Imgsdm:ApplicationDomain;
      
      public static var YuanBaoCJ_Imgsdm:ApplicationDomain;
      
      public static var fruitShop_Imgsdm:ApplicationDomain;
      
      public static var HuangBang_Imgdm:ApplicationDomain;
      
      public static var XinShou_3dm:ApplicationDomain;
      
      public static var wanJiaBack_Imgdm:ApplicationDomain;
      
      public static var cangBaoTu_Imgdm:ApplicationDomain;
      
      public static var XXPPdm:ApplicationDomain;
      
      public static var QQXdm:ApplicationDomain;
      
      public static var KFJYdm:ApplicationDomain;
      
      public static var LZHDdm:ApplicationDomain;
      
      public static var HZTXdm:ApplicationDomain;
      
      public static var QQBHdm:ApplicationDomain;
      
      public static var SMTBdm:ApplicationDomain;
      
      public static var KFPDdm:ApplicationDomain;
      
      public static var DTHLdm:ApplicationDomain;
      
      public static var XFJJdm:ApplicationDomain;
      
      public static var ChiBangdm:ApplicationDomain;
      
      public static var XZHGdm:ApplicationDomain;
      
      public static var WHHGdm:ApplicationDomain;
      
      public static var crossCampBattle_Imgdm:ApplicationDomain;
      
      public static var ZNdm:ApplicationDomain;
      
      public static var ZZJH_Imgsdm:ApplicationDomain;
      
      public static var HLZSdm:ApplicationDomain;
      
      public static var XFHKdm:ApplicationDomain;
      
      public static var HZXGLBdm:ApplicationDomain;
      
      public static var ShouChongTiaoZheng:ApplicationDomain;
      
      public static var ZhuTiZhou_Imgsdm:ApplicationDomain;
      
      public static var leijichongzhi_Imgsdm:ApplicationDomain;
      
      public static var TianMingdm:ApplicationDomain;
      
      public static var SMJNdm:ApplicationDomain;
      
      public static var CJQDdm:ApplicationDomain;
      
      public static var FXHJdm:ApplicationDomain;
      
      public static var XianShiLiBao_Imgsdm:ApplicationDomain;
      
      public static var WYBQ:ApplicationDomain;
      
      public static var TZJJ_Imgsdm:ApplicationDomain;
      
      public static var XZJZdm:ApplicationDomain;
      
      public static var MNXYdm:ApplicationDomain;
      
      public static var NSHSdm:ApplicationDomain;
      
      public static var DYNGdm:ApplicationDomain;
      
      public static var ZCLMdm:ApplicationDomain;
      
      public static var HLMNdm:ApplicationDomain;
      
      public static var AQZHdm:ApplicationDomain;
      
      public static var QYHDdm:ApplicationDomain;
      
      public static var CDMdm:ApplicationDomain;
      
      public static var QTHDdm:ApplicationDomain;
      
      public static var HZZPdm:ApplicationDomain;
      
      public static var YQSdm:ApplicationDomain;
      
      public static var JNHdm:ApplicationDomain;
      
      public static var JCHDdm:ApplicationDomain;
      
      public static var JHSdm:ApplicationDomain;
      
      public static var XingZuodm:ApplicationDomain;
      
      public static var XYSdm:ApplicationDomain;
      
      public static var XSFQdm:ApplicationDomain;
      
      public static var QTSIGNdm:ApplicationDomain;
      
      public static var HDXBdm:ApplicationDomain;
      
      public static var MMKPdm:ApplicationDomain;
      
      public static var KuPaoStyle1dm:ApplicationDomain;
      
      public static var CZHKDLdm:ApplicationDomain;
      
      public static var LZFLdm:ApplicationDomain;
      
      public static var KaPaidm:ApplicationDomain;
      
      public static var FWLZdm:ApplicationDomain;
      
      public static var HZCWdm:ApplicationDomain;
      
      public static var GCJSdm:ApplicationDomain;
      
      public static var GCHDdm:ApplicationDomain;
      
      public static var GCHGdm:ApplicationDomain;
      
      public static var QXWLdm:ApplicationDomain;
      
      public static var CJFLdm:ApplicationDomain;
      
      public static var XFTGdm:ApplicationDomain;
      
      public static var tempParam:int;
      
      public static var config:Object = new Object();
      
      public static var BaoShiQYTimecrl:String = "时间没传";
      
      public static var QQGameTimeCrl:String = "默认时间（蓝钻）";
      
      public static var guanWangTimeCrl:String = "默认时间（官网会员礼包）";
      
      public static var sheNianGfTipCtr:Boolean = false;
      
      public static var huangZTimeCtr:String = "2013年3月16至3月23日";
      
      public static var qqJinQuanCtr:Boolean = false;
      
      public static var isShowCaiFuTong:Boolean = false;
      
      public static var jiaodianUrl:String = "jiaodianPic/yaan.swf";
      
      public static var jiaodianLinkUrl:String = "http://yi.qq.com/act/a20130111xdjz/index.htm";
      
      public static var iconCtrlUnknown:Boolean = false;
      
      public static var filMoviesCTRL:Boolean = false;
      
      public static var HZTimeCtr:String = "";
      
      public static var activityGuide:Boolean = false;
      
      public static var WabIconCtrl:Boolean = false;
      
      public static var DAUCtrl:Boolean = false;
      
      public static var QQGameBackCtrl:Boolean = false;
      
      public static var DLXiaXin:Boolean = false;
      
      public static var BeCaHua:Boolean = false;
      
      public static var QQGameCJBtnCtrl:Boolean = false;
      
      public static var LoveAct:Boolean = false;
      
      public static var showSkinAct:Boolean = false;
      
      public static var HZShengYan:Boolean = false;
      
      public static var QT:Boolean = false;
      
      public static var LZFuLi:Boolean = false;
      
      public static var OPEN_LEVEL:int = 160;
      
      public static var IconObjCtrl:Object = new Object();
      
      public static var theBeautyIcon:Boolean = false;
      
      public static var theChampionIcon:Boolean = false;
      
      public static var QT_night_partyCtrl:Boolean = false;
      
      public static var VarsiongConfigCtl:String = "";
      
      public static const ConfigRs:String = "resource/config/config.xml";
      
      public static var HD2VarsionCrl:String = "";
      
      public static var isInHome:Boolean = false;
      
      public static var isBuildHome:Boolean = false;
      
      public static var crossParams:String = "";
      
      public static var isPata:Boolean = false;
      
      public static var loginTime:String = "TIME|";
      
      public static var lastTime:Number = 0;
      
      public static var isFirstPlay:Boolean = true;
      
      public static var isYellowDiamond:Boolean = false;
      
      public static var isPlayingMarriageEffect:Boolean = false;
      
      public static const quest_auto_level:int = 30;
      
      public static const constlockLength:int = 36000;
      
      public static const constlockLengAdd:int = 10000;
      
      public static const tuanGouOpenLevel:int = 35;
      
      public static const farmOpenLevel:int = 32;
      
      public static var isSleepMode:Boolean = false;
      
      public static var isInBattle:Boolean = false;
      
      public static var _curQShowSkinType:int = 0;
      
      public static var updateTimeManager:UpdateTimeManager = new UpdateTimeManager();
      
      public static var control:Control = new Control();
      
      public static var realPF:String = "";
      
      public function Global()
      {
         super();
      }
      
      public static function set sceneMap(value:int) : void
      {
         _sceneMap = value;
      }
      
      public static function get sceneMap() : int
      {
         return _sceneMap;
      }
      
      public static function get delegate() : Delegate123
      {
         return Singleton.getInstance(Delegate123);
      }
      
      public static function set pf(value:String) : void
      {
         _pf = value;
      }
      
      public static function get pf() : String
      {
         if(_pf.indexOf("*") == -1)
         {
            return _pf;
         }
         var _a:Array = _pf.split("*");
         return _a[1];
      }
      
      public static function get pfName() : String
      {
         if(_pf == Enum_SPStr.GUANWANG)
         {
            return "官网";
         }
         if(_pf == Enum_SPStr.PENGYOU)
         {
            return "朋友网";
         }
         if(_pf == Enum_SPStr.QZONE)
         {
            return "空间";
         }
         if(_pf == Enum_SPStr.QQGAME)
         {
            return "大厅";
         }
         if(_pf == Enum_SPStr.QQ3366)
         {
            return "3366";
         }
         if(_pf == Enum_SPStr.QQJIA)
         {
            return "Q+";
         }
         if(_pf == Enum_SPStr.WEIBO)
         {
            return "微博";
         }
         if(Enum_SPStr.isUnion(_pf))
         {
            return "微博";
         }
         if(_pf == Enum_SPStr.CHITU)
         {
            return "盒子";
         }
         if(Enum_SPStr.isIwan(Global.pf))
         {
            return "爱玩";
         }
         return "";
      }
      
      public static function set focus(value:InteractiveObject) : void
      {
         stage.focus = value;
      }
      
      public static function get focus() : InteractiveObject
      {
         return stage.focus;
      }
   }
}

