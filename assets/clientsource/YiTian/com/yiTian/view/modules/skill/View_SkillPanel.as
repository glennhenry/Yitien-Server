package com.yiTian.view.modules.skill
{
   import com.ui.controls.Button;
   import com.ui.controls.MyTextField;
   import com.ui.controls.ScaleBitmap;
   import com.ui.controls.TabButton;
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.data.Enum_type_grid;
   import com.yiTian.data.config.Enum_bar_swap;
   import com.yiTian.data.config.Enum_job;
   import com.yiTian.data.config.Enum_loaderType;
   import com.yiTian.data.config.Enum_resType;
   import com.yiTian.data.model.Model_store;
   import com.yiTian.data.vo.Vo_Skill;
   import com.yiTian.data.vo.Vo_grid;
   import com.yiTian.data.vo.Vo_item;
   import com.yiTian.data.vo.Vo_valuable;
   import com.yiTian.manager.GameUnitManager;
   import com.yiTian.manager.LangConfig;
   import com.yiTian.manager.TipManager;
   import com.yiTian.manager.UIManager;
   import com.yiTian.net.message.cg.MasterSkillCGMessage;
   import com.yiTian.net.message.cg.SkillCGMessage;
   import com.yiTian.utils.Bitmap2;
   import com.yiTian.utils.HtmlUtil;
   import com.yiTian.utils.MassLoader;
   import com.yiTian.utils.SingleLoader;
   import com.yiTian.utils.Singleton;
   import com.yiTian.utils.Utils;
   import com.yiTian.utils.call.Delegate123;
   import com.yiTian.view.Enum_explor;
   import com.yiTian.view.comp.View_Grid;
   import com.yiTian.view.modules.loading.View_loading;
   import com.yiTian.view.modules.skill.masterSk.MasterSkill;
   import com.yiTian.view.modules.skill.masterSk.View_masterSkill;
   import com.yiTian.view.modules.zhuanZhi.View_ZhuanZhiAtbSp;
   import com.yiTian.view.modules.zhuanZhi.View_zhuanZhiFangXiang;
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.events.TextEvent;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import flash.system.ApplicationDomain;
   import flash.utils.setTimeout;
   import flashx.textLayout.formats.TextAlign;
   
   public class View_SkillPanel extends MasterSkill
   {
      
      public static var saveE:MouseEvent;
      
      public static var nowGrid:View_Grid;
      
      public static var skillDm:ApplicationDomain;
      
      private static var tabArr:Array = [];
      
      private static const GAP:int = 13;
      
      private static var posX_arr:Array = [];
      
      private static var posXX_arr:Array = [];
      
      public static var isLoadURL:Boolean = false;
      
      public static var openType:int = 0;
      
      private var Skill_Name_text:MyTextField;
      
      private var SkillInformat_text:MyTextField;
      
      private var SkillCost_text:MyTextField;
      
      private var extra_txt1:MyTextField;
      
      private var extra_txt2:MyTextField;
      
      private var addCont:addConnect;
      
      private var line1:ScaleBitmap;
      
      private var line2:ScaleBitmap;
      
      private var tfFullLvl:MyTextField;
      
      public var jobAtbIcon:View_ZhuanZhiAtbSp;
      
      private var _curSkillIcon:Bitmap2;
      
      private var nowTab:TabButton;
      
      public var helpBtn:Button;
      
      private var gridPosition:Array = [[167,69],[97,135],[237,135],[97,197],[237,197],[51,259],[237,259],[38 + 30,372 - 30],[145,259],[191,324]];
      
      private var grids:Array = [];
      
      public var battleSkillGrids:Array = [];
      
      private var can_learn_skill_sign:Bitmap;
      
      private var can_up_skill_sign:Bitmap;
      
      private var can_learn_icons:Array = [];
      
      private var can_up_icons:Array = [];
      
      private var skill_lvls:Array = [];
      
      private var wayComp:WayComp;
      
      private var func:Function;
      
      private var _jinJieGrid:View_Grid;
      
      private var _tfJinJie:MyTextField;
      
      private var types:Object = {};
      
      private var isFirstOpen:Boolean = true;
      
      private var arowsLayer:Sprite = new Sprite();
      
      public function View_SkillPanel()
      {
         super();
      }
      
      override protected function initStaticView() : void
      {
         var tab:TabButton = null;
         isTween = true;
         var b1:ScaleBitmap = ComponentUtil.getScaleBitmap("Back1",[149,41,2,5],null,{
            "x":0,
            "y":0,
            "width":525,
            "height":499 + GAP_HEIGHT
         },Global.Img_Cdm);
         var b2:ScaleBitmap = ComponentUtil.getScaleBitmap("Back2",[5,5,10,10],null,{
            "x":24,
            "y":40 + GAP_HEIGHT,
            "width":477,
            "height":449
         },Global.Img_Cdm);
         superAddChildAt(b1,0);
         superAddChildAt(b2,1);
         Model_skill.addMasterUnit(masterSkillContainer);
         var txtArr:Array = ["江湖技能","师门技能"];
         var i:int = 0;
         while(i < 2)
         {
            tab = ComponentUtil.getTabButton(txtArr[i],"TabButton_Four",null,{
               "x":33 + 77 * i,
               "y":43
            },Global.Img_Cdm);
            tabArr.push(tab);
            superAddChildAt(tab,2 + i);
            tab.tabIndex = i;
            if(i == 0)
            {
               tab.choose = true;
               this.nowTab = tab;
            }
            tab.addEventListener(MouseEvent.CLICK,this.tabChange);
            i++;
         }
         addChild(this.arowsLayer);
         this.line1 = ComponentUtil.getScaleBitmap("Line",[29,1,2,0],this,{
            "x":301,
            "y":281,
            "width":184,
            "height":2
         },Global.Img_Cdm);
         this.line2 = ComponentUtil.getScaleBitmap("Line",[29,1,2,0],this,{
            "x":301,
            "y":401,
            "width":184,
            "height":2
         },Global.Img_Cdm);
         move = new Rectangle(0,0,512,36);
         superAddChildAt(moveBar,4);
         var cBtn:Button = CloseButton = ComponentUtil.getButton("","Button_Close",null,{
            "x":478,
            "y":6,
            "textColor":16184781
         },Global.Img_Cdm);
         superAddChildAt(cBtn,5);
         this.extra_txt1 = ComponentUtil.getTextField(LangConfig.getWord("802",0),this,{
            "x":310,
            "y":286,
            "color":16764206,
            "wordWrap":true,
            "multiline":true,
            "realWidth":180,
            "size":14
         });
         this.extra_txt2 = ComponentUtil.getTextField(LangConfig.getWord("808",0),this,{
            "x":310,
            "y":406,
            "color":16764206,
            "wordWrap":true,
            "multiline":true,
            "realWidth":180,
            "size":14
         });
         this.addCont = new addConnect();
         ComponentUtil.setPropertie(this.addCont,{
            "x":310,
            "y":431
         });
         addChild(this.addCont);
         this.tfFullLvl = ComponentUtil.getTextField("已满级",this,{
            "x":308,
            "y":307,
            "bold":true,
            "size":18,
            "color":16742144,
            "realWidth":162,
            "align":TextAlign.CENTER
         });
         this.Skill_Name_text = ComponentUtil.getTextField("技能名字\n类别",this,{
            "x":357,
            "y":59,
            "color":11904647,
            "leading":6
         });
         this.SkillInformat_text = ComponentUtil.getTextField("",this,{
            "x":308,
            "y":109,
            "color":11904647,
            "wordWrap":true,
            "multiline":true,
            "leading":4,
            "realWidth":180
         });
         this.SkillInformat_text.textColor = 11904647;
         this.SkillCost_text = ComponentUtil.getTextField("",this,{
            "x":308,
            "y":311,
            "color":11904647,
            "wordWrap":true,
            "multiline":true,
            "leading":4,
            "realWidth":180
         });
         this.jobAtbIcon = new View_ZhuanZhiAtbSp(false);
         this.jobAtbIcon.setSize(65);
         ComponentUtil.setPropertie(this.jobAtbIcon,{
            "x":50,
            "y":50
         });
         this.jobAtbIcon.setJob(GameUnitManager.hero.job);
         addChild(this.jobAtbIcon);
         ComponentUtil.getBitmap("Grid_Open",this,{
            "x":312,
            "y":59
         },Global.Img_Cdm);
         this._curSkillIcon = new Bitmap2();
         ComponentUtil.setPropertie(this._curSkillIcon,{
            "x":315,
            "y":62
         });
         addChild(this._curSkillIcon);
         this._tfJinJie = ComponentUtil.getTextField("",this,{
            "x":370,
            "y":457,
            "color":16776960,
            "visible":false
         });
         this._tfJinJie.htmlText = HtmlUtil.createLink("点我查看进阶技能");
         this._tfJinJie.mouseEnabled = true;
         this._tfJinJie.addEventListener(TextEvent.LINK,this.linkHd);
         this.wayComp = new WayComp();
         this.wayComp.x = 310;
         this.wayComp.y = 355;
         addChild(this.wayComp);
         this.wayComp.itemOverHd = this.itemOverHd;
      }
      
      private function tabChange(e:MouseEvent) : void
      {
         if(Boolean(this.nowTab) && this.nowTab == e.target)
         {
            return;
         }
         if(e.target.tabIndex == 1)
         {
            saveE = e;
            MasterSkillCGMessage.CG_MASTERSKILL_ICTROL();
            return;
         }
         this.tabChange_MS(e);
      }
      
      public function tabChange_MS(e:MouseEvent = null) : void
      {
         if(Boolean(this.nowTab))
         {
            this.nowTab.choose = false;
         }
         e.target.choose = true;
         this.nowTab = e.target as TabButton;
         switch(e.target.tabIndex)
         {
            case 0:
               commonSkillContainer.visible = true;
               Model_skill.hideMasterSkillPan();
               if(Boolean(this.helpBtn))
               {
                  this.helpBtn.visible = false;
               }
               break;
            case 1:
               commonSkillContainer.visible = false;
               Model_skill.showMasterSkillPan();
               if(!this.helpBtn)
               {
                  this.showHelpBtn();
               }
               this.helpBtn.visible = true;
               if(Model_skill.isGuideSkill)
               {
                  Model_skill.removeGuideObj();
               }
               TipManager.bind(this.helpBtn,LangConfig.getWord("10669",1));
         }
      }
      
      private function showHelpBtn() : void
      {
         this.helpBtn = ComponentUtil.getButton("","Button_HDTips",null,{
            "x":CloseButton.x - 22,
            "y":CloseButton.y,
            "textColor":16184781
         },Global.Img_Cdm);
         superAddChild(this.helpBtn);
      }
      
      override protected function initDynamicView() : void
      {
         var grid:View_Grid = null;
         var add_tf:AddTF = null;
         var i:int = 0;
         var ii:int = 0;
         super.initDynamicView();
         var len:int = int(this.gridPosition.length);
         i = 0;
         while(i < len)
         {
            if(i == 7)
            {
               grid = new View_Grid(true);
               grid.set_bmp_bg(View_Grid.GRID_OPEN_SKILL_SHENGONG);
               grid.set_bmp_over(true,View_Grid.GRID_OVER_SKILL_SHENGONG);
               grid.set_bmp_select(View_Grid.GRID_SELECT_SKILL_SHENGONG);
            }
            else
            {
               grid = new View_Grid();
               grid.set_bmp_bg(View_Grid.GRID_OPEN);
               grid.set_bmp_over(true,View_Grid.GRID_OVER);
               grid.set_bmp_select(View_Grid.GRID_SELECT);
            }
            grid.type = Enum_type_grid.SKILL;
            grid.x = this.gridPosition[i][0];
            grid.y = this.gridPosition[i][1];
            grid.index = i;
            grid.addEventListener(MouseEvent.CLICK,this.selSkill);
            grid.addEventListener(MouseEvent.MOUSE_DOWN,this.onDown);
            addChild(grid);
            if(i != 10)
            {
               this.can_learn_skill_sign = new Bitmap();
               this.can_up_skill_sign = new Bitmap();
               Utils.loadTitle("lang/ch/skillLearn.swf","Ready_Learn",this.can_learn_skill_sign,{
                  "x":grid.x - 25,
                  "y":grid.y - 25
               },this);
               Utils.loadTitle("lang/ch/skillLearn.swf","Ready_LvUp",this.can_up_skill_sign,{
                  "x":grid.x - 25,
                  "y":grid.y - 25
               },this);
               this.can_learn_skill_sign.visible = false;
               this.can_up_skill_sign.visible = false;
               add_tf = new AddTF();
               addChild(add_tf);
               this.skill_lvls.push(add_tf);
               if(i == 7)
               {
                  add_tf.x = grid.x + grid.width + 27;
                  posX_arr.push(add_tf.x);
                  posXX_arr.push(add_tf.x - GAP);
                  add_tf.y = grid.y + grid.height + 32;
               }
               else
               {
                  add_tf.x = grid.x + grid.width + 18;
                  add_tf.y = grid.y + grid.height + 22;
                  posX_arr.push(add_tf.x);
                  posXX_arr.push(add_tf.x - GAP);
               }
               this.can_learn_icons.push(this.can_learn_skill_sign);
               this.can_up_icons.push(this.can_up_skill_sign);
            }
            grid.isAutoLoad = false;
            this.grids.push(grid);
            i++;
         }
         ComponentUtil.getTextField("技能释放顺序：",this,{
            "x":44,
            "y":407,
            "color":16777215,
            "size":12,
            "leading":0
         });
         ii = 0;
         while(ii < 6)
         {
            grid = new View_Grid();
            grid.type = Enum_type_grid.BAR;
            grid.set_bmp_bg(View_Grid.GRID_MAINMENU);
            grid.set_bmp_over(true,null);
            grid.set_tf_info((ii + 1).toString());
            grid.index = ii;
            grid.x = 42 + ii * 41;
            grid.y = 430;
            grid.addEventListener(MouseEvent.MOUSE_DOWN,UIManager.startDrag);
            grid.addEventListener(MouseEvent.MOUSE_UP,this.onUp);
            addChild(grid);
            this.battleSkillGrids.push(grid);
            ii += 1;
         }
      }
      
      private function onUp(e:MouseEvent) : void
      {
         if(!UIManager.isDrag)
         {
            return;
         }
         var upGrid:View_Grid = e.target as View_Grid;
         var dragData:Vo_grid = UIManager.dragObj.grid.vo;
         var dragGrid:View_Grid = UIManager.dragObj.grid;
         if(dragGrid.type == Enum_type_grid.BAR)
         {
            SkillCGMessage.CG_SET_BAR(Enum_bar_swap.BAR_TO_BAR,dragGrid.index + 1,upGrid.index + 1);
         }
         else if(dragGrid.type == Enum_type_grid.SKILL)
         {
            SkillCGMessage.CG_SET_BAR(Enum_bar_swap.SKILL_TO_BAR,dragGrid.index + 1,upGrid.index + 1);
         }
      }
      
      public function setQuickSkillVo(index:int, vo:Vo_grid) : void
      {
         this.battleSkillGrids[index].vo = vo;
         Global.control.sendNotification(View_masterSkill.MSG_SKILL_CHANGE,null);
      }
      
      private function selSkill(e:MouseEvent) : void
      {
         var grid:View_Grid = e.target as View_Grid;
         if(!grid.vo)
         {
            return;
         }
         if(nowGrid == grid)
         {
            return;
         }
         if(Boolean(nowGrid))
         {
            nowGrid.bSelect = false;
         }
         nowGrid = grid;
         nowGrid.bSelect = true;
         this.getsSkillInfo(nowGrid);
         this.showInfo(nowGrid.vo as Vo_Skill);
      }
      
      public function downLoadEffect(_func:Function) : void
      {
         var arr:Array = [];
         this.func = _func;
         arr.push(["lang/ch/skill.swf",function(info:Object):void
         {
            Global.skillEffect = info.applicationDomain;
         },LangConfig.getWord("799",0),Enum_loaderType.SINGLE,Enum_resType.RES_URL]);
         View_loading.instance.load(arr,this.func);
      }
      
      private function getsSkillInfo(_grid:View_Grid) : Object
      {
         var temObj:Object = new Object();
         temObj.learnt_skill = false;
         temObj.up_skill = false;
         if(!_grid.vo)
         {
            return null;
         }
         var ski:Vo_Skill = new Vo_Skill((_grid.vo as Vo_Skill).realId);
         var tem_vo:Vo_Skill = ski;
         var tem_v_skill:Vo_Skill = this.get_front_skill(tem_vo);
         if((_grid.vo as Vo_Skill).current_grade != 0)
         {
            if(GameUnitManager.hero.level >= tem_vo.study_grade && this.learnd_skill(_grid) && Boolean(Model_store.getCount(tem_v_skill.required_prop)))
            {
               temObj.learnt_skill = true;
            }
            else if(GameUnitManager.hero.level >= tem_vo.study_grade && !this.learnd_skill(_grid) && Boolean(Model_store.getCount(tem_v_skill.required_prop)))
            {
               temObj.up_skill = true;
            }
         }
         else if(GameUnitManager.hero.level >= tem_vo.study_grade && this.learnd_skill(_grid) && Boolean(Model_store.getCount(tem_vo.required_prop)))
         {
            temObj.learnt_skill = true;
         }
         else if(GameUnitManager.hero.level >= tem_vo.study_grade && !this.learnd_skill(_grid) && Boolean(Model_store.getCount(tem_vo.required_prop)))
         {
            temObj.up_skill = true;
         }
         return temObj;
      }
      
      private function onDown(e:MouseEvent) : void
      {
         var grid:View_Grid = e.target as View_Grid;
         if(!grid.vo)
         {
            return;
         }
         if(!(grid.vo as Vo_Skill).current_grade)
         {
            return;
         }
         if((grid.vo as Vo_Skill).skill_type >= 2)
         {
            return;
         }
         UIManager.startDrag(e);
      }
      
      private function showDown(value:Boolean, skill:Vo_Skill, _curGrade:int, skillWay:int, roleJobWay:int, curSki:Vo_Skill) : void
      {
         this._tfJinJie.visible = roleJobWay != 0;
         if(skill.current_grade < 10)
         {
            this.types[1] = true;
         }
         else
         {
            delete this.types[1];
         }
         if(skillWay == 0 && skill.current_grade >= 9 && roleJobWay != 0)
         {
            this.types[2] = true;
         }
         else
         {
            delete this.types[2];
         }
         this.addCont.visible = value;
         this._curSkillIcon.load("resource/image/icon/" + skill.str_icon + ".png");
         this.wayComp.update(this.types);
         this.wayComp.updateItem(skill,_curGrade);
         if(skill.current_grade >= 10 && roleJobWay == 0 || skill.current_grade >= 10 && roleJobWay != 0 && skillWay != 0)
         {
            this.SkillCost_text.visible = false;
            this.extra_txt1.visible = false;
            this.extra_txt2.visible = false;
            this.tfFullLvl.visible = true;
         }
         else
         {
            this.SkillCost_text.visible = true;
            this.extra_txt1.visible = true;
            this.extra_txt2.visible = true;
            this.tfFullLvl.visible = false;
            if(Boolean(this.types[1]))
            {
               this.SkillCost_text.htmlText = LangConfig.getWord("797",0) + HtmlUtil.font(this.wayComp.voSkil1.study_grade.toString(),"#4b8ca0") + "\n" + LangConfig.getWord("798",0) + HtmlUtil.font(this.wayComp.vo_item1.str_name,"#4b8ca0");
               if(this.wayComp.voSkil1.current_grade == 1 && this.wayComp.voSkil1.skill_sour == 0)
               {
                  this.addCont.updata(1);
               }
               else
               {
                  this.addCont.updata(this.wayComp.voSkil1.skill_sour + 1);
               }
            }
            else if(Boolean(this.types[2]))
            {
               this.SkillCost_text.htmlText = LangConfig.getWord("797",0) + HtmlUtil.font(this.wayComp.voSkil2.study_grade.toString(),"#4b8ca0") + "\n" + LangConfig.getWord("798",0) + HtmlUtil.font(this.wayComp.vo_item2.str_name,"#4b8ca0");
               if(this.wayComp.voSkil2.current_grade == 1 && this.wayComp.voSkil2.skill_sour == 0)
               {
                  this.addCont.updata(1);
               }
               else
               {
                  this.addCont.updata(this.wayComp.voSkil2.skill_sour + 1);
               }
            }
         }
      }
      
      private function itemOverHd(i:WayItem) : void
      {
         switch(i.type)
         {
            case 1:
               this.SkillCost_text.htmlText = LangConfig.getWord("797",0) + HtmlUtil.font(this.wayComp.voSkil1.study_grade.toString(),"#4b8ca0") + "\n" + LangConfig.getWord("798",0) + HtmlUtil.font(this.wayComp.vo_item1.str_name,"#4b8ca0");
               if(this.wayComp.voSkil1.current_grade == 1 && this.wayComp.voSkil1.skill_sour == 0)
               {
                  this.addCont.updata(1);
                  break;
               }
               this.addCont.updata(this.wayComp.voSkil1.skill_sour + 1);
               break;
            case 2:
               this.SkillCost_text.htmlText = LangConfig.getWord("797",0) + HtmlUtil.font(this.wayComp.voSkil2.study_grade.toString(),"#4b8ca0") + "\n" + LangConfig.getWord("798",0) + HtmlUtil.font(this.wayComp.vo_item2.str_name,"#4b8ca0");
               if(this.wayComp.voSkil2.current_grade == 1 && this.wayComp.voSkil2.skill_sour == 0)
               {
                  this.addCont.updata(1);
                  break;
               }
               this.addCont.updata(this.wayComp.voSkil2.skill_sour + 1);
         }
      }
      
      private function linkHd(e:TextEvent) : void
      {
         var pnl:View_zhuanZhiFangXiang = null;
         pnl = Singleton.getInstance(View_zhuanZhiFangXiang);
         (Singleton.getInstance(Delegate123) as Delegate123).dosomething(pnl,function():void
         {
            pnl.visible = !pnl.visible;
         });
      }
      
      private function changedDesTitle(str:String) : void
      {
         this.extra_txt1.text = str;
      }
      
      private function jinJieClickHd(e:MouseEvent) : void
      {
         var roleJobWay:int = int(Enum_job.getChildWay(GameUnitManager.hero.job));
         if(Boolean(roleJobWay))
         {
            SkillCGMessage.CG_SKILL_STUDY(nowGrid.index + 1,2);
         }
      }
      
      private function showInfo(skill:Vo_Skill) : void
      {
         var tem_v_skill:Vo_Skill = null;
         this.SkillCost_text.htmlText = LangConfig.getWord("797",0) + "\n" + LangConfig.getWord("798",0);
         if(!skill)
         {
            return;
         }
         var skillWay:int = SkillUtil.getSkillZX(skill.id);
         var roleWay:int = int(Enum_job.getChildWay(GameUnitManager.hero.job));
         if(skill.realId != skill.id)
         {
            tem_v_skill = this.get_front_skill(new Vo_Skill(skill.realId));
         }
         else
         {
            tem_v_skill = this.get_front_skill(skill);
         }
         var realSki:Vo_Skill = new Vo_Skill(skill.realId);
         if(skill.current_grade != 0)
         {
            this.changedDesTitle(LangConfig.getWord("802",0));
            if(realSki.current_grade < 10 && skillWay == 0)
            {
               this.showDown(true,realSki,skill.current_grade,skillWay,roleWay,skill);
               this.Skill_Name_text.htmlText = HtmlUtil.font(skill.str_name,"#ffac00") + "\n" + LangConfig.getWord("793",0) + HtmlUtil.font(skill.str_describe,"#ffac00");
               this.SkillInformat_text.htmlText = LangConfig.getWord("794",0) + HtmlUtil.font(skill.target,"#ffac00") + "\n" + LangConfig.getWord("795",0) + HtmlUtil.font(skill.target_str,"#ffac00") + "\n" + LangConfig.getWord("780",0) + HtmlUtil.font(skill.mp_consume.toString(),"#ffac00") + "\n" + LangConfig.getWord("781",0) + HtmlUtil.font(skill.cooltime.toString(),"#ffac00") + "\n" + LangConfig.getWord("796",0) + HtmlUtil.font(skill.effect_description,"#ffac00");
            }
            else if(realSki.current_grade < 10 && skillWay >= 1)
            {
               this.showDown(true,realSki,skill.current_grade,skillWay,roleWay,skill);
               this.Skill_Name_text.htmlText = HtmlUtil.font(skill.str_name,"#ffac00") + "\n" + LangConfig.getWord("793",0) + HtmlUtil.font(skill.str_describe,"#ffac00");
               this.SkillInformat_text.htmlText = LangConfig.getWord("794",0) + HtmlUtil.font(skill.target,"#ffac00") + "\n" + LangConfig.getWord("795",0) + HtmlUtil.font(skill.target_str,"#ffac00") + "\n" + LangConfig.getWord("780",0) + HtmlUtil.font(skill.mp_consume.toString(),"#ffac00") + "\n" + LangConfig.getWord("781",0) + HtmlUtil.font(skill.cooltime.toString(),"#ffac00") + "\n" + LangConfig.getWord("796",0) + HtmlUtil.font(skill.effect_description,"#ffac00");
            }
            else if(realSki.current_grade == 10)
            {
               this.showDown(false,realSki,skill.current_grade,skillWay,roleWay,skill);
               this.Skill_Name_text.htmlText = HtmlUtil.font(skill.str_name,"#ffac00") + "\n" + LangConfig.getWord("793",0) + HtmlUtil.font(skill.str_describe,"#ffac00");
               this.SkillInformat_text.htmlText = LangConfig.getWord("794",0) + HtmlUtil.font(skill.target,"#ffac00") + "\n" + LangConfig.getWord("795",0) + HtmlUtil.font(skill.target_str,"#ffac00") + "\n" + LangConfig.getWord("780",0) + HtmlUtil.font(skill.mp_consume.toString(),"#ffac00") + "\n" + LangConfig.getWord("781",0) + HtmlUtil.font(skill.cooltime.toString(),"#ffac00") + "\n" + LangConfig.getWord("796",0) + HtmlUtil.font(skill.effect_description,"#ffac00");
            }
         }
         else
         {
            this.showDown(true,realSki,skill.current_grade,skillWay,roleWay,skill);
            this.changedDesTitle(LangConfig.getWord("803",0));
            this.Skill_Name_text.htmlText = HtmlUtil.font(skill.str_name,"#ffac00") + "\n" + LangConfig.getWord("793",0) + HtmlUtil.font(skill.str_describe,"#ffac00");
            this.SkillInformat_text.htmlText = LangConfig.getWord("794",0) + HtmlUtil.font(skill.target,"#ffac00") + "\n" + LangConfig.getWord("795",0) + HtmlUtil.font(skill.target_str,"#ffac00") + "\n" + LangConfig.getWord("780",0) + HtmlUtil.font(skill.mp_consume.toString(),"#ffac00") + "\n" + LangConfig.getWord("781",0) + HtmlUtil.font(skill.cooltime.toString(),"#ffac00") + "\n" + LangConfig.getWord("796",0) + HtmlUtil.font(skill.effect_description,"#ffac00");
         }
      }
      
      private function get_front_skill(_vo_skill:Vo_Skill) : Vo_Skill
      {
         var temSkill:Vo_Skill = null;
         if(Boolean(_vo_skill.promo_skill_id))
         {
            return new Vo_Skill(_vo_skill.promo_skill_id);
         }
         return _vo_skill;
      }
      
      private function getVo(voSkill:Vo_Skill) : Vo_grid
      {
         var tem_vo:Vo_item = null;
         var _num:int = voSkill.required_prop;
         if(_num != 0)
         {
            tem_vo = new Vo_item();
            tem_vo.id = _num;
            tem_vo.Init_lib();
            return tem_vo;
         }
         return null;
      }
      
      public function update_choose(_vo:Vo_valuable) : void
      {
         var ski:Vo_Skill = null;
         var tem_skill:Vo_Skill = null;
         var i:int = 0;
         while(i < 10)
         {
            if(this.grids[i].vo.promo_skill_id)
            {
               if((this.grids[i].vo as Vo_Skill).current_grade != 0)
               {
                  ski = new Vo_Skill((this.grids[i].vo as Vo_Skill).realId);
                  tem_skill = new Vo_Skill(ski.promo_skill_id);
                  if(tem_skill.required_prop == _vo.id && GameUnitManager.hero.level >= tem_skill.study_grade)
                  {
                     if(Boolean(nowGrid))
                     {
                        nowGrid.bSelect = false;
                     }
                     this.grids[i].bSelect = true;
                     nowGrid = this.grids[i];
                     this.getsSkillInfo(nowGrid);
                     this.showInfo(nowGrid.vo as Vo_Skill);
                     return;
                  }
               }
            }
            i++;
         }
      }
      
      public function handleHighLevelBookUse(vo:Vo_item) : void
      {
         this.visible = true;
         (this.grids[0] as View_Grid).dispatchEvent(new MouseEvent(MouseEvent.CLICK));
         (this.grids[0] as View_Grid).bSelect = true;
      }
      
      private function learnSkill(e:MouseEvent) : void
      {
         if(!nowGrid)
         {
            Utils.print("请选择技能");
            return;
         }
         SkillCGMessage.CG_SKILL_STUDY(nowGrid.index + 1,1);
      }
      
      override public function set visible(value:Boolean) : void
      {
         var point:Point = null;
         var setN:int = 0;
         super.visible = value;
         if(value)
         {
            this.update_can_study_skill(GameUnitManager.hero.level);
            this.update_can_up_skill(GameUnitManager.hero.level);
            if(this.isFirstOpen)
            {
               SingleLoader.add("lang/ch/SkillSystem_Imgs.swf",this.loadDmComp);
               this.setGridLoad();
               bind_target = Enum_explor.bind(Enum_explor.BTN_SKILL);
               this.isFirstOpen = false;
               this.jobAtbIcon.enableLoad();
            }
            (tabArr[openType] as DisplayObject).dispatchEvent(new MouseEvent(MouseEvent.CLICK));
            if(openType == 1)
            {
               openType = 0;
            }
            if(!isLoadURL)
            {
               this.loadURL();
            }
            this.update();
            if(Model_skill.isGuideSkill)
            {
               if(Boolean(Model_skill.guideObj) && !Model_skill.guideObj.visible)
               {
                  Model_skill.guideObj.visible = true;
               }
               point = localToGlobal(new Point(110,43));
               setN = int(setTimeout(function():void
               {
                  Model_skill.runto(point.x + 35,point.y - 40,90);
               },100));
            }
         }
         else
         {
            if(Model_skill.isGuideSkill)
            {
               if(Boolean(Model_skill.guideObj))
               {
                  Model_skill.guideObj.visible = false;
               }
            }
            this.reset();
         }
      }
      
      private function loadDmComp(info:Object) : void
      {
         var dm:ApplicationDomain = info.applicationDomain;
         skillDm = dm;
         ComponentUtil.getBitmap("Back_Skill",this.arowsLayer,{
            "x":34,
            "y":50
         },dm);
         ComponentUtil.getScaleBitmap("Back_InfList",[3,3,16,16],this.arowsLayer,{
            "x":297,
            "y":50,
            "width":194,
            "height":429
         },dm);
         var titlebm:Bitmap = ComponentUtil.getBitmap("Title_Skill",null,{
            "x":182,
            "y":5
         },dm);
         superAddChildAt(titlebm,6);
         ComponentUtil.getScaleBitmap("ExtureLine",[1,1,2,2],this.arowsLayer,{
            "x":185,
            "y":105,
            "width":4,
            "height":16
         },dm);
         ComponentUtil.getScaleBitmap("ExtureLine",[1,1,2,2],this.arowsLayer,{
            "x":118,
            "y":118,
            "width":140,
            "height":4
         },dm);
         ComponentUtil.getScaleBitmap("ExtureLine",[1,1,2,2],this.arowsLayer,{
            "x":71,
            "y":242,
            "width":92,
            "height":4
         },dm);
         ComponentUtil.getScaleBitmap("ExtureLine",[1,1,2,2],this.arowsLayer,{
            "x":165,
            "y":306,
            "width":92,
            "height":4
         },dm);
         ComponentUtil.getScaleBitmap("ExtureLine",[1,1,2,2],this.arowsLayer,{
            "x":253,
            "y":297,
            "width":4,
            "height":13
         },dm);
         ComponentUtil.getScaleBitmap("ExtureLine",[1,1,2,2],this.arowsLayer,{
            "x":163,
            "y":297,
            "width":4,
            "height":13
         },dm);
         ComponentUtil.getScaleBitmap("ExtureLine",[1,1,2,2],this.arowsLayer,{
            "x":253,
            "y":297,
            "width":4,
            "height":13
         },dm);
         ComponentUtil.getScaleBitmap("ExtureLine",[1,1,2,2],this.arowsLayer,{
            "x":163,
            "y":297,
            "width":4,
            "height":13
         },dm);
         ComponentUtil.getScaleBitmap("ExtureLine",[1,1,2,2],this.arowsLayer,{
            "x":114,
            "y":234,
            "width":4,
            "height":8
         },dm);
         ComponentUtil.getScaleBitmap("JianTou_Img",[3,3,1,5],this.arowsLayer,{
            "x":112,
            "y":171,
            "width":8,
            "height":24
         },dm);
         ComponentUtil.getScaleBitmap("JianTou_Img",[3,3,1,5],this.arowsLayer,{
            "x":161,
            "y":242,
            "width":8,
            "height":16
         },dm);
         ComponentUtil.getScaleBitmap("JianTou_Img",[3,3,1,5],this.arowsLayer,{
            "x":68,
            "y":242,
            "width":8,
            "height":16
         },dm);
         ComponentUtil.getScaleBitmap("JianTou_Img",[3,3,1,5],this.arowsLayer,{
            "x":252,
            "y":171,
            "width":8,
            "height":24
         },dm);
         ComponentUtil.getScaleBitmap("JianTou_Img",[3,3,1,5],this.arowsLayer,{
            "x":252,
            "y":233,
            "width":8,
            "height":24
         },dm);
         ComponentUtil.getScaleBitmap("JianTou_Img",[3,3,1,5],this.arowsLayer,{
            "x":113,
            "y":118,
            "width":8,
            "height":15
         },dm);
         ComponentUtil.getBitmap("JianTou_Img",this.arowsLayer,{
            "x":252,
            "y":118
         },dm);
         ComponentUtil.getBitmap("JianTou_Img",this.arowsLayer,{
            "x":207,
            "y":307
         },dm);
         ComponentUtil.getScaleBitmap("Back_SkillList",[5,5,8,8],this.arowsLayer,{
            "x":302,
            "y":55,
            "width":184,
            "height":48
         },dm);
      }
      
      public function loadURL() : void
      {
         MassLoader.add("resource/image/skill/SkillLV6_7.png",function():void
         {
            isLoadURL = true;
         });
      }
      
      public function setGridLoad() : void
      {
         var i:int = 0;
         while(i < this.grids.length)
         {
            this.grids[i].isAutoLoad = true;
            this.grids[i].beginLoad();
            i++;
         }
      }
      
      public function update_data() : void
      {
         this.update_can_study_skill(GameUnitManager.hero.level);
         this.update_can_up_skill(GameUnitManager.hero.level);
      }
      
      private function reset() : void
      {
         var i:int = 0;
         while(i < this.grids.length)
         {
            this.grids[i].bSelect = false;
            i++;
         }
      }
      
      public function get_first_grid_select(_index:int) : void
      {
         this.grids[_index].bSelect = true;
         nowGrid = this.grids[_index];
         nowGrid.bSelect = true;
         this.getsSkillInfo(nowGrid);
         this.showInfo(nowGrid.vo as Vo_Skill);
      }
      
      public function canLearnd() : Boolean
      {
         var i:int = 0;
         while(i < 10)
         {
            if((this.grids[i].vo as Vo_Skill).current_grade <= 0)
            {
               if(Boolean(this.getsSkillInfo(this.grids[i]).learnt_skill))
               {
                  return true;
               }
            }
            i++;
         }
         return false;
      }
      
      public function canUpSkill(voI:Vo_item) : View_Grid
      {
         var i:int = 0;
         while(i < 10)
         {
            if((this.grids[i].vo as Vo_Skill).current_grade != 0)
            {
               if(Boolean(this.getsSkillInfo(this.grids[i]).up_skill))
               {
                  if(this.upSkillHandle(voI,i))
                  {
                     return this.grids[i];
                  }
               }
            }
            i++;
         }
         return null;
      }
      
      private function upSkillHandle(vo_item:Vo_item, _num:int) : Boolean
      {
         var temVo_skill:Vo_Skill = new Vo_Skill((this.grids[_num].vo as Vo_Skill).realId);
         var temPro_skill:Vo_Skill = new Vo_Skill(temVo_skill.promo_skill_id);
         if(temPro_skill.required_prop == vo_item.id && GameUnitManager.hero.level >= temPro_skill.study_grade)
         {
            return true;
         }
         return false;
      }
      
      public function update() : void
      {
         var vo_skill:Vo_Skill = null;
         var realSkill:Vo_Skill = null;
         var i:int = 0;
         if(Boolean(this.grids))
         {
         }
         var data:Array = Vo_Skill.data;
         if(Boolean(data))
         {
            if(Boolean(data.length))
            {
               i = 0;
               while(i < data.length)
               {
                  (this.grids[i] as View_Grid).vo = data[i];
                  (this.grids[i] as View_Grid).count = (data[i] as Vo_Skill).current_grade;
                  vo_skill = (this.grids[i] as View_Grid).vo as Vo_Skill;
                  if(vo_skill.realId != 0)
                  {
                     realSkill = new Vo_Skill(vo_skill.realId);
                  }
                  if(vo_skill.id == vo_skill.realId)
                  {
                     this.skill_lvls[i].grade = (data[i] as Vo_Skill).current_grade;
                     this.skill_lvls[i].x = posX_arr[i];
                     this.skill_lvls[i].source = "resource/image/skill/SkillLV.png";
                     (this.grids[i] as View_Grid).set_grey(!(data[i] as Vo_Skill).current_grade);
                  }
                  else if(Boolean(realSkill))
                  {
                     this.skill_lvls[i].source = "resource/image/skill/SkillLV6_7.png";
                     this.skill_lvls[i].x = posXX_arr[i];
                     this.skill_lvls[i].gradee(realSkill.current_grade,vo_skill.id - vo_skill.realId);
                  }
                  i++;
               }
            }
         }
      }
      
      public function update_can_study_skill(hero_lvl:int) : void
      {
         var tem_data:Array = Vo_Skill.data;
         var i:int = 0;
         while(i < tem_data.length)
         {
            if(hero_lvl >= tem_data[i].study_grade && this.learnd_skill(this.grids[i]))
            {
               this.set_study(this.grids[i],true);
            }
            i++;
         }
      }
      
      public function update_can_up_skill(hero_lvl:int) : void
      {
         var _vo_skill:Vo_Skill = null;
         var ski:Vo_Skill = null;
         var tem_vo_skill:Vo_Skill = null;
         var tem_data:Array = Vo_Skill.data;
         var i:int = 0;
         while(i < tem_data.length)
         {
            _vo_skill = tem_data[i];
            ski = new Vo_Skill(_vo_skill.realId);
            tem_vo_skill = this.get_front_skill(ski);
            if(hero_lvl >= tem_vo_skill.study_grade && !this.learnd_skill(this.grids[i]) && ski.current_grade != 10)
            {
               this.set_lvl_up(this.grids[i],true);
            }
            else
            {
               this.set_lvl_up(this.grids[i],false);
            }
            i++;
         }
      }
      
      private function learnd_skill(_grid:View_Grid) : Boolean
      {
         var tem_add_tf:AddTF = this.skill_lvls[_grid.index];
         if(tem_add_tf.grade < 1)
         {
            return true;
         }
         return false;
      }
      
      private function set_study(_grid:View_Grid, value:Boolean = false) : void
      {
         this.can_learn_icons[_grid.index].visible = value;
      }
      
      private function set_lvl_up(_grid:View_Grid, value:Boolean = false) : void
      {
         this.can_up_icons[_grid.index].visible = value;
      }
      
      public function updateGrid(index:int) : void
      {
         var grid:View_Grid = null;
         var _num:int = 0;
         var perSkill:Vo_Skill = null;
         var sk:Vo_Skill = null;
         var tem_v_skill:Vo_Skill = null;
         var skill:Vo_Skill = Vo_Skill.data[index];
         if(skill.id == skill.realId)
         {
            grid = this.grids[index];
            grid.vo = Vo_Skill.data[index];
            grid.count = Vo_Skill.data[index].current_grade;
            grid.set_grey(!Vo_Skill.data[index].current_grade);
            this.skill_lvls[index].source = "resource/image/skill/SkillLV.png";
            this.skill_lvls[index].x = posX_arr[index];
            this.set_count(index);
            if(grid == nowGrid)
            {
               this.showInfo(grid.vo as Vo_Skill);
            }
         }
         else
         {
            _num = skill.id - skill.realId;
            perSkill = new Vo_Skill(skill.realId);
            grid = this.grids[index];
            grid.vo = Vo_Skill.data[index];
            grid.count = Vo_Skill.data[index].current_grade;
            grid.set_grey(!Vo_Skill.data[index].current_grade);
            this.skill_lvls[index].source = "resource/image/skill/SkillLV6_7.png";
            this.skill_lvls[index].x = posXX_arr[index];
            this.skill_lvls[index].gradee(perSkill.current_grade,_num);
            if(this.skill_lvls[index].grade > 0)
            {
               if(Boolean(this.can_learn_icons[index].visible))
               {
                  this.can_learn_icons[index].visible = false;
               }
               if(Boolean(this.can_up_icons[index]))
               {
                  this.can_up_icons[index].visible = true;
               }
            }
            sk = new Vo_Skill(skill.realId);
            if(sk.current_grade == 10)
            {
               if(Boolean(this.can_up_icons[index]))
               {
                  this.can_up_icons[index].visible = false;
               }
            }
            if(grid == nowGrid)
            {
               this.showInfo(grid.vo as Vo_Skill);
            }
            tem_v_skill = this.get_front_skill(perSkill);
         }
      }
      
      public function getGrid(index:int) : View_Grid
      {
         return this.grids[index];
      }
      
      private function set_count(_index:int) : void
      {
         this.skill_lvls[_index].grade = Vo_Skill.data[_index].current_grade;
         if(this.skill_lvls[_index].grade > 0)
         {
            if(Boolean(this.can_learn_icons[_index].visible))
            {
               this.can_learn_icons[_index].visible = false;
            }
         }
         var temVo_skill:Vo_Skill = this.get_front_skill(new Vo_Skill((Vo_Skill.data[_index] as Vo_Skill).realId));
         if(temVo_skill.study_grade > GameUnitManager.hero.level || (Vo_Skill.data[_index] as Vo_Skill).current_grade >= 10)
         {
            if(Boolean(this.can_up_icons[_index].visible))
            {
               this.can_up_icons[_index].visible = false;
            }
         }
         else if(Boolean(this.can_up_icons[_index]))
         {
            this.can_up_icons[_index].visible = true;
         }
      }
      
      override public function resetPosition() : void
      {
         x = (Global.stage.stageWidth - width) / 2;
         y = (Global.stage.stageHeight - height) / 2;
      }
   }
}

import Layout.ILayout;
import Layout.VGroup;
import com.ui.controls.Button;
import com.ui.controls.MyTextField;
import com.utils.ComponentUtil;
import com.yiTian.Global;
import com.yiTian.data.Data_lib;
import com.yiTian.data.config.Enum_job;
import com.yiTian.data.vo.Vo_Skill;
import com.yiTian.data.vo.Vo_item;
import com.yiTian.manager.CommandManager;
import com.yiTian.manager.GameUnitManager;
import com.yiTian.manager.LangConfig;
import com.yiTian.manager.UIManager;
import com.yiTian.net.message.cg.SkillCGMessage;
import com.yiTian.utils.HtmlUtil;
import com.yiTian.utils.Pool;
import com.yiTian.utils.Singleton;
import com.yiTian.utils.Utils;
import com.yiTian.view.comp.View_Grid;
import com.yiTian.view.modules.Shopping.shoppingMall.ShoppingMallPan;
import com.yiTian.view.modules.skill.View_SkillPanel;
import flash.display.Bitmap;
import flash.display.Shape;
import flash.display.Sprite;
import flash.events.MouseEvent;
import flash.events.TextEvent;
import flash.text.TextFormatAlign;

class AddTF extends Sprite
{
   
   private var tf:MyTextField;
   
   private var temBMP:Bitmap = new Bitmap();
   
   private var _source:String;
   
   private var _grade:int;
   
   public function AddTF()
   {
      super();
      mouseChildren = false;
      mouseEnabled = false;
      addChild(this.temBMP);
      this.source = "resource/image/skill/SkillLV.png";
      this.tf = ComponentUtil.getTextField("0",this,{"align":TextFormatAlign.CENTER});
      this.tf.x = this.width / 2 + 1;
   }
   
   public function set source(url:String) : void
   {
      if(Boolean(this.temBMP))
      {
         this.temBMP.bitmapData = null;
      }
      this._source = url;
      this.temBMP = Utils.getLoadBitmap(url,this.temBMP);
   }
   
   public function set grade(_num:int) : void
   {
      this.tf.realWidth = 20;
      this.tf.htmlText = String(_num);
      this._grade = _num;
      this.tf.x = this.width / 2 - 10;
   }
   
   public function gradee(_num:int, extral:int) : void
   {
      this.tf.realWidth = 34;
      this.tf.htmlText = HtmlUtil.font(String(_num),"#ffffff") + HtmlUtil.font("+" + String(extral),"#ff7700");
      this._grade = _num + extral;
      this.tf.x = this.width / 2 - 18;
   }
   
   public function get grade() : int
   {
      return this._grade;
   }
}

class addConnect extends Sprite
{
   
   private var tf1:MyTextField;
   
   private var tf2:MyTextField;
   
   private var jy_mask:Shape;
   
   private var typeArr:Array = [[LangConfig.getWord("805",0),LangConfig.getWord("7",0)],[LangConfig.getWord("806",0),LangConfig.getWord("309",0)]];
   
   private var _type:int;
   
   public function addConnect()
   {
      super();
      this.tf1 = ComponentUtil.getTextField("",this);
      this.tf1.textColor = 11904647;
      this.tf1.mouseEnabled = true;
      this.tf2 = ComponentUtil.getTextField("",this,{"x":102});
      this.tf2.textColor = 14662240;
      this.jy_mask = ComponentUtil.getShape(30,18,16711680,0);
      this.jy_mask.x = 102;
      addChild(this.jy_mask);
   }
   
   public function updata(type:int) : void
   {
      this._type = type;
      this.tf1.htmlText = HtmlUtil.font(this.typeArr[this._type - 1][0] + "        ","#afb495",12) + HtmlUtil.font(HtmlUtil.underLine(HtmlUtil.link(this.typeArr[this._type - 1][1],"event")),"#ccff00",12);
      this.reSize();
      this.jy_mask.addEventListener(MouseEvent.ROLL_OVER,this.overHandle);
      this.jy_mask.addEventListener(MouseEvent.ROLL_OUT,this.outHandle);
      this.jy_mask.addEventListener(MouseEvent.CLICK,this.clickHandle);
      this.tf1.addEventListener(TextEvent.LINK,this.linkHandle);
   }
   
   private function linkHandle(e:TextEvent) : void
   {
      var pan:ShoppingMallPan = null;
      if(this._type == 1)
      {
         UIManager.long_way_shop.set_title("ZAHUODIAN",52301);
         UIManager.long_way_shop.visible = true;
      }
      else if(this._type == 2)
      {
         pan = Singleton.getInstance(ShoppingMallPan) as ShoppingMallPan;
         pan.openView(4,1);
      }
   }
   
   public function reSize() : void
   {
      this.jy_mask.width = this.tf2.width;
      this.jy_mask.height = this.tf2.height;
   }
   
   private function overHandle(e:MouseEvent) : void
   {
      this.tf2.underline = true;
   }
   
   private function outHandle(e:MouseEvent) : void
   {
      this.tf2.underline = false;
      if(this.jy_mask.hasEventListener(MouseEvent.ROLL_OVER))
      {
         this.jy_mask.removeEventListener(MouseEvent.ROLL_OVER,this.overHandle);
      }
      if(this.jy_mask.hasEventListener(MouseEvent.ROLL_OUT))
      {
         this.jy_mask.removeEventListener(MouseEvent.ROLL_OUT,this.outHandle);
      }
      if(this.jy_mask.hasEventListener(MouseEvent.CLICK))
      {
         this.jy_mask.removeEventListener(MouseEvent.CLICK,this.clickHandle);
      }
   }
   
   private function clickHandle(e:MouseEvent) : void
   {
      if(this._type == 1)
      {
         trace("功能没做");
      }
      else if(this._type == 2)
      {
         trace("功能没做");
      }
   }
}

class WayComp extends Sprite
{
   
   private var gi:ILayout;
   
   private var items:Array = [];
   
   public var voSkil1:Vo_Skill;
   
   public var voSkil2:Vo_Skill;
   
   public var vo_item1:Vo_item;
   
   public var vo_item2:Vo_item;
   
   private var _f:Function;
   
   public function WayComp()
   {
      super();
      this.gi = new VGroup(0,0,0,0,0,90);
   }
   
   public function update(types:Object) : void
   {
      var it:WayItem = null;
      var k:String = null;
      var wayItem:WayItem = null;
      this.gi.clearItem();
      for each(it in this.items)
      {
         removeChild(it);
         Pool.saveObject(it);
      }
      this.items.splice(0);
      for(k in types)
      {
         wayItem = Pool.getObject(WayItem);
         wayItem.type = int(k);
         this.gi.appendItem(wayItem);
         this.items.push(wayItem);
         addChild(wayItem);
         wayItem.btn.callBack = this.btnClick;
         wayItem.addEventListener(MouseEvent.ROLL_OVER,this.onRollOverHd);
      }
      this.gi.align();
   }
   
   private function onRollOverHd(e:MouseEvent) : void
   {
      if(e.currentTarget is WayItem && this._f != null)
      {
         this._f(e.currentTarget as WayItem);
      }
   }
   
   public function set itemOverHd(f:Function) : void
   {
      this._f = f;
   }
   
   private function btnClick(e:MouseEvent) : void
   {
      var target:WayItem = (e.target as Button).parent as WayItem;
      SkillCGMessage.CG_SKILL_STUDY(View_SkillPanel.nowGrid.index + 1,target.type);
   }
   
   public function updateItem(vo:Vo_Skill, _curGrade:int) : void
   {
      var nxtSkillId:int = 0;
      var item:WayItem = null;
      var roleJobWay:int = 0;
      for each(item in this.items)
      {
         if(item.type == 1)
         {
            if(_curGrade == 0)
            {
               nxtSkillId = vo.id;
               item.btn.label = LangConfig.getWord("800",0);
               item.btn.LabelResize(9,3);
            }
            else
            {
               nxtSkillId = vo.promo_skill_id;
               item.btn.label = LangConfig.getWord("801",0);
               item.btn.LabelResize(9,3);
            }
            this.vo_item1 = new Vo_item();
            this.voSkil1 = new Vo_Skill(nxtSkillId);
            this.vo_item1.id = this.voSkil1.required_prop;
            this.vo_item1.Init_lib();
            item.needGrid.vo = this.vo_item1;
            item.btn.enabled = CommandManager.get_bag_count(this.vo_item1.id) > 0 && GameUnitManager.hero.level >= Data_lib.skill[nxtSkillId][Vo_Skill.STUDY_GRADE];
            item.needGrid.set_grey(!item.btn.enabled);
         }
         else if(item.type == 2)
         {
            item.btn.label = "进阶";
            roleJobWay = int(Enum_job.getChildWay(GameUnitManager.hero.job));
            if(roleJobWay > 0)
            {
               nxtSkillId = roleJobWay == 1 ? vo.zPromo_skill_id : vo.xPromo_skill_id;
               this.vo_item2 = new Vo_item();
               this.voSkil2 = new Vo_Skill(nxtSkillId);
               this.vo_item2.id = roleJobWay == 1 ? Number(this.voSkil2.zRequired) : Number(this.voSkil2.xRequired);
               this.vo_item2.Init_lib();
               item.needGrid.vo = this.vo_item2;
               item.btn.enabled = CommandManager.get_bag_count(this.vo_item2.id) > 0 && GameUnitManager.hero.level >= Data_lib.skill[nxtSkillId][Vo_Skill.STUDY_GRADE];
               item.needGrid.set_grey(!item.btn.enabled);
            }
         }
      }
   }
}

class WayItem extends Sprite
{
   
   public var _type:int;
   
   public var needGrid:View_Grid;
   
   public var btn:Button;
   
   public function WayItem()
   {
      super();
      this.needGrid = new View_Grid();
      this.needGrid.x = 0;
      this.needGrid.y = 0;
      this.needGrid.set_bmp_bg();
      this.needGrid.set_bmp_over(true,null);
      addChild(this.needGrid);
      this.btn = ComponentUtil.getButton("","Button_Two",this,{
         "x":39,
         "y":8
      },Global.Img_Cdm);
   }
   
   public function set type(v:int) : void
   {
      this._type = v;
   }
   
   public function get type() : int
   {
      return this._type;
   }
}
