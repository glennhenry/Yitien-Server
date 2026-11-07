package com.yiTian.view.modules.huaShanLunJian.viewer
{
   import Layout.HGroup;
   import com.ui.controls.Button;
   import com.ui.controls.MyTextField;
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.manager.LangConfig;
   import com.yiTian.utils.Pool;
   import com.yiTian.utils.ViewerCreator;
   import com.yiTian.view.Panel123;
   import flash.display.DisplayObjectContainer;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   
   public class View_HuaShanWoDeZhuFu extends Panel123
   {
      
      public static var curPlayerInfoArr:Array;
      
      private var bg:DisplayObjectContainer;
      
      private var hGroup:HGroup;
      
      private var itemArr:Array;
      
      private var closeBtn:Button;
      
      private var _itemArr:Array = [];
      
      public function View_HuaShanWoDeZhuFu()
      {
         super();
         regResource("lang/ch/kuafuzhan_Imgs.swf","kuafuzhan_Imgsdm");
         this.initUI2();
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
         ComponentUtil.getScaleBitmap("Back3",[4,4,1,1],this.bg,{
            "x":33,
            "y":50,
            "width":442,
            "height":184
         },Global.Img_Cdm);
         ComponentUtil.getBitmap("Title_WDZhuFu",this,{
            "x":175,
            "y":5
         },Global.kuafuzhan_Imgsdm);
         ComponentUtil.getScaleBitmap("Line",[29,1,2,0],this,{
            "x":40,
            "y":79,
            "width":425,
            "height":2
         },Global.Img_Cdm);
         move = new Rectangle(0,0,this.bg.width - 30,38);
         var arr:Array = [[MyTextField,{
            "text":LangConfig.getWord("29353",2),
            "x":70,
            "y":55,
            "color":16764206
         }],[MyTextField,{
            "text":LangConfig.getWord("29354",2),
            "x":222,
            "y":55,
            "color":16764206
         }],[MyTextField,{
            "text":LangConfig.getWord("29355",2),
            "x":385,
            "y":55,
            "color":16764206
         }]];
         ViewerCreator.createViewer(arr,this);
         this.closeBtn = ComponentUtil.getButton(LangConfig.getWord("29356",2),"Button_Orange",this,{
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
            item.update(data);
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
import com.utils.ComponentUtil;
import com.yiTian.Global;
import com.yiTian.manager.LangConfig;
import com.yiTian.view.modules.broadcast.Enum_BroadCastTool;
import com.yiTian.view.modules.huaShanLunJian.util.Enum_HuaShan;
import com.yiTian.view.modules.huaShanLunJian.util.HuaShanUtil;
import flash.display.Sprite;
import flash.text.TextFieldAutoSize;

class ItemVVV extends Sprite
{
   
   private var tf_title:MyTextField;
   
   private var tf_info:MyTextField;
   
   private var tf_result:MyTextField;
   
   public function ItemVVV()
   {
      super();
      ComponentUtil.getScaleBitmap("Line",[29,1,2,0],this,{
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
   
   public function update(info:Array) : void
   {
      var repStr:String = null;
      var bang:int = int(info[Enum_HuaShan.WDZF_BANG]);
      var lun:int = int(info[Enum_HuaShan.WDZF_LUN]);
      var roleId:int = int(info[Enum_HuaShan.WDZF_TARGETID]);
      var targetName:String = info[Enum_HuaShan.WDZF_TARGETNAME];
      var isWin:int = int(info[Enum_HuaShan.WDZF_RESULT]);
      var type:int = int(info[Enum_HuaShan.WDZF_MYITEMTYPE]);
      var changciStr:String = HuaShanUtil.labelsArr[bang - 1] + HuaShanUtil.lunNameArr[lun];
      if(isWin == 1)
      {
         repStr = "<font color=\'#11aa11\'>" + LangConfig.getWord("29357",2) + "</font>";
      }
      else if(isWin == 0)
      {
         repStr = "<font color=\'#aa1111\'>" + LangConfig.getWord("29358",2) + "</font>";
      }
      else
      {
         repStr = "<font color=\'#ffff11\'>" + LangConfig.getWord("29359",2) + "</font>";
      }
      this.tf_title.htmlText = changciStr;
      this.tf_info.htmlText = Enum_BroadCastTool.instance.getColorStr(HuaShanUtil.zhufuLabels[type - 1],type + 1) + "【" + targetName + "】";
      this.tf_result.htmlText = repStr;
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
