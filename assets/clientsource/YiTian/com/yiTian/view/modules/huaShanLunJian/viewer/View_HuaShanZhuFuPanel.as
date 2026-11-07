package com.yiTian.view.modules.huaShanLunJian.viewer
{
   import com.ui.controls.Button;
   import com.ui.controls.MyTextField;
   import com.utils.ComponentUtil;
   import com.utils.Util;
   import com.yiTian.Global;
   import com.yiTian.data.model.Model_heFu;
   import com.yiTian.manager.GameUnitManager;
   import com.yiTian.manager.LangConfig;
   import com.yiTian.manager.ModalUIManager;
   import com.yiTian.manager.TipManager;
   import com.yiTian.manager.UIManager;
   import com.yiTian.net.message.cg.HuaShanCGMessage;
   import com.yiTian.scene.GameScene;
   import com.yiTian.utils.Singleton;
   import com.yiTian.utils.Tween;
   import com.yiTian.utils.ViewerCreator;
   import com.yiTian.view.Panel123;
   import com.yiTian.view.comp.View_Alert;
   import com.yiTian.view.modules.huaShanLunJian.model.Model_HuaShan;
   import com.yiTian.view.modules.huaShanLunJian.util.Enum_HuaShan;
   import com.yiTian.view.modules.huaShanLunJian.util.HuaShanUtil;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.text.TextFieldAutoSize;
   
   public class View_HuaShanZhuFuPanel extends Panel123
   {
      
      private var bg:Sprite;
      
      private var btnClose:Button;
      
      private var item1:Child_ZhuFuInfo;
      
      private var item2:Child_ZhuFuInfo;
      
      private var tf_peiLv:MyTextField;
      
      private var tf_cant:MyTextField;
      
      private var vsObj:DisplayObject;
      
      private var sps:Array = [];
      
      private var btnArr:Array = [];
      
      private var costArr:Array = [0,168,668];
      
      private var rato:int = 4;
      
      private var offset:Number = 1;
      
      private var min:Number = 0;
      
      private var choosObj:DisplayObject;
      
      private var _jie:int;
      
      private var _bangType:int;
      
      private var _lun:int;
      
      private var _ju:int;
      
      private var _role1Info:Array;
      
      private var _role2Info:Array;
      
      public function View_HuaShanZhuFuPanel()
      {
         super();
         regResource("lang/ch/kuafuzhan_Imgs.swf","kuafuzhan_Imgsdm");
         bindParent = GameScene.modalLayer;
      }
      
      override protected function initUI2() : void
      {
         this.bg = new Sprite();
         this.bg.mouseEnabled = false;
         addChild(this.bg);
         ComponentUtil.getScaleBitmap("Back1",[149,41,2,5],this,{
            "x":0,
            "y":0,
            "width":483,
            "height":450
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back2",[5,5,10,10],this,{
            "x":24,
            "y":311,
            "width":434,
            "height":129
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back2",[5,5,10,10],this,{
            "x":24,
            "y":40,
            "width":434,
            "height":266
         },Global.Img_Cdm);
         this.choosObj = ComponentUtil.getBitmap("ZhuFu_Choose",null,null,Global.kuafuzhan_Imgsdm);
         ComponentUtil.getBitmap("Title_ZhuFu",this,{
            "x":161,
            "y":5
         },Global.kuafuzhan_Imgsdm);
         var creatorArr:Array = [[Button,{
            "x":439,
            "y":6,
            "name":"btnClose",
            "callBack":this.closeHd
         },Global.Img_Cdm]];
         ViewerCreator.createViewer(creatorArr,this);
         this.item1 = new Child_ZhuFuInfo();
         this.item1.mouseChildren = false;
         this.item2 = new Child_ZhuFuInfo();
         this.item2.mouseChildren = false;
         ComponentUtil.setPropertie(this.item1,{
            "bmScaleX":1,
            "x":35,
            "y":55,
            "tabIndex":1,
            "buttonMode":true
         });
         ComponentUtil.setPropertie(this.item2,{
            "bmScaleX":-1,
            "x":253,
            "y":55,
            "tabIndex":2,
            "buttonMode":true
         });
         addChild(this.item1);
         addChild(this.item2);
         this.item1.addEventListener(MouseEvent.CLICK,this.itemClickHd);
         this.item2.addEventListener(MouseEvent.CLICK,this.itemClickHd);
         this.vsObj = ComponentUtil.getBitmap("VS_Biger",this,{
            "x":220,
            "y":130
         },Global.kuafuzhan_Imgsdm);
         var sp1:Sprite = new Sprite();
         ComponentUtil.setPropertie(sp1,{
            "x":58,
            "y":320
         });
         addChild(sp1);
         var sp2:Sprite = new Sprite();
         ComponentUtil.setPropertie(sp2,{
            "x":211,
            "y":320
         });
         addChild(sp2);
         var sp3:Sprite = new Sprite();
         ComponentUtil.setPropertie(sp3,{
            "x":363,
            "y":320
         });
         addChild(sp3);
         this.sps.push(sp1,sp2,sp3);
         ComponentUtil.getBitmap("Icon_Free",sp1,{},Global.kuafuzhan_Imgsdm);
         ComponentUtil.getBitmap("Icon_88",sp2,{},Global.kuafuzhan_Imgsdm);
         ComponentUtil.getBitmap("Icon_888",sp3,{},Global.kuafuzhan_Imgsdm);
         this.tf_cant = ComponentUtil.getTextField("",this,{
            "x":240,
            "y":408,
            "autoSize":TextFieldAutoSize.CENTER,
            "color":16776960,
            "size":14,
            "bold":true
         });
         var i:int = 0;
         while(i < 3)
         {
            this.btnArr.push(ComponentUtil.getButton(HuaShanUtil.zhufuLabels[i],"Button_Four",this,{
               "x":53 + i * 153,
               "y":404,
               "callBack":this.commitClickHd,
               "tabIndex":i
            },Global.Img_Cdm));
            i += 1;
         }
      }
      
      private function commitClickHd(event:MouseEvent) : void
      {
         var index:int = 0;
         var roleInfo:Array = null;
         var roleId:Number = NaN;
         var roleName:String = null;
         var serv:String = null;
         index = int(event.target.tabIndex);
         if(GameUnitManager.hero.money < this.costArr[index])
         {
            UIManager.centerBroadcast.addMsg(LangConfig.getWord("20241",2));
            return;
         }
         if(this.item1.selected != this.item2.selected)
         {
            roleInfo = this.item1.selected ? this._role1Info : this._role2Info;
            roleId = Number(roleInfo[Enum_HuaShan.CONT_ID]);
            roleName = roleInfo[Enum_HuaShan.CONT_ROLENAME];
            serv = roleInfo[Enum_HuaShan.CONT_SERVNAME];
            View_Alert.show(Util.rep("是否 <font color=\'#ff4444\'>{0}</font> 【{1}】?",HuaShanUtil.zhufuLabels[index],Model_heFu.repNameByHero(roleName + ".S" + serv)),View_Alert.OK_CANCAL,function():void
            {
               HuaShanCGMessage.CG_BLESS_ROLE(_jie,_bangType,_lun,roleId,index + 1);
            });
         }
         else
         {
            UIManager.centerBroadcast.addMsg("");
         }
      }
      
      override public function set visible(value:Boolean) : void
      {
         var i:int = 0;
         if(value)
         {
            this.vsObj.y = 0;
            this.play();
            this.play2();
            this.play3();
            i = 0;
            while(i < this.sps.length)
            {
               TipManager.bind(this.sps[i],HuaShanUtil.getZhuFuRewardStr(i));
               i += 1;
            }
         }
         else
         {
            this.stop();
         }
         super.visible = value;
      }
      
      private function play2() : void
      {
         Tween.to(this,400,{"tweenP":[0,1]},null,null,this.tFun);
      }
      
      private function play3() : void
      {
         Tween.to(this.vsObj,600,{"y":[0,150]},null,null,this.tFun);
      }
      
      private function tFun(p:Number) : Number
      {
         var rate:Number = p * 3.1416 * this.rato;
         return 1 - Math.sin(rate) / rate;
      }
      
      public function set tweenP(v:Number) : void
      {
         this.item1.x = 35 - 99 + 99 * v;
         this.item2.x = 253 + 99 - 99 * v;
      }
      
      private function stop() : void
      {
         Tween.stop(this.choosObj);
      }
      
      private function play() : void
      {
         Tween.to(this.choosObj,1500,{"alpha":[0,1]},this.play,null,this.tranPercent);
      }
      
      public function tranPercent(v:Number) : Number
      {
         return Math.sin(v * 2 * Math.PI) + 1;
      }
      
      private function itemClickHd(event:MouseEvent) : void
      {
         var target:Child_ZhuFuInfo = event.target as Child_ZhuFuInfo;
         this.item1.selected = target == this.item1;
         target.addChild(this.choosObj);
         this.item2.selected = !this.item1.selected;
      }
      
      public function choose(roleID:int) : void
      {
         var rnd:Number = NaN;
         if(roleID == -1)
         {
            rnd = Math.random();
            if(rnd <= 0.5)
            {
               this.item1.selected = true;
               this.item1.addChild(this.choosObj);
            }
            else
            {
               this.item2.selected = true;
               this.item2.addChild(this.choosObj);
            }
            return;
         }
         if(this._role1Info[Enum_HuaShan.CONT_ID] == roleID)
         {
            this.item1.selected = true;
            this.item1.addChild(this.choosObj);
         }
         else if(this._role2Info[Enum_HuaShan.CONT_ID] == roleID)
         {
            this.item2.selected = true;
            this.item2.addChild(this.choosObj);
         }
      }
      
      private function closeHd(event:MouseEvent) : void
      {
         ModalUIManager.UNPOP();
         this.item1.oldExp = 0;
         this.item2.oldExp = 0;
      }
      
      public function update(jie:int, bangType2:int, lun:int, ju:int, role1Info:Array, role2Info:Array, b:Boolean = false) : void
      {
         var arr:Array = null;
         var btn:Button = null;
         var model:Model_HuaShan = Singleton.getInstance(Model_HuaShan);
         b = true;
         for each(arr in model.myZhuFuInfo)
         {
            if(arr[Enum_HuaShan.WDZF_LUN] + 1 == lun)
            {
               b = false;
               break;
            }
         }
         for each(btn in this.btnArr)
         {
            btn.visible = b;
         }
         this.tf_cant.text = b ? "" : LangConfig.getWord("29347",2);
         this.item1.selected = this.item2.selected = false;
         if(Boolean(this.choosObj.parent))
         {
            this.choosObj.parent.removeChild(this.choosObj);
         }
         this._jie = jie;
         this._bangType = bangType2;
         this._lun = lun;
         this._role1Info = role1Info;
         this._role2Info = role2Info;
         this.item1.update(role1Info);
         this.item2.update(role2Info);
      }
      
      public function update2(roleID:Number, blessLV:int, blessStar:int, blessExp:int) : void
      {
         var btn:Button = null;
         for each(btn in this.btnArr)
         {
            btn.visible = false;
         }
         this.tf_cant.text = LangConfig.getWord("29347",2);
         this.item1.update2(roleID,blessLV,blessStar,blessExp);
         this.item2.update2(roleID,blessLV,blessStar,blessExp);
      }
   }
}

