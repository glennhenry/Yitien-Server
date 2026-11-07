package com.yiTian.view.modules.wing
{
   import com.ui.controls.Button;
   import com.ui.controls.CheckBox;
   import com.ui.controls.MaskProgressBar2;
   import com.ui.controls.MyTextField;
   import com.utils.ComponentUtil;
   import com.utils.DateUtil;
   import com.utils.Util;
   import com.yiTian.Global;
   import com.yiTian.command.Enum_MsgType;
   import com.yiTian.data.Data_lib;
   import com.yiTian.data.config.Enum_job;
   import com.yiTian.data.model.Model_wing;
   import com.yiTian.data.vo.Vo_item;
   import com.yiTian.gameUnit.config.Action;
   import com.yiTian.manager.CommandManager;
   import com.yiTian.manager.EffectManager;
   import com.yiTian.manager.GameUnitManager;
   import com.yiTian.manager.TipManager;
   import com.yiTian.manager.UIManager;
   import com.yiTian.net.message.cg.WingCGMessage;
   import com.yiTian.net.message.cg.XxlCGMessage;
   import com.yiTian.scene.GameScene;
   import com.yiTian.utils.HtmlUtil;
   import com.yiTian.utils.Tween;
   import com.yiTian.view.Panel123;
   import com.yiTian.view.comp.View_Grid;
   import com.yiTian.view.modules.tianTi.Child_tianTiUnit;
   import com.yiTian.view.modules.xiaoxiaole.View_xiaoxiaole;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import flash.utils.getTimer;
   import flash.utils.setTimeout;
   
   public class View_wing_menu extends Panel123
   {
      
      private static var _instance:View_wing_menu;
      
      private const materialPrize:int = 48;
      
      private var progress:MaskProgressBar2;
      
      private var upLevelBtn:Button;
      
      private var leftBtn:Button;
      
      private var rightBtn:Button;
      
      private var costTips:CostTips;
      
      private var currentShowWingId:int;
      
      private var modelIdArray:Array;
      
      private var maxModelId:int;
      
      private var maxLevelBm:Bitmap;
      
      private var curShow:Child_tianTiUnit;
      
      private var nextShow:Child_tianTiUnit;
      
      private var wingGrid:View_Grid;
      
      private var voWing:Vo_item;
      
      private var curShowTxt:MyTextField;
      
      private var blessTxt:MyTextField;
      
      private var blessLeftTimeTxt:MyTextField;
      
      private var beginTime:int;
      
      private var pastTime:int;
      
      private var effSpr:Sprite;
      
      private var curWingNameTxt:MyTextField;
      
      private var curStarSprite:Sprite;
      
      private var curStarArray:Array;
      
      private var nextWingNameTxt:MyTextField;
      
      private var nextStarSprite:Sprite;
      
      private var nextStarArray:Array;
      
      private var materialGrid:View_Grid;
      
      private var vomaterial:Vo_item;
      
      private var upCostTxt:MyTextField;
      
      private var successPercentTxt:MyTextField;
      
      private const successString:Array = ["低","中","高","极高"];
      
      private var autoBuyCheckBox:CheckBox;
      
      private var currentAttributeArray:Array;
      
      private var upAttributeArray:Array;
      
      private var attributeSpriteArray:Array;
      
      private var currentAttributeTxtArray:Array;
      
      private var upAttributeTxtArray:Array;
      
      private var attributeArrowArray:Array;
      
      private var tips:blessTips;
      
      private var successBm:Bitmap;
      
      private var failBm:Bitmap;
      
      private var dressBtn:Button;
      
      public var HuanHuaBtn:Button;
      
      private var wingShowBtn:Button;
      
      private var wingHideBtn:Button;
      
      private var dressIsCoolDown:Boolean;
      
      private var showIsCoolDown:Boolean;
      
      private var isRunning:Boolean = false;
      
      private var xxlBtn:Button;
      
      private var alginX:int = -35;
      
      public function View_wing_menu()
      {
         super();
         if(Boolean(_instance))
         {
            return;
         }
         regResource("lang/ch/ChiBang.swf","ChiBangdm");
      }
      
      public static function get instance() : View_wing_menu
      {
         if(!_instance)
         {
            _instance = new View_wing_menu();
         }
         return _instance;
      }
      
      override protected function initUI2() : void
      {
         var ii:int;
         var LV:* = undefined;
         var k:int = 0;
         var modelId:* = undefined;
         var curAttriStrArr:Array = null;
         var i:* = undefined;
         var id:* = undefined;
         var curAttriStrArr2:Array = null;
         var j:* = undefined;
         var id2:* = undefined;
         var spr:Sprite = null;
         ComponentUtil.getScaleBitmap("Back1",[149,41,2,5],this,{
            "x":0,
            "y":0,
            "width":657,
            "height":478
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back_InfList",[3,3,16,16],this,{
            "x":25,
            "y":40,
            "width":608,
            "height":428
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back_XJGD",[4,4,1,1],this,{
            "x":37,
            "y":52,
            "width":584,
            "height":404
         },Global.ChiBangdm);
         ComponentUtil.getBitmap("Title_ChiBang",this,{
            "x":248,
            "y":6
         },Global.ChiBangdm);
         ComponentUtil.getBitmap("Back_CBJD",this,{
            "x":43,
            "y":281
         },Global.ChiBangdm);
         ComponentUtil.getBitmap("Frame_RWCB",this,{
            "x":44,
            "y":58
         },Global.ChiBangdm);
         ComponentUtil.getBitmap("Frame_RWCB",this,{
            "x":408,
            "y":58
         },Global.ChiBangdm);
         ComponentUtil.getBitmap("Icon_XYGCB",this,{
            "x":308,
            "y":169
         },Global.ChiBangdm);
         ComponentUtil.getBitmap("Light_CBMC",this,{
            "x":70,
            "y":271
         },Global.ChiBangdm);
         ComponentUtil.getBitmap("Light_CBMC",this,{
            "x":434,
            "y":271
         },Global.ChiBangdm);
         ComponentUtil.getBitmap("Light_CBYL",this,{
            "x":246,
            "y":52
         },Global.ChiBangdm);
         ComponentUtil.getBitmap("Light_DJS",this,{
            "x":62,
            "y":373
         },Global.ChiBangdm);
         ComponentUtil.getBitmap("Text_CBYL",this,{
            "x":298,
            "y":56
         },Global.ChiBangdm);
         ComponentUtil.getBitmap("Text_ZFZ",this,{
            "x":101,
            "y":319
         },Global.ChiBangdm);
         this.maxLevelBm = ComponentUtil.getBitmap("Text_JQQD",this,{
            "x":429,
            "y":172
         },Global.ChiBangdm);
         this.maxLevelBm.visible = false;
         this.materialGrid = new View_Grid();
         this.materialGrid.x = 172 + this.alginX;
         this.materialGrid.y = 403;
         addChild(this.materialGrid);
         this.materialGrid.set_bmp_bg();
         this.materialGrid.set_bmp_over();
         this.materialGrid.set_tf_count();
         this.vomaterial = new Vo_item();
         this.curShow = new Child_tianTiUnit();
         addChild(this.curShow);
         this.curShow.x = 167;
         this.curShow.y = 257;
         this.curShow.way = 3;
         this.curShow.type = Child_tianTiUnit.PLAYER;
         this.curShow.modelId = GameUnitManager.hero.body;
         this.curShow.weaponDir = GameUnitManager.hero.weapon.toString();
         this.curShow.state = Action.STAND;
         this.curShow.job = GameUnitManager.hero.job;
         this.curShow.sex = GameUnitManager.hero.sex;
         this.curShow.setFrameInterval(150);
         this.curShow.updateLayer();
         this.nextShow = new Child_tianTiUnit();
         addChild(this.nextShow);
         this.nextShow.x = 531;
         this.nextShow.y = 257;
         this.nextShow.way = 3;
         this.nextShow.type = Child_tianTiUnit.PLAYER;
         this.nextShow.modelId = GameUnitManager.hero.body;
         this.nextShow.weaponDir = GameUnitManager.hero.weapon.toString();
         this.nextShow.state = Action.STAND;
         this.nextShow.job = GameUnitManager.hero.job;
         this.nextShow.sex = GameUnitManager.hero.sex;
         this.nextShow.setFrameInterval(150);
         this.nextShow.updateLayer();
         this.curWingNameTxt = ComponentUtil.getTextField("紫电青冥(一阶1星)",this,{
            "x":94,
            "y":272,
            "color":16755712,
            "size":12,
            "leading":0
         });
         this.nextWingNameTxt = ComponentUtil.getTextField("紫电青冥(一阶1星)",this,{
            "x":459,
            "y":272,
            "color":16755712,
            "size":12,
            "leading":0
         });
         this.curStarSprite = new Sprite();
         this.nextStarSprite = new Sprite();
         addChild(this.curStarSprite);
         addChild(this.nextStarSprite);
         this.curStarSprite.x = 63;
         this.curStarSprite.y = 71;
         this.nextStarSprite.x = 427;
         this.nextStarSprite.y = 71;
         this.curStarArray = [];
         this.nextStarArray = [];
         ii = 0;
         while(ii < 10)
         {
            this.curStarArray.push(ComponentUtil.getBitmap("Icon_LXX",this.curStarSprite,{
               "x":ii * 17,
               "y":0
            },Global.ChiBangdm));
            this.nextStarArray.push(ComponentUtil.getBitmap("Icon_LXX",this.nextStarSprite,{
               "x":ii * 17,
               "y":0
            },Global.ChiBangdm));
            ii++;
         }
         this.currentAttributeArray = [];
         this.upAttributeArray = [];
         for(LV in Data_lib.wing)
         {
            curAttriStrArr = Data_lib.wing[LV][8].split(",");
            this.currentAttributeArray[LV - 1] = [];
            for(i in curAttriStrArr)
            {
               this.currentAttributeArray[LV - 1][i] = curAttriStrArr[i].split("_");
               for(id in this.currentAttributeArray[LV - 1][i])
               {
                  this.currentAttributeArray[LV - 1][i][id] = Number(this.currentAttributeArray[LV - 1][i][id]);
               }
            }
            if(LV < Data_lib.wing.getLength())
            {
               curAttriStrArr2 = Data_lib.wing[LV + 1][8].split(",");
               this.upAttributeArray[LV - 1] = [];
               for(j in curAttriStrArr2)
               {
                  this.upAttributeArray[LV - 1][j] = curAttriStrArr2[j].split("_");
                  for(id2 in this.upAttributeArray[LV - 1][j])
                  {
                     this.upAttributeArray[LV - 1][j][id2] = Number(this.upAttributeArray[LV - 1][j][id2]);
                  }
                  this.upAttributeArray[LV - 1][j][1] -= this.currentAttributeArray[LV - 1][j][1];
               }
            }
         }
         this.attributeSpriteArray = [];
         this.currentAttributeTxtArray = [];
         this.upAttributeTxtArray = [];
         this.attributeArrowArray = [];
         k = 0;
         while(k < 6)
         {
            spr = new Sprite();
            addChild(spr);
            spr.x = 259;
            spr.y = 200 + 17 * k;
            this.attributeSpriteArray.push(spr);
            TipManager.bind(spr,"攻加是指增加翅膀本身攻击属性百分比<br/>" + HtmlUtil.fontNoSize("(攻加所加的攻击:xx)","#00ff00") + "<br/><br/>" + "抗暴、伤害、伤免只在PVP战斗中计算伤害效果");
            this.currentAttributeTxtArray.push(ComponentUtil.getTextField("攻击+100",spr,{
               "x":0,
               "y":0,
               "color":16776960,
               "size":12,
               "leading":3
            }));
            this.attributeArrowArray.push(ComponentUtil.getBitmap("Icon_SXTS",spr,{
               "x":91,
               "y":1
            },Global.ChiBangdm));
            this.upAttributeTxtArray.push(ComponentUtil.getTextField("100",spr,{
               "x":113,
               "y":0,
               "color":65280,
               "size":12,
               "leading":3
            }));
            k++;
         }
         this.leftBtn = ComponentUtil.getButton("","Button_SYG",this,{
            "x":265,
            "y":93,
            "textColor":16771436
         },Global.ChiBangdm);
         this.leftBtn.callBack = this.changeWing;
         this.rightBtn = ComponentUtil.getButton("","Button_XYG",this,{
            "x":377,
            "y":93,
            "textColor":16771436
         },Global.ChiBangdm);
         this.rightBtn.callBack = this.changeWing;
         this.modelIdArray = [];
         for(modelId in Data_lib.wing)
         {
            if(modelId == 1)
            {
               this.modelIdArray.push(modelId);
            }
            else if(Data_lib.wing[modelId][32] != Data_lib.wing[modelId - 1][32])
            {
               this.modelIdArray.push(modelId);
            }
         }
         this.maxModelId = this.modelIdArray.length - 1;
         this.currentShowWingId = 0;
         this.updateArrowBtn();
         this.wingGrid = new View_Grid(true);
         this.wingGrid.x = 295;
         this.wingGrid.y = 85;
         addChild(this.wingGrid);
         this.wingGrid.set_bmp_bg(View_Grid.GRID_BIGGEST_OPEN);
         this.voWing = new Vo_item();
         this.curShowTxt = ComponentUtil.getTextField("",this,{
            "x":327,
            "y":153,
            "color":16776960
         },"center");
         ComponentUtil.getTextField("祝福值清空倒计时：",this,{
            "x":252,
            "y":376,
            "color":16772287,
            "size":12,
            "leading":0
         });
         this.blessLeftTimeTxt = ComponentUtil.getTextField("00:00:00",this,{
            "x":358,
            "y":375,
            "color":65280,
            "size":14,
            "leading":0
         });
         ComponentUtil.getTextField("当前消耗材料",this,{
            "x":91 + this.alginX,
            "y":414,
            "color":11904647,
            "size":12,
            "leading":0
         });
         ComponentUtil.getTextField("进阶费用：\n成功概率：",this,{
            "x":231 + this.alginX - 3,
            "y":405,
            "color":11904647,
            "size":12,
            "leading":3
         });
         this.upCostTxt = ComponentUtil.getTextField("999999",this,{
            "x":291 + this.alginX - 3,
            "y":406,
            "color":65280,
            "size":12,
            "leading":3
         });
         this.successPercentTxt = ComponentUtil.getTextField("低",this,{
            "x":291 + this.alginX - 3,
            "y":422,
            "color":65280,
            "size":12,
            "leading":3
         });
         ComponentUtil.getTextField("自动购买材料",this,{
            "x":368 + this.alginX - 3,
            "y":415,
            "color":11904647,
            "size":12,
            "leading":0
         });
         this.autoBuyCheckBox = ComponentUtil.getCheckBox("","CheckBox01",this,{
            "x":348 + this.alginX - 3,
            "y":417,
            "color":16772287
         },Global.Img_Cdm);
         this.tips = new blessTips();
         this.progress = new MaskProgressBar2(ComponentUtil.getBitmap("Line_JDT",null,{
            "x":101,
            "y":348
         },Global.ChiBangdm),ComponentUtil.getBitmap("Line_JDTD",null,{
            "x":63,
            "y":341
         },Global.ChiBangdm));
         addChild(this.progress);
         this.progress.addEventListener(MouseEvent.ROLL_OVER,this.showBlessTips);
         this.progress.addEventListener(MouseEvent.ROLL_OUT,this.showBlessTips);
         this.blessTxt = ComponentUtil.getTextField("0/0",this,{
            "x":328,
            "y":348,
            "color":16777215,
            "size":12,
            "leading":0
         },"center");
         this.effSpr = new Sprite();
         addChild(this.effSpr);
         this.effSpr.x = 328;
         this.effSpr.y = 357;
         this.effSpr.mouseEnabled = false;
         this.effSpr.mouseChildren = false;
         EffectManager.addEffect("35286",this.effSpr,1000,0,0,true);
         this.effSpr.visible = false;
         move = new Rectangle(0,0,657,30);
         CloseButton = ComponentUtil.getButton("","Button_Close",this,{
            "x":622,
            "y":5,
            "textColor":16771436
         },Global.Img_Cdm);
         CloseButton.callBack = function():void
         {
            visible = false;
         };
         this.successBm = ComponentUtil.getBitmap("Text_JJCG",this,{
            "x":251,
            "y":153
         },Global.ChiBangdm);
         this.failBm = ComponentUtil.getBitmap("Text_JJSB",this,{
            "x":251,
            "y":153
         },Global.ChiBangdm);
         this.successBm.alpha = 0;
         this.failBm.alpha = 0;
         this.upLevelBtn = ComponentUtil.getButton("进阶","Button_JinJie",this,{
            "x":417,
            "y":406,
            "textColor":16771436
         },Global.ChiBangdm);
         this.xxlBtn = ComponentUtil.getButton("材料获取","Button_JinJie",this,{
            "x":513,
            "y":406,
            "textColor":16771436
         },Global.ChiBangdm);
         this.xxlBtn.callBack = function():void
         {
            if(View_xiaoxiaole.getInstance().visible)
            {
               View_xiaoxiaole.getInstance().visible = false;
            }
            else
            {
               XxlCGMessage.CG_XXL_OPENWIN();
            }
         };
         this.upLevelBtn.callBack = function():void
         {
            var costArr:Array = null;
            var costCount:uint = 0;
            var extrId:uint = 0;
            var i_i:uint = 0;
            var count1:uint = 0;
            var count2:uint = 0;
            var dataS:String = null;
            var arr:Array = null;
            var dis:int = 0;
            var money:int = 0;
            if(Model_wing.wingId >= Data_lib.wing.getLength())
            {
               UIManager.centerBroadcast.addMsg("已进阶到最高级");
               return;
            }
            if(GameUnitManager.hero.bingSilver + GameUnitManager.hero.silver < Data_lib.wing[Model_wing.wingId][4])
            {
               UIManager.centerBroadcast.addMsg("银子不足");
               return;
            }
            if(!autoBuyCheckBox.selected)
            {
               costArr = Data_lib.wing[Model_wing.wingId][3].split(",");
               costCount = 0;
               extrId = 0;
               i_i = 0;
               if(i_i < costArr.length)
               {
                  dataS = costArr[i_i];
                  arr = dataS.split("_");
                  costCount = uint(arr[2]);
                  extrId = uint(arr[1]);
               }
               count1 = uint(CommandManager.get_bag_count(45252));
               count2 = uint(CommandManager.getCanUseToolNum(extrId));
               if(costCount > count1 + count2)
               {
                  dis = costCount - count1 - count2;
                  money = materialPrize * dis;
                  costTips.show(money,dis);
               }
               else
               {
                  WingCGMessage.CG_WING_UP_LEVEL(1);
               }
            }
            else
            {
               WingCGMessage.CG_WING_UP_LEVEL(2);
            }
         };
         this.wingShowBtn = ComponentUtil.getButton("","TabButton_Xian",this,{
            "x":52,
            "y":267
         },Global.Img_Cdm);
         this.wingHideBtn = ComponentUtil.getButton("","TabButton_Yin",this,{
            "x":52,
            "y":267
         },Global.Img_Cdm);
         this.HuanHuaBtn = ComponentUtil.getButton("","Button_Huan",this,{
            "x":52,
            "y":232
         },Global.ChiBangdm);
         this.dressBtn = ComponentUtil.getButton("","Button_Chuan",this,{
            "x":212,
            "y":267
         },Global.ChiBangdm);
         this.wingShowBtn.visible = false;
         this.wingHideBtn.visible = false;
         this.dressBtn.visible = false;
         this.HuanHuaBtn.visible = Model_wing.HuanHuaID > 0 ? true : false;
         this.dressBtn.callBack = function():void
         {
            var modelId:int = 0;
            if(dressIsCoolDown)
            {
               UIManager.centerBroadcast.addMsg("冷却时间60秒，请稍后再操作");
               return;
            }
            modelId = int(Data_lib.wing[modelIdArray[currentShowWingId]][Enum_job.getBaseJob(GameUnitManager.hero.job) * 2 + GameUnitManager.hero.sex + 6]);
            if(modelId == GameUnitManager.hero.wing)
            {
               UIManager.centerBroadcast.addMsg("已经是这件翅膀了，不需要更换");
            }
            else
            {
               dressIsCoolDown = true;
               dressBtn.filters = Util.disabled;
               HuanHuaBtn.filters = Util.disabled;
               WingCGMessage.CG_WING_CHANGE_MODEL(modelIdArray[currentShowWingId]);
               setTimeout(function():void
               {
                  dressIsCoolDown = false;
                  dressBtn.filters = [];
                  HuanHuaBtn.filters = [];
               },60000);
            }
         };
         this.HuanHuaBtn.callBack = function():void
         {
            if(dressIsCoolDown)
            {
               UIManager.centerBroadcast.addMsg("冷却时间60秒，请稍后再操作");
               return;
            }
            if(Model_wing.HuanHuaID > 0 && GameUnitManager.hero.wing == 0)
            {
               UIManager.centerBroadcast.addMsg("翅膀隐藏状态不能幻化");
            }
            else if(Model_wing.HuanHuaID == GameUnitManager.hero.wing)
            {
               UIManager.centerBroadcast.addMsg("已经是幻化翅膀了，不需要更换");
            }
            else
            {
               dressIsCoolDown = true;
               dressBtn.filters = Util.disabled;
               HuanHuaBtn.filters = Util.disabled;
               WingCGMessage.CG_WING_CHANGE_HuanHua();
               setTimeout(function():void
               {
                  dressIsCoolDown = false;
                  dressBtn.filters = [];
                  HuanHuaBtn.filters = [];
               },60000);
            }
         };
         this.wingShowBtn.callBack = function():void
         {
            if(showIsCoolDown)
            {
               UIManager.centerBroadcast.addMsg("冷却时间60秒，请稍后再操作");
               return;
            }
            showIsCoolDown = true;
            wingShowBtn.filters = Util.disabled;
            wingHideBtn.filters = Util.disabled;
            WingCGMessage.CG_WING_SHOW_AND_HIDE(1);
            setTimeout(function():void
            {
               showIsCoolDown = false;
               wingShowBtn.filters = [];
               wingHideBtn.filters = [];
            },60000);
         };
         this.wingHideBtn.callBack = function():void
         {
            if(showIsCoolDown)
            {
               UIManager.centerBroadcast.addMsg("冷却时间60秒，请稍后再操作");
               return;
            }
            showIsCoolDown = true;
            wingShowBtn.filters = Util.disabled;
            wingHideBtn.filters = Util.disabled;
            WingCGMessage.CG_WING_SHOW_AND_HIDE(0);
            setTimeout(function():void
            {
               showIsCoolDown = false;
               wingShowBtn.filters = [];
               wingHideBtn.filters = [];
            },60000);
         };
         TipManager.bind(this.dressBtn,"点击即可穿上翅膀，显示玩家此翅膀形象（冷却时间60秒）");
         TipManager.bind(this.wingShowBtn,"点击即可显示翅膀（冷却时间60秒）");
         TipManager.bind(this.wingHideBtn,"点击即可隐藏翅膀（冷却时间60秒）");
         TipManager.bind(this.HuanHuaBtn,"点击即可穿上幻化翅膀（冷却时间60秒）");
         this.costTips = new CostTips();
         addChild(this.costTips);
         this.costTips.x = 153;
         this.costTips.y = 149;
         this.costTips.visible = false;
         Global.control.registerCallBack(Enum_MsgType.ROLE_MODEL_CHANGE,this.changeModel);
      }
      
      private function changeModel() : void
      {
         this.curShow.modelId = GameUnitManager.hero.body;
         this.curShow.weaponDir = GameUnitManager.hero.weapon.toString();
         this.curShow.sex = GameUnitManager.hero.sex;
         this.curShow.updateLayer();
         this.nextShow.modelId = GameUnitManager.hero.body;
         this.nextShow.weaponDir = GameUnitManager.hero.weapon.toString();
         this.nextShow.sex = GameUnitManager.hero.sex;
         this.nextShow.updateLayer();
      }
      
      override public function set visible(value:Boolean) : void
      {
         var point:Point = null;
         if(super.visible == value || this.isRunning)
         {
            return;
         }
         this.isRunning = true;
         if(!value)
         {
            this.tips.hide();
            point = UIManager.special_btn.getPos(3);
            Tween.to(this,300,{
               "scaleX":[1,0],
               "scaleY":[1,0],
               "x":[this.x,point.x],
               "y":[this.y,point.y]
            },this.complete);
         }
         else
         {
            scaleX = 1;
            scaleY = 1;
            super.visible = true;
            Tween.to(this,300,{"alpha":[0,1]},function():void
            {
               isRunning = false;
            });
         }
         if(value)
         {
            Global.control.registerCallBack(Enum_MsgType.MSG_ENTERFRAME,this.curShow.onFrame);
            Global.control.registerCallBack(Enum_MsgType.MSG_ENTERFRAME,this.nextShow.onFrame);
         }
         else
         {
            Global.control.removeCallBack(Enum_MsgType.MSG_ENTERFRAME,this.curShow.onFrame);
            Global.control.removeCallBack(Enum_MsgType.MSG_ENTERFRAME,this.nextShow.onFrame);
            GameScene.instance.removeFrameCallBack(this.frameCallBack);
         }
      }
      
      private function complete() : void
      {
         super.visible = false;
         UIManager.special_btn.getEff(3);
         this.isRunning = false;
      }
      
      private function frameCallBack() : void
      {
         this.pastTime = getTimer() - this.beginTime;
         if(this.pastTime > 1000)
         {
            if(this.pastTime >= Model_wing.blessTime * 1000)
            {
               GameScene.instance.removeFrameCallBack(this.frameCallBack);
               Model_wing.bless = 0;
               Model_wing.blessTime = 0;
               this.effSpr.visible = false;
               this.blessTxt.text = String(Model_wing.bless) + "/" + String(Data_lib.wing[Model_wing.wingId][5]);
               this.progress.persent = Model_wing.bless / Data_lib.wing[Model_wing.wingId][5];
               this.blessLeftTimeTxt.text = DateUtil.getHMSBySecond2(Model_wing.blessTime);
            }
            else
            {
               this.blessLeftTimeTxt.text = DateUtil.getHMSBySecond2(Model_wing.blessTime - this.pastTime / 1000);
            }
         }
      }
      
      private function changeWing(e:MouseEvent) : void
      {
         if(e.currentTarget == this.leftBtn)
         {
            --this.currentShowWingId;
         }
         else if(e.currentTarget == this.rightBtn)
         {
            ++this.currentShowWingId;
         }
         this.updateArrowBtn();
         this.updateModelShow();
      }
      
      private function updateStar() : void
      {
         var nextStarStr:Array = null;
         var lightStar2:int = 0;
         var totalStar2:int = 0;
         var j:int = 0;
         var curStarStr:Array = Data_lib.wing[Model_wing.wingId][2].split("_");
         var lightStar:int = int(curStarStr[0]);
         var totalStar:int = int(curStarStr[1]);
         var i:int = 0;
         while(i < this.curStarArray.length)
         {
            if(i < totalStar)
            {
               if(!this.curStarSprite.contains(this.curStarArray[i]))
               {
                  this.curStarSprite.addChild(this.curStarArray[i]);
               }
               if(i < lightStar)
               {
                  Bitmap(this.curStarArray[i]).filters = [];
               }
               else
               {
                  Bitmap(this.curStarArray[i]).filters = Util.disabled;
               }
            }
            else if(this.curStarSprite.contains(this.curStarArray[i]))
            {
               this.curStarSprite.removeChild(this.curStarArray[i]);
            }
            i++;
         }
         this.curStarSprite.x = 147 - this.curStarSprite.width / 2;
         this.curWingNameTxt.htmlText = Data_lib.wing[Model_wing.wingId][0] + "（" + Data_lib.wing[Model_wing.wingId][1] + "）";
         if(Model_wing.wingId + 1 <= Data_lib.wing.getLength())
         {
            nextStarStr = Data_lib.wing[Model_wing.wingId + 1][2].split("_");
            lightStar2 = int(nextStarStr[0]);
            totalStar2 = int(nextStarStr[1]);
            j = 0;
            while(j < this.nextStarArray.length)
            {
               if(j < totalStar2)
               {
                  if(!this.nextStarSprite.contains(this.nextStarArray[j]))
                  {
                     this.nextStarSprite.addChild(this.nextStarArray[j]);
                  }
                  if(j < lightStar2)
                  {
                     Bitmap(this.nextStarArray[j]).filters = [];
                  }
                  else
                  {
                     Bitmap(this.nextStarArray[j]).filters = Util.disabled;
                  }
               }
               else if(this.nextStarSprite.contains(this.nextStarArray[j]))
               {
                  this.nextStarSprite.removeChild(this.nextStarArray[j]);
               }
               j++;
            }
            this.nextStarSprite.x = 511 - this.nextStarSprite.width / 2;
            this.nextWingNameTxt.htmlText = Data_lib.wing[Model_wing.wingId + 1][0] + "（" + Data_lib.wing[Model_wing.wingId + 1][1] + "）";
         }
      }
      
      private function updateArrowBtn() : void
      {
         if(this.currentShowWingId == 0)
         {
            this.leftBtn.enabled = false;
         }
         else
         {
            this.leftBtn.enabled = true;
         }
         if(this.currentShowWingId == this.maxModelId)
         {
            this.rightBtn.enabled = false;
         }
         else
         {
            this.rightBtn.enabled = true;
         }
      }
      
      private function updateModelShow() : void
      {
         this.voWing.id = Data_lib.wing[this.modelIdArray[this.currentShowWingId]][32];
         this.voWing.Init_lib();
         this.wingGrid.vo = this.voWing;
         this.curShow.wing = Data_lib.wing[this.modelIdArray[this.currentShowWingId]][Enum_job.getBaseJob(GameUnitManager.hero.job) * 2 + GameUnitManager.hero.sex + 6];
         this.curShowTxt.text = Data_lib.wing[this.modelIdArray[this.currentShowWingId]][1];
         this.updateShowBtn();
      }
      
      private function updateModel() : void
      {
         this.updateModelShow();
         if(Model_wing.wingId == Data_lib.wing.getLength())
         {
            this.maxLevelBm.visible = true;
            this.nextShow.visible = false;
            this.nextWingNameTxt.visible = false;
            this.nextStarSprite.visible = false;
         }
         else
         {
            this.maxLevelBm.visible = false;
            this.nextShow.visible = true;
            this.nextWingNameTxt.visible = true;
            this.nextStarSprite.visible = true;
            this.nextShow.wing = Data_lib.wing[Model_wing.wingId + 1][Enum_job.getBaseJob(GameUnitManager.hero.job) * 2 + GameUnitManager.hero.sex + 6];
         }
      }
      
      private function updateAttribute() : void
      {
         var attributeString:String = null;
         var increaseStr:String = null;
         var upAttri:int = 0;
         var i:int = 0;
         while(i < 6)
         {
            if(Boolean(this.currentAttributeArray[Model_wing.wingId - 1][i]))
            {
               this.attributeSpriteArray[i].visible = true;
               attributeString = Model_wing.attributeStringArray[i];
               increaseStr = this.currentAttributeArray[Model_wing.wingId - 1][i][2] == 1 ? String(this.currentAttributeArray[Model_wing.wingId - 1][i][1]) : (int(this.currentAttributeArray[Model_wing.wingId - 1][i][2] * 1000) / 10).toString() + "%";
               this.currentAttributeTxtArray[i].text = attributeString + ":+" + increaseStr;
               TipManager.bind(this.attributeSpriteArray[i],"攻加是指增加翅膀本身攻击属性百分比<br/>" + HtmlUtil.fontNoSize("(攻加所加的攻击:" + String(int(this.currentAttributeArray[Model_wing.wingId - 1][0][1] * this.currentAttributeArray[Model_wing.wingId - 1][1][2])) + ")","#00ff00") + "<br/><br/>" + "抗暴、伤害、伤免只在PVP战斗中计算伤害效果");
               if(Model_wing.wingId < Data_lib.wing.getLength())
               {
                  if(this.upAttributeArray[Model_wing.wingId - 1][i][2] == 1)
                  {
                     if(this.upAttributeArray[Model_wing.wingId - 1][i][1] > 0)
                     {
                        this.attributeArrowArray[i].visible = true;
                        this.upAttributeTxtArray[i].visible = true;
                        this.upAttributeTxtArray[i].text = String(this.upAttributeArray[Model_wing.wingId - 1][i][1]);
                     }
                     else
                     {
                        this.attributeArrowArray[i].visible = false;
                        this.upAttributeTxtArray[i].visible = false;
                     }
                  }
                  else
                  {
                     upAttri = int(this.upAttributeArray[Model_wing.wingId - 1][i][2] * 1000 - this.currentAttributeArray[Model_wing.wingId - 1][i][2] * 1000);
                     if(upAttri > 0)
                     {
                        this.attributeArrowArray[i].visible = true;
                        this.upAttributeTxtArray[i].visible = true;
                        this.upAttributeTxtArray[i].text = (upAttri / 10).toString() + "%";
                     }
                     else
                     {
                        this.attributeArrowArray[i].visible = false;
                        this.upAttributeTxtArray[i].visible = false;
                     }
                  }
               }
               else
               {
                  this.attributeArrowArray[i].visible = false;
                  this.upAttributeTxtArray[i].visible = false;
               }
            }
            else
            {
               this.attributeSpriteArray[i].visible = false;
            }
            i++;
         }
      }
      
      private function updateBless() : void
      {
         this.blessTxt.text = String(Model_wing.bless) + "/" + String(Data_lib.wing[Model_wing.wingId][5]);
         this.progress.persent = Model_wing.bless / Data_lib.wing[Model_wing.wingId][5];
         this.blessLeftTimeTxt.text = DateUtil.getHMSBySecond2(Model_wing.blessTime);
         if(Model_wing.bless > 0)
         {
            this.effSpr.visible = true;
            this.beginTime = getTimer();
            GameScene.instance.addFrameCallBack(this.frameCallBack);
         }
         else
         {
            this.effSpr.visible = false;
            GameScene.instance.removeFrameCallBack(this.frameCallBack);
         }
      }
      
      private function updateMaterial() : void
      {
         var arr:Array = null;
         var materialStr:Array = Data_lib.wing[Model_wing.wingId][3].split(",")[1].split("_");
         this.vomaterial.id = materialStr[1];
         this.vomaterial.count = materialStr[2];
         this.vomaterial.Init_lib();
         this.materialGrid.vo = this.vomaterial;
         this.upCostTxt.text = String(Data_lib.wing[Model_wing.wingId][4]);
         var i:int = 28;
         while(i <= 31)
         {
            arr = Data_lib.wing[Model_wing.wingId][i].split("_");
            if(Model_wing.bless >= int(arr[0]) && Model_wing.bless <= int(arr[1]))
            {
               this.successPercentTxt.text = this.successString[i - 28];
               break;
            }
            i++;
         }
      }
      
      public function update() : void
      {
         var i:* = undefined;
         for(i in this.modelIdArray)
         {
            if(Data_lib.wing[this.modelIdArray[i]][32] == Data_lib.wing[Model_wing.wingId][32])
            {
               this.currentShowWingId = i;
               break;
            }
         }
         this.updateArrowBtn();
         this.updateModel();
         this.updateAttribute();
         this.updateBless();
         this.updateMaterial();
         this.updateStar();
         this.updateShowBtn();
      }
      
      private function showBlessTips(e:MouseEvent) : void
      {
         if(e.type == MouseEvent.ROLL_OVER)
         {
            this.tips.show();
         }
         else
         {
            this.tips.hide();
         }
      }
      
      public function showUpLevelBitmap(flag:int) : void
      {
         if(flag == 1)
         {
            Tween.to(this.successBm,2000,{
               "alpha":[1,0],
               "y":[170,130]
            });
         }
         else if(flag == 2)
         {
            Tween.to(this.failBm,2000,{
               "alpha":[1,0],
               "y":[130,170]
            });
         }
      }
      
      public function updateShowBtn() : void
      {
         var t_canDressLevel:int = 0;
         if(Model_wing.wingId > 0)
         {
            if(GameUnitManager.hero.wing == 0)
            {
               this.wingShowBtn.visible = true;
            }
            else
            {
               this.wingShowBtn.visible = false;
            }
            this.wingHideBtn.visible = !this.wingShowBtn.visible;
            t_canDressLevel = Model_wing.wingId;
            while(t_canDressLevel > 1 && Data_lib.wing[t_canDressLevel - 1][32] == Data_lib.wing[t_canDressLevel][32])
            {
               t_canDressLevel--;
            }
            if(t_canDressLevel >= this.modelIdArray[this.currentShowWingId] && this.wingHideBtn.visible)
            {
               this.dressBtn.visible = true;
            }
            else
            {
               this.dressBtn.visible = false;
            }
         }
      }
   }
}

import com.ui.controls.Button;
import com.ui.controls.CheckBox;
import com.ui.controls.MyTextField;
import com.utils.ComponentUtil;
import com.yiTian.Global;
import com.yiTian.net.message.cg.WingCGMessage;
import com.yiTian.scene.GameScene;
import com.yiTian.utils.HtmlUtil;
import flash.display.Sprite;
import flash.events.MouseEvent;

class blessTips extends Sprite
{
   
   public function blessTips()
   {
      super();
      ComponentUtil.getScaleBitmap("Back_Floating",[8,9,4,2],this,{
         "x":0,
         "y":0,
         "width":472,
         "height":140
      },Global.Img_Cdm);
      ComponentUtil.getBitmap("Dot_JJTS",this,{
         "x":18,
         "y":16
      },Global.ChiBangdm);
      ComponentUtil.getBitmap("Dot_JJTS",this,{
         "x":18,
         "y":76
      },Global.ChiBangdm);
      ComponentUtil.getScaleBitmap("Line",[29,1,2,0],this,{
         "x":13,
         "y":61,
         "width":445,
         "height":2
      },Global.Img_Cdm);
      ComponentUtil.getTextField("什么是祝福值？",this,{
         "x":43,
         "y":11,
         "color":15660032,
         "size":14,
         "leading":0
      });
      ComponentUtil.getTextField("是指翅膀进阶失败后为您增加下次进阶成功的机率，祝福值越高，成功率越高",this,{
         "x":43,
         "y":34,
         "color":16772287,
         "size":12,
         "leading":0
      });
      ComponentUtil.getTextField("什么是祝福值保存倒计时？",this,{
         "x":43,
         "y":70,
         "color":15660032,
         "size":14,
         "leading":0
      });
      ComponentUtil.getTextField("祝福值在进阶成功后和倒计时结束清零，建议您一次性完成进阶，避免错过进\n" + "阶时间，造成损失",this,{
         "x":43,
         "y":92,
         "color":16772287,
         "size":12,
         "leading":3
      });
   }
   
   public function show() : void
   {
      if(!stage)
      {
         GameScene.uiLayer.addChild(this);
      }
      x = Global.stage.mouseX + this.width > Global.stage.stageWidth ? Global.stage.stageWidth - this.width : Global.stage.mouseX;
      y = Global.stage.mouseY + this.height > Global.stage.stageHeight ? Global.stage.stageHeight - this.height : Global.stage.mouseY;
   }
   
   public function hide() : void
   {
      if(Boolean(stage))
      {
         GameScene.uiLayer.removeChild(this);
      }
   }
}

class CostTips extends Sprite
{
   
   private var cost:int;
   
   private var txt:MyTextField;
   
   private var checkBox:CheckBox;
   
   private var OKBtn:Button;
   
   private var NOBtn:Button;
   
   private var closeBtn:Button;
   
   public function CostTips()
   {
      super();
      ComponentUtil.getScaleBitmap("Back1",[149,41,2,5],this,{
         "x":0,
         "y":0,
         "width":350,
         "height":180
      },Global.Img_Cdm);
      ComponentUtil.getScaleBitmap("Back2",[5,5,10,10],this,{
         "x":25,
         "y":41,
         "width":300,
         "height":130
      },Global.Img_Cdm);
      ComponentUtil.getBitmap("Title_WXPrompt",this,{
         "x":96,
         "y":6
      },Global.Img_Cdm);
      ComponentUtil.getTextField("不再提示",this,{
         "x":160,
         "y":96,
         "color":16772287,
         "size":12,
         "leading":0
      });
      this.txt = ComponentUtil.getTextField("材料不足，是否花费xxx元宝购买翅膀羽毛*x",this,{
         "x":56,
         "y":62,
         "color":16768256,
         "size":12,
         "leading":0
      });
      this.OKBtn = ComponentUtil.getButton("确定","Button_Two64",this,{
         "x":86,
         "y":131,
         "textColor":16771436
      },Global.Img_Cdm);
      this.OKBtn.callBack = this.buy;
      this.NOBtn = ComponentUtil.getButton("取消","Button_Two64",this,{
         "x":205,
         "y":131,
         "textColor":16771436
      },Global.Img_Cdm);
      this.NOBtn.callBack = this.closeMenu;
      this.checkBox = ComponentUtil.getCheckBox("","CheckBox01",this,{
         "x":138,
         "y":98,
         "color":16772287
      },Global.Img_Cdm);
      this.closeBtn = ComponentUtil.getButton("","Button_Close",this,{
         "x":315,
         "y":6,
         "textColor":16771436
      },Global.Img_Cdm);
      this.closeBtn.callBack = this.closeMenu;
   }
   
   public function show(money:int, wingCount:int) : void
   {
      if(this.checkBox.selected)
      {
         WingCGMessage.CG_WING_UP_LEVEL(2);
      }
      else
      {
         this.visible = true;
         this.txt.htmlText = "材料不足，是否花费" + HtmlUtil.fontNoSize(money.toString(),"#00ff00") + "元宝购买" + HtmlUtil.fontNoSize("翅膀羽毛*" + wingCount,"#00ff00") + "？";
      }
   }
   
   private function buy(e:MouseEvent) : void
   {
      this.visible = false;
      WingCGMessage.CG_WING_UP_LEVEL(2);
   }
   
   private function closeMenu(e:MouseEvent) : void
   {
      this.visible = false;
   }
}
