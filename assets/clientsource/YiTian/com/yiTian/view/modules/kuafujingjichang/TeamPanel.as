package com.yiTian.view.modules.kuafujingjichang
{
   import com.ui.controls.Button;
   import com.ui.controls.CheckBox;
   import com.ui.controls.MyTextField;
   import com.ui.controls.ScaleBitmap;
   import com.utils.ComponentUtil;
   import com.utils.Util;
   import com.yiTian.Global;
   import com.yiTian.command.Enum_MsgType;
   import com.yiTian.data.Data_lib;
   import com.yiTian.data.Enum_type_grid;
   import com.yiTian.data.config.Enum_job;
   import com.yiTian.data.config.valuable.Enum_filter;
   import com.yiTian.data.model.Model_KuaFuJingJiChang;
   import com.yiTian.gameUnit.magic.Effect;
   import com.yiTian.manager.CommandManager;
   import com.yiTian.manager.EffectManager;
   import com.yiTian.manager.GameUnitManager;
   import com.yiTian.manager.LangConfig;
   import com.yiTian.manager.ModalUIManager;
   import com.yiTian.manager.TipManager;
   import com.yiTian.manager.UIManager;
   import com.yiTian.net.message.cg.KuaFuJingJiChangCGMessage;
   import com.yiTian.scene.GameScene;
   import com.yiTian.utils.Utils;
   import com.yiTian.view.Panel123;
   import com.yiTian.view.modules.kuafujingjichang.extralDill.Model_DRKF;
   import com.yiTian.view.modules.pet.PetPanel;
   import com.yiTian.view.modules.pet.PetVO;
   import com.yiTian.view.modules.playerExtend.View_PlayerExtendPanel;
   import com.yiTian.view.modules.tianTi.Child_tianTiUnit;
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   
   public class TeamPanel extends Panel123
   {
      
      private static var _instance:TeamPanel;
      
      private var back:ScaleBitmap;
      
      private var teamItem:TeamItem;
      
      private var teamItem2:TeamItem;
      
      private var teamItem3:TeamItem;
      
      public var itemArr:Array;
      
      private var itArr:Array = new Array();
      
      private var teamSprite:Sprite;
      
      private var zhenXingBtn:Button;
      
      private var roomname:MyTextField;
      
      private var leaveBtn:Button;
      
      public var starBtn:Button;
      
      public var readyBtn:Button;
      
      public var inviteBtn:Button;
      
      public var quxiaoBtn:Button;
      
      public var ZDbox:CheckBox;
      
      public var ZDreadtf:MyTextField;
      
      private var tsArr:Array;
      
      private var ttUnitArr:Array = [];
      
      public var voArr:Array;
      
      private var indexTf:MyTextField;
      
      private var threeBack:Bitmap;
      
      private var twoBack:Bitmap;
      
      private var gridArr:Vector.<MyZFGrid> = new Vector.<MyZFGrid>();
      
      private var zhenFaName:MyTextField = new MyTextField();
      
      public var tiaoZhantf:Button;
      
      private var guiZetf:MyTextField;
      
      private var Tipstr:String = "多人跨服规则<br>1.5连杀额外增加<font color = \'#9ACD32\'>50</font>积分<br>2.10连杀额外增加<font color = \'#9ACD32\'>100</font>积分<br>3.15连杀额外增加<font color = \'#9ACD32\'>150</font>积分<br>4.20连杀额外增加<font color = \'#9ACD32\'>200</font>积分<br>5.25连杀额外增加<font color = \'#9ACD32\'>250</font>积分<br>6.30连杀额外增加<font color = \'#9ACD32\'>300</font>积分<br>7.中途离开队伍的话则失效<br>8.连杀次数越高的队伍将会<br>在榜单内显示排名。";
      
      private var lianZhanBm:Bitmap;
      
      private const TZL:int = 44724;
      
      private var lsArr:Array = [];
      
      public var _bmc:Bitmap;
      
      public var _bmc2:Bitmap;
      
      private var _effs:Array = [];
      
      public var _zbBmArr:Array = [];
      
      public function TeamPanel()
      {
         this.itemArr = [this.teamItem,this.teamItem2,this.teamItem3];
         super();
         regResource("lang/ch/DRKF_Imgs.swf","DRKF_Imgsdm");
      }
      
      public static function get instance() : TeamPanel
      {
         if(!_instance)
         {
            _instance = new TeamPanel();
         }
         return _instance;
      }
      
      override protected function initUI2() : void
      {
         var i:int = 0;
         var j:int = 0;
         var grid:MyZFGrid = null;
         bindParent = GameScene.modalLayer;
         this.back = ComponentUtil.getScaleBitmap("Back1",[149,41,2,5],this,{
            "x":0,
            "y":0,
            "width":886,
            "height":534
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back_Img",[26,26,2,2],this,{
            "x":24,
            "y":40,
            "width":838,
            "height":485
         },Global.DRKF_Imgsdm);
         ComponentUtil.getBitmap("Back_Team",this,{
            "x":26,
            "y":42
         },Global.DRKF_Imgsdm);
         ComponentUtil.getBitmap("Back_DuiWuZX",this,{
            "x":575,
            "y":50
         },Global.DRKF_Imgsdm);
         move = new Rectangle(0,0,this.back.width,35);
         ComponentUtil.getBitmap("Back_ZhenFa",this,{
            "x":595,
            "y":95
         },Global.DRKF_Imgsdm);
         this.zhenFaName = ComponentUtil.getTextField("阵法名称",this,{
            "x":625,
            "y":345,
            "color":13424242,
            "size":12,
            "leading":0
         });
         ComponentUtil.getTextField("房间：",this,{
            "x":622,
            "y":72,
            "color":13424242,
            "size":14,
            "leading":0
         });
         this.roomname = ComponentUtil.getTextField("",this,{
            "x":664,
            "y":72,
            "color":16764206,
            "size":14,
            "leading":0
         });
         ComponentUtil.getBitmap("Grid_Member",this,{
            "x":24 + 595,
            "y":24 + 95
         },Global.DRKF_Imgsdm);
         ComponentUtil.getBitmap("Grid_Member",this,{
            "x":94 + 595,
            "y":24 + 95
         },Global.DRKF_Imgsdm);
         ComponentUtil.getBitmap("Grid_Member",this,{
            "x":164 + 595,
            "y":24 + 95
         },Global.DRKF_Imgsdm);
         ComponentUtil.getBitmap("Grid_Member",this,{
            "x":94 + 595,
            "y":164 + 95
         },Global.DRKF_Imgsdm);
         ComponentUtil.getBitmap("Grid_Member",this,{
            "x":24 + 595,
            "y":94 + 95
         },Global.DRKF_Imgsdm);
         ComponentUtil.getBitmap("Grid_Member",this,{
            "x":24 + 595,
            "y":164 + 95
         },Global.DRKF_Imgsdm);
         ComponentUtil.getBitmap("Grid_Member",this,{
            "x":94 + 595,
            "y":94 + 95
         },Global.DRKF_Imgsdm);
         ComponentUtil.getBitmap("Grid_Member",this,{
            "x":164 + 595,
            "y":94 + 95
         },Global.DRKF_Imgsdm);
         ComponentUtil.getBitmap("Grid_Member",this,{
            "x":164 + 595,
            "y":164 + 95
         },Global.DRKF_Imgsdm);
         this.tiaoZhantf = ComponentUtil.getButton("","Button_QuanFu",this,{
            "x":599,
            "y":385,
            "textColor":16184781
         },Global.DRKF_Imgsdm);
         this.tiaoZhantf.addEventListener(MouseEvent.CLICK,this.tiaoZhanClick);
         this.ZDreadtf = ComponentUtil.getTextField("自动准备",this,{
            "x":599 + 20,
            "y":390,
            "color":13421772,
            "size":12,
            "leading":0
         });
         this.ZDreadtf.visible = false;
         i = 0;
         while(i < 3)
         {
            j = 0;
            while(j < 3)
            {
               grid = new MyZFGrid(false,".jpg");
               grid.type = Enum_type_grid.KFJJ_ZF;
               grid.set_tf_count(true,false,true);
               grid.x = 765 - 70 * j;
               grid.y = 125 + 70 * i;
               addChild(grid);
               this.gridArr.push(grid);
               grid.posStr = ((i + 1) * 10 + 3 - j).toString();
               j++;
            }
            i++;
         }
         ComponentUtil.getBitmap("Title_DRKFJingJi",this,{
            "x":363,
            "y":5
         },Global.DRKF_Imgsdm);
         this.teamSprite = new Sprite();
         addChild(this.teamSprite);
         this.teamSprite.mouseEnabled = false;
         this.ZDbox = ComponentUtil.getCheckBox("","CheckBox01",this,{
            "x":599,
            "y":390,
            "color":16777215
         },Global.Img_Cdm);
         this.ZDbox.selected = false;
         this.ZDbox.visible = false;
         this.tiaoZhantf.visible = !this.ZDbox.visible;
         this.guiZetf = ComponentUtil.getTextField("连杀规则",this,{
            "x":770,
            "y":390,
            "color":327424,
            "size":12,
            "leading":0
         });
         this.guiZetf.mouseEnabled = true;
         this.leaveBtn = ComponentUtil.getButton("","Button_Leave",this,{
            "x":613,
            "y":434,
            "textColor":16184781
         },Global.DRKF_Imgsdm);
         this.readyBtn = ComponentUtil.getButton("","Button_Ready",this,{
            "x":761,
            "y":428,
            "textColor":16184781
         },Global.DRKF_Imgsdm);
         this.starBtn = ComponentUtil.getButton("","Button_Start",this,{
            "x":761,
            "y":428,
            "textColor":16184781
         },Global.DRKF_Imgsdm);
         this.quxiaoBtn = ComponentUtil.getButton("","Button_Cancel",this,{
            "x":761,
            "y":428,
            "textColor":16184781
         },Global.DRKF_Imgsdm);
         this.quxiaoBtn.visible = false;
         this.inviteBtn = ComponentUtil.getButton("","Button_Invite",this,{
            "x":687,
            "y":434,
            "textColor":16184781
         },Global.DRKF_Imgsdm);
         this.zhenXingBtn = ComponentUtil.getButton("阵型设置","Button_TwoBule91",this,{
            "x":730,
            "y":343,
            "textColor":16184781
         },Global.Img_Cdm);
         this.indexTf = ComponentUtil.getTextField("00/00次",this,{
            "x":711,
            "y":390,
            "color":16764206,
            "size":12,
            "leading":0
         });
         this.leaveBtn.addEventListener(MouseEvent.CLICK,this.leaveClick);
         this.starBtn.addEventListener(MouseEvent.CLICK,this.starClick);
         this.zhenXingBtn.addEventListener(MouseEvent.CLICK,this.zhenXingClick);
         this.inviteBtn.addEventListener(MouseEvent.CLICK,this.inviteClick);
         this.readyBtn.addEventListener(MouseEvent.CLICK,this.readyBtnClick);
         this.quxiaoBtn.addEventListener(MouseEvent.CLICK,this.quxiaoClick);
         CloseButton = ComponentUtil.getButton("","Button_Close",this,{
            "x":852,
            "y":6,
            "textColor":16184781
         },Global.Img_Cdm);
         CloseButton.addEventListener(MouseEvent.CLICK,this.colseClick);
         this.ZDbox.addEventListener(MouseEvent.CLICK,this.zdClick);
         Model_DRKF.addLianZhanUnit(this,{
            "x":24,
            "y":40
         });
         TipManager.bind(this.guiZetf,this.Tipstr);
      }
      
      private function tiaoZhanClick(e:MouseEvent) : void
      {
         if(Boolean(this._bmc2))
         {
            if(this._bmc2.visible)
            {
               UIManager.centerBroadcast.addMsg("正在寻找对手");
               return;
            }
         }
         if(Boolean(this._bmc))
         {
            if(this._bmc.visible)
            {
               UIManager.centerBroadcast.addMsg("撮合中");
               return;
            }
         }
         if(CommandManager.get_bag_count(this.TZL,2) > 0)
         {
            KuaFuJingJiChangCGMessage.CG_TIAOZHAN_FAQI();
         }
         else if(!CommandManager.get_bag_vec(Enum_filter.ID,null,[this.TZL]).length)
         {
            UIManager.chatPrompt3.show(function():void
            {
               if(GameUnitManager.hero.money >= 15)
               {
                  KuaFuJingJiChangCGMessage.CG_TIAOZHAN_FAQI();
               }
               else
               {
                  UIManager.centerBroadcast.addMsg(LangConfig.getWord("139",0));
               }
            });
         }
         else
         {
            KuaFuJingJiChangCGMessage.CG_TIAOZHAN_FAQI();
         }
      }
      
      public function updata() : void
      {
         if(KuaFuJJCVO.cishu > 30)
         {
            KuaFuJJCVO.cishu = 30;
         }
         this.indexTf.text = KuaFuJJCVO.cishu + "/30次";
      }
      
      public function getLianSha(num:int) : void
      {
         this.lsArr.length = 0;
         if(num == 0)
         {
            this.lsArr.push(0);
         }
         if(num % 100 == 0)
         {
            this.lsArr.push(num / 100);
            this.lsArr.push("Bai");
            return;
         }
         if(num % 10 == 0)
         {
            if(num > 100)
            {
               this.lsArr.push(int(num / 100));
               this.lsArr.push("Bai");
               this.lsArr.push(num % 100 / 10);
               this.lsArr.push(10);
               return;
            }
            this.lsArr.push(num / 10);
            this.lsArr.push(10);
            return;
         }
         if(num <= 10)
         {
            this.lsArr.push(num);
            return;
         }
         if(num > 10 && num < 100)
         {
            this.lsArr.push(int(num / 10));
            this.lsArr.push(10);
            this.lsArr.push(num % 10);
            return;
         }
         if(num > 100)
         {
            if(num % 100 > 10)
            {
               this.lsArr.push(int(num / 100));
               this.lsArr.push("Bai");
               this.lsArr.push(int(num % 100 / 10));
               this.lsArr.push(10);
               this.lsArr.push(num % 10);
               return;
            }
            this.lsArr.push(int(num / 100));
            this.lsArr.push("Bai");
            this.lsArr.push(0);
            this.lsArr.push(num % 10);
            return;
         }
      }
      
      public function ready() : void
      {
         var isReady:Boolean = false;
         var j:int = 0;
         var i:int = 0;
         while(i < Model_KuaFuJingJiChang.myTeamVo.length)
         {
            isReady = false;
            j = 0;
            while(j < KuaFuJJCVO.readyArr.length)
            {
               if((Model_KuaFuJingJiChang.myTeamVo[i] as MyTeamVo).id == KuaFuJJCVO.readyArr[j])
               {
                  isReady = true;
                  break;
               }
               j++;
            }
            TeamPanel.instance.isPlayerReady(isReady,i);
            i++;
         }
      }
      
      public function cuohe() : void
      {
         var o:Bitmap = null;
         if(!this._bmc)
         {
            this._bmc = Utils.getLoadBitmap("resource/image/kuafujingjichang/cuohe.png");
            this._bmc.x = 275 - 130;
            this._bmc.y = 155;
         }
         else
         {
            this._bmc.visible = true;
         }
         for each(o in this._zbBmArr)
         {
            o.visible = true;
         }
      }
      
      public function zhaoxunBtn(v:Boolean) : void
      {
         if(this._bmc2.visible)
         {
            if(Boolean(this.starBtn))
            {
               this.starBtn.enabled = !v;
            }
            if(Boolean(this.readyBtn))
            {
               this.readyBtn.enabled = !v;
            }
            if(Boolean(this.readyBtn))
            {
               this.inviteBtn.enabled = !v;
            }
            if(Boolean(this.quxiaoBtn))
            {
               this.quxiaoBtn.enabled = !v;
            }
         }
         else
         {
            if(Boolean(this.starBtn))
            {
               this.starBtn.enabled = v;
            }
            if(Boolean(this.readyBtn))
            {
               this.readyBtn.enabled = v;
            }
            if(Boolean(this.inviteBtn))
            {
               this.inviteBtn.enabled = v;
            }
            if(Boolean(this.quxiaoBtn))
            {
               this.quxiaoBtn.enabled = v;
            }
         }
      }
      
      public function zhaoxun() : void
      {
         if(!this._bmc2)
         {
            this._bmc2 = Utils.getLoadBitmap("resource/image/kuafujingjichang/tiaozhan.png");
            this._bmc2.x = 275 - 130;
            this._bmc2.y = 155;
            addChildAt(this._bmc2,numChildren - 1);
         }
         else
         {
            this._bmc2.visible = true;
            addChildAt(this._bmc2,numChildren - 1);
         }
         this.zhaoxunBtn(this._bmc2.visible);
      }
      
      public function removezhaoxun() : void
      {
         if(Boolean(this._bmc2))
         {
            this._bmc2.visible = false;
         }
         if(Boolean(this._bmc2))
         {
            this.zhaoxunBtn(this._bmc2.visible);
         }
      }
      
      public function removecuohe() : void
      {
         var o:Bitmap = null;
         if(Boolean(this._bmc))
         {
            this._bmc.visible = false;
         }
         for each(o in this._zbBmArr)
         {
            o.visible = false;
         }
      }
      
      public function initItem() : void
      {
         var capId:int = 0;
         var ttUnit:Child_tianTiUnit = null;
         var curId:int = 0;
         var myId:int = 0;
         var petUrl:String = null;
         var heroUrl:String = null;
         this.roomname.text = "NO." + Model_KuaFuJingJiChang.team_id + "  " + DRKFlistPanel.instance.roomname.text;
         this.voArr = [];
         var i:int = 0;
         while(i < 3)
         {
            ttUnit = this.ttUnitArr[i] || new Child_tianTiUnit();
            if(!this.itemArr[i])
            {
               this.itemArr[i] = new TeamItem();
               this.itemArr[i].x = 44 + 187 * i;
               this.itemArr[i].y = 60;
               this.teamSprite.addChild(this.itemArr[i]);
               this.itemArr[i].setBtnParent();
               this.itArr.push(this.itemArr[i]);
               ttUnit.type = Child_tianTiUnit.PLAYER;
               this.ttUnitArr.push(ttUnit);
            }
            if(i >= Model_KuaFuJingJiChang.myTeamVo.length)
            {
               this.itemArr[i].visible = false;
            }
            else
            {
               this.itemArr[i].visible = true;
               (this.itemArr[i] as TeamItem).nametf.text = (Model_KuaFuJingJiChang.myTeamVo[i] as MyTeamVo).name;
               (this.itemArr[i] as TeamItem).leveltf.text = (Model_KuaFuJingJiChang.myTeamVo[i] as MyTeamVo).level.toString() + "级";
               (this.itemArr[i] as TeamItem).jifentf.text = (Model_KuaFuJingJiChang.myTeamVo[i] as MyTeamVo).num.toString();
               (this.itemArr[i] as TeamItem).zhiyetf.text = Enum_job.getMenPai((Model_KuaFuJingJiChang.myTeamVo[i] as MyTeamVo).job,false);
               (this.itemArr[i] as TeamItem).zhanlitf.text = (Model_KuaFuJingJiChang.myTeamVo[i] as MyTeamVo).zhanLi.toString();
               (this.itemArr[i] as TeamItem).id = (Model_KuaFuJingJiChang.myTeamVo[i] as MyTeamVo).petValue;
               (this.itemArr[i] as TeamItem).heroid = (Model_KuaFuJingJiChang.myTeamVo[i] as MyTeamVo).id;
               capId = (Model_KuaFuJingJiChang.myTeamVo[0] as MyTeamVo).id;
               curId = (Model_KuaFuJingJiChang.myTeamVo[i] as MyTeamVo).id;
               myId = GameUnitManager.hero.id;
               if(capId == myId && curId != myId)
               {
                  (this.itemArr[i] as TeamItem).tsBtn.visible = true;
               }
               else
               {
                  (this.itemArr[i] as TeamItem).tsBtn.visible = false;
               }
               petUrl = (Model_KuaFuJingJiChang.myTeamVo[i] as MyTeamVo).petId + "_40";
               Utils.getLoadBitmap("resource/image/icon/" + petUrl + ".jpg",(this.itemArr[i] as TeamItem).touxiang);
               heroUrl = "23" + (Model_KuaFuJingJiChang.myTeamVo[i] as MyTeamVo).job + "2" + (Model_KuaFuJingJiChang.myTeamVo[i] as MyTeamVo).sex;
               ttUnit.sex = (Model_KuaFuJingJiChang.myTeamVo[i] as MyTeamVo).sex;
               ttUnit.job = (Model_KuaFuJingJiChang.myTeamVo[i] as MyTeamVo).job;
               ttUnit.way = 4;
               ttUnit.setFrameInterval(120);
               ttUnit.modelId = (Model_KuaFuJingJiChang.myTeamVo[i] as MyTeamVo).Fashion;
               ttUnit.weaponDir = (Model_KuaFuJingJiChang.myTeamVo[i] as MyTeamVo).wuQi.toString();
               ttUnit.wing = (Model_KuaFuJingJiChang.myTeamVo[i] as MyTeamVo).wing;
               ttUnit.updateLayer();
               if(ttUnit.sex == 2 && ttUnit.job == 4)
               {
                  ttUnit.x = 100;
                  ttUnit.y = 190 + 100;
               }
               else
               {
                  ttUnit.x = 90;
                  ttUnit.y = 180 + 100;
               }
               if(Boolean(this._bmc))
               {
                  addChildAt(this._bmc,numChildren - 1);
               }
               (this.itemArr[i] as TeamItem).addChild(ttUnit);
            }
            i++;
         }
         if(this.itemArr[0] != null)
         {
            if((this.itemArr[0] as TeamItem).heroid == GameUnitManager.hero.id)
            {
               this.starBtn.visible = true;
               this.tiaoZhantf.visible = true;
               this.quxiaoBtn.visible = false;
               this.readyBtn.visible = false;
               this.inviteBtn.visible = true;
            }
            else
            {
               this.starBtn.visible = false;
               this.tiaoZhantf.visible = false;
               this.readyBtn.visible = true;
               this.inviteBtn.visible = false;
               this.ZDbox.visible = true;
               this.tiaoZhantf.visible = !this.ZDbox.visible;
               this.ZDreadtf.visible = true;
            }
         }
      }
      
      public function isZDready() : void
      {
         if(this.itemArr[0].heroid != GameUnitManager.hero.id)
         {
            if(this.ZDbox.selected == true && this.starBtn.visible == false)
            {
               this.quxiaoBtn.visible = false;
               this.zdClick();
            }
         }
         else
         {
            this.starBtn.visible = true;
            this.tiaoZhantf.visible = true;
            this.starBtn.enabled = true;
            this.quxiaoBtn.visible = false;
            this.readyBtn.visible = false;
            this.inviteBtn.visible = true;
            this.inviteBtn.enabled = true;
            this.ZDbox.visible = false;
            this.tiaoZhantf.visible = !this.ZDbox.visible;
            this.ZDbox.selected = false;
            this.ZDreadtf.visible = false;
         }
      }
      
      private function zdClick(e:MouseEvent = null) : void
      {
         if(this.quxiaoBtn.visible == false)
         {
            if(this.ZDbox.selected)
            {
               this.starBtn.visible = false;
               this.tiaoZhantf.visible = false;
               this.readyBtn.visible = false;
               this.quxiaoBtn.visible = true;
               this.inviteBtn.visible = false;
               this.ZDbox.visible = true;
               this.tiaoZhantf.visible = !this.ZDbox.visible;
               this.ZDreadtf.visible = true;
               KuaFuJingJiChangCGMessage.CG_DUIYUAN_READY(1);
            }
         }
      }
      
      public function petInfoVisible(value:Boolean) : void
      {
         PetPanel.curPanel = this;
         UIManager.petInfoPanel.visible = value;
         var point:Point = this.localToGlobal(new Point(this.mouseX,this.mouseY));
         UIManager.petInfoPanel.x = point.x;
         UIManager.petInfoPanel.y = point.y - 280;
      }
      
      public function showPetInfoView(petVO:PetVO) : void
      {
         UIManager.petInfoPanel.petVO = petVO;
         UIManager.petInfoPanel.update();
      }
      
      public function isPlayerReady(v:Boolean, index:int) : void
      {
         if(index != 0 && v && !this._effs[index])
         {
            this._effs[index] = EffectManager.addEffect("35178",this.itemArr[index] as Sprite,1000,90,185 + 100,true);
            this.itemArr[index].setChildIndex(this._effs[index],this.itemArr[index].getChildIndex(this.ttUnitArr[index] as DisplayObject));
            this._zbBmArr[index] = Utils.getLoadBitmap("resource/image/kuafujingjichang/zb.png",this._zbBmArr[index],{
               "x":105,
               "y":38 + 100
            });
            (this.itemArr[index] as Sprite).addChild(this._zbBmArr[index]);
            this._zbBmArr[index].visible = true;
         }
         if(index == 0 && v && !this._effs[index])
         {
            this._effs[index] = EffectManager.addEffect("35178",this.itemArr[index] as Sprite,1000,90,185 + 100,true);
            this.itemArr[index].setChildIndex(this._effs[index],this.itemArr[index].getChildIndex(this.ttUnitArr[index] as DisplayObject));
            this._zbBmArr[index] = Utils.getLoadBitmap("resource/image/kuafujingjichang/kaishi.png",this._zbBmArr[index],{
               "x":105,
               "y":38 + 100
            });
            (this.itemArr[index] as Sprite).addChild(this._zbBmArr[index]);
            this._zbBmArr[index].visible = true;
         }
         if(Boolean(!v) && Boolean(this._effs[index]) && index != 0)
         {
            EffectManager.removeEffect(this._effs[index] as Effect);
            this._effs[index] = null;
            if(Boolean(this._zbBmArr[index]))
            {
               this._zbBmArr[index].visible = false;
            }
         }
         if(Boolean(!v) && Boolean(this._effs[index]) && index == 0)
         {
            EffectManager.removeEffect(this._effs[index] as Effect);
            this._effs[index] = null;
            if(Boolean(this._zbBmArr[index]))
            {
               this._zbBmArr[index].visible = false;
            }
         }
      }
      
      public function updateZhenFa(id:int, zhanWei:String, type:int) : void
      {
         var playerId:Number = NaN;
         var playerInfo:MyTeamVo = null;
         var playerZhanwei:int = 0;
         var petZhanwei:int = 0;
         var pet:MyTeamVo = null;
         var grid:MyZFGrid = null;
         var vo:MyTeamVo = null;
         this.zhenFaName.text = Data_lib.zhenfa[type][2];
         var infos:Array = Util.splicObj(zhanWei,"|_") as Array;
         var vos:Array = [];
         var i:int = 0;
         while(i < infos.length)
         {
            playerId = Number(infos[i][0]);
            playerInfo = Model_KuaFuJingJiChang.myTeamMembers[playerId];
            playerZhanwei = int(infos[i][1]);
            vos[(int(playerZhanwei / 10) - 1) * 3 + playerZhanwei % 10 - 1] = playerInfo;
            if(playerInfo.petId != 0)
            {
               petZhanwei = int(infos[i][2]);
               pet = new MyTeamVo();
               pet.Id = playerInfo.petId;
               pet.str_icon = pet.Id.toString() + "_40";
               vos[(int(petZhanwei / 10) - 1) * 3 + petZhanwei % 10 - 1] = pet;
            }
            i += 1;
         }
         i = 0;
         while(i < this.gridArr.length)
         {
            grid = this.gridArr[i];
            vo = vos[i];
            if(Boolean(vo))
            {
               grid.vo = vo;
            }
            else
            {
               grid.vo = null;
            }
            i += 1;
         }
      }
      
      private function body(interval:int) : void
      {
         var u:Child_tianTiUnit = null;
         for each(u in this.ttUnitArr)
         {
            u.onFrame(interval);
         }
      }
      
      private function quxiaoClick(e:MouseEvent) : void
      {
         KuaFuJingJiChangCGMessage.CG_DUIYUAN_READY(2);
      }
      
      private function readyBtnClick(e:MouseEvent) : void
      {
         KuaFuJingJiChangCGMessage.CG_DUIYUAN_READY(1);
      }
      
      private function inviteClick(e:MouseEvent) : void
      {
         if(Model_KuaFuJingJiChang.myTeamVo.length == 3)
         {
            UIManager.centerBroadcast.addMsg("队伍人数已满");
         }
         else if(this.starBtn.visible == false)
         {
            UIManager.centerBroadcast.addMsg("队伍正在匹配");
         }
         else
         {
            Global.delegate.dosomething(YaoQingPanel.instance,YaoQingPanel.instance.show);
         }
      }
      
      private function starClick(e:MouseEvent) : void
      {
         KuaFuJingJiChangCGMessage.CG_DUIZHANG_STAR();
      }
      
      private function colseClick(e:MouseEvent) : void
      {
         this.leave();
      }
      
      private function leaveClick(e:MouseEvent) : void
      {
         this.leave();
      }
      
      private function zhenXingClick(e:MouseEvent) : void
      {
         if(Boolean(this._bmc2))
         {
            if(this._bmc2.visible)
            {
               UIManager.centerBroadcast.addMsg("正在寻找队伍中");
               return;
            }
         }
         if(this.starBtn.visible && this.starBtn.enabled)
         {
            Global.delegate.dosomething(UIManager.kuafulaw,UIManager.kuafulaw.show);
         }
         else if(!this.starBtn.visible)
         {
            UIManager.centerBroadcast.addMsg("只有队长才能设置阵型");
         }
         else if(!this.starBtn.enabled)
         {
            UIManager.centerBroadcast.addMsg("队伍正在撮合中");
         }
      }
      
      public function hide() : void
      {
         ModalUIManager.UNPOP();
      }
      
      private function leave() : void
      {
         KuaFuJingJiChangCGMessage.CG_LEAVE_DRKFTEAM(1);
      }
      
      public function leavegc() : void
      {
         switch(KuaFuJJCVO.isleave)
         {
            case 0:
               UIManager.centerBroadcast.addMsg("失败");
               break;
            case 1:
               Global.delegate.dosomething(DRKFlistPanel.instance,function():void
               {
                  if(Boolean(TeamPanel.instance.readyBtn))
                  {
                     TeamPanel.instance.readyBtn.visible = true;
                  }
                  if(Boolean(TeamPanel.instance.quxiaoBtn))
                  {
                     TeamPanel.instance.quxiaoBtn.visible = false;
                  }
                  DRKFlistPanel.instance.visible = true;
               });
               this.visible = false;
               KuaFuJingJiChangCGMessage.CG_KUAFUOPEN_YES();
               UIManager.centerBroadcast.addMsg("退出队伍");
               this.hide();
               break;
            case 2:
               UIManager.centerBroadcast.addMsg("队伍正在撮合中");
               break;
            case 10:
               UIManager.centerBroadcast.addMsg("队伍正在寻找对手");
         }
      }
      
      public function yaoqinggc() : void
      {
         switch(KuaFuJJCVO.yaoqing)
         {
            case 1:
               UIManager.centerBroadcast.addMsg("邀请成功");
               break;
            case 2:
               UIManager.centerBroadcast.addMsg("你不在队伍中");
               break;
            case 3:
               UIManager.centerBroadcast.addMsg("你不是队长");
               break;
            case 4:
               UIManager.centerBroadcast.addMsg("玩家不在线");
               break;
            case 5:
               UIManager.centerBroadcast.addMsg("该玩家等级不符");
               break;
            case 6:
               UIManager.centerBroadcast.addMsg("该玩家已进入其他队伍");
               break;
            case 7:
               UIManager.centerBroadcast.addMsg("该玩家已经在战斗中");
               break;
            case 8:
               UIManager.centerBroadcast.addMsg("当前玩家在副本中不可邀请");
               break;
            case 9:
               UIManager.centerBroadcast.addMsg("该玩家正在跑镖");
         }
      }
      
      public function show() : void
      {
         ModalUIManager.POPUP(this);
         UIManager.chatPanel.tmpParent = GameScene.sysLayer;
         View_PlayerExtendPanel.instance.getItem(false,2,3);
      }
      
      override public function set visible(value:Boolean) : void
      {
         super.visible = value;
         if(value)
         {
            this.initItem();
            Global.control.registerCallBack(Enum_MsgType.MSG_ENTERFRAME,this.body);
            Global.control.registerCallBack(Enum_MsgType.MSG_ENTER_FUBEN,this.onAskSceneOk);
            Global.control.registerCallBack(Enum_MsgType.MSG_ENTER_SCENE,this.onAskSceneOk);
         }
         else
         {
            Global.control.removeCallBack(Enum_MsgType.MSG_ENTERFRAME,this.body);
            if(DRKFlistPanel.instance.visible == false)
            {
               View_PlayerExtendPanel.instance.getItem(true);
            }
            Model_DRKF.hide();
         }
      }
      
      private function onAskSceneOk() : void
      {
         KuaFuJingJiChangCGMessage.CG_LEAVE_DRKFTEAM(2);
         Global.control.removeCallBack(Enum_MsgType.MSG_ENTER_FUBEN,arguments.callee);
         Global.control.removeCallBack(Enum_MsgType.MSG_ENTER_SCENE,arguments.callee);
         this.hide();
      }
      
      override public function resetPosition() : void
      {
         x = (Global.stage.stageWidth - this.width) / 2;
         y = (Global.stage.stageHeight - this.height) / 2;
      }
      
      override public function get width() : Number
      {
         return this.back.width;
      }
      
      override public function get height() : Number
      {
         return this.back.height;
      }
   }
}

import com.yiTian.view.comp.View_Grid;
import flash.display.Bitmap;

class MyZFGrid extends View_Grid
{
   
   public var posStr:String;
   
   public var _enabled:Boolean = true;
   
   public var _bitmap:Bitmap;
   
   public function MyZFGrid($bBigIcon:Boolean = false, str_extend_name:String = ".png")
   {
      super($bBigIcon,str_extend_name);
   }
   
   public function get enable() : Boolean
   {
      return this._enabled;
   }
   
   public function set enable(v:Boolean) : void
   {
      if(!v)
      {
         set_grey(true);
      }
      else
      {
         set_grey(false);
      }
      this._enabled = v;
   }
   
   public function get bitmap() : Bitmap
   {
      if(!this._bitmap)
      {
         this._bitmap = new Bitmap();
         var _temp_1:* = this._bitmap;
         this._bitmap.scaleY = 0.85;
         _temp_1.scaleX = 0.85;
         addChild(this._bitmap);
      }
      return this._bitmap;
   }
   
   public function set bitmap(b:Bitmap) : void
   {
      b = new Bitmap();
      this._bitmap = b;
   }
}
