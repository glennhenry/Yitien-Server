package com.yiTian.manager
{
   import com.utils.ComponentUtil;
   import com.utils.Util;
   import com.yiTian.Global;
   import com.yiTian.scene.GameScene;
   import com.yiTian.utils.Utils;
   import com.yiTian.view.Panel;
   import com.yiTian.view.UIBase;
   import com.yiTian.view.View_special_btn;
   import com.yiTian.view.comp.View_DragObj;
   import com.yiTian.view.comp.View_Grid;
   import com.yiTian.view.modules.DAU.View_DAU_summyRewardPanel;
   import com.yiTian.view.modules.FangChenMi.View_FangChenMiPanel;
   import com.yiTian.view.modules.FangChenMi.View_FangChenMiTipPanel;
   import com.yiTian.view.modules.FeiXingQi.View_FeiXingQiMainPanel;
   import com.yiTian.view.modules.JinDan.JinDanBtn;
   import com.yiTian.view.modules.JinDan.JinDanPanel;
   import com.yiTian.view.modules.KongJianDengLu.KongJianBtn;
   import com.yiTian.view.modules.KongJianDengLu.KongJianPanel;
   import com.yiTian.view.modules.Kunlun.View_KunLunInside;
   import com.yiTian.view.modules.Kunlun.View_enterArea;
   import com.yiTian.view.modules.Kunlun.View_kl_jieshao;
   import com.yiTian.view.modules.Kunlun.View_kunLunSubstantive;
   import com.yiTian.view.modules.Kunlun.View_kunlunAward;
   import com.yiTian.view.modules.Kunlun.View_kunlunPrompt;
   import com.yiTian.view.modules.Kunlun.View_kunlunTishi;
   import com.yiTian.view.modules.Kunlun.View_teamNoEnter;
   import com.yiTian.view.modules.ShengDan.ShengDanBtn;
   import com.yiTian.view.modules.ShengDan.ShengDanPanel;
   import com.yiTian.view.modules.Shopping.View_shoppingMall;
   import com.yiTian.view.modules.Shopping.View_tishi;
   import com.yiTian.view.modules.WuLinMiXin.View_PrizeTips;
   import com.yiTian.view.modules.WulinDaHui.CountdownTips;
   import com.yiTian.view.modules.WulinDaHui.EnterMap;
   import com.yiTian.view.modules.WulinDaHui.View_WulinRecord;
   import com.yiTian.view.modules.WulinDaHui.View_deadthCountPanel;
   import com.yiTian.view.modules.WulinDaHui.View_wulinIntro;
   import com.yiTian.view.modules.WulinDaHui.WuLinPaiHang;
   import com.yiTian.view.modules.ZaHuoDian.View_ZaHuoDianPanel;
   import com.yiTian.view.modules.ZaHuoDian.View_buy_num;
   import com.yiTian.view.modules.ZaHuoDian.View_sold_num;
   import com.yiTian.view.modules.actions.JJDanTips;
   import com.yiTian.view.modules.activity.View_ActKaiFu;
   import com.yiTian.view.modules.activity.View_ActivityMainPanel;
   import com.yiTian.view.modules.activity.View_CJPanel;
   import com.yiTian.view.modules.activityGuide.View_ActivityGuidePanel;
   import com.yiTian.view.modules.aixin.AiXinBtn;
   import com.yiTian.view.modules.bag.View_bagCancelResetApply;
   import com.yiTian.view.modules.bag.View_bagClearPwd;
   import com.yiTian.view.modules.bag.View_bagModifyPwd;
   import com.yiTian.view.modules.bag.View_bagPwdAdSetting;
   import com.yiTian.view.modules.bag.View_bagPwdPutIn;
   import com.yiTian.view.modules.bag.View_bagPwdSetter;
   import com.yiTian.view.modules.bag.View_bagResetPwdApply;
   import com.yiTian.view.modules.banhui.View_BBIntroduce;
   import com.yiTian.view.modules.banhui.View_BangBattleRanks;
   import com.yiTian.view.modules.banhui.View_bangBuyPrompt;
   import com.yiTian.view.modules.banhui.View_bangCheck;
   import com.yiTian.view.modules.banhui.View_bangCreate;
   import com.yiTian.view.modules.banhui.View_bangEvent;
   import com.yiTian.view.modules.banhui.View_bangJoin;
   import com.yiTian.view.modules.banhui.View_bangList;
   import com.yiTian.view.modules.banhui.View_bangMoneyTree;
   import com.yiTian.view.modules.banhui.View_bangPlant;
   import com.yiTian.view.modules.banhui.View_bangPrompt;
   import com.yiTian.view.modules.banhui.View_bangStore;
   import com.yiTian.view.modules.banhui.View_banghuiBack;
   import com.yiTian.view.modules.banhui.View_bbRank;
   import com.yiTian.view.modules.banhui.View_invideBang;
   import com.yiTian.view.modules.banhui.shenshou.ShenShouPaiHang;
   import com.yiTian.view.modules.banhui.shenshou.ViewFeedBeast;
   import com.yiTian.view.modules.battle.SiWangFuHuoPanel;
   import com.yiTian.view.modules.battle.View_battleReplay;
   import com.yiTian.view.modules.bianxinggaiming.BianXingGaiMingPanel;
   import com.yiTian.view.modules.blueDiamondND.ViewBlueDiamondNDPanel;
   import com.yiTian.view.modules.broadcast.CheckAllTip;
   import com.yiTian.view.modules.broadcast.View_CenterBroadcast;
   import com.yiTian.view.modules.broadcast.View_SelfBroadcast;
   import com.yiTian.view.modules.broadcast.View_SystemBroadcast;
   import com.yiTian.view.modules.broadcast.View_SystemBroadcast2;
   import com.yiTian.view.modules.broadcast.View_SystemBroadcast3;
   import com.yiTian.view.modules.broadcast.View_TriggleBroadcast;
   import com.yiTian.view.modules.broadcast.View_heroBroadcast;
   import com.yiTian.view.modules.canggao.CangGaoPanel;
   import com.yiTian.view.modules.chargeGuide.FashionGuide;
   import com.yiTian.view.modules.chargeGuide.VIPGuide;
   import com.yiTian.view.modules.chargeGuide.View_FashionGude;
   import com.yiTian.view.modules.chargeGuide.View_newContainer;
   import com.yiTian.view.modules.chargeGuide.Vip_TYStop;
   import com.yiTian.view.modules.chat.PriChatManager;
   import com.yiTian.view.modules.chat.View_ChatPanel;
   import com.yiTian.view.modules.chat.View_chatPrompt;
   import com.yiTian.view.modules.chat.View_chatPrompt2;
   import com.yiTian.view.modules.chat.View_chatPrompt3;
   import com.yiTian.view.modules.chat.View_chatPrompt4;
   import com.yiTian.view.modules.chat.View_labaChat;
   import com.yiTian.view.modules.chongzhi.View_YuanBaoXiang;
   import com.yiTian.view.modules.christmas.ViewChristMas;
   import com.yiTian.view.modules.farm.View_arrestList;
   import com.yiTian.view.modules.farm.View_buy_seed;
   import com.yiTian.view.modules.farm.View_exchange_goods;
   import com.yiTian.view.modules.farm.View_farm;
   import com.yiTian.view.modules.farm.View_farm_farmer_guide;
   import com.yiTian.view.modules.farm.View_farm_help;
   import com.yiTian.view.modules.farm.View_farm_journal;
   import com.yiTian.view.modules.farm.View_farm_list;
   import com.yiTian.view.modules.farm.View_farm_plant_guide;
   import com.yiTian.view.modules.farm.View_fruit_exchange;
   import com.yiTian.view.modules.farm.View_land_rank;
   import com.yiTian.view.modules.farm.View_refresh_fruit;
   import com.yiTian.view.modules.farm.View_seek_help;
   import com.yiTian.view.modules.farm.View_treasureChest;
   import com.yiTian.view.modules.fishing.View_fishIntro;
   import com.yiTian.view.modules.fishing.View_fishingPlayerPanel;
   import com.yiTian.view.modules.fishing.View_myFishMark;
   import com.yiTian.view.modules.fishing.View_otherFishMark;
   import com.yiTian.view.modules.fishing.View_riverChoose;
   import com.yiTian.view.modules.friends.View_BestowFlower;
   import com.yiTian.view.modules.friends.View_FriendsPanel;
   import com.yiTian.view.modules.friends.View_ZhuFuPanel;
   import com.yiTian.view.modules.friends.View_friQuestList;
   import com.yiTian.view.modules.friends.View_inviteReward;
   import com.yiTian.view.modules.fruitShop.ViewFruitShop;
   import com.yiTian.view.modules.fubenSel.View_fuBenSaodanging;
   import com.yiTian.view.modules.fubenSel.View_fubensel_panel;
   import com.yiTian.view.modules.goldLottery.ViewGoldCJ;
   import com.yiTian.view.modules.gongce.gcPanel;
   import com.yiTian.view.modules.gongce.gc_Btn;
   import com.yiTian.view.modules.guaji.View_gjReplayPanel;
   import com.yiTian.view.modules.guaji.View_gjTipPanel;
   import com.yiTian.view.modules.guaji.View_guajiPanel;
   import com.yiTian.view.modules.guaji.View_lqqdPlayerInfoPanel;
   import com.yiTian.view.modules.guaji.View_qysxExpInfoPanel;
   import com.yiTian.view.modules.guaji.View_qysxPanel;
   import com.yiTian.view.modules.guide.View_Arrow;
   import com.yiTian.view.modules.guide.View_guide_dialog;
   import com.yiTian.view.modules.huangbang.View_HuangbangInfoPanel;
   import com.yiTian.view.modules.jianghulixian.View_Jianghulixian;
   import com.yiTian.view.modules.jiaoyi.View_trans_check;
   import com.yiTian.view.modules.jiaoyi.View_trans_num;
   import com.yiTian.view.modules.jiaoyi.View_trans_panel;
   import com.yiTian.view.modules.jiaoyi.View_trans_send_panel;
   import com.yiTian.view.modules.jingJiChang.View_CZItem;
   import com.yiTian.view.modules.jingJiChang.View_jingJiChang;
   import com.yiTian.view.modules.jingJiChang.View_myInfor;
   import com.yiTian.view.modules.jingJiChang.View_paiMing;
   import com.yiTian.view.modules.jingmaiHang.View_JiMaiHang;
   import com.yiTian.view.modules.jingmaiHang.View_SoldNum;
   import com.yiTian.view.modules.jingmaiHang.View_SoldSet;
   import com.yiTian.view.modules.jingmaiHang.View_buyNum;
   import com.yiTian.view.modules.jingmaiHang.View_check_info_board;
   import com.yiTian.view.modules.jingmaiHang.View_martBuySet;
   import com.yiTian.view.modules.jingmaiHang.View_martSelectNum;
   import com.yiTian.view.modules.jingmaiHang.View_mart_sold_num;
   import com.yiTian.view.modules.jingmaiHang.View_sellNum;
   import com.yiTian.view.modules.joinfriends.JoinFriendsPanel;
   import com.yiTian.view.modules.kuafujingjichang.DRKFJieShao;
   import com.yiTian.view.modules.kuafujingjichang.DRKFjoinPanel;
   import com.yiTian.view.modules.kuafujingjichang.DRKFlawPanel;
   import com.yiTian.view.modules.kuafujingjichang.KuaFuJJC_Btn;
   import com.yiTian.view.modules.kuafujingjichang.SeachPanel;
   import com.yiTian.view.modules.kuafujingjichang.TeamPanel;
   import com.yiTian.view.modules.kuafujingjichang.XiaYiShop;
   import com.yiTian.view.modules.letter.GoodsNumView;
   import com.yiTian.view.modules.letter.LetterEditViewPanel;
   import com.yiTian.view.modules.letter.LetterManagerViewPanel;
   import com.yiTian.view.modules.lingqiwuhun.LingQiWuHunPanel;
   import com.yiTian.view.modules.longWayShop.View_longSoldNum;
   import com.yiTian.view.modules.longWayShop.View_longWayShop;
   import com.yiTian.view.modules.mainMenu.View_MainMenu;
   import com.yiTian.view.modules.mainMenu.View_SceneDiscript;
   import com.yiTian.view.modules.mainUIBtnContainer.New_mainBtnContainer;
   import com.yiTian.view.modules.mainUIBtnContainer.ViewNextSys;
   import com.yiTian.view.modules.mainUIBtnContainer.View_RiChangWanFa_menu;
   import com.yiTian.view.modules.mainUIBtnContainer.View_TeHuiFuLi_menu;
   import com.yiTian.view.modules.mainUIBtnContainer.View_TipBtnContainer;
   import com.yiTian.view.modules.mainUIBtnContainer.View_XiaZheShiLian_menu;
   import com.yiTian.view.modules.mainUIBtnContainer.View_XianShiHuoDong_menu;
   import com.yiTian.view.modules.mainUIBtnContainer.View_mainUiBtn_container;
   import com.yiTian.view.modules.map.MapPanel;
   import com.yiTian.view.modules.map.SmallMap;
   import com.yiTian.view.modules.marriage.View_GetMarriageBlessPlane;
   import com.yiTian.view.modules.marriage.View_GetMarriagePlane;
   import com.yiTian.view.modules.marriage.View_HongBao;
   import com.yiTian.view.modules.marriage.View_MarriagePlane;
   import com.yiTian.view.modules.midAutumn.View_midAutumn;
   import com.yiTian.view.modules.npcDialog.View_npcDialog_panel;
   import com.yiTian.view.modules.npcDialog.View_quest_dialog;
   import com.yiTian.view.modules.olympic.View_daysWards;
   import com.yiTian.view.modules.paihang.HeroInfoPanel;
   import com.yiTian.view.modules.paihang.PaiHangPanel;
   import com.yiTian.view.modules.panel.View_DepotPanel;
   import com.yiTian.view.modules.panel.View_bagPanel;
   import com.yiTian.view.modules.panel.View_castPanel;
   import com.yiTian.view.modules.panel.View_layIn_pill;
   import com.yiTian.view.modules.panel.View_num_valuable;
   import com.yiTian.view.modules.panel.View_otherRolePanel;
   import com.yiTian.view.modules.panel.View_panelChip;
   import com.yiTian.view.modules.panel.View_panel_updateTip;
   import com.yiTian.view.modules.panel.View_rolePanel;
   import com.yiTian.view.modules.paobiao.PaoBiaoPanel;
   import com.yiTian.view.modules.paobiao.YunSongBiaoChePanel;
   import com.yiTian.view.modules.pata.PataOverlordViewPanel;
   import com.yiTian.view.modules.pata.PataTipPanel;
   import com.yiTian.view.modules.pet.BianShengKaPanel;
   import com.yiTian.view.modules.pet.HuaXingPanel;
   import com.yiTian.view.modules.pet.JiNengShuaXinPanel;
   import com.yiTian.view.modules.pet.JingXiuPanel;
   import com.yiTian.view.modules.pet.PetHeadPanel;
   import com.yiTian.view.modules.pet.PetInfoPanel;
   import com.yiTian.view.modules.pet.PetPanel;
   import com.yiTian.view.modules.pet.PetTipPanel;
   import com.yiTian.view.modules.pet.PetYellowDiamond;
   import com.yiTian.view.modules.pet.XiLianJiNengPanel;
   import com.yiTian.view.modules.pet.ZDJingXiu;
   import com.yiTian.view.modules.qplus.ViewQplusShare;
   import com.yiTian.view.modules.qqHallNationalDay.View_QqHallNationalDay;
   import com.yiTian.view.modules.quest.View_quest_dailyAccept;
   import com.yiTian.view.modules.quest.View_quest_hero_panel;
   import com.yiTian.view.modules.quest.View_quest_panel;
   import com.yiTian.view.modules.quest.View_quest_trace;
   import com.yiTian.view.modules.retrieExp.View_retrieSubmit;
   import com.yiTian.view.modules.roleHead.TargetHead;
   import com.yiTian.view.modules.roleHead.View_HeroHead;
   import com.yiTian.view.modules.shenBing.View_ShenBingPanel;
   import com.yiTian.view.modules.shenBing.View_ShenBingSkillStore;
   import com.yiTian.view.modules.shenBing.View_ShenBingSkillUpdate;
   import com.yiTian.view.modules.shenMiShop.View_SMS_tishi;
   import com.yiTian.view.modules.shenMiShop.View_mutilTips;
   import com.yiTian.view.modules.shenMiShop.View_search;
   import com.yiTian.view.modules.shenMiShop.View_shenMiShop;
   import com.yiTian.view.modules.shouchangyouli.View_shouchang_Panel;
   import com.yiTian.view.modules.shouchong.ShouChongPanel;
   import com.yiTian.view.modules.skill.View_SkillPanel;
   import com.yiTian.view.modules.team.ApplyCaptainTip;
   import com.yiTian.view.modules.team.CapReqFollowTip;
   import com.yiTian.view.modules.team.ChaKanTeam;
   import com.yiTian.view.modules.team.InviteTip;
   import com.yiTian.view.modules.team.TeamSearchPanel;
   import com.yiTian.view.modules.team.TeamSignTogether;
   import com.yiTian.view.modules.team.Zhenxing;
   import com.yiTian.view.modules.tianTi.View_tianTiPanel;
   import com.yiTian.view.modules.tianTi.View_xinFaPanel;
   import com.yiTian.view.modules.tiliStore.MeiWeiJiaYaoPanel;
   import com.yiTian.view.modules.tiliStore.TlProm;
   import com.yiTian.view.modules.tiliStore.View_tiliStore;
   import com.yiTian.view.modules.treasureBowl.View_treasureBowl;
   import com.yiTian.view.modules.tuanGou.ViewTuanGouPanel;
   import com.yiTian.view.modules.vip.OpenVipPanel;
   import com.yiTian.view.modules.vip.VipPanel;
   import com.yiTian.view.modules.wanansi.WanAnSiPanel;
   import com.yiTian.view.modules.worldLevel.View_worldLvReward;
   import com.yiTian.view.modules.wuXing.WuxingTips;
   import com.yiTian.view.modules.wuyi.wuyiBtn;
   import com.yiTian.view.modules.wuyi.wuyiPanel;
   import com.yiTian.view.modules.yellowDiamond.Model_init;
   import com.yiTian.view.modules.yellowDiamond.View_qqOnLine;
   import com.yiTian.view.modules.yellowDiamond.View_xianShiGift;
   import com.yiTian.view.modules.yellowDiamond.View_yellGif;
   import com.yiTian.view.modules.yellowDiamond.View_yellowDiamond;
   import com.yiTian.view.modules.yellowDiamond_NationalDay.View_YellowDiamond_ND_Panel;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.utils.describeType;
   
   public class UIManager
   {
      
      public static var arrow:View_Arrow;
      
      public static var guideDialog:View_guide_dialog;
      
      public static var treasureBowlPanel:View_treasureBowl;
      
      public static var midAutumnPanel:View_midAutumn;
      
      public static var farm:View_farm;
      
      public static var treasureChest:View_treasureChest;
      
      public static var buySeed:View_buy_seed;
      
      public static var exchangeGoods:View_exchange_goods;
      
      public static var fruitExchange:View_fruit_exchange;
      
      public static var land_upgrade:View_land_rank;
      
      public static var refresh_fruit:View_refresh_fruit;
      
      public static var farmFriendList:View_farm_list;
      
      public static var farmJournal:View_farm_journal;
      
      public static var seekHelp:View_seek_help;
      
      public static var farmHelp:View_farm_help;
      
      public static var farmPlantGuide:View_farm_plant_guide;
      
      public static var farmFarmerGuide:View_farm_farmer_guide;
      
      public static var farmArrestList:View_arrestList;
      
      public static var christmasView:ViewChristMas;
      
      public static var layInPill:View_layIn_pill;
      
      public static var shouchang_panel:View_shouchang_Panel;
      
      public static var isDragPanel:Boolean;
      
      public static var curDragPanel:UIBase;
      
      public static var isDrag:Boolean;
      
      public static var qplusShare:ViewQplusShare;
      
      private static var startX:int;
      
      private static var startY:int;
      
      public static var num_valuable:View_num_valuable = new View_num_valuable();
      
      public static var nextSys:ViewNextSys = new ViewNextSys();
      
      public static var mainMenu:View_MainMenu = new View_MainMenu();
      
      public static var sceneDisView:View_SceneDiscript = new View_SceneDiscript();
      
      public static var dragObj:View_DragObj = new View_DragObj();
      
      public static var bagPanel:View_bagPanel = new View_bagPanel();
      
      public static var rolePanel:View_rolePanel = new View_rolePanel();
      
      public static var castPanel:View_castPanel = new View_castPanel();
      
      public static var panelChip:View_panelChip = new View_panelChip();
      
      public static var panel_updateTip:View_panel_updateTip = new View_panel_updateTip();
      
      public static var skillPanel:View_SkillPanel = new View_SkillPanel();
      
      public static var chatPanel:View_ChatPanel = new View_ChatPanel();
      
      public static var laba_panel:View_labaChat = new View_labaChat();
      
      public static var chatPrompt:View_chatPrompt = new View_chatPrompt();
      
      public static var chatPrompt2:View_chatPrompt2 = new View_chatPrompt2();
      
      public static var chatPrompt3:View_chatPrompt3 = new View_chatPrompt3();
      
      public static var chatPrompt4:View_chatPrompt4 = new View_chatPrompt4();
      
      public static var tiliProm:TlProm = new TlProm();
      
      public static var wuXingProm:WuxingTips = new WuxingTips();
      
      public static var jjdProm:JJDanTips = new JJDanTips();
      
      public static var special_btn:View_special_btn = new View_special_btn();
      
      public static var teamSignTogether:TeamSignTogether = new TeamSignTogether();
      
      public static var chaKanTeam:ChaKanTeam = new ChaKanTeam();
      
      public static var inviteTip:InviteTip = new InviteTip();
      
      public static var zhenxing:Zhenxing = new Zhenxing();
      
      public static var applyCaptainTip:ApplyCaptainTip = new ApplyCaptainTip();
      
      public static var capReqFollowTip:CapReqFollowTip = new CapReqFollowTip();
      
      public static var letterManagerViewPanel:LetterManagerViewPanel = new LetterManagerViewPanel();
      
      public static var letterEditViewPanel:LetterEditViewPanel = new LetterEditViewPanel();
      
      public static var friendPanel:View_FriendsPanel = new View_FriendsPanel();
      
      public static var bestowFlower:View_BestowFlower = new View_BestowFlower();
      
      public static var friQuestPanel:View_friQuestList = new View_friQuestList();
      
      public static var zhufuPanel:View_ZhuFuPanel = new View_ZhuFuPanel();
      
      public static var teamSearchPanel:TeamSearchPanel = new TeamSearchPanel();
      
      public static var shoppingMall:View_shoppingMall = new View_shoppingMall();
      
      public static var zaHuoDian:View_ZaHuoDianPanel = new View_ZaHuoDianPanel();
      
      public static var sold_num_shop:View_sold_num = new View_sold_num();
      
      public static var bought_num:View_buy_num = new View_buy_num();
      
      public static var long_way_shop:View_longWayShop = new View_longWayShop();
      
      public static var long_sold_num:View_longSoldNum = new View_longSoldNum();
      
      public static var trans_chck:View_trans_check = new View_trans_check();
      
      public static var trans_num:View_trans_num = new View_trans_num();
      
      public static var trans_panel:View_trans_panel = new View_trans_panel();
      
      public static var trans_send_panel:View_trans_send_panel = new View_trans_send_panel();
      
      public static var heroHead:View_HeroHead = new View_HeroHead();
      
      public static var smallMap:SmallMap = new SmallMap();
      
      public static var mappanel:MapPanel = new MapPanel();
      
      public static var fubenSelPanel:View_fubensel_panel = new View_fubensel_panel();
      
      public static var npcDialog:View_npcDialog_panel = new View_npcDialog_panel();
      
      public static var questDialog:View_quest_dialog = new View_quest_dialog();
      
      public static var targetHead:TargetHead = new TargetHead();
      
      public static var saoDangFuben:View_fuBenSaodanging = new View_fuBenSaodanging();
      
      public static var canggao:CangGaoPanel = new CangGaoPanel();
      
      public static var deadthCountPan:View_deadthCountPanel = new View_deadthCountPanel();
      
      public static var JMH_panel:View_JiMaiHang = new View_JiMaiHang();
      
      public static var sold_set:View_SoldSet = new View_SoldSet();
      
      public static var buy_set:View_martBuySet = new View_martBuySet();
      
      public static var storeTip:View_tishi = new View_tishi();
      
      public static var sellNum:View_sellNum = new View_sellNum();
      
      public static var buyNum:View_buyNum = new View_buyNum();
      
      public static var selectNum:View_martSelectNum = new View_martSelectNum();
      
      public static var ch_info_board:View_check_info_board = new View_check_info_board();
      
      public static var mart_sold_num:View_mart_sold_num = new View_mart_sold_num();
      
      public static var mart_buy_num:View_SoldNum = new View_SoldNum();
      
      public static var jjc_panel:View_jingJiChang = new View_jingJiChang();
      
      public static var pai_ming:View_paiMing = new View_paiMing();
      
      public static var cz_info:View_CZItem = new View_CZItem();
      
      public static var myInfoPanel:View_myInfor = new View_myInfor();
      
      public static var selfBroadcast:View_SelfBroadcast = new View_SelfBroadcast();
      
      public static var checkAllTip:CheckAllTip = new CheckAllTip();
      
      public static var centerBroadcast:View_CenterBroadcast = new View_CenterBroadcast();
      
      public static var triggleBroadcast:View_TriggleBroadcast = new View_TriggleBroadcast();
      
      public static var unuse:View_SystemBroadcast = new View_SystemBroadcast();
      
      public static var actBroadcast:View_SystemBroadcast2 = new View_SystemBroadcast2();
      
      public static var systemBroadcast:View_SystemBroadcast3 = new View_SystemBroadcast3();
      
      public static var heroBroadcast:View_heroBroadcast = new View_heroBroadcast();
      
      public static var fangChenMiPanel:View_FangChenMiPanel = new View_FangChenMiPanel();
      
      public static var fangChenMiTipPanel:View_FangChenMiTipPanel = new View_FangChenMiTipPanel();
      
      public static var depotPanel:View_DepotPanel = new View_DepotPanel();
      
      public static var newMainBtnContainer:New_mainBtnContainer = new New_mainBtnContainer();
      
      public static var mainUiBtnContainer:View_mainUiBtn_container = new View_mainUiBtn_container();
      
      public static var view_XianShiHuoDong_menu:View_XianShiHuoDong_menu = View_XianShiHuoDong_menu.instance;
      
      public static var view_XiaZheShiLian_menu:View_XiaZheShiLian_menu = View_XiaZheShiLian_menu.instance;
      
      public static var view_RiChangWanFa_menu:View_RiChangWanFa_menu = View_RiChangWanFa_menu.instance;
      
      public static var view_TeHuiFuLi_menu:View_TeHuiFuLi_menu = View_TeHuiFuLi_menu.instance;
      
      public static var tipBtnContainer:View_TipBtnContainer = new View_TipBtnContainer();
      
      public static var goodsNumView:GoodsNumView = new GoodsNumView();
      
      public static var pataOverlordViewPanel:PataOverlordViewPanel = new PataOverlordViewPanel();
      
      public static var pataTipPanel:PataTipPanel = new PataTipPanel();
      
      public static var newContainer:View_newContainer = new View_newContainer();
      
      public static var petPanel:PetPanel = new PetPanel();
      
      public static var zdjx:ZDJingXiu = new ZDJingXiu();
      
      public static var petTipPanel:PetTipPanel = new PetTipPanel();
      
      public static var petHeadPanel:PetHeadPanel = new PetHeadPanel();
      
      public static var petInfoPanel:PetInfoPanel = new PetInfoPanel();
      
      public static var xiLianJiNengPanel:XiLianJiNengPanel = new XiLianJiNengPanel();
      
      public static var bianShengKa:BianShengKaPanel = new BianShengKaPanel();
      
      public static var huaxing:HuaXingPanel = new HuaXingPanel();
      
      public static var jingxiu:JingXiuPanel = new JingXiuPanel();
      
      public static var jiNengShuaxinPanel:JiNengShuaXinPanel = new JiNengShuaXinPanel();
      
      public static var petYellowDiamond:PetYellowDiamond = new PetYellowDiamond();
      
      public static var paiHangPanel:PaiHangPanel = new PaiHangPanel();
      
      public static var heroInfoPanel:HeroInfoPanel = new HeroInfoPanel();
      
      public static var siWangFuHuoPanel:SiWangFuHuoPanel = new SiWangFuHuoPanel();
      
      public static var vipPanel:VipPanel = new VipPanel();
      
      public static var openVipPanel:OpenVipPanel = new OpenVipPanel();
      
      public static var kunlun_prompt:View_kunlunPrompt = new View_kunlunPrompt();
      
      public static var teamEnter_no:View_teamNoEnter = new View_teamNoEnter();
      
      public static var kunlun_inside:View_KunLunInside = new View_KunLunInside();
      
      public static var kunlun_tishi:View_kunlunTishi = new View_kunlunTishi();
      
      public static var kunlun_award:View_kunlunAward = new View_kunlunAward();
      
      public static var kunlun_substantive:View_kunLunSubstantive = new View_kunLunSubstantive();
      
      public static var kunlun_jieShao:View_kl_jieshao = new View_kl_jieshao();
      
      public static var kl_roomInfo:View_enterArea = new View_enterArea();
      
      public static var banghuiBack:View_banghuiBack = new View_banghuiBack();
      
      public static var bangList:View_bangList = new View_bangList();
      
      public static var bangCreate:View_bangCreate = new View_bangCreate();
      
      public static var bang_check:View_bangCheck = new View_bangCheck();
      
      public static var invide_bang:View_invideBang = new View_invideBang();
      
      public static var bang_prompt:View_bangPrompt = new View_bangPrompt();
      
      public static var bang_event:View_bangEvent = new View_bangEvent();
      
      public static var bang_store:View_bangStore = new View_bangStore();
      
      public static var bang_store_prompt:View_bangBuyPrompt = new View_bangBuyPrompt();
      
      public static var bangJoinList:View_bangJoin = new View_bangJoin();
      
      public static var bangPlant:View_bangPlant = new View_bangPlant();
      
      public static var bangMoneyTree:View_bangMoneyTree = new View_bangMoneyTree();
      
      public static var bbIntroduce:View_BBIntroduce = new View_BBIntroduce();
      
      public static var bbRanks:View_BangBattleRanks = new View_BangBattleRanks();
      
      public static var bbRank:View_bbRank = new View_bbRank();
      
      public static var yuanBaoXiang:View_YuanBaoXiang = new View_YuanBaoXiang();
      
      public static var sm_shop:View_shenMiShop = new View_shenMiShop();
      
      public static var tishi_sms:View_SMS_tishi = new View_SMS_tishi();
      
      public static var search:View_search = new View_search();
      
      public static var sms_mulTips:View_mutilTips = new View_mutilTips();
      
      public static var questPanel:View_quest_panel = new View_quest_panel();
      
      public static var questTraceView:View_quest_trace = new View_quest_trace();
      
      public static var questDailyAccView:View_quest_dailyAccept = new View_quest_dailyAccept();
      
      public static var questHeroPanel:View_quest_hero_panel = new View_quest_hero_panel();
      
      public static var questTraceView1:View_quest_trace = new View_quest_trace();
      
      public static var wulinMXTips:View_PrizeTips = new View_PrizeTips();
      
      public static var jianghulixian_tips:View_Jianghulixian = new View_Jianghulixian();
      
      public static var jianghulixian_onekey_tips:View_Jianghulixian = new View_Jianghulixian();
      
      public static var retrieExpSubmit:View_retrieSubmit = new View_retrieSubmit();
      
      public static var amPanel:View_ActivityMainPanel = new View_ActivityMainPanel();
      
      public static var cjPanel:View_CJPanel = new View_CJPanel();
      
      public static var actKaiFu:View_ActKaiFu = new View_ActKaiFu();
      
      public static var lqqdPlayerInfoPanel:View_lqqdPlayerInfoPanel = new View_lqqdPlayerInfoPanel();
      
      public static var guajiPanel:View_guajiPanel = new View_guajiPanel();
      
      public static var qysxExpInfoPanel:View_qysxExpInfoPanel = new View_qysxExpInfoPanel();
      
      public static var qysxPanel:View_qysxPanel = new View_qysxPanel();
      
      public static var gjReplay:View_gjReplayPanel = new View_gjReplayPanel();
      
      public static var gjTipPanel:View_gjTipPanel = new View_gjTipPanel();
      
      public static var fishingPlayerPanel:View_fishingPlayerPanel = new View_fishingPlayerPanel();
      
      public static var riverChoose:View_riverChoose = new View_riverChoose();
      
      public static var otherFishMark:View_otherFishMark = new View_otherFishMark();
      
      public static var myFishMark:View_myFishMark = new View_myFishMark();
      
      public static var fishIntro:View_fishIntro = new View_fishIntro();
      
      public static var otherRolePanel:View_otherRolePanel = new View_otherRolePanel();
      
      public static var lingQiWuHunPanel:LingQiWuHunPanel = new LingQiWuHunPanel();
      
      public static var activityGuide:View_ActivityGuidePanel = View_ActivityGuidePanel.instance;
      
      public static var wulin_enter_map:EnterMap = new EnterMap();
      
      public static var wulin_paihang:WuLinPaiHang = new WuLinPaiHang();
      
      public static var countDown_tip:CountdownTips = new CountdownTips();
      
      public static var wulin_record:View_WulinRecord = new View_WulinRecord();
      
      public static var wulin_intro:View_wulinIntro = new View_wulinIntro();
      
      public static var yellowDiamond:View_yellowDiamond = new View_yellowDiamond();
      
      public static var qqHallNationalDay:View_QqHallNationalDay = new View_QqHallNationalDay();
      
      public static var tuanGou:ViewTuanGouPanel = new ViewTuanGouPanel();
      
      public static var tiliStore:View_tiliStore = new View_tiliStore();
      
      public static var meiWeiJiaYaoPanel:MeiWeiJiaYaoPanel = new MeiWeiJiaYaoPanel();
      
      public static var tianTiPanel:View_tianTiPanel = new View_tianTiPanel();
      
      public static var xinFaPanel:View_xinFaPanel = new View_xinFaPanel();
      
      public static var shouChongPanel:ShouChongPanel = new ShouChongPanel();
      
      public static var joinFriendsPanel:JoinFriendsPanel = new JoinFriendsPanel();
      
      public static var battleReplay:View_battleReplay = new View_battleReplay();
      
      public static var inviteReward:View_inviteReward = new View_inviteReward();
      
      public static var feiXingQiPanel:View_FeiXingQiMainPanel = new View_FeiXingQiMainPanel();
      
      public static var paoBiaoPanel:PaoBiaoPanel = new PaoBiaoPanel();
      
      public static var yunSongBiaoChePanel:YunSongBiaoChePanel = new YunSongBiaoChePanel();
      
      public static var wanAnSiPanel:WanAnSiPanel = new WanAnSiPanel();
      
      public static var onlineAward:View_qqOnLine = new View_qqOnLine();
      
      public static var yellowGift:View_yellGif = new View_yellGif();
      
      public static var guidVip:Vip_TYStop = new Vip_TYStop();
      
      public static var kongjian:KongJianPanel = new KongJianPanel();
      
      public static var kongjianBtn:KongJianBtn = new KongJianBtn();
      
      public static var xshdPan:View_xianShiGift = new View_xianShiGift();
      
      public static var ShengDan:ShengDanPanel = new ShengDanPanel();
      
      public static var shengdanBtn:ShengDanBtn = new ShengDanBtn();
      
      public static var JinDan:JinDanPanel = new JinDanPanel();
      
      public static var jindanBtn:JinDanBtn = new JinDanBtn();
      
      public static var kuafuBtn:KuaFuJJC_Btn = new KuaFuJJC_Btn();
      
      public static var team:TeamPanel = TeamPanel.instance;
      
      public static var kuafujoin:DRKFjoinPanel = DRKFjoinPanel.instance;
      
      public static var kuafulaw:DRKFlawPanel = DRKFlawPanel.instance;
      
      public static var Seach:SeachPanel = SeachPanel.instance;
      
      public static var xyShop:XiaYiShop = XiaYiShop.instance;
      
      public static var drkfjs:DRKFJieShao = new DRKFJieShao();
      
      public static var gcBtn:gc_Btn = new gc_Btn();
      
      public static var gongCe:gcPanel = gcPanel.instance;
      
      public static var axBtn:AiXinBtn = new AiXinBtn();
      
      public static var wyBtn:wuyiBtn = new wuyiBtn();
      
      public static var wuyi:wuyiPanel = wuyiPanel.instance;
      
      public static var marriagePlane:View_MarriagePlane = new View_MarriagePlane();
      
      public static var getMarriagePlane:View_GetMarriagePlane = new View_GetMarriagePlane();
      
      public static var hongbao:View_HongBao = new View_HongBao();
      
      public static var getMarriageBlessPlane:View_GetMarriageBlessPlane = new View_GetMarriageBlessPlane();
      
      public static var fashionGuide:FashionGuide = new FashionGuide();
      
      public static var vipGuide:VIPGuide = new VIPGuide();
      
      public static var view_fsPan:View_FashionGude = new View_FashionGude();
      
      public static var daysAPan:View_daysWards = new View_daysWards();
      
      public static var worldLevReward:View_worldLvReward = new View_worldLvReward();
      
      public static var bianXingGaiMing:BianXingGaiMingPanel = new BianXingGaiMingPanel();
      
      public static var visiblePanels:Array = [];
      
      public static var yellowDiamondND:View_YellowDiamond_ND_Panel = new View_YellowDiamond_ND_Panel();
      
      public static var blueDiamondND:ViewBlueDiamondNDPanel = new ViewBlueDiamondNDPanel();
      
      public static var shenShouPaiHang:ShenShouPaiHang = new ShenShouPaiHang();
      
      public static var feedBeast:ViewFeedBeast = new ViewFeedBeast();
      
      public static var bagPwdSetter:View_bagPwdSetter = new View_bagPwdSetter();
      
      public static var bagPwdPutIn:View_bagPwdPutIn = new View_bagPwdPutIn();
      
      public static var bagPwdAdSetting:View_bagPwdAdSetting = new View_bagPwdAdSetting();
      
      public static var bagModifyPwd:View_bagModifyPwd = new View_bagModifyPwd();
      
      public static var bagClearPwd:View_bagClearPwd = new View_bagClearPwd();
      
      public static var bagResetPwd:View_bagResetPwdApply = new View_bagResetPwdApply();
      
      public static var bagCancelApply:View_bagCancelResetApply = new View_bagCancelResetApply();
      
      public static var DAU_summryReward:View_DAU_summyRewardPanel = new View_DAU_summyRewardPanel();
      
      public static var huangbangInfo:View_HuangbangInfoPanel = View_HuangbangInfoPanel.instance;
      
      public static var shenBingPanel:View_ShenBingPanel = new View_ShenBingPanel();
      
      public static var shenbingSkillStore:View_ShenBingSkillStore = new View_ShenBingSkillStore();
      
      public static var shenBingSkillUpdate:View_ShenBingSkillUpdate = new View_ShenBingSkillUpdate();
      
      public static var goldCJ:ViewGoldCJ = new ViewGoldCJ();
      
      public static var fruitShop:ViewFruitShop = new ViewFruitShop();
      
      private static var _isInit:Boolean = false;
      
      public function UIManager()
      {
         super();
      }
      
      public static function get isInit() : Boolean
      {
         return _isInit;
      }
      
      public static function createUI(info:Object) : void
      {
         Global.UIdm = info.applicationDomain;
         ComponentUtil.domain = Global.UIdm;
      }
      
      private static function prioTyInit() : void
      {
         questTraceView1.visible = false;
         mainMenu.init();
         mainUiBtnContainer.init();
         special_btn.init();
         newMainBtnContainer.init();
      }
      
      public static function init() : void
      {
         var propertyInfo:XML = null;
         var propertyName:String = null;
         prioTyInit();
         var properties:XMLList = describeType(UIManager).variable;
         for each(propertyInfo in properties)
         {
            propertyName = propertyInfo.@name;
            if(UIManager[propertyName])
            {
               if(UIManager[propertyName] is UIBase)
               {
                  if(!(UIManager[propertyName] as UIBase).isInit_base)
                  {
                     (UIManager[propertyName] as UIBase).init();
                  }
               }
            }
         }
         TipManager.Init();
         NpcFunManager.register();
         GameScene.uiLayer.addEventListener(MouseEvent.ROLL_OVER,rollOver);
         GameScene.uiLayer.addEventListener(MouseEvent.ROLL_OUT,rollOut);
         GameScene.modalLayer.addEventListener(MouseEvent.ROLL_OVER,rollOver);
         GameScene.modalLayer.addEventListener(MouseEvent.ROLL_OUT,rollOut);
         GameScene.popupLayer.addEventListener(MouseEvent.ROLL_OVER,rollOver);
         GameScene.popupLayer.addEventListener(MouseEvent.ROLL_OUT,rollOut);
         ModalUIManager.init();
         Model_init.init();
         _isInit = true;
      }
      
      private static function rollOver(e:MouseEvent) : void
      {
         Util.isOnUI = true;
      }
      
      private static function rollOut(e:MouseEvent) : void
      {
         Util.isOnUI = false;
      }
      
      public static function resetPosition() : void
      {
         var temp:DisplayObject = null;
         if(isDragPanel && curDragPanel != null)
         {
            curDragPanel["upEvent"](null);
         }
         var i:int = 0;
         while(i < GameScene.uiLayer.numChildren)
         {
            temp = GameScene.uiLayer.getChildAt(i);
            if(temp is UIBase)
            {
               (temp as UIBase).resetPosition();
            }
            i++;
         }
         i = 0;
         while(i < GameScene.downUILayer.numChildren)
         {
            temp = GameScene.downUILayer.getChildAt(i);
            if(temp is UIBase)
            {
               (temp as UIBase).resetPosition();
            }
            i++;
         }
         var ii:int = 0;
         while(ii < GameScene.upUILayer.numChildren)
         {
            temp = GameScene.upUILayer.getChildAt(ii);
            if(temp is UIBase)
            {
               (temp as UIBase).resetPosition();
            }
            ii++;
         }
         var iii:int = 0;
         while(iii < GameScene.popupLayer.numChildren)
         {
            temp = GameScene.popupLayer.getChildAt(iii);
            if(temp is UIBase)
            {
               (temp as UIBase).resetPosition();
            }
            iii++;
         }
         iii = 0;
         while(iii < GameScene.sysLayer.numChildren)
         {
            temp = GameScene.sysLayer.getChildAt(iii);
            if(temp is UIBase)
            {
               (temp as UIBase).resetPosition();
            }
            iii++;
         }
         if(Global.isInBattle && GameScene.battleLayer.isInit)
         {
            i = 0;
            while(i < GameScene.battleLayer.uiLayer.numChildren)
            {
               if(GameScene.battleLayer.uiLayer.getChildAt(i).hasOwnProperty("resetPosition"))
               {
                  Object(GameScene.battleLayer.uiLayer.getChildAt(i)).resetPosition();
               }
               i++;
            }
         }
         if(Boolean(systemBroadcast))
         {
            systemBroadcast.resetPosition();
         }
         PriChatManager.getInstance().resetTipPos();
         ModalUIManager.resetPos();
         Model_init.reposition();
      }
      
      public static function checkDragPanel() : void
      {
         if(isDragPanel && curDragPanel != null)
         {
            if(Global.stage.mouseX <= 0 || Global.stage.mouseY <= 0 || Global.stage.mouseX >= Global.stage.stageWidth || Global.stage.mouseY >= Global.stage.stageHeight)
            {
               curDragPanel["upEvent"](null);
            }
         }
      }
      
      public static function startDrag(e:MouseEvent) : void
      {
         var grid:View_Grid = null;
         if(e.shiftKey || e.ctrlKey || isDrag)
         {
            return;
         }
         grid = e.target as View_Grid;
         if(grid.vo == null || grid.vo.str_name == null)
         {
            return;
         }
         startX = e.stageX;
         startY = e.stageY;
         dragObj.grid = grid;
         if(Global.stage.hasEventListener(MouseEvent.MOUSE_MOVE) == false)
         {
            Global.stage.addEventListener(MouseEvent.MOUSE_MOVE,onMove);
         }
         else
         {
            trace("重复UIManager.startDrag()");
         }
      }
      
      private static function onMove(e:MouseEvent) : void
      {
         if(Utils.dist(startX,startY,e.stageX,e.stageY) < 5)
         {
            return;
         }
         isDrag = true;
         if(!Global.stage.contains(dragObj))
         {
            Global.stage.addChild(dragObj);
         }
         dragObj.x = e.stageX - dragObj.width / 2;
         dragObj.y = e.stageY - dragObj.height / 2;
      }
      
      public static function stopDrag() : void
      {
         isDrag = false;
         if(Global.stage.contains(dragObj))
         {
            Global.stage.removeChild(dragObj);
         }
         Global.stage.removeEventListener(MouseEvent.MOUSE_MOVE,onMove);
      }
      
      public static function addVisibleView(view:Sprite, position:int) : void
      {
         if(!visiblePanels[position])
         {
            visiblePanels[position] = [];
         }
         var panels:Array = visiblePanels[position];
         var i:int = 0;
         while(i < panels.length)
         {
            if(panels[i] == view)
            {
               panels.splice(i,1);
               panels.push(view);
               return;
            }
            i++;
         }
         panels.push(view);
      }
      
      public static function removeVisibleView(view:Sprite, position:int) : void
      {
         var panels:Array = null;
         var i:int = 0;
         if(Boolean(visiblePanels[position]))
         {
            panels = visiblePanels[position];
            i = panels.length - 1;
            while(i >= 0)
            {
               if(panels[i] == view)
               {
                  panels.splice(i,1);
                  return;
               }
               i--;
            }
         }
      }
      
      public static function clearVisibleView() : void
      {
         var spr:Sprite = null;
         if(!visiblePanels[0])
         {
            return;
         }
         while(Boolean(visiblePanels[0].length))
         {
            spr = UIManager.visiblePanels[0][0] as Sprite;
            if(spr is Panel)
            {
               (spr as Panel).visible = false;
            }
         }
      }
   }
}

