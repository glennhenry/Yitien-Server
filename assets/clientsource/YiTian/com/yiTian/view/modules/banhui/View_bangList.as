package com.yiTian.view.modules.banhui
{
   import com.ui.controls.Button;
   import com.ui.controls.MyTextField;
   import com.ui.controls.TabButton;
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.data.model.Model_bang;
   import com.yiTian.data.vo.Vo_banghuiList;
   import com.yiTian.manager.GameUnitManager;
   import com.yiTian.manager.LangConfig;
   import com.yiTian.manager.UIManager;
   import com.yiTian.net.message.cg.BangCGMessage;
   import com.yiTian.utils.SingleLoader;
   import com.yiTian.utils.Utils;
   import com.yiTian.view.Enum_explor;
   import com.yiTian.view.Panel;
   import flash.events.FocusEvent;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   import flash.text.TextFieldAutoSize;
   import flash.text.TextFieldType;
   import flash.text.TextFormatAlign;
   
   public class View_bangList extends Panel
   {
      
      private static var isLoad:Boolean = false;
      
      private var Button_PageUp:Button;
      
      private var Button_PageDown:Button;
      
      private var Button_BHLieBiao:TabButton;
      
      private var Button_Seach:Button;
      
      private var Button_Great:Button;
      
      private var PageNumber_text:MyTextField;
      
      public var BangName_text:MyTextField;
      
      public var BZName_text:MyTextField;
      
      public var bangListItem:View_bangList_Item;
      
      public var bangListItem_arr:Array = [];
      
      public var DEFAULTTEXT1:String;
      
      public var DEFAULTTEXT2:String;
      
      private const LEN:int = 11;
      
      private var nowItem:View_bangList_Item;
      
      public var _curPage:int = 1;
      
      public var _totalPage:int;
      
      private var isFirstOpen:Boolean = true;
      
      public var leftNum:int;
      
      public function View_bangList()
      {
         super();
      }
      
      override protected function initStaticView() : void
      {
         var i:int = 0;
         super.initStaticView();
         this.DEFAULTTEXT1 = LangConfig.getWord("50038",5);
         this.DEFAULTTEXT2 = LangConfig.getWord("50039",5);
         isTween = true;
         ComponentUtil.getScaleBitmap("Back1",[149,41,2,5],this,{
            "x":0,
            "y":0,
            "width":728,
            "height":455
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back2",[5,5,10,10],this,{
            "x":24,
            "y":40,
            "width":680,
            "height":385
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back_Num",[3,3,3,3],this,{
            "x":430,
            "y":44,
            "width":100,
            "height":22
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back_Num",[3,3,3,3],this,{
            "x":273,
            "y":44,
            "width":100,
            "height":22
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back3",[4,4,1,1],this,{
            "x":29,
            "y":70,
            "width":670,
            "height":350
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back_Title",[2,2,18,18],this,{
            "x":30,
            "y":71,
            "width":668,
            "height":20
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back_Num",[3,3,3,3],this,{
            "x":330,
            "y":426,
            "width":63,
            "height":22
         },Global.Img_Cdm);
         ComponentUtil.getTextField(LangConfig.getWord("60001",6),this,{
            "x":45,
            "y":71,
            "color":16764206,
            "size":12,
            "leading":0
         });
         ComponentUtil.getTextField(LangConfig.getWord("60002",6),this,{
            "x":154,
            "y":71,
            "color":16764206,
            "size":12,
            "leading":0
         });
         ComponentUtil.getTextField(LangConfig.getWord("60003",6),this,{
            "x":304,
            "y":71,
            "color":16764206,
            "size":12,
            "leading":0
         });
         ComponentUtil.getTextField(LangConfig.getWord("60004",6),this,{
            "x":422,
            "y":71,
            "color":16764206,
            "size":12,
            "leading":0
         });
         ComponentUtil.getTextField(LangConfig.getWord("60005",6),this,{
            "x":529,
            "y":71,
            "color":16764206,
            "size":12,
            "leading":0
         });
         ComponentUtil.getTextField(LangConfig.getWord("60023",6),this,{
            "x":631,
            "y":71,
            "color":16764206,
            "size":12,
            "leading":0
         });
         ComponentUtil.getTextField(LangConfig.getWord("60024",6),this,{
            "x":389,
            "y":47,
            "color":11904647,
            "size":12,
            "leading":0
         });
         ComponentUtil.getTextField(LangConfig.getWord("60025",6),this,{
            "x":208,
            "y":47,
            "color":11904647,
            "size":12,
            "leading":0
         });
         move = new Rectangle(0,0,700,38);
         this.Button_PageUp = ComponentUtil.getButton("","Button_PageLeft",this,{
            "x":307,
            "y":427,
            "textColor":16184781
         },Global.Img_Cdm);
         this.Button_PageDown = ComponentUtil.getButton("","Button_PageRight",this,{
            "x":395,
            "y":427,
            "textColor":16184781
         },Global.Img_Cdm);
         this.Button_PageUp.name = "minus";
         this.Button_PageDown.name = "add";
         this.Button_PageUp.addEventListener(MouseEvent.CLICK,this.pageChangHandle);
         this.Button_PageDown.addEventListener(MouseEvent.CLICK,this.pageChangHandle);
         this.Button_BHLieBiao = ComponentUtil.getTabButton(LangConfig.getWord("50040",5),"TabButton_Four",this,{
            "x":41,
            "y":47,
            "textColor":16773818,
            "chooseColor":16773818
         },Global.Img_Cdm);
         this.Button_BHLieBiao.choose = true;
         this.Button_BHLieBiao.useHandCursor = false;
         this.Button_BHLieBiao.mouseEnabled = false;
         i = 0;
         while(i < this.LEN)
         {
            this.bangListItem = new View_bangList_Item();
            this.bangListItem.x = 38;
            this.bangListItem.y = 92 + 30 * i;
            addChild(this.bangListItem);
            this.bangListItem_arr.push(this.bangListItem);
            this.bangListItem.addEventListener(MouseEvent.CLICK,this.cliHandle);
            this.bangListItem = null;
            i++;
         }
         this.Button_Seach = ComponentUtil.getButton(LangConfig.getWord("50041",5),"Button_Four",this,{
            "x":540,
            "y":43,
            "textColor":16184781
         },Global.Img_Cdm);
         this.Button_Great = ComponentUtil.getButton(LangConfig.getWord("50042",5),"Button_Four",this,{
            "x":620,
            "y":43,
            "textColor":16184781
         },Global.Img_Cdm);
         CloseButton = ComponentUtil.getButton("","Button_Close",this,{
            "x":694,
            "y":6,
            "textColor":16184781
         },Global.Img_Cdm);
         this.PageNumber_text = ComponentUtil.getTextField("1/1",this,{
            "x":341,
            "y":428,
            "color":14662240,
            "size":12,
            "leading":0,
            "realWidth":45
         });
         this.PageNumber_text.autoSize = TextFieldAutoSize.CENTER;
         this.BangName_text = ComponentUtil.getTextField(this.DEFAULTTEXT1,this,{
            "x":269.05,
            "y":46.25,
            "realWidth":106,
            "realHeight":18,
            "color":14013822
         });
         this.BangName_text.type = TextFieldType.INPUT;
         this.BangName_text.align = TextFormatAlign.CENTER;
         this.BangName_text.maxChars = 8;
         this.BZName_text = ComponentUtil.getTextField(this.DEFAULTTEXT2,this,{
            "x":425.95,
            "y":46.25,
            "realWidth":106,
            "realHeight":18,
            "color":14013822
         });
         this.BZName_text.type = TextFieldType.INPUT;
         this.BZName_text.align = TextFormatAlign.CENTER;
         this.BZName_text.maxChars = 8;
         this.BangName_text.addEventListener(FocusEvent.FOCUS_IN,this.bangNameHandle);
         this.BZName_text.addEventListener(FocusEvent.FOCUS_IN,this.bangHostHandle);
         this.BangName_text.addEventListener(FocusEvent.FOCUS_OUT,this.bang_outNameHandle);
         this.BZName_text.addEventListener(FocusEvent.FOCUS_OUT,this.bang_outHostHandle);
         this.Button_Great.addEventListener(MouseEvent.CLICK,this.createBangHandle);
         this.Button_Great.addEventListener(MouseEvent.MOUSE_DOWN,this.createDownBangHandle);
         this.Button_Seach.addEventListener(MouseEvent.CLICK,this.searchHandle);
      }
      
      private function searchHandle(e:MouseEvent) : void
      {
         var temBangName:String = this.BangName_text.text;
         var temBZName:String = this.BZName_text.text;
         if(temBangName == this.DEFAULTTEXT1)
         {
            temBangName = "";
         }
         if(temBZName == this.DEFAULTTEXT2)
         {
            temBZName = "";
         }
         if(temBangName == "" && temBZName == "")
         {
            UIManager.centerBroadcast.addMsg(LangConfig.getWord("50043",5));
         }
         BangCGMessage.CG_BANG_SEARCH(temBangName,temBZName);
      }
      
      private function cliHandle(e:MouseEvent) : void
      {
         if(!(e.target is View_bangList_Item))
         {
            return;
         }
         var cliItem:View_bangList_Item = e.target as View_bangList_Item;
         if(this.nowItem == cliItem)
         {
            return;
         }
         if(Boolean(this.nowItem))
         {
            this.nowItem.select = false;
         }
         this.nowItem = cliItem;
         this.nowItem.select = true;
      }
      
      public function pageChangHandle(e:MouseEvent) : void
      {
         if(Boolean(this.nowItem))
         {
            this.nowItem.select = false;
         }
         var temBtn:Button = e.target as Button;
         if(temBtn.name == "minus")
         {
            if(this._curPage == 1)
            {
               return;
            }
            --this._curPage;
            if(this._curPage < 1)
            {
               this._curPage = 1;
            }
         }
         else
         {
            if(this._curPage == this._totalPage)
            {
               return;
            }
            ++this._curPage;
            if(this._curPage > this._totalPage)
            {
               this._curPage = this._totalPage;
            }
         }
         var temBangName:String = this.BangName_text.text;
         var temBZName:String = this.BZName_text.text;
         if(temBangName == this.DEFAULTTEXT1)
         {
            temBangName = "";
         }
         if(temBZName == this.DEFAULTTEXT2)
         {
            temBZName = "";
         }
         if(Model_bang.partyType == 1)
         {
            BangCGMessage.CG_BANG_PAGE_SEARCH(3,"","",this._curPage);
         }
         if(Model_bang.bang_search_type == 1)
         {
            BangCGMessage.CG_BANG_PAGE_SEARCH(Model_bang.bang_search_type,temBangName,temBZName,this._curPage);
         }
         else if(Model_bang.bang_search_type == 2)
         {
            BangCGMessage.CG_BANG_PAGE_SEARCH(Model_bang.bang_search_type,Model_bang.bang_search_condition_first,Model_bang.bang_search_condition_second,this._curPage);
         }
      }
      
      override public function set visible(value:Boolean) : void
      {
         super.visible = value;
         if(value)
         {
            if(this.isFirstOpen)
            {
               bind_target = Enum_explor.bind(Enum_explor.BTN_PARTY);
               this.isFirstOpen = false;
               if(!Global.Bang_Imgsdm)
               {
                  SingleLoader.add("lang/ch/Bang_Imgs.swf",function(info:Object):void
                  {
                     Global.Bang_Imgsdm = info.applicationDomain;
                     showBmp();
                  });
               }
               else if(!isLoad)
               {
                  this.showBmp();
               }
            }
            BangCGMessage.CG_BANG_PAGE_SEARCH(1,"","",1);
         }
      }
      
      private function showBmp() : void
      {
         ComponentUtil.getBitmap("Title_Bang",this,{
            "x":284,
            "y":5
         },Global.Bang_Imgsdm);
      }
      
      public function cloHandle(e:MouseEvent) : void
      {
         this.reset();
      }
      
      public function reset() : void
      {
         this.BangName_text.text = this.DEFAULTTEXT1;
         this.BZName_text.text = this.DEFAULTTEXT2;
      }
      
      public function bangNameHandle(e:FocusEvent) : void
      {
         if(this.BangName_text.text == this.DEFAULTTEXT1)
         {
            this.BangName_text.text = "";
         }
      }
      
      public function bang_outNameHandle(e:FocusEvent) : void
      {
         if(this.BangName_text.text == "")
         {
            this.BangName_text.text = this.DEFAULTTEXT1;
         }
      }
      
      public function bangHostHandle(e:FocusEvent) : void
      {
         if(this.BZName_text.text == this.DEFAULTTEXT2)
         {
            this.BZName_text.text = "";
         }
      }
      
      public function bang_outHostHandle(e:FocusEvent) : void
      {
         if(this.BZName_text.text == "")
         {
            this.BZName_text.text = this.DEFAULTTEXT2;
         }
      }
      
      private function createDownBangHandle(e:MouseEvent) : void
      {
         e.stopPropagation();
      }
      
      public function createBangHandle(e:MouseEvent) : void
      {
         if(GameUnitManager.hero.level < 30)
         {
            UIManager.centerBroadcast.addMsg(LangConfig.getWord("29173",2));
            return;
         }
         if(GameUnitManager.hero.silver + GameUnitManager.hero.bingSilver < 5000)
         {
            UIManager.centerBroadcast.addMsg(LangConfig.getWord("23437",2));
            return;
         }
         if(!UIManager.bangCreate.visible)
         {
            UIManager.bangCreate.visible = true;
         }
         UIManager.bangCreate.parent.setChildIndex(UIManager.bangCreate,UIManager.bangCreate.parent.numChildren - 1);
      }
      
      public function update(arr:Array, current_page:int, total_page:int, size:int) : void
      {
         var temItem:View_bangList_Item = null;
         var vo_listItem:Vo_banghuiList = null;
         this.PageNumber_text.text = String(current_page) + "/" + String(total_page);
         this._curPage = current_page;
         var i:int = 0;
         while(i < this.LEN)
         {
            this.bangListItem_arr[i].visible = false;
            i++;
         }
         if(size > this.LEN)
         {
            Utils.print(LangConfig.getWord("60026",6));
         }
         var j:int = 0;
         while(j < size)
         {
            temItem = this.bangListItem_arr[j];
            vo_listItem = arr[j];
            temItem.visible = true;
            temItem.partyId = vo_listItem.bang_id;
            temItem.Rank_text.text = String(vo_listItem.paiming);
            temItem.BangName_text.text = vo_listItem.bang_name;
            temItem.BangZhu_text.text = vo_listItem.bang_host;
            temItem.Lever_text.text = String(vo_listItem.bang_level);
            temItem.Member_text.text = String(vo_listItem.bang_members) + "/" + String(vo_listItem.bang_members_lim);
            j++;
         }
      }
      
      override public function resetPosition() : void
      {
         x = (Global.stage.stageWidth - width) / 2;
         y = (Global.stage.stageHeight - height) / 2;
      }
   }
}

