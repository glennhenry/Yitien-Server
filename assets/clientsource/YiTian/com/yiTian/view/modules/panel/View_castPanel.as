package com.yiTian.view.modules.panel
{
   import com.ui.controls.Button;
   import com.ui.controls.TabButton;
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.command.Enum_MsgType;
   import com.yiTian.data.config.Enum_loaderType;
   import com.yiTian.data.config.Enum_quest_step_type;
   import com.yiTian.data.config.Enum_resType;
   import com.yiTian.data.config.valuable.Enum_filter;
   import com.yiTian.data.model.Model_bag;
   import com.yiTian.data.model.Model_cast;
   import com.yiTian.data.model.Model_quest;
   import com.yiTian.manager.CommandManager;
   import com.yiTian.manager.GameUnitManager;
   import com.yiTian.manager.LangConfig;
   import com.yiTian.manager.QuestGuiManager;
   import com.yiTian.manager.UIManager;
   import com.yiTian.net.message.cg.CastCGMessage;
   import com.yiTian.utils.SingleLoader;
   import com.yiTian.utils.Tween;
   import com.yiTian.view.ControlPan;
   import com.yiTian.view.modules.bag.View_panel;
   import com.yiTian.view.modules.cast.View_cast_base;
   import com.yiTian.view.modules.cast.View_equip_CZ_xilian;
   import com.yiTian.view.modules.cast.View_equip_ChengZhuang_jingLian;
   import com.yiTian.view.modules.cast.View_equip_decompose;
   import com.yiTian.view.modules.cast.View_equip_hole;
   import com.yiTian.view.modules.cast.View_equip_inlay;
   import com.yiTian.view.modules.cast.View_equip_inten_change;
   import com.yiTian.view.modules.cast.View_equip_intensify;
   import com.yiTian.view.modules.cast.View_equip_polish;
   import com.yiTian.view.modules.cast.View_gem_compose;
   import com.yiTian.view.modules.cast.newUnit.View_equip_DianHua;
   import com.yiTian.view.modules.cast.newUnit.View_equip_jinJi;
   import com.yiTian.view.modules.chat.EffecObj;
   import com.yiTian.view.modules.guide.View_questGuiJian;
   import com.yiTian.view.modules.loading.View_loading;
   import com.yiTian.view.modules.newRolePan.View_rolePan;
   import com.yiTian.view.modules.wuXing.WuXingMter;
   import flash.display.Bitmap;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   
   public class View_castPanel extends View_panel
   {
      
      private static const INDEX:int = 38;
      
      private static const COUNT:int = 11;
      
      private static var urlStr:Array = ["Title_QiangHua","Title_BaoShi","Title_XiLian","Title_FenJie","Title_ZhuanYi","Title_HeCheng","Title_ZhiZuo","Title_JingLian","Title_CZXiLian","Title_DianHua","Title_JinJi"];
      
      private var ARR_STR:Array = new Array();
      
      private var view_now:View_cast_base;
      
      private var vec_view:Vector.<View_cast_base>;
      
      private var tbtn_now:TabButton;
      
      private var vec_tbtn:Vector.<TabButton>;
      
      private var closeBtn:Button;
      
      private var bmp:Bitmap;
      
      private var point:Point;
      
      public var isGetObj:Boolean = false;
      
      private var isFinishVis:Boolean = false;
      
      private var isFirstOpen:Boolean = true;
      
      private var tipBtn:TabButton;
      
      public function View_castPanel()
      {
         super();
      }
      
      override protected function initStaticView() : void
      {
         var tbtn:TabButton = null;
         var v:View_cast_base = null;
         var i:int = 0;
         ComponentUtil.getScaleBitmap("Back1",[149,41,2,5],this,{
            "x":0,
            "y":0,
            "width":714,
            "height":462
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back2",[5,5,10,10],this,{
            "x":24,
            "y":40,
            "width":666,
            "height":412
         },Global.Img_Cdm);
         this.bmp = new Bitmap();
         addChild(this.bmp);
         ComponentUtil.setPropertie(this.bmp,{
            "x":300,
            "y":6
         });
         move = new Rectangle(0,0,600,36);
         this.ARR_STR = [LangConfig.getWord("220",0),LangConfig.getWord("877",0),LangConfig.getWord("252",0),LangConfig.getWord("155",0),LangConfig.getWord("209",0),LangConfig.getWord("268",0),LangConfig.getWord("189",0),LangConfig.getWord("937",0),LangConfig.getWord("938",0),"套装点化","装备晋级"];
         this.closeBtn = ComponentUtil.getButton("","Button_Close",this,{
            "x":676,
            "y":6,
            "textColor":16184781,
            "callBack":function(e:MouseEvent):void
            {
               visible = false;
            }
         },Global.Img_Cdm);
         this.vec_tbtn = new Vector.<TabButton>(COUNT,true);
         this.vec_view = new Vector.<View_cast_base>(COUNT,true);
         i = 0;
         while(i < COUNT)
         {
            switch(i)
            {
               case Enum_panel_cast.EQUIP_INTENSIFY:
                  v = new View_equip_intensify();
                  break;
               case Enum_panel_cast.EQUIP_HOLE:
                  v = new View_equip_hole();
                  break;
               case Enum_panel_cast.EQUIP_INLAY:
                  v = new View_equip_polish();
                  break;
               case Enum_panel_cast.EQUIP_DECOMPOSE:
                  v = new View_equip_decompose();
                  break;
               case Enum_panel_cast.GEM_INSTENSITY_CHANGE:
                  v = new View_equip_inten_change();
                  break;
               case Enum_panel_cast.GEM_COMPOSE:
                  v = new View_gem_compose();
                  break;
               case Enum_panel_cast.EQUIP_POLISH:
                  v = new View_equip_inlay();
                  break;
               case Enum_panel_cast.EQUIP_CZ_JINGLIAN:
                  v = new View_equip_ChengZhuang_jingLian();
                  break;
               case Enum_panel_cast.EQUIP_CZ_XILIAN:
                  v = new View_equip_CZ_xilian();
                  break;
               case Enum_panel_cast.EQUIP_DIANHUA:
                  v = new View_equip_DianHua();
                  break;
               case Enum_panel_cast.EQUIP_JINJI:
                  v = new View_equip_jinJi();
            }
            addChild(v);
            v.visible = false;
            this.vec_view[i] = v;
            View_cast_base.Init_static(this);
            v.Init();
            tbtn = ComponentUtil.getTabButton(this.ARR_STR[i],"ClassButton",this,{
               "x":INDEX,
               "y":57 + i * 34,
               "textColor":16773818,
               "chooseColor":16773818
            },Global.Img_Cdm);
            if(i == 10)
            {
               ComponentUtil.setPropertie(tbtn,{
                  "x":INDEX,
                  "y":57 + (i - 1) * 34
               });
            }
            if(i >= 7)
            {
               tbtn.visible = false;
            }
            tbtn.addEventListener(MouseEvent.CLICK,this.CLICK_TBTN);
            tbtn.tabIndex = i;
            tbtn.textColor = 14155520;
            tbtn.chooseColor = 8437092;
            this.vec_tbtn[i] = tbtn;
            i++;
         }
      }
      
      override protected function initDynamicView() : void
      {
         this.view_now = this.vec_view[Enum_panel_cast.EQUIP_INTENSIFY];
         this.view_now.display();
         this.tbtn_now = this.vec_tbtn[Enum_panel_cast.EQUIP_INTENSIFY];
         this.tbtn_now.choose = true;
      }
      
      override public function resetPosition() : void
      {
         x = (Global.stage.stageWidth - 726) / 2;
         y = (Global.stage.stageHeight - 496) / 2;
      }
      
      public function setTabEnable(value:Boolean) : void
      {
         var tabItem:TabButton = null;
         for each(tabItem in this.vec_tbtn)
         {
            tabItem.mouseEnabled = value;
         }
      }
      
      public function showQuestGuide() : void
      {
         if(Model_quest.checkCurMainQStepType(Enum_quest_step_type.EQUIP_STRENGTH))
         {
            this.reset();
            this.updata_choose(Enum_panel_cast.EQUIP_INTENSIFY);
            (this.vec_view[Enum_panel_cast.EQUIP_INTENSIFY] as View_equip_intensify).getClickGrid(UIManager.rolePanel.view_role_equip.getSmallestGrid());
            QuestGuiManager.addKuang(this,301,299,80,32);
            QuestGuiManager.addJian(this,388,316,180);
         }
      }
      
      public function showCloseGuide() : void
      {
         QuestGuiManager.addKuang(this,this.closeBtn.x - 5,this.closeBtn.y - 5,this.closeBtn.width + 10,this.closeBtn.height + 10);
         QuestGuiManager.addJian(this,this.closeBtn.width + this.closeBtn.x + 3,this.closeBtn.height / 2 + this.closeBtn.y,180);
      }
      
      private function comp() : void
      {
         super.visible = false;
         this.isFinishVis = false;
         UIManager.special_btn.getEff(1);
      }
      
      public function getObj() : void
      {
         this.point = UIManager.special_btn.getPos(1);
         this.isGetObj = true;
      }
      
      override public function set visible(value:Boolean) : void
      {
         if(value == false)
         {
            Model_bag.isCastDiscard = 0;
            if(this.isFinishVis)
            {
               return;
            }
            if(!this.isGetObj)
            {
               this.getObj();
            }
            this.isFinishVis = true;
            Tween.to(this,300,{
               "scaleX":[1,0],
               "scaleY":[1,0],
               "x":[this.x,this.point.x],
               "y":[this.y,this.point.y]
            },this.comp);
            this.view_now.re_set();
            this.reset();
            if(this.tbtn_now != this.vec_tbtn[0])
            {
               this.tbtn_now.choose = false;
            }
            this.vec_tbtn[0].choose = true;
            this.tbtn_now = this.vec_tbtn[0];
            ControlPan.dic_panel[ControlPan.CAST] = null;
            if(View_questGuiJian.instance.bindSpr == this)
            {
               UIManager.questTraceView.showMainQGuide();
            }
         }
         else
         {
            scaleX = 1;
            scaleY = 1;
            super.visible = value;
            if(this.isFirstOpen)
            {
               this.isFirstOpen = false;
               SingleLoader.add("lang/ch/Forging_Imgs.swf",function(info:Object):void
               {
                  Global.Forging_Imgsdm = info.applicationDomain;
               });
            }
            ControlPan.dic_panel[ControlPan.CAST] = this;
            Tween.to(this,300,{"alpha":[0,1]});
            if(!Global.wordEffect)
            {
               this.downLoadEffect();
            }
            if(Model_bag.isCastDiscard == 0 && Model_bag.pwdLockState == Model_bag.PWD_STATE_LOCK_T)
            {
               this.view_now = this.vec_view[Enum_panel_cast.EQUIP_DECOMPOSE];
               Model_cast.CAST_TYPE = Enum_panel_cast.EQUIP_DECOMPOSE;
               this.view_now.visible = true;
               this.view_now.display();
               this.showQuestGuide();
               this.showTitle(Model_cast.CAST_TYPE);
               this.vec_tbtn[Enum_panel_cast.EQUIP_DECOMPOSE].dispatchEvent(new MouseEvent(MouseEvent.CLICK));
            }
            else
            {
               this.view_now = this.vec_view[Enum_panel_cast.EQUIP_INTENSIFY];
               Model_cast.CAST_TYPE = Enum_panel_cast.EQUIP_INTENSIFY;
               this.view_now.visible = true;
               this.view_now.display();
               this.showQuestGuide();
               this.showTitle(Model_cast.CAST_TYPE);
               this.vec_tbtn[Enum_panel_cast.EQUIP_INTENSIFY].dispatchEvent(new MouseEvent(MouseEvent.CLICK));
            }
            WuXingMter.getPan(View_rolePan,function(pan:View_rolePan):void
            {
               if(pan.visible)
               {
                  pan.visible = false;
               }
            });
            this.showTips();
            this.L_toTabBtn();
         }
         ControlPan.panelControl(this);
      }
      
      private function L_toTabBtn() : void
      {
         var show_JJ:Function = null;
         var show_czJL:Function = null;
         show_JJ = function():void
         {
            if(GameUnitManager.hero.level < 51)
            {
               return;
            }
            Global.control.removeCallBack(Enum_MsgType.MSG_LV_UP_2,show_JJ);
            vec_tbtn[Enum_panel_cast.EQUIP_JINJI].visible = true;
         };
         show_czJL = function():void
         {
            if(GameUnitManager.hero.level < 45)
            {
               return;
            }
            Global.control.removeCallBack(Enum_MsgType.MSG_LV_UP_2,show_czJL);
            vec_tbtn[Enum_panel_cast.EQUIP_CZ_JINGLIAN].visible = true;
            vec_tbtn[Enum_panel_cast.EQUIP_CZ_XILIAN].visible = true;
         };
         if(GameUnitManager.hero.level < 51)
         {
            Global.control.registerCallBack(Enum_MsgType.MSG_LV_UP_2,show_JJ);
         }
         else
         {
            show_JJ();
         }
         if(GameUnitManager.hero.level < 45)
         {
            Global.control.registerCallBack(Enum_MsgType.MSG_LV_UP_2,show_czJL);
         }
         else
         {
            show_czJL();
         }
      }
      
      public function lvUp() : void
      {
         if(GameUnitManager.hero.level < 70)
         {
            this.vec_tbtn[10].visible = false;
            Global.control.registerCallBack(Enum_MsgType.MSG_LV_UP,this.show);
         }
         else
         {
            this.vec_tbtn[10].visible = true;
         }
      }
      
      private function show() : void
      {
         if(GameUnitManager.hero.level >= 70)
         {
            this.vec_tbtn[10].visible = true;
            Global.control.removeCallBack(Enum_MsgType.MSG_LV_UP,this.show);
            if(visible == true)
            {
               if(this.view_now != this.vec_view[10])
               {
                  if(Model_cast.isFirOpen_jinJiPan)
                  {
                  }
               }
            }
         }
      }
      
      private function showTitle(_index:int) : void
      {
         if(Boolean(this.bmp))
         {
            this.bmp.bitmapData = null;
         }
         if(!Global.Forging_Imgsdm)
         {
            SingleLoader.add("lang/ch/Forging_Imgs.swf",function(info:Object):void
            {
               Global.Forging_Imgsdm = info.applicationDomain;
               showT(_index);
            });
         }
         else
         {
            this.showT(_index);
         }
      }
      
      private function showT(_index:int) : void
      {
         this.bmp.bitmapData = ComponentUtil.getBitmapData(urlStr[_index],Global.Forging_Imgsdm);
         setChildIndex(this.bmp,2);
      }
      
      public function downLoadEffect() : void
      {
         var arr:Array = [];
         arr.push(["lang/ch/wordEffects.swf",function(info:Object):void
         {
            Global.wordEffect = info.applicationDomain;
         },LangConfig.getWord("799",0),Enum_loaderType.SINGLE,Enum_resType.RES_URL]);
         View_loading.instance.load(arr);
      }
      
      public function updata_choose(type:int) : void
      {
         if(Boolean(this.tbtn_now))
         {
            this.tbtn_now.choose = false;
         }
         var i:int = 0;
         while(i < this.vec_view.length)
         {
            this.vec_view[i].visible = false;
            i++;
         }
         this.vec_tbtn[type].choose = true;
         this.tbtn_now = this.vec_tbtn[type];
         this.view_now = this.vec_view[type];
         this.view_now.visible = true;
         this.view_now.display();
      }
      
      public function update() : void
      {
         this.view_now.update();
      }
      
      public function update_up_down() : void
      {
         this.view_now.update_upAndDown();
      }
      
      public function update_bag_emp(arr_gridId:Array) : void
      {
         this.view_now.bagEmpthHandle(arr_gridId);
      }
      
      public function changeEquipBag(_equips:Array) : void
      {
         this.view_now.changeEquipBag(_equips);
      }
      
      public function changeEquipSelf(_equips:Array) : void
      {
         this.view_now.changeEquipSelf(_equips);
      }
      
      public function update_role_emp(_grid_id:int) : void
      {
         this.view_now.roleEmptyHandle(_grid_id);
      }
      
      public function update_success_copy() : void
      {
         this.view_now.update_success_copy();
      }
      
      public function update_success_hold(result:int) : void
      {
         if(this.vec_view[1].visible)
         {
            (this.vec_view[1] as View_equip_hole).successHold(result);
         }
      }
      
      public function intensGetEffect(result:int) : void
      {
         if(this.vec_view[0].visible)
         {
            (this.vec_view[0] as View_equip_intensify).intensGetEffect(result);
         }
      }
      
      public function jinJiHandle(result:int) : void
      {
         if(this.vec_view[10].visible)
         {
            (this.vec_view[10] as View_equip_jinJi).intensGetEffect(result);
         }
      }
      
      public function dianHuaHandle(result:int) : void
      {
         if(this.vec_view[9].visible)
         {
            (this.vec_view[9] as View_equip_DianHua).update_success_changed(result);
         }
      }
      
      public function update_success_gemCompose() : void
      {
         if(this.vec_view[5].visible)
         {
            (this.vec_view[5] as View_gem_compose).intensGemComp();
         }
      }
      
      public function update_success_changed() : void
      {
         if(this.vec_view[2].visible)
         {
            (this.vec_view[2] as View_equip_polish).update_success_changed();
         }
      }
      
      public function update_success_insChanged() : void
      {
         if(this.vec_view[4].visible)
         {
            (this.vec_view[4] as View_equip_inten_change).update_success_insChanged();
         }
      }
      
      public function update_fail_insChanged() : void
      {
         if(this.vec_view[4].visible)
         {
            (this.vec_view[4] as View_equip_inten_change).update_fail_insChanged();
         }
      }
      
      public function updata_refine() : void
      {
         if(this.vec_view[7].visible)
         {
            (this.vec_view[7] as View_equip_ChengZhuang_jingLian).updata_refine();
         }
      }
      
      public function updata_cz_polish() : void
      {
         if(this.vec_view[8].visible)
         {
            (this.vec_view[8] as View_equip_CZ_xilian).updata_cz_polish();
         }
      }
      
      public function updata_create() : void
      {
         if(this.vec_view[6].visible)
         {
            (this.vec_view[6] as View_equip_inlay).updata_create();
         }
      }
      
      public function update_decompose_count(vec:Vector.<int>) : void
      {
         if(this.vec_view[3].visible)
         {
            (this.vec_view[3] as View_equip_decompose).update_count(vec);
         }
      }
      
      public function update_inlay() : void
      {
         if(this.vec_view[1].visible)
         {
            (this.vec_view[1] as View_equip_hole).update_inlay();
         }
      }
      
      public function update_success_unLoad() : void
      {
         if(this.vec_view[1].visible)
         {
            (this.vec_view[1] as View_equip_hole).updata_unLoad();
         }
      }
      
      public function update_polish_txt(vec:Vector.<int>) : void
      {
         if(this.vec_view[2].visible)
         {
            (this.vec_view[2] as View_equip_polish).update_txt(vec);
         }
      }
      
      public function openView(enum_panel_cast:int) : void
      {
         this.vec_tbtn[enum_panel_cast].dispatchEvent(new MouseEvent(MouseEvent.CLICK));
         this.showTitle(enum_panel_cast);
      }
      
      public function get_child_cast_panel(_index:int) : View_cast_base
      {
         return this.vec_view[_index];
      }
      
      private function changeView(v:View_cast_base) : void
      {
         if(this.view_now == v)
         {
            return;
         }
         this.view_now.visible = false;
         this.view_now.hide();
         this.view_now = v;
         this.view_now.re_set();
         this.view_now.display();
         this.view_now.update();
         this.view_now.visible = true;
         if(!(this.view_now is View_equip_jinJi))
         {
            if(GameUnitManager.hero.level >= 70)
            {
               if(Model_cast.isFirOpen_jinJiPan)
               {
               }
            }
         }
         else if(GameUnitManager.hero.level >= 70)
         {
            if(Model_cast.isFirOpen_jinJiPan)
            {
               Model_cast.isFirOpen_jinJiPan = false;
               EffecObj.removeEffect(this.vec_tbtn[10]);
               CastCGMessage.CG_FIRST_OPEN_PAN_JINJI();
            }
         }
         if(!(this.view_now is View_equip_DianHua))
         {
            if(GameUnitManager.hero.level >= 50)
            {
               if(Model_cast.isFirOpen_dianHua)
               {
               }
            }
         }
         else if(GameUnitManager.hero.level >= 50)
         {
            if(Model_cast.isFirOpen_dianHua)
            {
               Model_cast.isFirOpen_dianHua = false;
               EffecObj.removeEffect(this.vec_tbtn[9]);
               CastCGMessage.CG_FIRST_OPEN_PAN_JINJI_DIANHUA();
            }
         }
      }
      
      private function reset() : void
      {
         this.view_now.reset();
         if(this.view_now != this.vec_view[Enum_panel_cast.EQUIP_INTENSIFY])
         {
            this.view_now.visible = false;
         }
      }
      
      private function CLICK_TBTN(e:MouseEvent) : void
      {
         if(this.tbtn_now == e.target)
         {
            return;
         }
         var tbtn:TabButton = e.target as TabButton;
         if(tbtn.tabIndex != Enum_panel_cast.EQUIP_DECOMPOSE && Model_bag.pwdLockState == Model_bag.PWD_STATE_LOCK_T)
         {
            UIManager.bagPwdPutIn.visible = true;
            return;
         }
         if(this.tbtn_now != null)
         {
            this.tbtn_now.choose = false;
         }
         tbtn.choose = true;
         this.tbtn_now = tbtn;
         Model_cast.CAST_TYPE = this.tbtn_now.tabIndex;
         trace("铸造类型:",Model_cast.CAST_TYPE);
         this.showTitle(this.tbtn_now.tabIndex);
         this.changeView(this.vec_view[this.tbtn_now.tabIndex]);
         this.showTips();
      }
      
      public function showXL() : void
      {
         var tbtn:TabButton = this.vec_tbtn[Enum_panel_cast.EQUIP_INLAY];
         if(tbtn.tabIndex != Enum_panel_cast.EQUIP_DECOMPOSE && Model_bag.pwdLockState == Model_bag.PWD_STATE_LOCK_T)
         {
            UIManager.bagPwdPutIn.visible = true;
            return;
         }
         if(this.tbtn_now == tbtn)
         {
            return;
         }
         if(this.tbtn_now != null)
         {
            this.tbtn_now.choose = false;
         }
         tbtn.choose = true;
         this.tbtn_now = tbtn;
         Model_cast.CAST_TYPE = this.tbtn_now.tabIndex;
         this.showTitle(this.tbtn_now.tabIndex);
         this.changeView(this.vec_view[this.tbtn_now.tabIndex]);
      }
      
      public function showTips() : void
      {
         var MM:Function = function():void
         {
            var len:int;
            var endfun:Function = null;
            endfun = function():void
            {
               var _y:int = 285;
               if(tipBtn.y >= _y)
               {
                  _y = 265;
               }
               Tween.to(tipBtn,800,{"y":[tipBtn.y,_y]},endfun);
            };
            if(!tipBtn)
            {
               tipBtn = ComponentUtil.getTabButton("","Button_GMBS",UIManager.castPanel,{
                  "x":584,
                  "y":265
               },Global.WYBQ);
               tipBtn.addEventListener(MouseEvent.CLICK,removeTips);
            }
            removeTips();
            len = int(CommandManager.get_bag_vec(Enum_filter.ITEM_GEM).length);
            if(Boolean(len))
            {
               return;
            }
            if(Model_cast.CAST_TYPE != Enum_panel_cast.EQUIP_HOLE)
            {
               return;
            }
            tipBtn.visible = true;
            endfun();
         };
         if(!Global.WYBQ)
         {
            SingleLoader.add("lang/ch/WYBQ.swf",function(info:Object):void
            {
               Global.WYBQ = info.applicationDomain;
               MM();
            });
         }
         else
         {
            MM();
         }
      }
      
      private function removeTips(e:MouseEvent = null) : void
      {
         if(Boolean(this.tipBtn))
         {
            this.tipBtn.visible = false;
            Tween.stop(this.tipBtn);
         }
      }
   }
}

