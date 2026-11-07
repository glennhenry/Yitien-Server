package com.yiTian.view.modules.huaShanLunJian.viewer
{
   import Layout.HGroup;
   import com.ui.controls.Button;
   import com.ui.controls.MyTextField;
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.utils.Pool;
   import com.yiTian.utils.ViewerCreator;
   import com.yiTian.view.Panel123;
   import flash.display.DisplayObjectContainer;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   
   public class View_HuaShanWoDeXiaZhu extends Panel123
   {
      
      public static var curPlayerInfoArr:Array;
      
      private var bg:DisplayObjectContainer;
      
      private var hGroup:HGroup;
      
      private var itemArr:Array;
      
      private var closeBtn:Button;
      
      private var _itemArr:Array = [];
      
      public function View_HuaShanWoDeXiaZhu()
      {
         super();
         regResource("lang/ch/kuafuzhan_Imgs.swf","kuafuzhan_Imgsdm");
      }
      
      override protected function initUI2() : void
      {
         this.bg = new Sprite();
         this.bg.mouseEnabled = false;
         addChild(this.bg);
         ComponentUtil.getScaleBitmap("Back1",[149,41,2,5],this.bg,{
            "x":0,
            "y":0,
            "width":510,
            "height":294
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back2",[5,5,10,10],this.bg,{
            "x":24,
            "y":40,
            "width":462,
            "height":244
         },Global.Img_Cdm);
         ComponentUtil.getBitmap("Cross_myxiazhu",this.bg,{
            "x":175,
            "y":5
         },Global.kuafuzhan_Imgsdm);
         ComponentUtil.getScaleBitmap("Back3",[4,4,1,1],this.bg,{
            "x":33,
            "y":50,
            "width":442,
            "height":184
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back_Title",[2,2,18,18],this.bg,{
            "x":34,
            "y":53,
            "width":438,
            "height":26
         },Global.Img_Cdm);
         move = new Rectangle(0,0,this.bg.width - 30,38);
         var arr:Array = [[MyTextField,{
            "text":"场次",
            "x":70,
            "y":55,
            "color":16764206
         }],[MyTextField,{
            "text":"下注详情",
            "x":222,
            "y":55,
            "color":16764206
         }],[MyTextField,{
            "text":"下注结果",
            "x":385,
            "y":55,
            "color":16764206
         }]];
         ViewerCreator.createViewer(arr,this);
         this.closeBtn = ComponentUtil.getButton("关闭","Button_Orange",this,{
            "callBack":this.closeBtnClickHd,
            "x":219,
            "y":245,
            "textColor":16773818
         },Global.Img_Cdm);
         CloseButton = ComponentUtil.getButton("","Button_Close",this,{
            "callBack":this.closeBtnClickHd,
            "x":this.bg.width - 30,
            "y":5
         },Global.Img_Cdm);
         this.hGroup = new HGroup(40,88,0,0,0,30);
      }
      
      private function closeBtnClickHd(event:MouseEvent) : void
      {
         visible = false;
      }
      
      private function clear() : void
      {
         var item:ItemVVV = null;
         for each(item in this._itemArr)
         {
            Pool.saveObject(item);
            removeChild(item);
         }
         this.hGroup.clearItem();
         this._itemArr.splice(0);
      }
      
      public function update(bangType:int, info:Array) : void
      {
         var item:ItemVVV = null;
         var data:Array = null;
         this.clear();
         var i:int = 0;
         while(i < info.length)
         {
            item = Pool.getObject(ItemVVV) as ItemVVV;
            data = info[i];
            item.update(bangType,data);
            addChild(item);
            this.hGroup.appendItem(item);
            this._itemArr.push(item);
            i += 1;
         }
         this.hGroup.align();
      }
      
      override public function resetPosition() : void
      {
         x = (Global.stage.stageWidth - this.bg.width) / 2;
         y = (Global.stage.stageHeight - this.bg.height) / 2;
      }
   }
}

import com.ui.controls.MyTextField;
import com.ui.controls.ScaleBitmap;
import com.utils.ComponentUtil;
import com.utils.Util;
import com.yiTian.Global;
import com.yiTian.view.modules.huaShanLunJian.util.Enum_HuaShan;
import com.yiTian.view.modules.huaShanLunJian.util.HuaShanUtil;
import flash.display.Sprite;
import flash.text.TextFieldAutoSize;

class ItemVVV extends Sprite
{
   
   private static var lineBM:ScaleBitmap;
   
   private var tf_title:MyTextField;
   
   private var tf_info:MyTextField;
   
   private var tf_result:MyTextField;
   
   public function ItemVVV()
   {
      super();
      lineBM = ComponentUtil.getScaleBitmap("Line",[29,1,2,0],this,{
         "y":22,
         "width":425,
         "height":2
      },Global.Img_Cdm);
      this.tf_title = ComponentUtil.getTextField("",this,{
         "x":40,
         "color":11184640
      });
      this.tf_title.autoSize = TextFieldAutoSize.CENTER;
      this.tf_info = ComponentUtil.getTextField("",this,{
         "x":202,
         "color":14662240
      });
      this.tf_info.autoSize = TextFieldAutoSize.CENTER;
      this.tf_result = ComponentUtil.getTextField("",this,{"x":373});
      this.tf_result.autoSize = TextFieldAutoSize.CENTER;
   }
   
   public function update(bangType:int, info:Array) : void
   {
      var repStr:String = null;
      var lun:int = int(info[Enum_HuaShan.WDXZ_LUN]);
      var roleId:int = int(info[Enum_HuaShan.WDXZ_TARGETID]);
      var targetName:String = info[Enum_HuaShan.WDXZ_TARGETNAME];
      var type:int = int(info[Enum_HuaShan.WDXZ_MYITEMTYPE]);
      var cost:int = int(info[Enum_HuaShan.WDXZ_MYITEMNUM]);
      var isWin:int = int(info[Enum_HuaShan.WDXZ_ISWIN]);
      var gainObjType:int = int(info[Enum_HuaShan.WDXZ_GAINITEMTYPE]);
      var gainObjID:int = int(info[Enum_HuaShan.WDXZ_GAINITEMID]);
      var gainObjNum:int = int(info[Enum_HuaShan.WDXZ_GAINITEMNUM]);
      var changciStr:String = HuaShanUtil.labelsArr[bangType - 1] + HuaShanUtil.lunNameArr[lun - 1];
      var costStr:String = cost.toString() + "银两";
      var gainStr:String = gainObjNum.toString() + "绑银";
      if(isWin == 1)
      {
         repStr = "<font color=\'#11aa11\'>获利{0}</font>";
      }
      else
      {
         repStr = "<font color=\'#aa1111\'>失去{0}</font>";
      }
      this.tf_title.htmlText = changciStr;
      this.tf_info.htmlText = Util.rep("下注玩家<font color=\'#55ff55\'>【{0}】</font><font color=\'#ff6666\'>{1}</font>",targetName,costStr);
      this.tf_result.htmlText = Util.rep(repStr,gainStr);
   }
   
   public function dispose() : void
   {
      removeChild(this.tf_title);
      removeChild(this.tf_info);
      removeChild(this.tf_result);
      this.tf_title.dispose();
      this.tf_info.dispose();
      this.tf_result.dispose();
      this.tf_title = null;
      this.tf_info = null;
      this.tf_result = null;
   }
}
