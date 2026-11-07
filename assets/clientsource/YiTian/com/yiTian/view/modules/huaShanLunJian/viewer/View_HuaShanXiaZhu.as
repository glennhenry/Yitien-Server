package com.yiTian.view.modules.huaShanLunJian.viewer
{
   import com.ui.controls.Button;
   import com.ui.controls.ComboBox;
   import com.ui.controls.MyTextField;
   import com.utils.ComponentUtil;
   import com.utils.Util;
   import com.yiTian.Global;
   import com.yiTian.manager.ModalUIManager;
   import com.yiTian.manager.UIManager;
   import com.yiTian.net.message.cg.HuaShanCGMessage;
   import com.yiTian.scene.GameScene;
   import com.yiTian.utils.ViewerCreator;
   import com.yiTian.view.UIBase;
   import com.yiTian.view.comp.View_Alert;
   import com.yiTian.view.modules.huaShanLunJian.util.Enum_HuaShan;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   
   public class View_HuaShanXiaZhu extends UIBase
   {
      
      private var bg:Sprite;
      
      private var btnClose:Button;
      
      private var item1:ItemVVV;
      
      private var item2:ItemVVV;
      
      private var tf_silverCost:MyTextField;
      
      private var cb_silverCost:ComboBox;
      
      private var tf_peiLv:MyTextField;
      
      private var btn_commit:Button;
      
      private var vsObj:DisplayObject;
      
      private var _jie:int;
      
      private var _bangType:int;
      
      private var _lun:int;
      
      private var _ju:int;
      
      private var _role1Info:Array;
      
      private var _role2Info:Array;
      
      public function View_HuaShanXiaZhu()
      {
         super();
         this.initB();
         bindParent = GameScene.modalLayer;
      }
      
      private function initB() : void
      {
         this.bg = new Sprite();
         this.bg.mouseEnabled = false;
         addChild(this.bg);
         ComponentUtil.getScaleBitmap("Back1",[149,41,2,5],this.bg,{
            "x":0,
            "y":0,
            "width":408,
            "height":310
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back2",[5,5,10,10],this.bg,{
            "x":24,
            "y":40,
            "width":360,
            "height":260
         },Global.Img_Cdm);
         ComponentUtil.getBitmap("Cross_xiazhu",this.bg,{
            "x":124,
            "y":5
         },Global.kuafuzhan_Imgsdm);
         var creatorArr:Array = [[Button,{
            "x":374,
            "y":6,
            "name":"btnClose",
            "callBack":this.closeHd
         },Global.Img_Cdm],[MyTextField,{
            "x":94,
            "y":245,
            "color":11904647,
            "text":"下注金额:"
         }],[MyTextField,{
            "x":267,
            "y":245,
            "color":14662240,
            "text":"赔率1:1"
         }],[Button,{
            "x":167,
            "y":271,
            "textColor":16184781,
            "text":"下注",
            "style":"Button_Orange",
            "name":"btnCommit",
            "callBack":this.commitClickHd
         },Global.Img_Cdm]];
         ViewerCreator.createViewer(creatorArr,this);
         this.vsObj = ComponentUtil.getTextField("VS",this,{
            "size":50,
            "color":43520,
            "x":173,
            "y":100
         });
         this.item1 = new ItemVVV();
         this.item2 = new ItemVVV();
         this.item1.bmScaleX = -1;
         ComponentUtil.setPropertie(this.item1,{
            "x":95,
            "y":55,
            "tabIndex":1
         });
         ComponentUtil.setPropertie(this.item2,{
            "x":312,
            "y":55,
            "tabIndex":2
         });
         addChild(this.item1);
         addChild(this.item2);
         this.item1.addEventListener(MouseEvent.CLICK,this.itemClickHd);
         this.item2.addEventListener(MouseEvent.CLICK,this.itemClickHd);
         this.cb_silverCost = new ComboBox([],this.comboxSelectedHd,100,"Button_PageDown","ComboBox_background");
         ComponentUtil.setPropertie(this.cb_silverCost,{
            "x":159,
            "y":243
         });
         addChild(this.cb_silverCost);
      }
      
      private function comboxSelectedHd(value:Object) : void
      {
         trace(value);
      }
      
      private function commitClickHd(event:MouseEvent) : void
      {
         var roleInfo:Array = null;
         var roleId:Number = NaN;
         var roleName:String = null;
         var index:int = 0;
         var tip:String = null;
         if(this.item1.selected != this.item2.selected)
         {
            roleInfo = this.item1.selected ? this._role1Info : this._role2Info;
            roleId = Number(roleInfo[Enum_HuaShan.CONT_ID]);
            roleName = roleInfo[Enum_HuaShan.CONT_ROLENAME];
            index = this.cb_silverCost.selIndex + 1;
            tip = Util.rep("是否给 <font color=\'#00ff00\'>{0}</font> 投注 <font color=\'#ff6666\'>索引{1}</font> ？",roleName,index);
            View_Alert.show(tip,View_Alert.OK_CANCAL,function():void
            {
               HuaShanCGMessage.CG_XUANBABET(_jie,_bangType,_lun,roleId,roleName,1,index);
            });
         }
         else
         {
            UIManager.centerBroadcast.addMsg("请选择你支持的玩家");
         }
      }
      
      private function itemClickHd(event:MouseEvent) : void
      {
         var target:ItemVVV = event.target as ItemVVV;
         this.item1.selected = target == this.item1;
         this.item2.selected = !this.item1.selected;
      }
      
      public function updateCombox(src:Array) : void
      {
         var arr:Array = null;
         var lable:String = null;
         var info:Array = null;
         var srcc:Array = [];
         for each(arr in src)
         {
            if(arr[0] == "3")
            {
               lable = "银两：" + arr[1] + "万";
               info = arr;
               srcc.push([lable,info]);
            }
         }
         this.cb_silverCost.source = srcc;
         this.cb_silverCost.select(srcc[0][1]);
      }
      
      private function closeHd(event:MouseEvent) : void
      {
         ModalUIManager.UNPOP();
      }
      
      public function update(jie:int, bangType:int, lun:int, ju:int, role1Info:Array, role2Info:Array) : void
      {
         var _temp_1:* = this.item1;
         this.item2.selected = false;
         _temp_1.selected = false;
         this._jie = jie;
         this._bangType = bangType;
         this._lun = lun;
         this._role1Info = role1Info;
         this._role2Info = role2Info;
         this.item1.update(role1Info);
         this.item2.update(role2Info);
      }
   }
}

import com.ui.controls.MyTextField;
import com.ui.controls.RadioButton;
import com.utils.Util;
import com.yiTian.Global;
import com.yiTian.data.Const_strImg;
import com.yiTian.utils.Bitmap2;
import com.yiTian.utils.ViewerCreator;
import com.yiTian.view.modules.huaShanLunJian.util.Enum_HuaShan;
import flash.display.Shape;
import flash.display.Sprite;
import flash.geom.ColorTransform;
import flash.text.TextFieldAutoSize;

class ItemVVV extends Sprite
{
   
   private var bm_roleHead:Bitmap2;
   
   private var tf_roleName:MyTextField;
   
   private var tf_lv:MyTextField;
   
   private var tf_strength:MyTextField;
   
   private var rb_support:RadioButton;
   
   private var shp_mask:Shape;
   
   public function ItemVVV()
   {
      super();
      var creatorObj:Array = [[Bitmap2,{
         "x":-41.5,
         "name":"bm"
      }],[MyTextField,{
         "text":"ddd",
         "y":108,
         "name":"2",
         "color":14662240
      }],[MyTextField,{
         "y":125,
         "name":"3",
         "color":14662240
      }],[MyTextField,{
         "y":142,
         "name":"4",
         "color":14662240
      }],[RadioButton,{
         "text":"支持",
         "style":"CheckBox01",
         "x":-18,
         "y":162,
         "name":"5",
         "textColor":16776960
      },Global.Img_Cdm]];
      ViewerCreator.createViewer(creatorObj,this);
      this.bm_roleHead = getChildByName("bm") as Bitmap2;
      this.tf_roleName = getChildByName("2") as MyTextField;
      this.tf_roleName.autoSize = TextFieldAutoSize.CENTER;
      this.tf_lv = getChildByName("3") as MyTextField;
      this.tf_lv.autoSize = TextFieldAutoSize.CENTER;
      this.tf_strength = getChildByName("4") as MyTextField;
      this.tf_strength.autoSize = TextFieldAutoSize.CENTER;
      this.rb_support = getChildByName("5") as RadioButton;
      mouseChildren = false;
      buttonMode = true;
   }
   
   public function set bmScaleX(number:Number) : void
   {
      if(number == -1)
      {
         this.bm_roleHead.x = 41.5;
      }
      else
      {
         this.bm_roleHead.x = -41.5;
      }
      this.bm_roleHead.scaleX = number;
   }
   
   public function set selected(b:Boolean) : void
   {
      this.rb_support.selected = b;
      transform.colorTransform = b ? Util.colorWhite2 : Util.colorNomal;
   }
   
   public function get selected() : Boolean
   {
      return this.rb_support.selected;
   }
   
   public function update(obj:Object) : void
   {
      var dataArr:Array = obj as Array;
      var roleID:int = int(dataArr[Enum_HuaShan.CONT_ID]);
      var roleName:String = dataArr[Enum_HuaShan.CONT_ROLENAME];
      var lv:int = int(dataArr[Enum_HuaShan.CONT_ROLELV]);
      var strength:int = int(dataArr[Enum_HuaShan.CONT_ROLESTRENGTH]);
      var roleSex:int = int(dataArr[Enum_HuaShan.CONT_ROLESEX]);
      var roleJob:int = int(dataArr[Enum_HuaShan.CONT_ROLEJOB]);
      var str_roleHeadUrl:String = Const_strImg.getPlayerHead(roleJob,roleSex,6);
      this.tf_roleName.text = roleName;
      this.tf_strength.text = "战力：" + strength.toString();
      this.tf_lv.text = "等级：" + lv.toString();
      this.bm_roleHead.load(str_roleHeadUrl,1);
   }
}
