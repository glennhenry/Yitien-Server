package com.yiTian.view.modules.baby.babyPan
{
   import com.ui.controls.MyTextField;
   import com.ui.controls.ScaleBitmap;
   import com.ui.controls.TabButton;
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.manager.TipManager;
   import com.yiTian.manager.UIManager;
   import com.yiTian.net.message.cg.BabyCGMessage;
   import com.yiTian.utils.Singleton;
   import com.yiTian.view.Panel123;
   import com.yiTian.view.modules.baby.Ibaby;
   import com.yiTian.view.modules.baby.NumsEffectManager;
   import com.yiTian.view.modules.baby.babyIcon.BabyBtnBesideRole;
   import com.yiTian.view.modules.baby.babyManager.Model_baby;
   import com.yiTian.view.modules.specialBtnDill.Model_specialD;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.FocusEvent;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   import flash.text.TextFieldType;
   
   public class View_babyPan extends Panel123
   {
      
      public static var nowChooseTab:TabButton;
      
      private static var nowChooseUnit:Ibaby;
      
      public static const BABY_MEILI:uint = 0;
      
      public static const BABY_PEIYANG:uint = 1;
      
      public static var nowChooseIndex:uint = 0;
      
      private static var strArr:Array = ["崽崽魅力","崽崽培养"];
      
      public static var nowChooseUnitIndex:uint = 0;
      
      public static const GAP_HEIGHT:uint = 50;
      
      public static var sign_a_first_mark:Boolean = false;
      
      public static var isFirstGetData:Boolean = true;
      
      private var tabBtnVec:Vector.<TabButton> = new Vector.<TabButton>(2);
      
      private var fm_wg_unit:Child_FM_WG;
      
      private var childBm:Bitmap;
      
      private var cover:Sprite;
      
      private var babyNameTf:MyTextField;
      
      private var paoPao:PaoPao;
      
      private var sprCon:Sprite;
      
      public function View_babyPan()
      {
         super();
         regResource("lang/ch/ZN.swf","ZNdm");
      }
      
      public static function get instance() : View_babyPan
      {
         return Singleton.getInstance(View_babyPan);
      }
      
      override protected function initUI2() : void
      {
         var tab:TabButton = null;
         ComponentUtil.getScaleBitmap("Back1",[149,41,2,5],this,{
            "x":0,
            "y":0,
            "width":620,
            "height":407
         },Global.Img_Cdm);
         move = new Rectangle(0,0,620,38);
         ComponentUtil.getScaleBitmap("Back2",[5,5,10,10],this,{
            "x":24,
            "y":64,
            "width":572,
            "height":334
         },Global.Img_Cdm);
         var i:uint = 0;
         while(i < this.tabBtnVec.length)
         {
            tab = ComponentUtil.getTabButton(strArr[i],"TabButton_Four",this,{
               "x":31 + 78 * i,
               "y":43,
               "textColor":16772813,
               "chooseColor":16771436,
               "tabIndex":i
            },Global.Img_Cdm);
            tab.addEventListener(MouseEvent.CLICK,this.tabEvent);
            this.tabBtnVec[i] = tab;
            i++;
         }
         ComponentUtil.getBitmap("Title_ZaiZai",this,{
            "x":230,
            "y":5
         },Global.ZNdm);
         ComponentUtil.getBitmap("Back_ZN",this,{
            "x":33,
            "y":72
         },Global.ZNdm);
         ComponentUtil.getBitmap("Icon_ZDL",this,{
            "x":40,
            "y":78
         },Global.ZNdm);
         this.childBm = ComponentUtil.getBitmap("Back_NanHai",this,{
            "x":128,
            "y":133
         },Global.ZNdm);
         CloseButton = ComponentUtil.getButton("","Button_Close",this,{
            "x":585,
            "y":6,
            "textColor":16771436
         },Global.Img_Cdm);
         this.fm_wg_unit = new Child_FM_WG();
         addChild(this.fm_wg_unit);
         ComponentUtil.setPropertie(this.fm_wg_unit,{
            "x":67,
            "y":348
         });
         this.fm_wg_unit.update(0);
         this.paoPao = new PaoPao();
         this.paoPao.x = 211;
         this.paoPao.y = 108;
         addChild(this.paoPao);
         var sbb:ScaleBitmap = ComponentUtil.getScaleBitmap("MC_MingChenD",[4,4,1,1],this,{
            "x":219,
            "y":84,
            "width":95,
            "height":22
         },Global.ZNdm);
         this.babyNameTf = ComponentUtil.getTextField("",this,{
            "x":221,
            "y":85,
            "color":16742144,
            "size":12,
            "leading":0,
            "realWidth":95,
            "realHeight":22,
            "maxChars":6
         });
         this.babyNameTf.addEventListener(FocusEvent.FOCUS_OUT,this.foOut);
         ComponentUtil.getBitmap("Icon_Bi",this,{
            "x":302,
            "y":86
         },Global.ZNdm);
         this.cover = new Sprite();
         addChild(this.cover);
         this.cover.graphics.beginFill(0,0);
         this.cover.graphics.drawRect(0,0,sbb.width,sbb.height);
         this.cover.graphics.endFill();
         this.cover.addEventListener(MouseEvent.MOUSE_DOWN,this.down);
         ComponentUtil.setPropertie(this.cover,{
            "x":sbb.x,
            "y":sbb.y
         });
         this.cover.buttonMode = true;
         super.initDynamicView();
      }
      
      private function down(e:MouseEvent) : void
      {
         this.babyNameTf.type = TextFieldType.INPUT;
         Global.focus = this.babyNameTf;
         this.cover.visible = false;
         this.babyNameTf.setSelection(this.babyNameTf.text.length,this.babyNameTf.text.length);
      }
      
      private function foOut(e:FocusEvent) : void
      {
         this.babyNameTf.type = TextFieldType.DYNAMIC;
         if(this.babyNameTf.text == "")
         {
            UIManager.centerBroadcast.addMsg("子女名字不能为空");
            return;
         }
         if(this.babyNameTf.text.indexOf("_") != -1)
         {
            UIManager.centerBroadcast.addMsg("子女名字中不能出现下划线");
            return;
         }
         BabyCGMessage.CG_RENAME_BABY(this.babyNameTf.text);
         this.cover.visible = true;
      }
      
      private function tabEvent(e:MouseEvent) : void
      {
         if(e.target.tabIndex == nowChooseUnitIndex)
         {
            return;
         }
         this.showPartOf(e.target.tabIndex);
      }
      
      public function showPartOf(index:uint) : void
      {
         var showNow:Function = null;
         showNow = function():void
         {
            if(index == 0)
            {
               nowChooseUnit = Child_babyMeili.instance;
            }
            else
            {
               nowChooseUnit = Child_babyPY.instance;
            }
            if(!nowChooseUnit.isInit)
            {
               ComponentUtil.setPropertie(nowChooseUnit,{
                  "x":329 + Ibaby.tiaoZheng,
                  "y":72
               });
            }
            nowChooseUnit.show();
            if(!contains(nowChooseUnit))
            {
               addChild(nowChooseUnit);
            }
            tabBtnVec[nowChooseUnitIndex].choose = true;
         };
         this.tabBtnVec[nowChooseUnitIndex].choose = false;
         nowChooseUnitIndex = index;
         if(Boolean(nowChooseUnit))
         {
            nowChooseUnit.hide(showNow);
         }
         else
         {
            showNow();
         }
         this.fm_wg_unit.update(index);
         this.paoPao.update_bm4(index);
         if(!visible)
         {
            this.visible = true;
         }
      }
      
      override public function set visible(value:Boolean) : void
      {
         if(value)
         {
            super.visible = value;
            this.showPartOf(nowChooseUnitIndex);
            Global.control.registerCallBack(BabyBtnBesideRole.BABYPAN_MSG_BACK,this.update);
            PaoPao.stop = false;
            this.paoPao.play(PaoPao.nowIndex);
            if(isFirstGetData)
            {
               sign_a_first_mark = true;
            }
            BabyCGMessage.CG_OPEN_BABY_PAN();
         }
         else
         {
            PaoPao.stop = true;
            Global.control.removeCallBack(BabyBtnBesideRole.BABYPAN_MSG_BACK,this.update);
            if(Boolean(Model_baby.role_beside_icon) && Boolean(Model_baby.role_beside_icon.parent))
            {
               Model_specialD.visFalseComp(this,Model_baby.role_beside_icon,this.superHide);
            }
         }
      }
      
      private function superHide() : void
      {
         super.visible = false;
      }
      
      private function update() : void
      {
         if(!this.sprCon)
         {
            this.sprCon = new Sprite();
            addChild(this.sprCon);
            ComponentUtil.setPropertie(this.sprCon,{
               "x":100,
               "y":83
            });
            this.refreshTip();
         }
         if(Boolean(NumsEffectManager.dataSdic[NumsEffectManager.BABY_STRENGTH]))
         {
            NumsEffectManager.update(Model_baby.baby_strength,NumsEffectManager.BABY_STRENGTH);
         }
         else
         {
            NumsEffectManager.addNums(Model_baby.baby_strength,Global.ZNdm,12,15,100,this.sprCon,Model_baby.numsArr,NumsEffectManager.BABY_STRENGTH);
         }
         this.childBm.bitmapData = ComponentUtil.getBitmapData(Model_baby.sex == 1 ? "Back_NanHai" : "Back_NvHai",Global.ZNdm);
         Child_babyMeili.instance.update();
         Child_babyPY.instance.update();
         this.fm_wg_unit.checkBox.selected = Model_baby.isFuMo == 1;
         this.babyNameTf.text = Model_baby.babyName;
      }
      
      override public function resetPosition() : void
      {
         x = (Global.stage.stageWidth - 620) / 2;
         y = (Global.stage.stageHeight - 400) / 2;
      }
      
      public function refreshTip() : void
      {
         if(Boolean(Model_baby.strengthTip) && Boolean(this.sprCon))
         {
            TipManager.bind(this.sprCon,Model_baby.strengthTip);
         }
      }
   }
}

