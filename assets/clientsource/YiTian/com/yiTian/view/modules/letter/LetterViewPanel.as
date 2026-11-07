package com.yiTian.view.modules.letter
{
   import com.ui.controls.Button;
   import com.ui.controls.CheckBox;
   import com.ui.controls.MyTextField;
   import com.utils.ColorConstant;
   import com.utils.ComponentUtil;
   import com.utils.Util;
   import com.yiTian.Global;
   import com.yiTian.command.Enum_MsgType;
   import com.yiTian.data.Const_png;
   import com.yiTian.data.Data_lib;
   import com.yiTian.data.Enum_SPStr;
   import com.yiTian.data.Enum_type_grid;
   import com.yiTian.data.vo.Vo_equip;
   import com.yiTian.data.vo.Vo_grid;
   import com.yiTian.data.vo.Vo_item;
   import com.yiTian.manager.LangConfig;
   import com.yiTian.manager.TipManager;
   import com.yiTian.manager.UIManager;
   import com.yiTian.net.message.cg.BlueDiamondCGMessage;
   import com.yiTian.net.message.cg.LetterCGMessage;
   import com.yiTian.utils.HtmlUtil;
   import com.yiTian.utils.Utils;
   import com.yiTian.view.comp.View_Grid;
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.events.TextEvent;
   import flash.geom.Point;
   import flash.net.URLRequest;
   import flash.net.navigateToURL;
   import flash.text.TextField;
   import flash.text.TextFormatAlign;
   
   public class LetterViewPanel extends Sprite implements ILetterView
   {
      
      public static var curPoint:Point;
      
      public static var curVO:Vo_grid;
      
      public static var isCan:Boolean;
      
      private var instance38:DisplayObject;
      
      private var instance40:DisplayObject;
      
      private var instance42:DisplayObject;
      
      private var instance44:DisplayObject;
      
      public var Letter01_CheckBox:CheckBox;
      
      private var Letter01_Type_text:MyTextField;
      
      private var Letter01_Time_text:MyTextField;
      
      private var Letter01_NeiRong_text:TextField;
      
      private var moneyGrid:View_Grid;
      
      private var moneyTip:Sprite;
      
      private var moneyTxt:MyTextField;
      
      private var goodsGrid:View_Grid;
      
      private var goodsTxt:MyTextField;
      
      private var huiFuBtn:Button;
      
      private var letterVO:LetterVO;
      
      private var letterManageVO:LetterManagerVO;
      
      private var bmBack:Bitmap;
      
      private var bmFlat:Bitmap;
      
      public function LetterViewPanel()
      {
         super();
         ComponentUtil.getScaleBitmap("Back_Translucent",[2,2,4,4],this,{
            "x":36,
            "y":4,
            "width":100,
            "height":20
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back_Num",[3,3,3,3],this,{
            "x":415,
            "y":24,
            "width":96,
            "height":50
         },Global.Img_Cdm);
         ComponentUtil.getTextField(LangConfig.getWord("60199",6),this,{
            "x":437,
            "y":3,
            "color":16764206,
            "size":12,
            "leading":0
         });
         this.bmBack = new Bitmap();
         this.bmBack.x = 10;
         this.bmBack.y = 25;
         addChild(this.bmBack);
         this.bmFlat = new Bitmap();
         this.bmFlat.x = 364;
         this.bmFlat.y = 54;
         addChild(this.bmFlat);
         this.Letter01_CheckBox = new CheckBox("","CheckBox01",Global.Img_Cdm);
         this.Letter01_CheckBox.x = 10;
         this.Letter01_CheckBox.y = 5;
         addChild(this.Letter01_CheckBox);
         this.Letter01_Type_text = ComponentUtil.getTextField("",this,{
            "x":48,
            "y":5,
            "color":6524973,
            "size":12,
            "leading":0
         });
         this.Letter01_Type_text.realWidth = 84;
         this.Letter01_Type_text.align = TextFormatAlign.CENTER;
         this.Letter01_Time_text = ComponentUtil.getTextField("",this,{
            "x":140,
            "y":5,
            "color":11904647,
            "size":12,
            "leading":0
         });
         this.Letter01_Time_text.realWidth = 127.05;
         this.Letter01_Time_text.align = TextFormatAlign.CENTER;
         this.Letter01_NeiRong_text = new TextField();
         this.Letter01_NeiRong_text.x = 15;
         this.Letter01_NeiRong_text.y = 28;
         this.Letter01_NeiRong_text.width = 395;
         this.Letter01_NeiRong_text.height = 70;
         this.Letter01_NeiRong_text.textColor = 789252;
         this.Letter01_NeiRong_text.wordWrap = true;
         this.Letter01_NeiRong_text.mouseEnabled = true;
         this.Letter01_NeiRong_text.addEventListener(TextEvent.LINK,this.link);
         addChild(this.Letter01_NeiRong_text);
         this.goodsGrid = new View_Grid();
         this.goodsGrid.set_tf_count(true,false,true);
         this.goodsGrid.type = Enum_type_grid.NO_DRAG;
         this.goodsGrid.set_bmp_bg();
         this.goodsGrid.set_bmp_select();
         this.goodsGrid.set_bmp_over();
         this.goodsGrid.index = 1;
         addChild(this.goodsGrid);
         this.goodsGrid.x = 424;
         this.goodsGrid.y = 32;
         this.goodsGrid.buttonMode = true;
         this.goodsGrid.addEventListener(MouseEvent.CLICK,this.gridClickHandler);
         this.moneyGrid = new View_Grid();
         this.moneyGrid.type = Enum_type_grid.NO_DRAG;
         this.moneyGrid.set_bmp_bg();
         this.moneyGrid.set_bmp_select();
         this.moneyGrid.set_bmp_over();
         this.moneyGrid.index = 2;
         addChild(this.moneyGrid);
         this.moneyGrid.x = 467;
         this.moneyGrid.y = 32;
         this.moneyGrid.buttonMode = true;
         this.moneyGrid.addEventListener(MouseEvent.CLICK,this.gridClickHandler);
         this.moneyTip = new Sprite();
         this.moneyTip.graphics.beginFill(16777215,0);
         this.moneyTip.graphics.drawRect(0,0,Const_png.SIZE_GRID - 5,Const_png.SIZE_GRID - 5);
         this.moneyTip.graphics.endFill();
         this.moneyTip.buttonMode = true;
         addChild(this.moneyTip);
         this.moneyTip.x = this.moneyGrid.x;
         this.moneyTip.y = this.moneyGrid.y;
         this.moneyTip.visible = false;
         this.moneyTip.addEventListener(MouseEvent.ROLL_OUT,this.onRollOut);
         this.moneyTip.addEventListener(MouseEvent.ROLL_OVER,this.onRollOver);
         this.moneyTip.addEventListener(MouseEvent.CLICK,function(e:MouseEvent):void
         {
            moneyGrid.dispatchEvent(new MouseEvent(MouseEvent.CLICK));
         });
         this.huiFuBtn = ComponentUtil.getButton(LangConfig.getWord("10239",1),"Button_Orange",this,{
            "x":427,
            "y":76,
            "textColor":16184781
         },Global.Img_Cdm);
         this.huiFuBtn.addEventListener(MouseEvent.CLICK,this.huiFuHandler);
      }
      
      public function loadBack() : void
      {
         Utils.loadTitle("lang/ch/Letter_Imgs.swf","Letter_Back",this.bmBack,null,null);
      }
      
      private function huiFuHandler(e:MouseEvent) : void
      {
         if(!this.letterVO)
         {
            return;
         }
         if(this.letterVO.sender != LangConfig.getWord("10240",1))
         {
            Global.control.sendNotification(Enum_MsgType.MSG_SENDMAIL,this.letterVO.sender);
         }
         if(UIManager.letterManagerViewPanel.letterManageVO.type == 4)
         {
            Global.control.sendNotification(Enum_MsgType.MSG_SENDMAIL,this.letterVO.addressee);
         }
      }
      
      protected function onRollOver(event:MouseEvent) : void
      {
         this.moneyGrid.dispatchEvent(new MouseEvent(MouseEvent.ROLL_OVER));
         if(!this.refreshData)
         {
            return;
         }
         if(this.letterVO.msType == 1)
         {
            TipManager.bind(this.moneyTip,Data_lib.attribute[18][0] + "：" + this.letterVO.msNum);
         }
         else if(this.letterVO.msType == 2)
         {
            TipManager.bind(this.moneyTip,Data_lib.attribute[16][0] + "：" + this.letterVO.msNum);
         }
         else if(this.letterVO.msType == 5)
         {
            TipManager.bind(this.moneyTip,"绑银" + "：" + this.letterVO.msNum);
         }
      }
      
      protected function onRollOut(event:MouseEvent) : void
      {
         this.moneyGrid.dispatchEvent(new MouseEvent(MouseEvent.ROLL_OUT));
         if(!this.refreshData)
         {
            return;
         }
         if(this.letterVO.msType > 0)
         {
            TipManager.hide();
         }
      }
      
      protected function gridClickHandler(event:MouseEvent) : void
      {
         if(UIManager.letterManagerViewPanel.letterManageVO.type == 4)
         {
            return;
         }
         if(!this.refreshData)
         {
            return;
         }
         if(event.target.index == 1)
         {
            if(this.letterVO.goodNum > 0)
            {
               LetterCGMessage.CG_GET_ATTACHMENT(UIManager.letterManagerViewPanel.letterManageVO.type,UIManager.letterManagerViewPanel.curPage,this.letterVO.id,2);
               curPoint = localToGlobal(new Point(event.target.x,event.target.y));
               curVO = (event.target as View_Grid).vo;
               isCan = true;
            }
         }
         else if(event.target.index == 2)
         {
            if(this.letterVO.msType > 0)
            {
               LetterCGMessage.CG_GET_ATTACHMENT(UIManager.letterManagerViewPanel.letterManageVO.type,UIManager.letterManagerViewPanel.curPage,this.letterVO.id,1);
               this.moneyTip.visible = false;
               isCan = false;
            }
         }
      }
      
      private function link(e:TextEvent) : void
      {
         Utils.print("link...");
         var evt:String = e.text;
         if(evt == "linkWuhun")
         {
            UIManager.vipPanel.visible = !UIManager.vipPanel.visible;
         }
         else if(evt == "openLanZuan_3")
         {
            if(Global.pf == Enum_SPStr.QQGAME || Global.pf == Enum_SPStr.QQ3366)
            {
               BlueDiamondCGMessage.CG_QQGAMEXF_SHOWPLANE();
            }
            else
            {
               UIManager.centerBroadcast.addMsg("请从大厅或3366平台登陆");
            }
         }
         else
         {
            navigateToURL(new URLRequest(e.text),"_blank");
         }
      }
      
      private function linkHd(value:LetterVO) : void
      {
         var temS:String = null;
         var temT:String = null;
         var temF:String = null;
         var _temS:String = null;
         var __sIndx:int = 0;
         var __eIndx:int = 0;
         var __tems:String = null;
         var _dataSS:String = null;
         var temConSS:String = null;
         var contentSS:String = null;
         var str:String = value.content;
         var startIndex:int = str.indexOf("[");
         var _startIndex:int = str.indexOf("{");
         var endIndex:int = str.indexOf("]");
         var _endIndex:int = str.indexOf("}");
         if(startIndex != -1 && endIndex != -1)
         {
            temS = str.replace("[","").replace("]","");
            temT = temS.substr(startIndex,endIndex - startIndex - 1);
            temF = temS.replace(temT,HtmlUtil.link("<u>" + temT + "</u>",temT));
            this.Letter01_NeiRong_text.htmlText = temF;
            this.Letter01_NeiRong_text.getCharBoundaries(startIndex);
         }
         if(_startIndex != -1 && _endIndex != -1)
         {
            _temS = str.slice(_startIndex,_endIndex);
            __sIndx = _temS.indexOf("(");
            __eIndx = _temS.indexOf(")");
            __tems = _temS.slice(__sIndx + 1,__eIndx);
            if(__tems == "0")
            {
               _dataSS = str.slice(_startIndex + 4,_endIndex);
               temConSS = str.replace("{","").replace("}","").replace("(0)","");
               contentSS = temConSS.replace(_dataSS,HtmlUtil.link("<u>" + HtmlUtil.font(_dataSS,ColorConstant.getColorStr(ColorConstant.GREEN)) + "</u>","linkWuhun"));
               this.Letter01_NeiRong_text.htmlText = contentSS;
            }
         }
      }
      
      public function get refreshData() : LetterVO
      {
         return this.letterVO;
      }
      
      public function set refreshData(value:LetterVO) : void
      {
         var pattern:RegExp = null;
         var vo:Vo_item = null;
         var eItem:Vo_equip = null;
         var mVO:Vo_grid = null;
         var sVO:Vo_grid = null;
         var bsVo:Vo_grid = null;
         this.letterVO = value;
         if(this.letterVO.sender != LangConfig.getWord("10240",1))
         {
            this.huiFuBtn.mouseEnabled = true;
            this.huiFuBtn.filters = [];
         }
         this.Letter01_CheckBox.mouseEnabled = true;
         this.Letter01_Type_text.text = value.sender;
         this.Letter01_Time_text.text = LetterManagerViewPanel.transDate(value.sendTime);
         if(value.content != "" && value.content.split("sysmail_fribless_")[0] == "" && value.content.split("sysmail_fribless_")[1] != "")
         {
            this.Letter01_NeiRong_text.htmlText = LangConfig.getWord("10241",1) + " <font color=\'#004e00\'>" + value.content.split("sysmail_fribless_")[1] + "</font> " + LangConfig.getWord("10242",1);
         }
         else if(this.letterVO.sender == LangConfig.getWord("10633",1))
         {
            this.Letter01_NeiRong_text.htmlText = value.content;
         }
         else
         {
            pattern = /http(s)?:\/\/([\w-]+\.)+[\w-]+(\/[\w- .\/?%&=]*)?/;
            this.Letter01_NeiRong_text.htmlText = value.content.replace(pattern,"");
         }
         if(this.letterVO.sender == LangConfig.getWord("10633",1))
         {
            this.linkHd(value);
         }
         if(UIManager.letterManagerViewPanel.letterManageVO.type == 4)
         {
            this.Letter01_Type_text.text = value.addressee;
            this.Letter01_CheckBox.mouseEnabled = false;
            this.huiFuBtn.label = "续发";
         }
         else
         {
            this.huiFuBtn.label = "回复";
         }
         if(value.goodNum > 0)
         {
            if(value.goodFlag == 1)
            {
               vo = new Vo_item();
               vo.id = value.toolId;
               vo.Init_lib();
               vo.count = value.goodNum;
               this.goodsGrid.vo = vo;
            }
            else if(value.goodFlag == 2)
            {
               eItem = new Vo_equip();
               if(Boolean(value.equipArr) && value.equipArr.length > 1)
               {
                  eItem.Init_sever_bag(value.equipArr);
               }
               else
               {
                  eItem.id = value.equipId;
                  eItem.Init_lib();
               }
               this.goodsGrid.vo = eItem;
            }
         }
         if(value.msType == 0)
         {
            this.moneyGrid.vo = null;
         }
         else if(value.msType == 1)
         {
            mVO = new Vo_grid();
            mVO.str_icon = "18";
            this.moneyGrid.vo = mVO;
            this.moneyTip.visible = true;
         }
         else if(value.msType == 2)
         {
            sVO = new Vo_grid();
            sVO.str_icon = "16";
            this.moneyGrid.vo = sVO;
            this.moneyTip.visible = true;
         }
         else if(value.msType == 5)
         {
            bsVo = new Vo_grid();
            bsVo.str_icon = "18";
            this.moneyGrid.vo = bsVo;
            this.moneyTip.visible = true;
         }
         if(this.letterVO.sender == LangConfig.getWord("10633",1))
         {
            Utils.loadTitle("lang/ch/Letter_Imgs.swf","SystemLetter",this.bmFlat,null,null);
         }
         else
         {
            Utils.loadTitle("lang/ch/Letter_Imgs.swf","PlayerLetter",this.bmFlat,null,null);
         }
         if(UIManager.letterManagerViewPanel.letterManageVO.type == 4)
         {
            this.goodsGrid.filters = Util.disabled;
            this.goodsGrid.useHandCursor = false;
            this.goodsGrid.buttonMode = false;
            this.moneyGrid.filters = Util.disabled;
            this.moneyGrid.useHandCursor = false;
            this.moneyGrid.buttonMode = false;
            this.moneyTip.buttonMode = false;
         }
      }
      
      public function reset() : void
      {
         this.Letter01_Type_text.text = "";
         this.Letter01_Time_text.text = "";
         this.Letter01_NeiRong_text.text = "";
         this.Letter01_CheckBox.selected = false;
         this.goodsGrid.filters = [];
         this.goodsGrid.useHandCursor = true;
         this.goodsGrid.buttonMode = true;
         this.moneyGrid.filters = [];
         this.moneyGrid.buttonMode = true;
         this.moneyGrid.useHandCursor = true;
         this.moneyTip.buttonMode = true;
         this.goodsGrid.vo = null;
         this.moneyGrid.vo = null;
         this.letterVO = null;
         this.Letter01_CheckBox.mouseEnabled = false;
         this.moneyTip.visible = false;
         this.huiFuBtn.mouseEnabled = false;
         this.huiFuBtn.filters = Util.disabled;
      }
   }
}

