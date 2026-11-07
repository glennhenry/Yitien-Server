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
   import com.yiTian.net.message.cg.PaiHangCGMessage;
   import com.yiTian.net.message.cg.RoleCGMessage;
   import com.yiTian.scene.GameScene;
   import com.yiTian.utils.HtmlUtil;
   import com.yiTian.view.Panel123;
   import com.yiTian.view.comp.View_Grid;
   import com.yiTian.view.modules.cast.baishiZengyi.TipMan;
   import com.yiTian.view.modules.marriage.VO_MarriageAttribute;
   import com.yiTian.view.modules.paihang.PaiHangVO;
   import com.yiTian.view.modules.role.Enum_role_equip;
   import com.yiTian.view.modules.shenBing.Vo_ShenBingAtb;
   import com.yiTian.view.modules.wuXing.Vo_wuXing;
   import com.yiTian.view.modules.wuXing.WuXingMter;
   import com.yiTian.view.modules.zhuanZhi.View_ZhuanZhiAtbSp;
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   import flashx.textLayout.formats.TextAlign;
   
   public class ComparePan extends Panel123
   {
      
      private static var _rightX:int = 360;
      
      private static var isOnTaoZhuangMove:Boolean = false;
      
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
      
      private var bstf:MyTextField;
      
      private var cbTf:MyTextField;
      
      private var CBButton:Button;
      
      private var BSButton:Button;
      
      private var titleBM:Bitmap;
      
      private var jobExtraAtbSp:View_ZhuanZhiAtbSp;
      
      private var _shenBingAtbSp:ShenBingAtbIconSp;
      
      private var _shuXingDanSp:ShuXingDanIcon;
      
      private var hlSP:ringSP;
      
      private var tipShow:TipMan;
      
      private var playUn:PlayUnit;
      
      private var gridVec:Vector.<View_Grid> = new Vector.<View_Grid>();
      
      private var vec_Vo_equip_cache:Vector.<Vo_equip>;
      
      private var vecMerridian:Vector.<int> = new Vector.<int>();
      
      private var __otherRoleVO:vo_otherRoleInfo;
      
      private var vecTitle:Vector.<String> = new <String>["Title_DengJi","Title_ZhanLi","Title_CaiFu","Title_JingJi","Title_RoleInf"];
      
      private var _diaoXiangType:int = -1;
      
      public function ComparePan()
      {
         super();
         regResource("lang/ch/XJueSe.swf","XJueSedm");
      }
      
      override protected function initUI2() : void
      {
         var i:int;
         var sp:Sprite = null;
         var pro:Object = null;
         var u:String = null;
         _tmpParent = GameScene.sysLayer;
         this.leftContainer = new Sprite();
         ComponentUtil.getScaleBitmap("Back1",[149,41,2,5],this.leftContainer,{
            "x":0,
            "y":0,
            "width":360,
            "height":480
         },Global.Img_Cdm);
         this.titleBM = ComponentUtil.getBitmap("Title_Role",this.leftContainer,{
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
            "x":86,
            "y":66
         });
         this.leftContainer.addChild(this.jobExtraAtbSp);
         this._shenBingAtbSp = new ShenBingAtbIconSp();
         this._shenBingAtbSp.visible = false;
         ComponentUtil.setPropertie(this._shenBingAtbSp,{
            "x":86,
            "y":98
         });
         this.leftContainer.addChild(this._shenBingAtbSp);
         this._shuXingDanSp = new ShuXingDanIcon();
         this._shuXingDanSp.vo = new Vo_shuXingDan();
         ComponentUtil.setPropertie(this._shuXingDanSp,{
            "x":237,
            "y":110
         });
         this.leftContainer.addChild(this._shuXingDanSp);
         this.hlSP = new ringSP();
         ComponentUtil.setPropertie(this.hlSP,{
            "x":237,
            "y":75
         });
         this.leftContainer.addChild(this.hlSP);
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
         this.bstf = ComponentUtil.getTextField("被鄙视次数:0000",this.leftContainer,{
            "x":217,
            "y":420,
            "color":11904647,
            "size":12,
            "leading":0
         });
         this.CBButton = ComponentUtil.getButton("崇拜","Button_Four",this.leftContainer,{
            "x":63,
            "y":438,
            "textColor":16771436
         },Global.Img_Cdm);
         this.CBButton.callBack = function():void
         {
            RoleCGMessage.CG_BUTTON_CBBS(__otherRoleVO.roleName,1);
         };
         this.BSButton = ComponentUtil.getButton("鄙视","Button_Four",this.leftContainer,{
            "x":228,
            "y":438,
            "textColor":16771436
         },Global.Img_Cdm);
         this.BSButton.callBack = function():void
         {
            RoleCGMessage.CG_BUTTON_CBBS(__otherRoleVO.roleName,2);
         };
         CloseButton = ComponentUtil.getButton("","Button_Close",this.leftContainer,{
            "x":323,
            "y":6,
            "textColor":16771436
         },Global.Img_Cdm);
         initDynamicView();
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
                     OtherRoleMter.onMouseMove(e.target);
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
         ComponentUtil.setPropertie(this.shiLiComparePan,{"x":_rightX});
         this.rother_rolepan = new ROther_rolePan();
         addChild(this.rother_rolepan);
         ComponentUtil.setPropertie(this.rother_rolepan,{"x":_rightX});
         addChild(this.leftContainer);
         move = new Rectangle(0,0,323,38);
      }
      
      public function updateJobIdx(v:uint) : void
      {
         this.jobExtraAtbSp.setJob(v);
      }
      
      public function updateShenBing(v:Vo_ShenBingAtb) : void
      {
         this._shenBingAtbSp.vo = v;
      }
      
      public function updateShuXingDan(v:Vo_shuXingDan) : void
      {
         this._shuXingDanSp.vo = v;
      }
      
      public function updateRing(ringID:int, qmd:int, cpl_otherName:String) : void
      {
         this.hlSP.visible = ringID > 0;
         if(ringID <= 0)
         {
            return;
         }
         var vo:VO_MarriageAttribute = new VO_MarriageAttribute();
         vo.ringId = ringID;
         vo.qmd = qmd;
         vo.sex = this.__otherRoleVO.roleSex;
         vo.coupleName = cpl_otherName;
         this.hlSP.setInfo(vo);
      }
      
      public function updateCBBS(cbValue:int, bsValue:int, isBtn:int, __index:int) : void
      {
         switch(cbValue.toString().length)
         {
            case 1:
               this.cbTf.htmlText = "被崇拜次数:000" + cbValue.toString();
               break;
            case 2:
               this.cbTf.htmlText = "被崇拜次数:00" + cbValue.toString();
               break;
            case 3:
               this.cbTf.htmlText = "被崇拜次数:0" + cbValue.toString();
               break;
            default:
               this.cbTf.htmlText = "被崇拜次数:" + cbValue.toString();
         }
         switch(bsValue.toString().length)
         {
            case 1:
               this.bstf.htmlText = "被鄙视次数:000" + bsValue.toString();
               break;
            case 2:
               this.bstf.htmlText = "被鄙视次数:00" + bsValue.toString();
               break;
            case 3:
               this.bstf.htmlText = "被鄙视次数:0" + bsValue.toString();
               break;
            default:
               this.bstf.htmlText = "被鄙视次数:" + bsValue.toString();
         }
         if(isBtn == 1)
         {
            this.CBButton.enabled = true;
            this.BSButton.enabled = true;
         }
         else if(isBtn == 2)
         {
            this.CBButton.enabled = false;
            this.BSButton.enabled = false;
         }
         var tipstr:String = LangConfig.getWord("60487",6) + __index + LangConfig.getWord("60488",6);
         TipManager.bind(this.CBButton,tipstr);
         TipManager.bind(this.BSButton,tipstr);
      }
      
      public function getEuqipSingle(enum_pos:int) : Vo_equip
      {
         if(Boolean(this.gridVec[enum_pos].vo))
         {
            return this.gridVec[enum_pos].vo as Vo_equip;
         }
         return null;
      }
      
      public function get gridV() : Vector.<View_Grid>
      {
         return this.gridVec;
      }
      
      public function initPan() : void
      {
         this.initUI2();
         preFun();
      }
      
      private function showMerriDian(e:DisplayObject) : void
      {
         var st:String = null;
         var addS:String = null;
         var _arr:Array = null;
         var sd:String = null;
         var sst:String = "当前经脉\n";
         if(!this.vecMerridian)
         {
            return;
         }
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
            g.type = Enum_type_grid.ROLE_EQUIP_OTHER;
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
            this._shenBingAtbSp.init();
            this.changeView(1);
            this.leftContainer.visible = true;
         }
         else
         {
            this._diaoXiangType = -1;
            this.leftContainer.visible = false;
         }
      }
      
      public function get vec_voEequip_cache() : Vector.<Vo_equip>
      {
         return this.vec_Vo_equip_cache;
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
         this.__otherRoleVO = otherRoleVo;
         this.vec_Vo_equip_cache = this.get_role_vec_equip(otherRoleVo.equipArr);
         this.showEquip();
         this.updateBind();
         this.updateWuXingTip(otherRoleVo.dataArr);
         this.updateMerridian(otherRoleVo);
         this.updateRing(otherRoleVo.ringId,otherRoleVo.qinmiDu,otherRoleVo.couple_other_name);
         this.updateJobIdx(otherRoleVo.roleJob);
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
         this.rother_rolepan.visible = true;
         this.tipShow = TipMan.instance;
         if(otherRoleVo.roleLevel < 40)
         {
            this.tipShow.bind(this.spVec[4],"还没开启",false);
         }
         else
         {
            this.tipShow.bind(this.spVec[4],otherRoleVo.stoneLvl,true);
         }
         this.playUn.playImg(otherRoleVo.horse,otherRoleVo.weapon,otherRoleVo.roleSex,otherRoleVo.body,otherRoleVo.roleJob,otherRoleVo.wing);
         PaiHangCGMessage.CG_REQUEST_SHENBINGINFO(otherRoleVo.roleId,1);
         PaiHangCGMessage.CG_ASK_SHUXINGDANINFO(otherRoleVo.roleId);
      }
      
      private function updateMerridian(otherRoleVo:vo_otherRoleInfo) : void
      {
         OtherRoleMter.strengthenSet(otherRoleVo.levelTen,otherRoleVo.levelSix,otherRoleVo.levelSixNums,otherRoleVo.level,otherRoleVo.nums);
      }
      
      public function updateWuXingTip(__arr:Array) : void
      {
         var _totalLeiJiWorth:int = 0;
         var _vo:Vo_wuXing = null;
         var _sid:int = 0;
         var _addTypeStr:String = null;
         var _leiJiWorth:int = 0;
         var s:String = null;
         var ss:String = null;
         if(!__arr || !__arr.length)
         {
            return;
         }
         var singAdd:String = "";
         var i:int = 0;
         while(i < __arr.length)
         {
            _vo = new Vo_wuXing();
            _sid = int(__arr[i][0]);
            _vo.initLib(_sid);
            _addTypeStr = _vo.addTypeStr;
            _leiJiWorth = int(__arr[i][2]);
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
      
      public function updateBind() : void
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
         while(i < RoleMter.tianMingDataVecOther.length)
         {
            _voTM = RoleMter.tianMingDataVecOther[i];
            if(_voTM.value != 0)
            {
               strName = _voTM.str_name;
               level = _voTM.level;
               typeRl = _voTM.type_result;
               typeLeve = HtmlUtil.font(strName + "Lv." + level,"#f9ff00");
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
      
      public function showTitle(diaoXiangType:int = -1) : void
      {
         this._diaoXiangType = diaoXiangType;
         if(this._diaoXiangType == -1)
         {
            this.titleBM.bitmapData = ComponentUtil.getBitmapData("Title_Role",Global.XJueSedm);
         }
         else
         {
            this.titleBM.bitmapData = ComponentUtil.getBitmapData(this.vecTitle[Boolean(this._diaoXiangType) ? this._diaoXiangType - this._diaoXiangType / 2 : this._diaoXiangType],Global.XJueSedm);
         }
      }
      
      public function addMess(_arr1:Array, _arr2:Array) : void
      {
         trace(_arr1,_arr2);
         if(!this.__otherRoleVO)
         {
            this.__otherRoleVO = new vo_otherRoleInfo();
         }
         this.__otherRoleVO.isOnLine = _arr1[0];
         this.__otherRoleVO._voVec = _arr1[1];
         this.__otherRoleVO.levelTen = _arr1[2];
         this.__otherRoleVO.levelSix = _arr1[3];
         this.__otherRoleVO.levelSixNums = _arr1[4];
         this.__otherRoleVO.level = _arr1[5];
         this.__otherRoleVO.nums = _arr1[6];
         this.__otherRoleVO.vec = _arr1[7];
         this.__otherRoleVO.body = _arr1[8];
         this.__otherRoleVO.weapon = _arr1[9];
         this.__otherRoleVO.horse = _arr1[10];
         this.__otherRoleVO.dataArr = _arr1[11];
         this.__otherRoleVO.chengHao = _arr1[12];
         this.__otherRoleVO.wing = _arr1[13];
         this.__otherRoleVO.roleShengWang = _arr2[0];
         this.__otherRoleVO.tili = _arr2[1];
         this.__otherRoleVO.maxHp = _arr2[2];
         this.__otherRoleVO.maxMp = _arr2[3];
         this.__otherRoleVO.physAtt = _arr2[4];
         this.__otherRoleVO.physDef = _arr2[5];
         this.__otherRoleVO.shot = _arr2[6];
         this.__otherRoleVO.escape = _arr2[7];
         this.__otherRoleVO.critical = _arr2[8];
         this.__otherRoleVO.repel = _arr2[9];
         this.__otherRoleVO.attSpeed = _arr2[10];
         this.__otherRoleVO.critHeat = _arr2[11];
         this.__otherRoleVO.strength = _arr2[12];
         this.__otherRoleVO.rolePartyName = PaiHangVO.bangPai;
         this.vecMerridian = this.__otherRoleVO.vec;
         OtherRoleMter.prestige = this.__otherRoleVO.roleShengWang;
         OtherRoleMter.vigor = this.__otherRoleVO.tili;
         OtherRoleMter.hpMax = this.__otherRoleVO.maxHp;
         OtherRoleMter.mpMax = this.__otherRoleVO.maxMp;
         OtherRoleMter.minAtt = this.__otherRoleVO.physAtt;
         OtherRoleMter.def = this.__otherRoleVO.physDef;
         OtherRoleMter.attRate = this.__otherRoleVO.shot;
         OtherRoleMter.dod = this.__otherRoleVO.escape;
         OtherRoleMter.crit = this.__otherRoleVO.critical;
         OtherRoleMter.repelv = this.__otherRoleVO.repel;
         OtherRoleMter.attSpeed = this.__otherRoleVO.attSpeed;
         OtherRoleMter.critv = this.__otherRoleVO.critHeat;
         OtherRoleMter.party = this.__otherRoleVO.rolePartyName;
         this.updateBind();
         this.updateWuXingTip(this.__otherRoleVO.dataArr);
         this.updateMerridian(this.__otherRoleVO);
         this.rother_rolepan.update(this.__otherRoleVO);
         this.shiLiComparePan.update(this.__otherRoleVO);
         this.updateRing(this.__otherRoleVO.ringId,this.__otherRoleVO.qinmiDu,this.__otherRoleVO.couple_other_name);
         this.updateJobIdx(this.__otherRoleVO.roleJob);
         this.playUn.playImg(this.__otherRoleVO.horse,this.__otherRoleVO.weapon,this.__otherRoleVO.roleSex,this.__otherRoleVO.body,this.__otherRoleVO.roleJob,this.__otherRoleVO.wing);
         this.tipShow = TipMan.instance;
         if(this.__otherRoleVO.roleLevel < 40)
         {
            this.tipShow.bind(this.spVec[4],"还没开启",false);
         }
         else
         {
            this.tipShow.bind(this.spVec[4],this.__otherRoleVO.stoneLvl,true);
         }
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
