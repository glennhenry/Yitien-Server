package com.yiTian.view.modules.letter
{
   import com.ui.controls.Button;
   import com.ui.controls.MyTextField;
   import com.ui.controls.TabButton;
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.manager.LangConfig;
   import com.yiTian.manager.UIManager;
   import com.yiTian.net.message.cg.LetterCGMessage;
   import com.yiTian.utils.Utils;
   import com.yiTian.view.Enum_explor;
   import com.yiTian.view.Panel;
   import com.yiTian.view.comp.View_Alert;
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   import flash.text.TextFormatAlign;
   
   public class LetterManagerViewPanel extends Panel
   {
      
      private var instance38:DisplayObject;
      
      private var instance40:DisplayObject;
      
      private var instance42:DisplayObject;
      
      private var instance44:DisplayObject;
      
      private var instance46:DisplayObject;
      
      private var instance48:DisplayObject;
      
      private var instance50:DisplayObject;
      
      private var instance52:DisplayObject;
      
      private var instance56:MyTextField;
      
      private var Button_AllLetters:TabButton;
      
      private var Button_SystemLetters:TabButton;
      
      private var Button_PersonalLetters:TabButton;
      
      private var Button_SentLetters:TabButton;
      
      private var Button_AllSelcet:Button;
      
      private var Button_Remove:Button;
      
      private var Button_DelSelect:Button;
      
      private var Button_Write:Button;
      
      private var Button_PageDown:Button;
      
      private var Button_PageUp:Button;
      
      private var Page_text:MyTextField;
      
      private var LetterCap_text:MyTextField;
      
      private var tbtn_now:TabButton;
      
      public var letterManageVO:LetterManagerVO;
      
      public var letterVOArr:Array;
      
      private var isFirstOpen:Boolean = true;
      
      private var pageSize:int = 3;
      
      private var tempLetterViewPanel:LetterViewPanel;
      
      private var positionYArr:Array = [70,177,284];
      
      private var letterViewArr:Array;
      
      public var direct:String;
      
      public var lastStartPage:int;
      
      public var curPage:int;
      
      public function LetterManagerViewPanel()
      {
         super();
      }
      
      public static function transDate(value:Number) : String
      {
         var date:Date = new Date(value * 1000);
         var yearStr:String = date.fullYear.toString();
         var monthStr:String = (date.month + 1).toString();
         var dateStr:String = date.date < 10 ? "0" + date.date : date.date.toString();
         var hoursStr:String = date.getHours() < 10 ? "0" + date.getHours() : date.getHours().toString();
         var minutesStr:String = date.getMinutes() < 10 ? "0" + date.getMinutes() : date.getMinutes().toString();
         var secondsStr:String = date.getSeconds() < 10 ? "0" + date.getSeconds() : date.getSeconds().toString();
         return yearStr + "/" + monthStr + "/" + dateStr + " " + hoursStr + ":" + minutesStr + ":" + secondsStr;
      }
      
      override protected function initStaticView() : void
      {
         var letterView:LetterViewPanel = null;
         var letterViewBack:DisplayObject = null;
         var i:uint = 0;
         var back:DisplayObject = ComponentUtil.getScaleBitmap("Back1",[149,41,2,5],this,{
            "x":0,
            "y":0,
            "width":588,
            "height":462
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back2",[5,5,10,10],this,{
            "x":24,
            "y":40,
            "width":540,
            "height":360
         },Global.Img_Cdm);
         move = new Rectangle(0,0,back.width,35);
         CloseButton = ComponentUtil.getButton("","Button_Close",this,{
            "x":554,
            "y":6,
            "textColor":16184781
         },Global.Img_Cdm);
         CloseButton.addEventListener(MouseEvent.CLICK,function(e:MouseEvent):void
         {
            visible = false;
         });
         ComponentUtil.getScaleBitmap("Back_Num",[3,3,3,3],this,{
            "x":260,
            "y":404,
            "width":140,
            "height":22
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back_Num",[3,3,3,3],this,{
            "x":457,
            "y":404,
            "width":80,
            "height":22
         },Global.Img_Cdm);
         ComponentUtil.getTextField(LangConfig.getWord("60200",6),this,{
            "x":265,
            "y":431,
            "color":11904647,
            "size":12,
            "leading":0
         });
         ComponentUtil.getTextField("请勿信游戏要求汇款、出售元宝、中奖信息",this,{
            "x":325,
            "y":50,
            "color":16764206,
            "size":11,
            "leading":0
         });
         this.Button_AllLetters = ComponentUtil.getTabButton(LangConfig.getWord("10219",1),"TabButton_Four",this,{
            "x":38,
            "y":48,
            "textColor":16773818,
            "chooseColor":16773818
         },Global.Img_Cdm);
         this.Button_SystemLetters = ComponentUtil.getTabButton(LangConfig.getWord("10220",1),"TabButton_Four",this,{
            "x":110,
            "y":48,
            "textColor":16773818,
            "chooseColor":16773818
         },Global.Img_Cdm);
         this.Button_PersonalLetters = ComponentUtil.getTabButton(LangConfig.getWord("10221",1),"TabButton_Four",this,{
            "x":182,
            "y":48,
            "textColor":16773818,
            "chooseColor":16773818
         },Global.Img_Cdm);
         this.Button_SentLetters = ComponentUtil.getTabButton("已发信件","TabButton_Four",this,{
            "x":254,
            "y":48,
            "textColor":16773818,
            "chooseColor":16773818
         },Global.Img_Cdm);
         this.Button_AllSelcet = ComponentUtil.getButton(LangConfig.getWord("10222",1),"Button_Four",this,{
            "x":35,
            "y":404,
            "textColor":16184781
         },Global.Img_Cdm);
         this.Button_Remove = ComponentUtil.getButton(LangConfig.getWord("10223",1),"Button_Four",this,{
            "x":35,
            "y":431,
            "textColor":16184781
         },Global.Img_Cdm);
         this.Button_DelSelect = ComponentUtil.getButton(LangConfig.getWord("10224",1),"Button_Four",this,{
            "x":125,
            "y":404,
            "textColor":16184781
         },Global.Img_Cdm);
         this.Button_Write = ComponentUtil.getButton(LangConfig.getWord("10225",1),"Button_Four",this,{
            "x":125,
            "y":431,
            "textColor":16184781
         },Global.Img_Cdm);
         this.Button_PageDown = ComponentUtil.getButton("","Button_PageLeft",this,{
            "x":434,
            "y":405,
            "name":"Button_PageUp"
         },Global.Img_Cdm);
         this.Button_PageUp = ComponentUtil.getButton("","Button_PageRight",this,{
            "x":539,
            "y":405,
            "name":"Button_PageDown"
         },Global.Img_Cdm);
         this.Page_text = ComponentUtil.getTextField("0/0",this,{
            "x":459,
            "y":406,
            "color":16773818,
            "size":12,
            "leading":0
         });
         this.Page_text.realWidth = 58 + 17;
         this.Page_text.align = TextFormatAlign.CENTER;
         this.LetterCap_text = ComponentUtil.getTextField("0/0",this,{
            "x":263,
            "y":405,
            "color":16773818,
            "size":12,
            "leading":0
         });
         this.LetterCap_text.realWidth = 135;
         this.LetterCap_text.align = TextFormatAlign.CENTER;
         this.letterViewArr = [];
         i = 0;
         while(i < 3)
         {
            ComponentUtil.getScaleBitmap("Back_Invite",[5,5,6,6],this,{
               "x":34,
               "y":this.positionYArr[i],
               "width":520,
               "height":106
            },Global.Img_Cdm);
            letterView = new LetterViewPanel();
            letterView.x = 34;
            letterView.y = this.positionYArr[i];
            addChild(letterView);
            this.letterViewArr.push(letterView);
            i++;
         }
         this.Button_AllLetters.addEventListener(MouseEvent.CLICK,this.tabButtonClickHandler);
         this.Button_SystemLetters.addEventListener(MouseEvent.CLICK,this.tabButtonClickHandler);
         this.Button_PersonalLetters.addEventListener(MouseEvent.CLICK,this.tabButtonClickHandler);
         this.Button_SentLetters.addEventListener(MouseEvent.CLICK,this.tabButtonClickHandler);
         this.tbtn_now = this.Button_AllLetters;
         this.tbtn_now.choose = true;
         this.Button_AllSelcet.addEventListener(MouseEvent.CLICK,this.buttonClickHandler);
         this.Button_Remove.addEventListener(MouseEvent.CLICK,this.buttonClickHandler);
         this.Button_DelSelect.addEventListener(MouseEvent.CLICK,this.buttonClickHandler);
         this.Button_Write.addEventListener(MouseEvent.CLICK,this.buttonClickHandler);
         this.Button_PageDown.addEventListener(MouseEvent.CLICK,this.pageHandler);
         this.Button_PageUp.addEventListener(MouseEvent.CLICK,this.pageHandler);
         this.Button_PageDown.mouseEnabled = false;
         this.Button_PageUp.mouseEnabled = false;
         this.Button_AllSelcet.mouseEnabled = false;
         this.Button_Remove.mouseEnabled = false;
         this.Button_DelSelect.mouseEnabled = false;
         this.addEventListener(MouseEvent.MOUSE_DOWN,function(e:MouseEvent):void
         {
            e.stopImmediatePropagation();
         });
      }
      
      override public function set visible(value:Boolean) : void
      {
         var i:int = 0;
         super.visible = value;
         if(value)
         {
            if(this.isFirstOpen)
            {
               Utils.loadTitle("lang/ch/Letter_Imgs.swf","Title_ManageLetters",new Bitmap(),{
                  "x":214,
                  "y":5
               },this);
               i = 0;
               while(i < this.letterViewArr.length)
               {
                  this.letterViewArr[i].loadBack();
                  i++;
               }
            }
            this.isFirstOpen = false;
            bind_target = Enum_explor.bind(Enum_explor.BTN_LETTER);
         }
      }
      
      protected function tabButtonClickHandler(event:MouseEvent) : void
      {
         var tbtn:TabButton = event.target as TabButton;
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
         switch(tbtn.text)
         {
            case LangConfig.getWord("10219",1):
               LetterCGMessage.CG_MAIL(1,1);
               break;
            case LangConfig.getWord("10220",1):
               LetterCGMessage.CG_MAIL(3,1);
               break;
            case LangConfig.getWord("10221",1):
               LetterCGMessage.CG_MAIL(2,1);
               break;
            case "已发信件":
               LetterCGMessage.CG_MAIL(4,1);
         }
      }
      
      private function showLetterList() : void
      {
         var i:uint = 0;
         var tempLetterVO:LetterVO = null;
         this.letterViewArr[0].reset();
         this.letterViewArr[1].reset();
         this.letterViewArr[2].reset();
         this.letterViewArr[0].visible = false;
         this.letterViewArr[1].visible = false;
         this.letterViewArr[2].visible = false;
         i = 0;
         i = 0;
         while(i < this.pageSize && Boolean(this.letterVOArr[(this.curPage - 1) % 5 * this.pageSize + i]))
         {
            this.tempLetterViewPanel = this.letterViewArr[i];
            this.tempLetterViewPanel.visible = true;
            this.tempLetterViewPanel.refreshData = this.letterVOArr[(this.curPage - 1) % 5 * this.pageSize + i];
            tempLetterVO = this.letterVOArr[(this.curPage - 1) % 5 * this.pageSize + i];
            if(!tempLetterVO.readFlag)
            {
               tempLetterVO.readFlag = 1;
            }
            i++;
         }
      }
      
      private function pageHandler(e:MouseEvent) : void
      {
         var tempLetterVO:LetterVO = null;
         var str:String = null;
         var char:String = null;
         var i:uint = 0;
         switch(e.target.name)
         {
            case "Button_PageDown":
               if(this.curPage + 1 <= this.letterManageVO.endPage)
               {
                  ++this.curPage;
                  tempLetterVO = this.letterVOArr[(this.curPage - 1) % 5 * this.pageSize];
                  if(!tempLetterVO.readFlag)
                  {
                     str = "";
                     char = "";
                     i = 0;
                     while(i < this.pageSize && Boolean(this.letterVOArr[(this.curPage - 1) % 5 * this.pageSize + i]))
                     {
                        if(i == 0)
                        {
                           char = "";
                        }
                        else
                        {
                           char = "_";
                        }
                        tempLetterVO = this.letterVOArr[(this.curPage - 1) % 5 * this.pageSize + i];
                        str += char + tempLetterVO.id.toString();
                        i++;
                     }
                     LetterCGMessage.CG_TURN_PAGE(this.letterManageVO.type,str);
                  }
                  this.showLetterList();
                  this.Page_text.text = this.curPage.toString() + "/" + this.letterManageVO.totalPage.toString();
                  return;
               }
               if(this.letterManageVO.endPage < this.letterManageVO.totalPage && this.curPage % 5 == 0)
               {
                  LetterCGMessage.CG_MAIL(this.letterManageVO.type,this.curPage + 1);
               }
               break;
            case "Button_PageUp":
               if(this.curPage - 1 >= this.letterManageVO.startPage)
               {
                  --this.curPage;
                  this.showLetterList();
                  this.Page_text.text = this.curPage.toString() + "/" + this.letterManageVO.totalPage.toString();
                  return;
               }
               if(this.letterManageVO.startPage > 5 && (this.curPage - 1) % 5 == 0)
               {
                  LetterCGMessage.CG_MAIL(this.letterManageVO.type,this.curPage - 1);
               }
         }
      }
      
      protected function buttonClickHandler(event:MouseEvent) : void
      {
         var i:uint = 0;
         var isSelected:Boolean = false;
         var isAttachment:Boolean = false;
         switch(event.target.label)
         {
            case LangConfig.getWord("10225",1):
               UIManager.letterEditViewPanel.visible = true;
               UIManager.letterEditViewPanel.updatafriendsList();
               break;
            case LangConfig.getWord("10222",1):
               i = 0;
               while(i < 3)
               {
                  this.tempLetterViewPanel = this.letterViewArr[i];
                  if(Boolean(this.tempLetterViewPanel.refreshData))
                  {
                     this.tempLetterViewPanel.Letter01_CheckBox.selected = true;
                  }
                  i++;
               }
               break;
            case LangConfig.getWord("10223",1):
               View_Alert.show(LangConfig.getWord("10226",1),View_Alert.OK_CANCAL,this.clearAll,this.cancalCallBack);
               break;
            case LangConfig.getWord("10224",1):
               isSelected = false;
               i = 0;
               while(i < 3)
               {
                  this.tempLetterViewPanel = this.letterViewArr[i];
                  if(this.tempLetterViewPanel.Letter01_CheckBox.selected)
                  {
                     isSelected = true;
                     break;
                  }
                  i++;
               }
               if(!isSelected)
               {
                  UIManager.centerBroadcast.addMsg("<font color=\'#ffff00\'>" + LangConfig.getWord("10227",1) + "</font>");
                  return;
               }
               isAttachment = false;
               i = 0;
               while(i < 3)
               {
                  this.tempLetterViewPanel = this.letterViewArr[i];
                  if(Boolean(this.tempLetterViewPanel.refreshData) && (Boolean(this.tempLetterViewPanel.refreshData.goodNum > 0 || this.tempLetterViewPanel.refreshData.msNum > 0)) && this.tempLetterViewPanel.Letter01_CheckBox.selected == true)
                  {
                     isAttachment = true;
                     break;
                  }
                  i++;
               }
               if(isAttachment)
               {
                  View_Alert.show(LangConfig.getWord("10228",1),View_Alert.OK_CANCAL,this.deleteSeleted,this.cancalCallBack);
                  break;
               }
               this.deleteSeleted();
         }
      }
      
      private function clearAll() : void
      {
         LetterCGMessage.CG_CLEAR_MAIL(this.letterManageVO.type,this.curPage);
      }
      
      private function deleteSeleted() : void
      {
         var idArr:Array = [];
         var nums:int = 0;
         var i:uint = 0;
         while(i < 3)
         {
            this.tempLetterViewPanel = this.letterViewArr[i];
            if(this.tempLetterViewPanel.Letter01_CheckBox.selected)
            {
               idArr.push(this.tempLetterViewPanel.refreshData.id);
               nums++;
            }
            i++;
         }
         LetterCGMessage.CG_DELETE_MAIL(this.letterManageVO.type,this.curPage,nums,idArr);
      }
      
      private function cancalCallBack() : void
      {
      }
      
      public function refreshData() : void
      {
         if(this.letterManageVO.size > 0)
         {
            this.Button_PageDown.mouseEnabled = true;
            this.Button_PageUp.mouseEnabled = true;
            this.Button_AllSelcet.mouseEnabled = true;
            this.Button_Remove.mouseEnabled = true;
            this.Button_DelSelect.mouseEnabled = true;
         }
         else
         {
            this.Button_PageDown.mouseEnabled = false;
            this.Button_PageUp.mouseEnabled = false;
            this.Button_AllSelcet.mouseEnabled = false;
            this.Button_Remove.mouseEnabled = false;
            this.Button_DelSelect.mouseEnabled = false;
         }
         this.Button_AllLetters.choose = false;
         this.Button_SystemLetters.choose = false;
         this.Button_PersonalLetters.choose = false;
         this.Button_SentLetters.choose = false;
         switch(this.letterManageVO.type)
         {
            case 1:
               this.tbtn_now = this.Button_AllLetters;
               this.tbtn_now.choose = true;
               break;
            case 2:
               this.tbtn_now = this.Button_PersonalLetters;
               this.tbtn_now.choose = true;
               break;
            case 3:
               this.tbtn_now = this.Button_SystemLetters;
               this.tbtn_now.choose = true;
               break;
            case 4:
               this.tbtn_now = this.Button_SentLetters;
               this.tbtn_now.choose = true;
         }
         if(this.letterManageVO.type == 4)
         {
            this.Button_AllSelcet.mouseEnabled = false;
            this.Button_Remove.mouseEnabled = false;
            this.Button_DelSelect.mouseEnabled = false;
         }
         this.curPage = this.letterManageVO.currentPage;
         this.LetterCap_text.text = LangConfig.getWord("60202",6) + this.letterManageVO.mailNum.toString();
         this.Page_text.text = this.curPage.toString() + "/" + this.letterManageVO.totalPage.toString();
         this.showLetterList();
         if(this.letterManageVO.mailNum > 98 && this.letterManageVO.currentPage == 1)
         {
            UIManager.centerBroadcast.addMsg("<font color=\'#ffff00\'>" + LangConfig.getWord("10229",1) + "</font>");
         }
      }
      
      override public function resetPosition() : void
      {
         x = (Global.stage.stageWidth - width) / 2;
         y = (Global.stage.stageHeight - height) / 2;
      }
   }
}

