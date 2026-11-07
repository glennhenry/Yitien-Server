package com.yiTian.view.modules.letter
{
   import com.ui.controls.Button;
   import com.ui.controls.ComboBox;
   import com.ui.controls.MyTextField;
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.command.Enum_MsgType;
   import com.yiTian.data.Data_lib;
   import com.yiTian.data.Enum_type_grid;
   import com.yiTian.data.model.Model_bag;
   import com.yiTian.data.model.Model_heFu;
   import com.yiTian.data.vo.Vo_equip;
   import com.yiTian.data.vo.Vo_item;
   import com.yiTian.data.vo.Vo_unit;
   import com.yiTian.manager.GameUnitManager;
   import com.yiTian.manager.LangConfig;
   import com.yiTian.manager.UIManager;
   import com.yiTian.net.message.cg.LetterCGMessage;
   import com.yiTian.utils.StrFilter;
   import com.yiTian.utils.Utils;
   import com.yiTian.view.Panel;
   import com.yiTian.view.comp.View_Grid;
   import com.yiTian.view.modules.friends.Model_Friends;
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import flash.events.Event;
   import flash.events.FocusEvent;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   import flash.text.TextFieldType;
   import flash.text.TextFormatAlign;
   import flash.utils.Dictionary;
   
   public class LetterEditViewPanel extends Panel
   {
      
      private var Button_cancel:Button;
      
      private var Button_send:Button;
      
      private var YinLiang_text:MyTextField;
      
      private var XinJianNeiRong_text:MyTextField;
      
      private var ShouXinRen_text:MyTextField;
      
      private var HaoYouLieBiao_text:MyTextField;
      
      public var goodsGrid:View_Grid;
      
      private var friendsComboBox:ComboBox;
      
      private var selSilIngCom:ComboBox;
      
      private var isSilIng:int;
      
      public var friendsArr:Array;
      
      private var defaultTxt:String;
      
      private var friendsDic:Dictionary = new Dictionary();
      
      private var f:Boolean = true;
      
      public function LetterEditViewPanel()
      {
         super();
      }
      
      override protected function initStaticView() : void
      {
         var back:DisplayObject;
         this.defaultTxt = LangConfig.getWord("10231",1);
         back = ComponentUtil.getScaleBitmap("Back1",[149,41,2,5],this,{
            "x":0,
            "y":0,
            "width":458,
            "height":260
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back2",[5,5,10,10],this,{
            "x":24,
            "y":40,
            "width":410,
            "height":188
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back_Num",[3,3,3,3],this,{
            "x":105,
            "y":48,
            "width":100,
            "height":24
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back_ComboBox",[4,4,3,3],this,{
            "x":315,
            "y":48,
            "width":110,
            "height":24
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back3",[4,4,1,1],this,{
            "x":105,
            "y":75,
            "width":322,
            "height":102
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back_Num",[3,3,3,3],this,{
            "x":150,
            "y":193,
            "width":80,
            "height":22
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back_ComboBox",[4,4,3,3],this,{
            "x":235,
            "y":193,
            "width":62,
            "height":24
         },Global.Img_Cdm);
         ComponentUtil.getTextField(LangConfig.getWord("60196",6),this,{
            "x":45,
            "y":50,
            "color":11904647,
            "size":12,
            "leading":0
         });
         ComponentUtil.getTextField(LangConfig.getWord("60197",6),this,{
            "x":210,
            "y":50,
            "color":12877056,
            "size":12,
            "leading":0
         });
         ComponentUtil.getTextField(LangConfig.getWord("60198",6),this,{
            "x":45,
            "y":80,
            "color":11904647,
            "size":12,
            "leading":0
         });
         ComponentUtil.getTextField(LangConfig.getWord("60199",6),this,{
            "x":50,
            "y":180,
            "color":11904647,
            "size":12,
            "leading":0
         });
         move = new Rectangle(0,0,430,37);
         CloseButton = ComponentUtil.getButton("","Button_Close",this,{
            "x":424,
            "y":6,
            "textColor":16184781
         },Global.Img_Cdm);
         this.Button_cancel = ComponentUtil.getButton(LangConfig.getWord("10146",1),"Button_Four",this,{
            "x":270,
            "y":230,
            "textColor":16184781
         },Global.Img_Cdm);
         this.Button_send = ComponentUtil.getButton(LangConfig.getWord("10232",1),"Button_Four",this,{
            "x":110,
            "y":230,
            "textColor":16184781
         },Global.Img_Cdm);
         this.YinLiang_text = ComponentUtil.getTextField("2,113",this,{
            "x":150,
            "y":195,
            "color":16777215,
            "size":12,
            "leading":0
         });
         this.YinLiang_text.align = TextFormatAlign.RIGHT;
         this.XinJianNeiRong_text = ComponentUtil.getTextField("",this,{
            "x":110,
            "y":80,
            "color":16184781,
            "size":12,
            "leading":0
         });
         this.ShouXinRen_text = ComponentUtil.getTextField("",this,{
            "x":110,
            "y":50,
            "color":16184781,
            "size":12,
            "leading":0
         });
         this.XinJianNeiRong_text.addEventListener(Event.CHANGE,this.inputHandler);
         this.Button_send.addEventListener(MouseEvent.CLICK,this.sendHandler);
         this.Button_cancel.addEventListener(MouseEvent.CLICK,this.cancelHandler);
         CloseButton.addEventListener(MouseEvent.CLICK,this.closeButtonHandler);
         this.XinJianNeiRong_text.type = TextFieldType.INPUT;
         this.XinJianNeiRong_text.realWidth = 314.35;
         this.XinJianNeiRong_text.realHeight = 94.4;
         this.XinJianNeiRong_text.wordWrap = true;
         this.ShouXinRen_text.type = TextFieldType.INPUT;
         this.ShouXinRen_text.realWidth = 100;
         this.ShouXinRen_text.realHeight = 18.5;
         this.ShouXinRen_text.maxChars = 7;
         this.YinLiang_text.type = TextFieldType.INPUT;
         this.YinLiang_text.realWidth = 77;
         this.YinLiang_text.realHeight = 18.5;
         this.YinLiang_text.restrict = "0-9";
         this.YinLiang_text.addEventListener(Event.CHANGE,this.txtChangeHandler);
         this.selSilIngCom = new ComboBox([[Data_lib.attribute[18][0],1],[Data_lib.attribute[16][0],2]],function(value:Object):void
         {
            isSilIng = int(value);
            trace("value..",isSilIng);
         },55,"Button_PageDown","ComboBox_background");
         addChild(this.selSilIngCom);
         this.selSilIngCom.x = 240;
         this.selSilIngCom.y = 194;
         this.goodsGrid = new View_Grid();
         this.goodsGrid.set_tf_count(true,true,true);
         this.goodsGrid.set_bmp_bg();
         this.goodsGrid.set_bmp_select();
         this.goodsGrid.set_bmp_over();
         this.goodsGrid.type = Enum_type_grid.NO_DRAG;
         addChild(this.goodsGrid);
         this.goodsGrid.x = 110;
         this.goodsGrid.y = 183;
         addChild(this.goodsGrid);
         this.goodsGrid.addEventListener(MouseEvent.MOUSE_UP,this.onUp);
         this.goodsGrid.addEventListener(MouseEvent.CLICK,this.clearGoodsGrid);
         this.friendsComboBox = new ComboBox(this.friendsArr,function(value:Object):void
         {
            trace("value..",value);
            ShouXinRen_text.text = friendsDic[value];
         },105,"Button_PageDown","ComboBox_background","xuanze_over",180);
         addChild(this.friendsComboBox);
         this.friendsComboBox.x = 317;
         this.friendsComboBox.y = 48;
         this.reset();
         Global.control.registerCallBack(Enum_MsgType.MSG_SENDMAIL,this.sendMail);
      }
      
      public function clearGoodsGrid(e:MouseEvent = null) : void
      {
         if(Boolean(this.goodsGrid.vo))
         {
            this.gridUnlock();
            this.goodsGrid.vo = null;
            UIManager.goodsNumView.visible = false;
         }
      }
      
      protected function closeButtonHandler(event:MouseEvent) : void
      {
         UIManager.goodsNumView.visible = false;
         this.gridUnlock();
         this.reset();
      }
      
      protected function txtChangeHandler(event:Event) : void
      {
         var str:String = this.YinLiang_text.text;
         if(str.substr(0,1) == "0")
         {
            this.YinLiang_text.text = str.substr(1,str.length);
         }
         if(this.isSilIng == 1)
         {
            if(int(this.YinLiang_text.text) > GameUnitManager.hero.silver)
            {
               this.YinLiang_text.text = GameUnitManager.hero.silver.toString();
            }
         }
         else if(this.isSilIng == 2)
         {
            if(int(this.YinLiang_text.text) > GameUnitManager.hero.money)
            {
               this.YinLiang_text.text = GameUnitManager.hero.money.toString();
            }
         }
         else if(this.isSilIng == 0)
         {
            this.YinLiang_text.text = "0";
         }
      }
      
      public function getGridItem(dragGrid:View_Grid) : void
      {
         if(Boolean(dragGrid) && Boolean(dragGrid.vo))
         {
            if(dragGrid.vo is Vo_equip && (dragGrid.vo as Vo_equip).type == 12)
            {
               UIManager.centerBroadcast.addMsg("勋章不能传信件");
               return;
            }
         }
         if(dragGrid.vo is Vo_item)
         {
            if((dragGrid.vo as Vo_item).bBind)
            {
               UIManager.centerBroadcast.addMsg("<font color=\'#ffff00\'>" + LangConfig.getWord("10233",1) + "</font>");
               return;
            }
         }
         else if(dragGrid.vo is Vo_equip)
         {
            if((dragGrid.vo as Vo_equip).bBind)
            {
               UIManager.centerBroadcast.addMsg("<font color=\'#ffff00\'>" + LangConfig.getWord("10233",1) + "</font>");
               return;
            }
         }
         this.gridUnlock();
         UIManager.bagPanel.set_mask(dragGrid.vo.gridId,true);
         this.goodsGrid.vo = dragGrid.vo;
         this.goodsGrid.index = dragGrid.index;
         this.goodsGrid.count = 1;
         if(this.goodsGrid.vo.count > 1)
         {
            UIManager.goodsNumView.visible = true;
            UIManager.goodsNumView.reset(this.goodsGrid.vo);
         }
      }
      
      private function onUp(e:MouseEvent) : void
      {
         var dragGrid:View_Grid = null;
         if(UIManager.isDrag)
         {
            dragGrid = UIManager.dragObj.grid;
            if(Boolean(dragGrid.vo))
            {
               if(dragGrid.type == Enum_type_grid.BAG)
               {
                  this.getGridItem(dragGrid);
               }
            }
         }
      }
      
      protected function cancelHandler(event:MouseEvent) : void
      {
         UIManager.letterEditViewPanel.visible = false;
         this.gridUnlock();
         this.reset();
      }
      
      private function compare(vo:Vo_unit, index:int, a:Array) : Boolean
      {
         return vo.name == this.ShouXinRen_text.text;
      }
      
      protected function sendHandler(event:MouseEvent) : void
      {
         var reg:RegExp;
         var str:String;
         var msType:int = 0;
         var msNum:int = 0;
         var goodType:int = 0;
         var goodId:int = 0;
         var goodNum:int = 0;
         var goodsGridId:int = 0;
         if(GameUnitManager.hero.level < 40 && !Model_Friends.friendArr.some(this.compare))
         {
            UIManager.centerBroadcast.addMsg("40级以下玩家只能与好友发送邮件");
            return;
         }
         if(this.ShouXinRen_text.text == "" || this.XinJianNeiRong_text.text == "" || this.XinJianNeiRong_text.text == this.defaultTxt)
         {
            UIManager.centerBroadcast.addMsg("<font color=\'#ffff00\'>" + LangConfig.getWord("10237",1) + "</font>");
            return;
         }
         if(this.XinJianNeiRong_text.text.split("sysmail_fribless_")[0] == "" && this.XinJianNeiRong_text.text.split("sysmail_fribless_")[1] != "")
         {
            UIManager.centerBroadcast.addMsg("<font color=\'#ffff00\'>" + LangConfig.getWord("10234",1) + "</font>");
            return;
         }
         reg = new RegExp("<(S*?)[^>]*>.*?|<.*? />","g");
         str = this.XinJianNeiRong_text.text.replace(reg,"");
         if(str.length != this.XinJianNeiRong_text.text.length)
         {
            UIManager.centerBroadcast.addMsg("<font color=\'#ffff00\'>" + LangConfig.getWord("10235",1) + "</font>");
            return;
         }
         if(this.ShouXinRen_text.text == GameUnitManager.hero.name)
         {
            UIManager.centerBroadcast.addMsg("<font color=\'#ffff00\'>" + LangConfig.getWord("10236",1) + "</font>");
            return;
         }
         if(Boolean(this.ShouXinRen_text.text) && Boolean(this.XinJianNeiRong_text.text) && this.XinJianNeiRong_text.text != this.defaultTxt)
         {
            if(this.isSilIng == 0 || !this.YinLiang_text.text)
            {
               msType = 0;
            }
            else if(this.isSilIng == 1)
            {
               msType = 1;
            }
            else if(this.isSilIng == 2)
            {
               msType = 2;
            }
            msNum = int(this.YinLiang_text.text);
            if(!this.goodsGrid.vo)
            {
               goodType = 0;
               goodId = 0;
               goodNum = 0;
               goodsGridId = 0;
            }
            else
            {
               goodId = this.goodsGrid.vo.id;
               goodNum = 1;
               goodsGridId = this.goodsGrid.vo.gridId;
               if(this.goodsGrid.count > 1)
               {
                  goodNum = this.goodsGrid.count;
               }
               if(this.goodsGrid.vo is Vo_item)
               {
                  goodType = 1;
               }
               else if(this.goodsGrid.vo is Vo_equip)
               {
                  goodType = 2;
               }
            }
            StrFilter.load(this.XinJianNeiRong_text.text,function(text:String):void
            {
               if(StrFilter.hasUnRegisterString(text))
               {
                  UIManager.centerBroadcast.addMsg("<font color=\'#ffff00\'>" + LangConfig.getWord("10234",1) + "</font>");
               }
               else
               {
                  LetterCGMessage.CG_SEND_MAIL(Model_heFu.correctRoleServName(ShouXinRen_text.text),XinJianNeiRong_text.text,msType,msNum,goodType,goodId,goodNum,goodsGridId);
                  gridUnlock();
                  reset(false);
               }
            });
         }
         else
         {
            UIManager.centerBroadcast.addMsg("<font color=\'#ffff00\'>" + LangConfig.getWord("10237",1) + "</font>");
         }
      }
      
      protected function inputHandler(event:Event) : void
      {
         var str:String = event.target.text;
         if(str.length > 100)
         {
            this.XinJianNeiRong_text.text = str.substr(0,100);
         }
      }
      
      private function gridUnlock() : void
      {
         if(Boolean(this.goodsGrid.vo))
         {
            UIManager.bagPanel.set_mask(this.goodsGrid.vo.gridId,false);
         }
      }
      
      public function reset(bRename:Boolean = true) : void
      {
         this.XinJianNeiRong_text.text = this.defaultTxt;
         this.XinJianNeiRong_text.addEventListener(FocusEvent.FOCUS_IN,this.focusInHandler);
         if(bRename)
         {
            this.ShouXinRen_text.text = "";
         }
         this.YinLiang_text.text = "";
         this.goodsGrid.vo = null;
         this.updatafriendsList();
         this.isSilIng = 1;
         this.selSilIngCom.defaultText = Data_lib.attribute[18][0];
         UIManager.goodsNumView.visible = false;
      }
      
      public function updatafriendsList(obj:Object = null) : void
      {
         var tempUnitVO:Vo_unit = null;
         var tempArr:Array = null;
         this.friendsArr = [];
         var i:uint = 0;
         while(i < Model_Friends.friendArr.length)
         {
            tempUnitVO = Model_Friends.friendArr[i];
            tempArr = [];
            tempArr.push(tempUnitVO.name);
            tempArr.push(tempUnitVO.id);
            this.friendsDic[tempUnitVO.id] = tempUnitVO.name;
            this.friendsArr.push(tempArr);
            i++;
         }
         this.friendsComboBox.source = this.friendsArr;
         this.friendsComboBox.defaultText = LangConfig.getWord("10238",1);
      }
      
      protected function focusInHandler(event:FocusEvent) : void
      {
         this.XinJianNeiRong_text.removeEventListener(FocusEvent.FOCUS_IN,this.focusInHandler);
         this.XinJianNeiRong_text.text = "";
      }
      
      private function sendMail(shouXinRen:Object) : void
      {
         this.visible = true;
         this.gridUnlock();
         this.reset(false);
         this.ShouXinRen_text.text = String(shouXinRen);
      }
      
      override public function set visible(value:Boolean) : void
      {
         if(Model_bag.pwdLockState == Model_bag.PWD_STATE_LOCK_T)
         {
            UIManager.bagPwdPutIn.visible = true;
            return;
         }
         super.visible = value;
         if(!value)
         {
            UIManager.goodsNumView.visible = false;
            this.gridUnlock();
            this.reset();
            Global.control.removeCallBack(Enum_MsgType.MSG_FRIEND_C,this.updatafriendsList);
         }
         else
         {
            if(!UIManager.bagPanel.visible)
            {
               UIManager.bagPanel.visible = true;
            }
            if(this.f)
            {
               Utils.loadTitle("lang/ch/Letter_Imgs.swf","Title_LetterSend",new Bitmap(),{
                  "x":146,
                  "y":5
               },this);
               this.f = false;
            }
            Global.control.registerCallBack(Enum_MsgType.MSG_FRIEND_C,this.updatafriendsList);
         }
      }
      
      override public function resetPosition() : void
      {
         x = (Global.stage.stageWidth - width) / 2;
         y = (Global.stage.stageHeight - height) / 2;
      }
   }
}

