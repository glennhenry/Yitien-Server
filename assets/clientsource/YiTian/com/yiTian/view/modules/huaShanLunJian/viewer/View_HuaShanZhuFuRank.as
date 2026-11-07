package com.yiTian.view.modules.huaShanLunJian.viewer
{
   import Layout.HGroup;
   import Layout.ILayout;
   import com.ui.controls.Button;
   import com.ui.controls.MyTextField;
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.manager.LangConfig;
   import com.yiTian.manager.ModalUIManager;
   import com.yiTian.utils.Pool;
   import com.yiTian.utils.Singleton;
   import com.yiTian.utils.ViewerCreator;
   import com.yiTian.utils.call.Delegate123;
   import com.yiTian.view.Panel123;
   import com.yiTian.view.modules.huaShanLunJian.model.Model_HuaShan;
   import com.yiTian.view.modules.huaShanLunJian.util.Enum_HuaShan;
   import com.yiTian.view.modules.huaShanLunJian.util.HuaShanUtil;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   import flash.text.TextFieldAutoSize;
   
   public class View_HuaShanZhuFuRank extends Panel123
   {
      
      private var closeBtn:Button;
      
      private var layout:ILayout;
      
      private var tf_pageInfo:MyTextField;
      
      private var btn_prePage:Button;
      
      private var btn_nxtPage:Button;
      
      private var btn_bless:Button;
      
      private var _zhufuInfo:Child_ZhuFuInfo2;
      
      private var _itemArr:Array = [];
      
      private var _data:Array;
      
      private var _playerInfo:Array;
      
      private var _curId:Number = 0;
      
      private var _oldTarget:Itemxx;
      
      private const ITEMLENGTH:int = 10;
      
      private var _curPageIndex:int = 0;
      
      public function View_HuaShanZhuFuRank()
      {
         super();
         regResource("lang/ch/kuafuzhan_Imgs.swf","kuafuzhan_Imgsdm");
      }
      
      override protected function initUI2() : void
      {
         var arr:Array = [[MyTextField,{
            "text":LangConfig.getWord("29332",2),
            "x":48,
            "y":52,
            "color":16764206
         }],[MyTextField,{
            "text":LangConfig.getWord("29333",2),
            "x":110,
            "y":52,
            "color":16764206
         }],[MyTextField,{
            "text":LangConfig.getWord("29348",2),
            "x":183,
            "y":52,
            "color":16764206
         }],[MyTextField,{
            "text":LangConfig.getWord("29349",2),
            "x":243 + 16,
            "y":52,
            "color":16764206
         }]];
         ComponentUtil.getScaleBitmap("Back1",[149,41,2,5],this,{
            "x":357,
            "y":0,
            "width":300,
            "height":433
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back2",[5,5,10,10],this,{
            "x":381,
            "y":40,
            "width":252,
            "height":383
         },Global.Img_Cdm);
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
         ComponentUtil.getBitmap("Title_ZhuFuRank",this,{
            "x":98,
            "y":5
         },Global.kuafuzhan_Imgsdm);
         ComponentUtil.getBitmap("Title_ZhuFuINF",this,{
            "x":427,
            "y":5
         },Global.kuafuzhan_Imgsdm);
         ComponentUtil.getScaleBitmap("Line",[29,1,2,0],this,{
            "x":386,
            "y":245,
            "width":242,
            "height":2
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Line",[29,1,2,0],this,{
            "x":386,
            "y":360,
            "width":242,
            "height":2
         },Global.Img_Cdm);
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
         this._zhufuInfo = new Child_ZhuFuInfo2();
         ComponentUtil.setPropertie(this._zhufuInfo,{
            "x":500 - 87,
            "y":60,
            "bmScaleX":-1
         });
         addChild(this._zhufuInfo);
         this.btn_bless = ComponentUtil.getButton(LangConfig.getWord("29342",2),"Button_Five",this,{
            "x":462,
            "y":380,
            "textColor":16184781,
            "callBack":this.zhufuClickHd
         },Global.Img_Cdm);
      }
      
      public function zhufuClickHd(event:MouseEvent) : void
      {
         var lun:int = 0;
         var chang:int = 0;
         var model:Model_HuaShan = null;
         var role1Info:Array = null;
         var role2Info:Array = null;
         var zhufuPanel:View_HuaShanZhuFuPanel = null;
         var jie:int = 0;
         var bangType:int = 0;
         var matchNodeInfo:Array = HuaShanUtil.getOverMatchByID(this._curId);
         if(!matchNodeInfo)
         {
            this.btn_bless.enabled = false;
         }
         else
         {
            lun = matchNodeInfo[0][0] + 1;
            chang = matchNodeInfo[0][1] + 1;
            model = Singleton.getInstance(Model_HuaShan);
            role1Info = HuaShanUtil.finPlayerInfoByID(matchNodeInfo[1][Enum_HuaShan.NODE_ID1],model.curPlayerInfoArr);
            role2Info = HuaShanUtil.finPlayerInfoByID(matchNodeInfo[1][Enum_HuaShan.NODE_ID2],model.curPlayerInfoArr);
            zhufuPanel = Singleton.getInstance(View_HuaShanZhuFuPanel);
            jie = model.jie;
            bangType = model.bangType2;
            visible = false;
            (Singleton.getInstance(Delegate123) as Delegate123).dosomething(zhufuPanel,function():void
            {
               ModalUIManager.POPUP(zhufuPanel);
               zhufuPanel.update(jie,bangType,lun,chang,role1Info,role2Info);
               zhufuPanel.choose(_curId);
            });
         }
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
      
      private function itemClickHd(event:MouseEvent) : void
      {
         var target:Itemxx = event.target as Itemxx;
         this.showPlayeInfo(this._itemArr.indexOf(target) + this.ITEMLENGTH * this._curPageIndex);
      }
      
      public function clear() : void
      {
         var item:Itemxx = null;
         this.layout.clearItem();
         for each(item in this._itemArr)
         {
            Pool.saveObject(item);
            removeChild(item);
         }
         this._itemArr.splice(0);
      }
      
      public function update(jie:int, bang:int, info:Array) : void
      {
         var model:Model_HuaShan = Singleton.getInstance(Model_HuaShan);
         if(jie != model.jie || bang != model.bangType2)
         {
            return;
         }
         this._playerInfo = model.curPlayerInfoArr;
         this._data = info;
         this.showPage(0);
      }
      
      public function showPlayeInfo(index:int) : void
      {
         var target:Itemxx = this._itemArr[index % this.ITEMLENGTH];
         target.isChoose = true;
         if(Boolean(this._oldTarget) && this._oldTarget != target)
         {
            this._oldTarget.isChoose = false;
         }
         this._oldTarget = target;
         this._curId = this._data[index][1];
         var roleInfo:Array = HuaShanUtil.finPlayerInfoByID(this._curId,this._playerInfo);
         roleInfo[Enum_HuaShan.CONT_BLESSLV] = this._data[index][4][3];
         roleInfo[Enum_HuaShan.CONT_BLESSSTAR] = this._data[index][4][4];
         roleInfo[Enum_HuaShan.CONT_BLESSEXP] = this._data[index][4][5];
         var matchNodeInfo:Array = HuaShanUtil.getOverMatchByID(this._curId);
         if(!matchNodeInfo)
         {
            this.btn_bless.enabled = false;
         }
         else if(matchNodeInfo[1][Enum_HuaShan.NODE_ID1] == 0 || matchNodeInfo[1][Enum_HuaShan.NODE_ID2] == 0)
         {
            this.btn_bless.enabled = false;
         }
         else
         {
            this.btn_bless.enabled = matchNodeInfo != null;
         }
         this._zhufuInfo.update(roleInfo);
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
            this.layout.appendItem(item);
            item.update(src[i]);
            addChild(item);
            this._itemArr.push(item);
            item.addEventListener(MouseEvent.CLICK,this.itemClickHd);
            i += 1;
         }
         this.layout.align();
         this.showPlayeInfo(value * this.ITEMLENGTH);
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
import com.utils.ComponentUtil;
import com.yiTian.Global;
import com.yiTian.data.model.Model_heFu;
import com.yiTian.view.modules.broadcast.Enum_BroadCastTool;
import flash.display.Shape;
import flash.display.Sprite;
import flash.events.Event;
import flash.events.MouseEvent;
import flash.text.TextFieldAutoSize;

class Itemxx extends Sprite
{
   
   private var tf_rank:MyTextField;
   
   private var tf_roleName:MyTextField;
   
   private var tf_srcStr:MyTextField;
   
   private var tf_addStr:MyTextField;
   
   private var _bReNew:Boolean = false;
   
   private var bg:Shape;
   
   private var _isChoose:Boolean = false;
   
   private var _mouseOver:Boolean = false;
   
   public function Itemxx()
   {
      super();
      this.bg = new Shape();
      addChild(this.bg);
      this.bg.graphics.beginFill(16777215,0);
      this.bg.graphics.drawRoundRect(0,0,274,30,4,4);
      this.bg.graphics.endFill();
      this.tf_rank = ComponentUtil.getTextField("",this,{
         "x":18,
         "y":4,
         "autoSize":TextFieldAutoSize.CENTER,
         "color":14662240
      });
      this.tf_roleName = ComponentUtil.getTextField("",this,{
         "x":88,
         "y":4,
         "autoSize":TextFieldAutoSize.CENTER,
         "color":14662240
      });
      this.tf_srcStr = ComponentUtil.getTextField("",this,{
         "x":194 - 25,
         "y":4,
         "autoSize":TextFieldAutoSize.CENTER,
         "color":14662240
      });
      this.tf_addStr = ComponentUtil.getTextField("",this,{
         "x":350 - 105,
         "y":4,
         "autoSize":TextFieldAutoSize.CENTER,
         "color":16776960
      });
      ComponentUtil.getScaleBitmap("Line",[29,1,2,0],this,{
         "y":30,
         "width":275,
         "height":2
      },Global.Img_Cdm);
      addEventListener(MouseEvent.ROLL_OVER,this.rollOverHd);
      addEventListener(MouseEvent.ROLL_OUT,this.roleOutHd);
   }
   
   private function updateFace() : void
   {
      var b:Boolean = false;
      if(Boolean(this._mouseOver) || Boolean(this._isChoose))
      {
         b = true;
      }
      else
      {
         b = false;
      }
      if(b)
      {
         this.bg.graphics.clear();
         this.bg.graphics.beginFill(11184725,0.2);
         this.bg.graphics.drawRoundRect(0,0,274,30,6,6);
         this.bg.graphics.endFill();
      }
      else
      {
         this.bg.graphics.clear();
         this.bg.graphics.beginFill(16777215,0);
         this.bg.graphics.drawRoundRect(0,0,274,30,6,6);
         this.bg.graphics.endFill();
      }
   }
   
   public function set isChoose(v:Boolean) : void
   {
      this._isChoose = v;
      this.updateFace();
   }
   
   public function update(data:Array) : void
   {
      var rank:int = int(data[0]);
      var roleID:int = int(data[1]);
      var roleName:String = data[2];
      var roleArea:String = data[3];
      var values:Array = data[4];
      this.tf_rank.htmlText = Enum_BroadCastTool.instance.getBitStr(rank);
      this.tf_roleName.htmlText = Model_heFu.repNameByHero(roleName + ".S" + roleArea);
      this.tf_srcStr.text = values[1].toString();
      this.tf_addStr.text = values[2].toString();
   }
   
   private function rollOverHd(e:Event) : void
   {
      this._mouseOver = true;
      this.updateFace();
   }
   
   private function roleOutHd(e:Event) : void
   {
      this._mouseOver = false;
      this.updateFace();
   }
}
