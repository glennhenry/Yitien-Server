package com.yiTian.view.modules.huaShanLunJian.viewer
{
   import Layout.HGroup;
   import Layout.ILayout;
   import com.ui.controls.Button;
   import com.ui.controls.MyTextField;
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.utils.Pool;
   import com.yiTian.utils.ViewerCreator;
   import com.yiTian.view.Panel123;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   import flash.text.TextFieldAutoSize;
   
   public class View_ShenJiaBangPanel extends Panel123
   {
      
      private var closeBtn:Button;
      
      private var layout:ILayout;
      
      private var tf_pageInfo:MyTextField;
      
      private var btn_prePage:Button;
      
      private var btn_nxtPage:Button;
      
      private var _itemArr:Array = [];
      
      private var _data:Array;
      
      private const ITEMLENGTH:int = 10;
      
      private var _curPageIndex:int = 0;
      
      public function View_ShenJiaBangPanel()
      {
         super();
         regResource("lang/ch/kuafuzhan_Imgs.swf","kuafuzhan_Imgsdm");
      }
      
      override protected function initUI2() : void
      {
         var arr:Array = [[MyTextField,{
            "text":"排名",
            "x":58,
            "y":52,
            "color":16764206
         }],[MyTextField,{
            "text":"名字",
            "x":160,
            "y":52,
            "color":16764206
         }],[MyTextField,{
            "text":"身价",
            "x":263,
            "y":52,
            "color":16764206
         }]];
         ComponentUtil.getScaleBitmap("Back1",[149,41,2,5],this,{
            "x":0,
            "y":0,
            "width":357,
            "height":433
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back2",[5,5,10,10],this,{
            "x":24,
            "y":40,
            "width":308,
            "height":383
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back_Num",[3,3,3,3],this,{
            "x":137,
            "y":392,
            "width":80,
            "height":20
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back3",[4,4,1,1],this,{
            "x":33,
            "y":50,
            "width":289,
            "height":335
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back_Title",[2,2,18,18],this,{
            "x":34,
            "y":52,
            "width":285,
            "height":20
         },Global.Img_Cdm);
         ComponentUtil.getBitmap("Cross_shenjiabang",this,{
            "x":98,
            "y":5
         },Global.kuafuzhan_Imgsdm);
         move = new Rectangle(0,0,357,38);
         ViewerCreator.createViewer(arr,this);
         this.closeBtn = ComponentUtil.getButton("","Button_Close",this,{
            "x":323,
            "y":6,
            "callBack":this.closeBtnClickHd
         },Global.Img_Cdm);
         this.tf_pageInfo = ComponentUtil.getTextField("",this,{
            "x":175,
            "y":393,
            "color":14662240
         });
         this.tf_pageInfo.autoSize = TextFieldAutoSize.CENTER;
         this.tf_pageInfo.text = "1/1";
         this.btn_prePage = ComponentUtil.getButton("","Button_PageLeft",this,{
            "x":116,
            "y":392,
            "callBack":this.preClickHd
         },Global.Img_Cdm);
         this.btn_nxtPage = ComponentUtil.getButton("","Button_PageRight",this,{
            "x":219,
            "y":392,
            "callBack":this.nxtClickHd
         },Global.Img_Cdm);
         this.layout = new HGroup(40,77,0,0,0,30);
      }
      
      private function preClickHd(event:MouseEvent) : void
      {
         this.showPage(this._curPageIndex - 1);
      }
      
      private function nxtClickHd(event:MouseEvent) : void
      {
         this.showPage(this._curPageIndex + 1);
      }
      
      private function closeBtnClickHd(event:MouseEvent) : void
      {
         visible = false;
      }
      
      public function clear(dispose:Boolean = false) : void
      {
         var item:Itemxx = null;
         for each(item in this._itemArr)
         {
            removeChild(item);
            Pool.saveObject(item);
            if(dispose)
            {
               item.dispose();
            }
         }
         this.layout.clearItem();
         this._itemArr.splice(0);
      }
      
      public function update(info:Array) : void
      {
         this._data = info;
         this.showPage(0);
      }
      
      private function showPage(value:int) : void
      {
         var item:Itemxx = null;
         if(!this._data)
         {
            return;
         }
         if(value < 0 || value > this.maxPage)
         {
            return;
         }
         var startIndex:int = value * this.ITEMLENGTH;
         var endIndex:int = startIndex + 10;
         var src:Array = this._data.slice(startIndex,endIndex);
         this._curPageIndex = value;
         this.tf_pageInfo.text = (this._curPageIndex + 1).toString() + "/" + (this.maxPage + 1).toString();
         this.clear();
         var i:int = 0;
         while(i < src.length)
         {
            item = Pool.getObject(Itemxx) as Itemxx;
            item.reNew();
            this.layout.appendItem(item);
            item.update(src[i]);
            addChild(item);
            this._itemArr.push(item);
            i += 1;
         }
         this.layout.align();
      }
      
      public function get maxPage() : int
      {
         var result:int = 0;
         if(!this._data)
         {
            return 0;
         }
         result = int(this._data.length / this.ITEMLENGTH);
         if(this._data.length > 0 && this._data.length % this.ITEMLENGTH == 0)
         {
            result -= 1;
         }
         return result;
      }
      
      override public function get width() : Number
      {
         return super.width;
      }
      
      override public function get height() : Number
      {
         return super.height;
      }
      
      override public function resetPosition() : void
      {
         x = (Global.stage.stageWidth - this.width) / 2;
         y = (Global.stage.stageHeight - this.height) / 2;
      }
   }
}

import com.ui.controls.MyTextField;
import com.ui.controls.ScaleBitmap;
import com.utils.ComponentUtil;
import com.yiTian.Global;
import com.yiTian.view.modules.broadcast.Enum_BroadCastTool;
import flash.display.Sprite;
import flash.text.TextFieldAutoSize;

class Itemxx extends Sprite
{
   
   private static var lineBM:ScaleBitmap;
   
   private var tf_rank:MyTextField;
   
   private var tf_roleName:MyTextField;
   
   private var tf_value:MyTextField;
   
   private var _bReNew:Boolean = false;
   
   public function Itemxx()
   {
      super();
   }
   
   public function update(data:Array) : void
   {
      var rank:int = int(data[0]);
      var roleID:int = int(data[1]);
      var roleName:String = data[2];
      var value:int = int(data[3]);
      this.tf_rank.htmlText = Enum_BroadCastTool.instance.getBitStr(rank);
      this.tf_roleName.htmlText = roleName;
      this.tf_value.htmlText = value.toString();
   }
   
   public function dispose() : void
   {
      if(!this._bReNew)
      {
         return;
      }
      this.tf_rank.dispose();
      this.tf_roleName.dispose();
      this.tf_value.dispose();
      this.tf_rank = this.tf_value = this.tf_roleName = null;
      this._bReNew = false;
   }
   
   public function reNew() : void
   {
      if(this._bReNew)
      {
         return;
      }
      this._bReNew = true;
      this.tf_rank = ComponentUtil.getTextField("",this,{
         "x":30,
         "autoSize":TextFieldAutoSize.CENTER,
         "color":14662240
      });
      this.tf_roleName = ComponentUtil.getTextField("",this,{
         "x":133,
         "autoSize":TextFieldAutoSize.CENTER,
         "color":14662240
      });
      this.tf_value = ComponentUtil.getTextField("",this,{
         "x":234,
         "autoSize":TextFieldAutoSize.CENTER,
         "color":14662240
      });
      lineBM = ComponentUtil.getScaleBitmap("Line",[29,1,2,0],this,{
         "y":22,
         "width":275,
         "height":2
      },Global.Img_Cdm);
   }
}
