package com.yiTian.view.modules.newRolePan
{
   import com.ui.controls.Button;
   import com.ui.controls.MyTextField;
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.data.Data_lib;
   import com.yiTian.data.Enum_type_grid;
   import com.yiTian.data.vo.Vo_TianMing;
   import com.yiTian.data.vo.Vo_equip;
   import com.yiTian.data.vo.Vo_shuXingDan;
   import com.yiTian.data.vo.vo_otherRoleInfo;
   import com.yiTian.manager.LangConfig;
   import com.yiTian.manager.TipManager;
   import com.yiTian.manager.UIManager;
   import com.yiTian.net.message.cg.RoleCGMessage;
   import com.yiTian.scene.GameScene;
   import com.yiTian.utils.HtmlUtil;
   import com.yiTian.utils.SingleLoader;
   import com.yiTian.view.comp.View_Grid;
   import com.yiTian.view.modules.cast.baishiZengyi.TipMan;
   import com.yiTian.view.modules.marriage.VO_MarriageAttribute;
   import com.yiTian.view.modules.paihang.PaiHangVO;
   import com.yiTian.view.modules.role.Enum_role_equip;
   import com.yiTian.view.modules.shenBing.Vo_ShenBingAtb;
   import com.yiTian.view.modules.wuXing.Vo_wuXing;
   import com.yiTian.view.modules.wuXing.WuXingMter;
   import com.yiTian.view.modules.zhuanZhi.View_ZhuanZhiAtbSp;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flashx.textLayout.formats.TextAlign;
   
   public class PaiHangRolePan extends Sprite
   {
      
      private static var _rightX:int = 360;
      
      private static var isOnTaoZhuangMove:Boolean = false;
      
      public static var tianMingDataVec:Vector.<Vo_TianMing> = new Vector.<Vo_TianMing>();
      
      private static const MAX_GRID:int = 12;
      
      private var leftContainer:Sprite;
      
      private var properTyArr:Array = [{
         "x":47,
         "y":372
      },{
         "x":108,
         "y":374
      },{
         "x":163,
         "y":376
      },{
         "x":213,
         "y":375
      },{
         "x":274,
         "y":378
      }];
      
      private var urlStr:Array = ["BT_TianMingXiao_up","BT_TaoZhuangXiao_up","BT_WuXingXiao_up","BT_JingMai_Xiao_up","BT_BSZengYyiXiao_up"];
      
      private var shiLiComparePan:RightComPan;
      
      private var rother_rolepan:ROther_rolePan;
      
      private var nameTf:MyTextField;
      
      private var spVec:Vector.<Sprite> = new Vector.<Sprite>();
      
      public var isFirstOpen:Boolean = true;
      
      private var cbTf:MyTextField;
      
      private var bsTf:MyTextField;
      
      private var cbBtn:Button;
      
      private var bsBtn:Button;
      
      private var jobExtraAtbSp:View_ZhuanZhiAtbSp;
      
      private var shenBingAtbSp:ShenBingAtbIconSp;
      
      private var shuXingDanSp:ShuXingDanIcon;
      
      private var __paiHangRoleArr:Array = [];
      
      private var hlSP:ringSP;
      
      private var VoRole:vo_otherRoleInfo;
      
      private var tipShow:TipMan;
      
      private var playUn:PlayUnit;
      
      private var gridVec:Vector.<View_Grid> = new Vector.<View_Grid>();
      
      private var vec_Vo_equip_cache:Vector.<Vo_equip>;
      
      private var vecMerridian:Vector.<int> = new Vector.<int>();
      
      public function PaiHangRolePan()
      {
         super();
      }
      
      public function initUI2() : void
      {
         var i:int;
         var sp:Sprite = null;
         var pro:Object = null;
         var u:String = null;
         this.leftContainer = new Sprite();
         ComponentUtil.getScaleBitmap("Back1",[149,41,2,5],this.leftContainer,{
            "x":0,
            "y":0,
            "width":360,
            "height":480
         },Global.Img_Cdm);
         ComponentUtil.getBitmap("Title_Role",this.leftContainer,{
            "x":100,
            "y":5
         },Global.XJueSedm);
         ComponentUtil.getScaleBitmap("Back2",[5,5,10,10],this.leftContainer,{
            "x":23,
            "y":41,
            "width":314,
            "height":430
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back3",[4,4,1,1],this.leftContainer,{
            "x":26,
            "y":44,
            "width":308,
            "height":424
         },Global.Img_Cdm);
         ComponentUtil.getBitmap("BG_XRWu",this.leftContainer,{
            "x":72,
            "y":65
         },Global.XJueSedm);
         ComponentUtil.getScaleBitmap("Back_JSID",[75,3,1,1],this.leftContainer,{
            "x":110,
            "y":72,
            "width":146,
            "height":22
         },Global.XJueSedm);
         this.nameTf = ComponentUtil.getTextField("角色名字六个",this.leftContainer,{
            "x":122,
            "y":72,
            "color":15856113,
            "size":14,
            "leading":0,
            "realWidth":123,
            "align":TextAlign.CENTER
         });
         this.jobExtraAtbSp = new View_ZhuanZhiAtbSp();
         ComponentUtil.setPropertie(this.jobExtraAtbSp,{
            "x":97,
            "y":68
         });
         this.leftContainer.addChild(this.jobExtraAtbSp);
         this.shenBingAtbSp = new ShenBingAtbIconSp();
         this.shenBingAtbSp.x = 97;
         this.shenBingAtbSp.y = 110;
         this.leftContainer.addChild(this.shenBingAtbSp);
         this.shuXingDanSp = new ShuXingDanIcon();
         ComponentUtil.setPropertie(this.shuXingDanSp,{
            "x":237,
            "y":115
         });
         this.leftContainer.addChild(this.shuXingDanSp);
         this.hlSP = new ringSP();
         ComponentUtil.setPropertie(this.hlSP,{
            "x":237,
            "y":75
         });
         addChild(this.hlSP);
         ComponentUtil.getScaleBitmap("Back_RWGongNeng",[28,19,1,1],this.leftContainer,{
            "x":29,
            "y":363,
            "width":303,
            "height":104
         },Global.XJueSedm);
         this.cbTf = ComponentUtil.getTextField("被崇拜次数:0000",this.leftContainer,{
            "x":49,
            "y":420,
            "color":11904647,
            "size":12,
            "leading":0
         });
         this.bsTf = ComponentUtil.getTextField("被鄙视次数:0000",this.leftContainer,{
            "x":217,
            "y":420,
            "color":11904647,
            "size":12,
            "leading":0
         });
         this.cbBtn = ComponentUtil.getButton("崇拜一下","Button_Four",this.leftContainer,{
            "x":63,
            "y":438,
            "textColor":16771436
         },Global.Img_Cdm);
         this.bsBtn = ComponentUtil.getButton("鄙视一下","Button_Four",this.leftContainer,{
            "x":228,
            "y":438,
            "textColor":16771436
         },Global.Img_Cdm);
         this.cbBtn.callBack = function():void
         {
            RoleCGMessage.CG_PAIHANG_CLICK(VoRole.roleName,1);
         };
         this.bsBtn.callBack = function():void
         {
            RoleCGMessage.CG_PAIHANG_CLICK(VoRole.roleName,2);
         };
         i = 0;
         while(i < 5)
         {
            sp = new Sprite();
            ComponentUtil.getBitmap("BG_QuanXiao",this.leftContainer,{
               "x":45 + 56 * i,
               "y":373
            },Global.XJueSedm);
            this.leftContainer.addChild(sp);
            pro = this.properTyArr[i];
            ComponentUtil.setPropertie(sp,pro);
            u = this.urlStr[i];
            ComponentUtil.getBitmap(u,sp,{
               "x":0,
               "y":0
            },Global.XJueSedm);
            if(i == 1)
            {
               sp.tabIndex = 101;
               sp.addEventListener(MouseEvent.MOUSE_OVER,function(e:MouseEvent):void
               {
                  isOnTaoZhuangMove = true;
                  GameScene.upUILayer.addChild(UIManager.rolePanel.tip);
                  dispatchEvent(new MouseEvent(MouseEvent.MOUSE_MOVE));
               });
               sp.addEventListener(MouseEvent.MOUSE_OUT,function(e:MouseEvent):void
               {
                  isOnTaoZhuangMove = false;
                  if(GameScene.upUILayer.contains(UIManager.rolePanel.tip))
                  {
                     GameScene.upUILayer.removeChild(UIManager.rolePanel.tip);
                  }
               });
               sp.addEventListener(MouseEvent.MOUSE_MOVE,function(e:MouseEvent):void
               {
                  if(isOnTaoZhuangMove)
                  {
                     PaiHangRoleMter.onMouseMove(e.target);
                  }
               });
            }
            else
            {
               sp.tabIndex = i + 1;
               sp.addEventListener(MouseEvent.MOUSE_OVER,function(e:MouseEvent):void
               {
                  switch(e.target.tabIndex)
                  {
                     case 1:
                        break;
                     case 4:
                        showMerriDian(e.target as DisplayObject);
                  }
               });
               sp.addEventListener(MouseEvent.MOUSE_OUT,function(e:MouseEvent):void
               {
               });
            }
            this.spVec.push(sp);
            i++;
         }
         this.playUn = new PlayUnit(this.leftContainer,191,298,"other");
         this.initGrid();
         this.shiLiComparePan = new RightComPan();
         addChild(this.shiLiComparePan);
         this.shiLiComparePan.visible = false;
         ComponentUtil.setPropertie(this.shiLiComparePan,{"x":_rightX});
         this.rother_rolepan = new ROther_rolePan();
         addChild(this.rother_rolepan);
         ComponentUtil.setPropertie(this.rother_rolepan,{"x":_rightX});
         addChild(this.leftContainer);
      }
      
      public function open(str:String, _index:int) : void
      {
         var tipstr:String = LangConfig.getWord("60487",6) + _index + LangConfig.getWord("60488",6);
         switch(PaiHangVO.CBvalue.toString().length)
         {
            case 1:
               this.cbTf.htmlText = "被崇拜次数:000" + PaiHangVO.CBvalue.toString();
               break;
            case 2:
               this.cbTf.htmlText = "被崇拜次数:00" + PaiHangVO.CBvalue.toString();
               break;
            case 3:
               this.cbTf.htmlText = "被崇拜次数:0" + PaiHangVO.CBvalue.toString();
               break;
            default:
               this.cbTf.htmlText = "被崇拜次数:" + PaiHangVO.CBvalue.toString();
         }
         switch(PaiHangVO.BSvalue.toString().length)
         {
            case 1:
               this.bsTf.htmlText = "被鄙视次数:000" + PaiHangVO.BSvalue.toString();
               break;
            case 2:
               this.bsTf.htmlText = "被鄙视次数:00" + PaiHangVO.BSvalue.toString();
               break;
            case 3:
               this.bsTf.htmlText = "被鄙视次数:0" + PaiHangVO.BSvalue.toString();
               break;
            default:
               this.bsTf.htmlText = "被鄙视次数:" + PaiHangVO.BSvalue.toString();
         }
         if(PaiHangVO.isButton == 1)
         {
            this.cbBtn.enabled = true;
            this.bsBtn.enabled = true;
         }
         else if(PaiHangVO.isButton == 2)
         {
            this.cbBtn.enabled = false;
            this.bsBtn.enabled = false;
         }
         TipManager.bind(this.cbBtn,tipstr);
         TipManager.bind(this.bsBtn,tipstr);
         switch(PaiHangVO.wuHun)
         {
            case 0:
               this.nameTf.htmlText = str;
               break;
            case 1:
               this.nameTf.htmlText = "<font color =\'#ADFF2F\'>" + str + LangConfig.getWord("60490",6) + "</font>";
               break;
            case 2:
               this.nameTf.htmlText = "<font color =\'#8EE5EE\'>" + str + LangConfig.getWord("60490",6) + "</font>";
               break;
            case 3:
               this.nameTf.htmlText = "<font color =\'#FF00FF\'>" + str + LangConfig.getWord("60490",6) + "</font>";
         }
      }
      
      public function updateJobIdx(v:uint) : void
      {
         this.jobExtraAtbSp.enableLoad();
         this.jobExtraAtbSp.setJob(v);
      }
      
      public function updateShenBing(v:Vo_ShenBingAtb) : void
      {
         this.shenBingAtbSp.init();
         this.shenBingAtbSp.vo = v;
      }
      
      public function updateShuXingDan(v:Vo_shuXingDan) : void
      {
         this.shuXingDanSp.vo = v;
      }
      
      public function showData(_vec_Vo_equip_cache:Vector.<Vo_equip>, dataArr:Array) : void
      {
         this.vec_Vo_equip_cache = _vec_Vo_equip_cache;
         this.__paiHangRoleArr = dataArr;
         if(this.isFirstOpen)
         {
            if(!Global.XJueSedm)
            {
               SingleLoader.add("lang/ch/XJueSe.swf",function(info:Object):void
               {
                  Global.XJueSedm = info.applicationDomain;
                  initUI2();
                  showMessage();
               });
            }
            else
            {
               this.initUI2();
               this.showMessage();
            }
            this.isFirstOpen = false;
         }
         else
         {
            this.showMessage();
         }
      }
      
      public function updateRing(ringID:int, qmd:int, cpl_other_name:String = "夫妻另一方") : void
      {
         this.hlSP.isAutoLoad = true;
         this.hlSP.visible = ringID > 0;
         if(ringID <= 0)
         {
            return;
         }
         var vo:VO_MarriageAttribute = new VO_MarriageAttribute();
         vo.ringId = ringID;
         vo.qmd = qmd;
         vo.sex = this.VoRole.roleSex;
         vo.coupleName = cpl_other_name;
         this.hlSP.setInfo(vo);
         setChildIndex(this.hlSP,numChildren - 1);
      }
      
      private function showMessage() : void
      {
         var voR:vo_otherRoleInfo = new vo_otherRoleInfo();
         this.initRoleMessage(voR,this.__paiHangRoleArr);
         this.VoRole = voR;
         PaiHangRoleMter.strengthenSet(voR.levelTen,voR.levelSix,voR.levelSixNums,voR.level,voR.nums);
         this.update(voR);
      }
      
      private function initRoleMessage(otherRoleVo:vo_otherRoleInfo, _arr:Array) : void
      {
         var _gp:int = 0;
         var Len:int = _arr.length - 2;
         if(!(_arr[5] is Array))
         {
            _gp = 1;
         }
         else
         {
            _gp = 0;
         }
         otherRoleVo.roleName = _arr[1];
         otherRoleVo.roleLevel = _arr[4];
         otherRoleVo.roleJob = _arr[2];
         otherRoleVo.roleSex = _arr[6 + _gp];
         otherRoleVo.roleShengWang = _arr[Len - 2][0];
         otherRoleVo.tili = _arr[Len - 2][1];
         otherRoleVo.maxHp = _arr[Len - 2][2];
         otherRoleVo.maxMp = _arr[Len - 2][3];
         otherRoleVo.physAtt = _arr[Len - 2][4];
         otherRoleVo.physDef = _arr[Len - 2][5];
         otherRoleVo.shot = _arr[Len - 2][6];
         otherRoleVo.escape = _arr[Len - 2][7];
         otherRoleVo.critical = _arr[Len - 2][8];
         otherRoleVo.repel = _arr[Len - 2][9];
         otherRoleVo.attSpeed = _arr[Len - 2][10];
         otherRoleVo.critHeat = _arr[Len - 2][11];
         otherRoleVo.strength = _arr[Len - 2][12];
         otherRoleVo.roleId = _arr[Len - 2][13];
         otherRoleVo.rolePartyName = _arr[Len - 2][14];
         otherRoleVo.shenBingVo = _arr[Len];
         otherRoleVo.shuXingDan = _arr[Len + 1];
         otherRoleVo.ringId = _arr[Len - 5][0];
         otherRoleVo.qinmiDu = _arr[Len - 5][1];
         otherRoleVo.couple_other_name = _arr[Len - 5][2];
         otherRoleVo.equipArr = _arr[5 + _gp];
         otherRoleVo.stoneLvl = _arr[Len - 4];
         otherRoleVo.isOnLine = _arr[Len - 3][0];
         otherRoleVo._voVec = _arr[Len - 3][1];
         otherRoleVo.levelTen = _arr[Len - 3][2];
         otherRoleVo.levelSix = _arr[Len - 3][3];
         otherRoleVo.levelSixNums = _arr[Len - 3][4];
         otherRoleVo.level = _arr[Len - 3][5];
         otherRoleVo.nums = _arr[Len - 3][6];
         otherRoleVo.vec = _arr[Len - 3][7];
         otherRoleVo.body = _arr[Len - 3][8];
         otherRoleVo.weapon = _arr[Len - 3][9];
         otherRoleVo.horse = _arr[Len - 3][10];
         otherRoleVo.dataArr = _arr[Len - 3][11];
         otherRoleVo.chengHao = _arr[Len - 3][12];
         otherRoleVo.wing = _arr[Len - 3][13];
      }
      
      private function showMerriDian(e:DisplayObject) : void
      {
         var st:String = null;
         var addS:String = null;
         var _arr:Array = null;
         var sd:String = null;
         var sst:String = "当前经脉\n";
         var i:int = 0;
         while(i < this.vecMerridian.length)
         {
            st = Data_lib.meridian[this.vecMerridian[i]][0] + "：";
            addS = Data_lib.meridian[this.vecMerridian[i]][11];
            _arr = addS.split("：");
            sd = HtmlUtil.font(st + Data_lib.meridian[this.vecMerridian[i]][2] + "级当前效果：","#f9ff00") + HtmlUtil.font(_arr[1],"#04ff00") + "\n";
            sst += sd;
            i++;
         }
         TipManager.bind(e,sst);
      }
      
      private function initGrid() : void
      {
         var g:View_Grid = null;
         var proper:Object = null;
         var i:int = 0;
         while(i < 12)
         {
            g = new View_Grid();
            g.set_bmp_bg();
            g.set_bmp_over();
            g.type = Enum_type_grid.ROLE_PAIHANG;
            g.set_tf_info(HtmlUtil.font(Enum_role_equip.TXT[i],"#d5d57e"));
            this.leftContainer.addChild(g);
            if(i == 11)
            {
               g.visible = false;
            }
            proper = RoleMter.propertysArr[i];
            ComponentUtil.setPropertie(g,{
               "x":proper.x,
               "y":proper.y
            });
            this.gridVec.push(g);
            i++;
         }
      }
      
      override public function set visible(value:Boolean) : void
      {
         super.visible = value;
         if(value)
         {
            this.hlSP.isAutoLoad = true;
            this.jobExtraAtbSp.enableLoad();
            this.changeView(1);
            this.leftContainer.visible = true;
         }
         else
         {
            this.leftContainer.visible = false;
         }
      }
      
      public function set isShow(value:Boolean) : void
      {
         super.visible = value;
      }
      
      private function showEquip() : void
      {
         var i:int = 0;
         while(i < this.gridVec.length)
         {
            this.gridVec[i].vo = this.vec_Vo_equip_cache[i];
            i++;
         }
      }
      
      public function update(otherRoleVo:vo_otherRoleInfo) : void
      {
         if(!visible)
         {
            this.visible = true;
         }
         this.vec_Vo_equip_cache = this.get_role_vec_equip(otherRoleVo.equipArr);
         this.showEquip();
         this.updateWuXingTip(otherRoleVo.dataArr);
         this.updateRing(otherRoleVo.ringId,otherRoleVo.qinmiDu,otherRoleVo.couple_other_name);
         this.updateJobIdx(otherRoleVo.roleJob);
         this.updateBind();
         OtherRoleMter.party = otherRoleVo.rolePartyName;
         OtherRoleMter.prestige = otherRoleVo.roleShengWang;
         OtherRoleMter.vigor = otherRoleVo.tili;
         OtherRoleMter.hpMax = otherRoleVo.maxHp;
         OtherRoleMter.mpMax = otherRoleVo.maxMp;
         OtherRoleMter.minAtt = otherRoleVo.physAtt;
         OtherRoleMter.def = otherRoleVo.physDef;
         OtherRoleMter.attRate = otherRoleVo.shot;
         OtherRoleMter.dod = otherRoleVo.escape;
         OtherRoleMter.crit = otherRoleVo.critical;
         OtherRoleMter.repelv = otherRoleVo.repel;
         OtherRoleMter.attSpeed = otherRoleVo.attSpeed;
         OtherRoleMter.critv = otherRoleVo.critHeat;
         OtherRoleMter.level = otherRoleVo.roleLevel;
         OtherRoleMter.job = otherRoleVo.roleJob;
         this.vecMerridian = otherRoleVo.vec;
         this.nameTf.htmlText = otherRoleVo.roleName;
         this.rother_rolepan.update(otherRoleVo);
         this.shiLiComparePan.update(otherRoleVo);
         this.shiLiComparePan.visible = false;
         this.updateShenBing(otherRoleVo.shenBingVo);
         this.updateShuXingDan(otherRoleVo.shuXingDan);
         this.rother_rolepan.visible = true;
         this.playUn.playImg(otherRoleVo.horse,otherRoleVo.weapon,otherRoleVo.roleSex,otherRoleVo.body,otherRoleVo.roleJob,otherRoleVo.wing);
         if(!this.tipShow)
         {
            this.tipShow = new TipMan();
         }
         if(otherRoleVo.roleLevel < 40)
         {
            this.tipShow.bind(this.spVec[4],"还没开启",false);
         }
         else
         {
            this.tipShow.bind(this.spVec[4],otherRoleVo.stoneLvl,true);
         }
      }
      
      private function updateWuXingTip(__arr:Array) : void
      {
         var _totalLeiJiWorth:int = 0;
         var _vo:Vo_wuXing = null;
         var _sid:int = 0;
         var _leiJiWorth:int = 0;
         var _addTypeStr:String = null;
         var s:String = null;
         var ss:String = null;
         var singAdd:String = "";
         var i:int = 0;
         while(i < __arr.length)
         {
            _vo = new Vo_wuXing();
            _sid = int(__arr[i][0]);
            _vo.initLib(_sid);
            _leiJiWorth = int(__arr[i][2]);
            _addTypeStr = _vo.addTypeStr;
            _totalLeiJiWorth += _leiJiWorth;
            s = RoleMter.dataStrArr[i];
            ss = HtmlUtil.font(s.replace("{0}",_vo.xiuXingWorthLv).replace("{1}",HtmlUtil.font(_addTypeStr,"#04ff00")) + "\n","#f9ff00");
            singAdd += ss;
            i++;
         }
         var layers:int = WuXingMter.getChongShuWorth(_totalLeiJiWorth);
         var _lv:int = int(Data_lib.Wuxing_s[layers][0]);
         var addS:String = Data_lib.Wuxing_s[layers][2];
         var chongStr:String = "当前五行修炼第" + _lv + "重\n";
         var extralStr:String = HtmlUtil.font("五行全属性额外增加：","#f9ff00") + HtmlUtil.font(addS,"#04ff00");
         TipManager.bind(this.spVec[2],"五行属性：\n" + singAdd + chongStr + extralStr);
      }
      
      private function updateBind() : void
      {
         var _voTM:Vo_TianMing = null;
         var strName:String = null;
         var level:int = 0;
         var typeRl:int = 0;
         var typeLeve:String = null;
         var strAdd:String = null;
         var matchStr:String = null;
         var startStr:String = "天命属性：\n";
         var i:int = 0;
         while(i < this.VoRole._voVec.length)
         {
            _voTM = this.VoRole._voVec[i];
            if(_voTM.value != 0)
            {
               strName = _voTM.str_name;
               level = _voTM.level;
               typeRl = _voTM.type_result;
               typeLeve = strName + "Lv." + level;
               strAdd = HtmlUtil.font(" 增加" + Data_lib.attribute[typeRl][0],"#f9ff00") + HtmlUtil.font("+" + _voTM.value,"#04ff00");
               matchStr = typeLeve + strAdd + "\n";
               startStr += matchStr;
            }
            i++;
         }
         if(startStr.length < 8)
         {
            startStr = "天命属性：无\n";
         }
         TipManager.bind(this.spVec[0],startStr);
      }
      
      private function get_role_vec_equip(equips:Array) : Vector.<Vo_equip>
      {
         var equip_t:Vo_equip = null;
         var vec_equip:Vector.<Vo_equip> = new Vector.<Vo_equip>(MAX_GRID,true);
         var i:int = 0;
         while(i < equips.length)
         {
            equip_t = new Vo_equip();
            equip_t.Init_sever_bag(equips[i]);
            equip_t.bDress = true;
            if(equip_t.gridId != 13)
            {
               vec_equip[equip_t.gridId - 1] = equip_t;
            }
            i++;
         }
         return vec_equip;
      }
      
      private function reset() : void
      {
         this.shiLiComparePan.visible = false;
         this.leftContainer.visible = false;
      }
      
      public function changeView(_type:int) : void
      {
         this.reset();
         this.leftContainer.visible = true;
         if(_type == 1)
         {
            this.rother_rolepan.visible = true;
         }
         else if(_type == 2)
         {
            this.shiLiComparePan.visible = true;
         }
      }
   }
}

import com.yiTian.manager.TipManager;
import com.yiTian.utils.Utils;
import com.yiTian.view.modules.marriage.MarriageGetWord;
import com.yiTian.view.modules.marriage.VO_MarriageAttribute;
import flash.display.Bitmap;
import flash.display.Sprite;
import flash.events.MouseEvent;
import flash.filters.GlowFilter;

class ringSP extends Sprite
{
   
   private var bm_icon:Bitmap;
   
   private var qinmiLv:int;
   
   private var _vo:VO_MarriageAttribute;
   
   private var bm_url:String = "";
   
   private var _isAutoLoad:Boolean = false;
   
   public function ringSP()
   {
      super();
      this.bm_icon = new Bitmap();
      addChild(this.bm_icon);
   }
   
   public function setInfo(vo:VO_MarriageAttribute) : void
   {
      var rId:int = vo.ringId;
      var qmd:int = vo.qmd;
      this._vo = vo;
      var lv:int = rId - 46440;
      this.qinmiLv = MarriageGetWord.getQMDIndex(qmd);
      this._vo.qmdLv = this.qinmiLv;
      addEventListener(MouseEvent.ROLL_OVER,this.rollOverHd);
      addEventListener(MouseEvent.ROLL_OUT,this.rollOutHd);
      var effLv:int = this.qinmiLv / 2;
      var effArr:Array = [16777215,65280,54783,16711935,16744192];
      if(effArr[effLv] > 0)
      {
         filters = [new GlowFilter(effArr[effLv],0.8,25,25,2,1)];
      }
      this.bm_url = "resource/image/ringBM/lv" + lv.toString() + ".png";
      if(this._isAutoLoad)
      {
         Utils.getLoadBitmap(this.bm_url,this.bm_icon);
         this.bm_url = "";
      }
   }
   
   private function rollOverHd(evt:MouseEvent) : void
   {
      TipManager.update(this._vo);
   }
   
   private function rollOutHd(evt:MouseEvent) : void
   {
      TipManager.hide();
   }
   
   public function set isAutoLoad(b:Boolean) : void
   {
      if(!this._isAutoLoad && b && this.bm_url != "")
      {
         Utils.getLoadBitmap(this.bm_url,this.bm_icon);
         this.bm_url = "";
      }
      this._isAutoLoad = b;
   }
}
