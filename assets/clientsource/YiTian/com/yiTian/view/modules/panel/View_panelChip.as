package com.yiTian.view.modules.panel
{
   import com.ui.controls.Button;
   import com.ui.controls.MyTextField;
   import com.ui.controls.TabButton;
   import com.utils.ComponentUtil;
   import com.utils.Util;
   import com.yiTian.Global;
   import com.yiTian.data.Data_lib;
   import com.yiTian.data.config.Enum_job;
   import com.yiTian.data.vo.Vo_equip;
   import com.yiTian.data.vo.Vo_grid;
   import com.yiTian.data.vo.Vo_item;
   import com.yiTian.manager.GameUnitManager;
   import com.yiTian.manager.LangConfig;
   import com.yiTian.manager.UIManager;
   import com.yiTian.net.message.cg.Little_system_CGMessage;
   import com.yiTian.utils.Bitmap2;
   import com.yiTian.utils.ComboTweenStep;
   import com.yiTian.utils.Singleton;
   import com.yiTian.utils.Tween;
   import com.yiTian.view.Enum_explor;
   import com.yiTian.view.Panel123;
   import com.yiTian.view.comp.View_Grid;
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   
   public class View_panelChip extends Panel123
   {
      
      private var _bmTitle:Bitmap2;
      
      private var _bmWeapon:Bitmap2;
      
      private var _tbtns:Array = [];
      
      private var _curChooseTbtn:TabButton = null;
      
      private var _curData:Array;
      
      private var _curIndex:int = -1;
      
      private var _btnGetReward:Button;
      
      private var _curType:int = -1;
      
      private var _tfAim:MyTextField;
      
      private var _tfTaskInfos:MyTextField;
      
      private var _bmFinish:Bitmap2;
      
      private var _this:Sprite;
      
      private var _atbDis1:DisplayObject;
      
      private var _atbDis2:DisplayObject;
      
      private var _rewardGrids:Vector.<View_Grid>;
      
      private var _isShow:Boolean = false;
      
      public function View_panelChip()
      {
         super();
         this._this = this;
         regResource("lang/ch/Target_Imgs.swf","Target_Imgsdm");
      }
      
      override protected function initUI2() : void
      {
         var grid:View_Grid = null;
         var i:int = 0;
         ComponentUtil.getScaleBitmap("Back1",[149,41,2,5],this,{
            "x":0,
            "y":0,
            "width":588,
            "height":370
         },Global.Img_Cdm);
         ComponentUtil.getBitmap("Target_Back",this,{
            "x":24,
            "y":40
         },Global.Target_Imgsdm);
         ComponentUtil.getScaleBitmap("Back_Translucent",[2,2,4,4],this,{
            "x":264,
            "y":55,
            "width":196,
            "height":291
         },Global.Img_Cdm);
         ComponentUtil.getBitmap("Title_Target",this,{
            "x":214,
            "y":5
         },Global.Target_Imgsdm);
         ComponentUtil.getBitmap("Back_CZList",this,{
            "x":32,
            "y":44
         },Global.Target_Imgsdm);
         move = new Rectangle(0,0,558,36);
         this.visible = false;
         this.setType(1);
         addChild(this._bmWeapon = new Bitmap2());
         this._bmWeapon.x = 70;
         addChild(this._bmTitle = new Bitmap2());
         this._bmTitle.x = 85;
         this._bmTitle.y = 59;
         this._tfAim = ComponentUtil.getTextField("",this,{
            "x":269,
            "y":65,
            "realWidth":195,
            "color":16742144,
            "size":14
         });
         this._tfAim.autoSize = "center";
         this._tfAim.text = LangConfig.getWord("29125",2);
         this._tfTaskInfos = ComponentUtil.getTextField("",this,{
            "x":280,
            "y":90,
            "color":3407667,
            "leading":4
         });
         this._bmFinish = new Bitmap2();
         this._bmFinish.x = 305;
         this._bmFinish.y = 155;
         addChild(this._bmFinish);
         this._atbDis1 = ComponentUtil.getDisplayObject("atbPart",this,{
            "x":26,
            "y":85
         },Global.Target_Imgsdm);
         this._atbDis2 = ComponentUtil.getDisplayObject("atbPart2",this,{
            "x":26,
            "y":85
         },Global.Target_Imgsdm);
         ComponentUtil.getButton("","Button_Close",this,{
            "x":554,
            "y":6,
            "textColor":16184781,
            "callBack":this.hide
         },Global.Img_Cdm);
         this._btnGetReward = ComponentUtil.getButton("","Button_Four",this,{
            "x":326,
            "y":310,
            "textColor":16184781,
            "callBack":this.btnGetClickHd
         },Global.Img_Cdm);
         this._rewardGrids = new Vector.<View_Grid>();
         i = 0;
         while(i < 4)
         {
            grid = new View_Grid();
            grid.set_bmp_bg();
            grid.set_bmp_over(true,null);
            grid.set_tf_count();
            grid.x = 278 + 44.5 * i;
            grid.y = 260;
            addChild(grid);
            this._rewardGrids[i] = grid;
            i++;
         }
         bind_target = Enum_explor.bind(Enum_explor.BTN_POINT);
         Model_target.init();
         Global.control.registerCallBack(Model_target.TARGET_GET_CHIP_SUCCESS,this.handleGetRewardSuccess);
      }
      
      private function btnGetClickHd(e:MouseEvent) : void
      {
         Little_system_CGMessage.CG_CHIP_GIFT((this._curData[this._curIndex] as Vo_Target).clipIndex);
      }
      
      public function setType(v:int) : void
      {
         var numBtn:int = 0;
         var tbtn:TabButton = null;
         var i:int = 0;
         var j:int = 0;
         var bm:Bitmap = null;
         if(v == 1)
         {
            numBtn = 7;
         }
         else if(v == 2)
         {
            numBtn = 7;
         }
         i = 0;
         while(i < numBtn)
         {
            tbtn = this._tbtns[i];
            if(!tbtn)
            {
               tbtn = this._tbtns[i] = ComponentUtil.getTabButton("","Button_SuiPian",this,null,Global.Target_Imgsdm);
               tbtn.x = 463;
               tbtn.y = 53 + i * 43;
               tbtn.addEventListener(MouseEvent.CLICK,this.tbtnMouseClickHd);
               bm = new Bitmap();
               bm.name = "bmLabel";
               bm.x = 42;
               bm.y = 8;
               tbtn.addChild(bm);
            }
            tbtn.visible = tbtn.visible || true;
            i += 1;
         }
         j = i;
         while(j < this._tbtns.length)
         {
            tbtn = this._tbtns[j];
            tbtn.visible = false;
            j += 1;
         }
      }
      
      public function changeVis(p:* = null) : void
      {
         Global.delegate.dosomething(this,visible ? function():void
         {
            hide(p);
         } : function():void
         {
            show(p);
         });
      }
      
      public function show(p:* = null) : void
      {
         if(-1 == Model_target.type)
         {
            return;
         }
         this.visible = true;
         var index:int = Model_target.getChipCanGetting();
         if(index >= 0)
         {
            this.setChooseIndex(index);
         }
         else
         {
            this.setChooseIndex(0);
         }
      }
      
      public function hide(p:* = null) : void
      {
         this.visible = false;
      }
      
      public function handleTypeUpdate() : void
      {
         this.setType(Model_target.type);
         this.setChooseIndex(0);
      }
      
      public function updateType() : void
      {
         if(Model_target.type == 1)
         {
            this._atbDis1.visible = true;
            this._atbDis2.visible = false;
            this._curData = Model_target.clipsVo1;
            this._bmWeapon.load(Model_target.getWeaponUrl());
            this._bmTitle.load(Model_target.getTitleUrl());
         }
         else
         {
            if(Model_target.type != 2)
            {
               return;
            }
            this._atbDis1.visible = false;
            this._atbDis2.visible = true;
            this._bmWeapon.load(Model_target.getWeaponUrl());
            this._bmTitle.load(Model_target.getTitleUrl());
            this._curData = Model_target.clipsVo2;
         }
         this._curType = Model_target.type;
      }
      
      public function updateTbtnLabel() : void
      {
         var vo:Vo_Target = null;
         var tabbutton:TabButton = null;
         var bm:Bitmap = null;
         var i:int = 0;
         while(i < this._curData.length)
         {
            vo = this._curData[i];
            tabbutton = this._tbtns[i] as TabButton;
            bm = tabbutton.getChildByName("bmLabel") as Bitmap;
            if(vo.isAllTaskComplete())
            {
               bm.bitmapData = ComponentUtil.getBitmapData("Text_OK",Global.Target_Imgsdm);
            }
            else
            {
               bm.bitmapData = ComponentUtil.getBitmapData("Text_Faslt",Global.Target_Imgsdm);
            }
            i += 1;
         }
      }
      
      public function setChooseIndex(index:int = -1) : void
      {
         if(Model_target.type == -1)
         {
            return;
         }
         if(Boolean(this._curChooseTbtn))
         {
            this._curChooseTbtn.choose = false;
         }
         this._curIndex = index;
         this._curChooseTbtn = this._tbtns[index] as TabButton;
         this._curChooseTbtn.choose = true;
         this.updateType();
         this.updateChooseInfo();
      }
      
      public function handleGetRewardSuccess(chipID:int) : void
      {
         var vo:Vo_Target = null;
         var g:View_Grid = null;
         if(this._curIndex >= 0)
         {
            vo = this._curData[this._curIndex];
            if(vo.clipIndex == chipID)
            {
               for each(g in this._rewardGrids)
               {
                  ComboTweenStep.toBag(g);
               }
            }
         }
      }
      
      public function updateChooseInfo() : void
      {
         var vo_grid:Vo_grid = null;
         var vo:Vo_Target = null;
         var staticDes:String = null;
         var txt:String = null;
         var info:Array = null;
         if(Boolean(this._curData) && this._curIndex >= 0)
         {
            vo = this._curData[this._curIndex];
         }
         this.updateTbtnLabel();
         var txts:Array = [];
         var i:int = 0;
         while(i < vo.taskIDs.length)
         {
            staticDes = Data_lib.chip_task[vo.taskIDs[i]][3];
            txt = staticDes + (Model_target.taskStateMap[vo.taskIDs[i]] == -1 ? "<font color=\'#33ff33\'>(" + LangConfig.getWord("29129",2) + ")</font>" : "<font color=\'#ff3333\'>(" + LangConfig.getWord("29128",2) + ")</font>");
            txts.push(txt);
            i += 1;
         }
         this._tfTaskInfos.htmlText = txts.join("\n");
         if(Model_target.taskCompleteMap[vo.clipIndex] == 1)
         {
            this._btnGetReward.label = "<font color=\'#ffff33\'>" + LangConfig.getWord("29127",2) + "</font>";
            this._btnGetReward.enabled = false;
            this._bmFinish.load("resource/image/iconNaN/chip_finish.png");
         }
         else if(vo.isAllTaskComplete())
         {
            this._btnGetReward.label = "<font color=\'#ffff33\'>" + LangConfig.getWord("29126",2) + "</font>";
            this._btnGetReward.enabled = true;
            this._bmFinish.load("resource/image/iconNaN/chip_finish.png");
         }
         else
         {
            this._btnGetReward.label = LangConfig.getWord("29126",2);
            this._btnGetReward.enabled = false;
            this._bmFinish.load(null);
         }
         var infos:Array = Util.splicObj(Data_lib.chip_reward[vo.clipIndex][Enum_job.getBaseJob(GameUnitManager.hero.job) - 1] as String,",_") as Array;
         var ii:int = 0;
         while(ii < infos.length)
         {
            info = infos[ii];
            if(info[0] == 1)
            {
               vo_grid = new Vo_item();
               vo_grid.id = int(info[1]);
               vo_grid.count = int(info[2]);
               (vo_grid as Vo_item).Init_lib();
            }
            else
            {
               vo_grid = new Vo_item();
               vo_grid.id = int(info[1]);
               vo_grid.count = int(info[2]);
               (vo_grid as Vo_equip).Init_lib();
            }
            this._rewardGrids[ii].vo = vo_grid;
            ii += 1;
         }
      }
      
      public function set curData(data:Array) : void
      {
         this._curData = data;
         this.updateChooseInfo();
      }
      
      private function tweenWeapon() : void
      {
         Tween.to(this._bmWeapon,4000,{"y":[120,105]},this.tweenWeapon,null,this.easing);
      }
      
      private function easing(p:Number) : Number
      {
         return Math.sin(p * Math.PI * 2);
      }
      
      private function tbtnMouseClickHd(e:MouseEvent) : void
      {
         var index:int = this._tbtns.indexOf(e.target);
         if(index != -1)
         {
            this.setChooseIndex(index);
         }
      }
      
      private function handleJieMiPopFlagChange() : void
      {
         if(Model_target.jieMiFlag == -1)
         {
            UIManager.smallMap.addTip(5);
            this.popUpJieMi();
         }
      }
      
      override public function set visible(value:Boolean) : void
      {
         if(value)
         {
            if(Model_target.type == -1)
            {
               return;
            }
            this.tweenWeapon();
            this.handleJieMiPopFlagChange();
            Global.control.registerCallBack(Model_target.TARGET_DATA_UPDATE,this.updateChooseInfo);
            Global.control.registerCallBack(Model_target.TARGET_TYPE_CHANGE,this.handleTypeUpdate);
            Global.control.registerCallBack(Model_target.TARGET_POPUP_JIEMI,this.handleJieMiPopFlagChange);
            super.visible = true;
         }
         else
         {
            Tween.stop(this._bmWeapon);
            Global.control.removeCallBack(Model_target.TARGET_DATA_UPDATE,this.updateChooseInfo);
            Global.control.removeCallBack(Model_target.TARGET_TYPE_CHANGE,this.handleTypeUpdate);
            Global.control.removeCallBack(Model_target.TARGET_POPUP_JIEMI,this.handleJieMiPopFlagChange);
            if(this._isShow)
            {
               super.visible = false;
            }
         }
         this._isShow = value;
      }
      
      public function popUpJieMi() : void
      {
         var pnl:View_targetJieMi = null;
         pnl = Singleton.getInstance(View_targetJieMi);
         Global.delegate.dosomething(pnl,function():void
         {
            pnl.setbBindTarget(_this);
            pnl.show();
         });
      }
   }
}

